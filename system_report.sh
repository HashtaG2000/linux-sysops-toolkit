#!/bin/bash

# Configuration: Fail fast and remain predictable
set -euo pipefail

# Global variables using readonly for constants, immutable
readonly PROCESS_COUNT=5
readonly SYSTEM_HOSTNAME=$(hostname)
readonly CURRENT_DATE=$(date)

check_memory() {
    echo "Memory Statistics"
    free -h

    # Extracting available memory in MB for logic processing, awk stronger than grep as it focuses on mathcing pattern inside the awk
    local available_mem_mb
    available_mem_mb=$(free -m | awk '/Mem:/ {print $7}')

    if [ "$available_mem_mb" -lt 500 ]; then
        echo "Alert: Low memory ($available_mem_mb MB)"
    elif [ "$available_mem_mb" -lt 1000 ]; then
        echo "Note: Available memory below 1GB ($available_mem_mb MB)"
    else
        echo "Status: Memory levels nominal"
    fi
    printf "\n"
}

check_disk() {
    echo "Disk Usage"
    # Filter for physical devices only to avoid virtual filesystem noise
    df -h | grep '^/dev/'
    printf "\n"
}

check_cpu() {
    echo "Top $PROCESS_COUNT CPU Consumers"
    # +1 to include the header row from ps
    ps aux --sort=-%cpu | head -n "$((PROCESS_COUNT + 1))"
    printf "\n"
}

check_users() {
    echo "Current User Activity and Load"
    w
    printf "\n"
}

check_last_logins() {
    echo "Recent Login History"
    last | head -n 5
    printf "\n"
}

main() {
    echo "System Report for $SYSTEM_HOSTNAME"
    echo "Timestamp: $CURRENT_DATE"
    echo "Uptime: $(uptime -p)"
    printf "\n"

    check_memory
    check_disk
    check_cpu
    check_users
    check_last_logins
}

main
