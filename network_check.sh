#!/bin/bash
set -euo pipefail

# 1. Define hosts and ports
HOSTS=("google.com" "github.com" "8.8.8.8")
TARGET_DOMAIN="google.com"
PORTS=(80 443)

echo "NETWORK CONNECTIVITY CHECK"
echo "Checking hosts: ${HOSTS[*]}"
echo "----------------------------------"

# 2. Loop through hosts to check Reachability
echo "PING TEST"
for host in "${HOSTS[@]}"; do
    if ping -c 1 -W 2 "$host" &> /dev/null; then
        echo "[OK] $host: REACHABLE"
    else
        echo "[FAIL] $host: UNREACHABLE"
    fi
done

echo ""

# 3. Loop through ports on google.com
echo "PORT CONNECTIVITY (on $TARGET_DOMAIN)"
for port in "${PORTS[@]}"; do
    # nc -z (scan), -w1 (1 second timeout)
    if nc -zw1 "$TARGET_DOMAIN" "$port" &> /dev/null; then
        echo "[OK] PORT $port: OPEN"
    else
        echo "[FAIL] PORT $port: CLOSED/FILTERED"
    fi
done

echo ""

# 4. DNS Lookup
echo "DNS LOOKUP ($TARGET_DOMAIN)"
# We use || to try nslookup if dig is not installed
dig +short "$TARGET_DOMAIN" || nslookup "$TARGET_DOMAIN"

echo ""
echo "CHECK COMPLETE"
