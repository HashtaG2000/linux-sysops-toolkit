#!/bin/bash
# clear screen for a clean look
PROCESS_COUNT=6
SYS_HOSTNAME=$(hostname)
DATE=$(date)

check_memory() {
echo "Memory"
AVAILABLE_MEM=$(free -m | grep Mem | awk '{print $7}')
#If else loop for memery status
if [ "$AVAILABLE_MEM" -lt 500 ]; then
    echo "STATUS: WARNING - Low memory ($AVAILABLE_MEM MB)"
elif [ "$AVAILABLE_MEM" -lt 1000 ]; then
    echo "STATUS: CAUTION - Available memory is under 1GB ($AVAILABLE_MEM MB)"
else
    echo "STATUS: OK ($AVAILABLE_MEM MB)"
fi
}

check_disk(){
echo "Disk"
df -h | grep '^/dev/'
}

check_processes(){
echo "Top Process (CPU %)"
ps aux --sort=-%cpu | head -n $PROCESS_COUNT
}

check_single_port() {
    local PORT=$1
    if ss -tuln | grep -q ":$PORT "; then
        echo "PORT $PORT: OPEN"
    else
        echo "PORT $PORT: NOT LISTENING"
    fi
}

check_ports() {
    echo "=== LISTENING PORTS ==="
    PORTS=(22 80 443)
    for PORT in "${PORTS[@]}"; do
        check_single_port $PORT
    done
}

check_services(){
echo "Failed Services"
systemctl --failed --no-pager
}

main() {
    echo "System Health Check - $SYS_HOSTNAME"
    echo "$DATE"
    check_memory
    check_disk
    check_processes
    check_ports
    check_services
    echo "Check Complete"
}

main
