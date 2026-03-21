#!/bin/bash

# clear screen for a clean look

PROCESS_COUNT=6
HOSTNAME=$(hostname)
DATE=$(date)

echo ""
echo "System Health check - $HOSTNAME"
echo ""

echo "$DATE"

echo "Memory"
free -h
echo ""

echo "Disk"
df -h | grep '^/dev/'
echo ""

echo "Top Process (CPU %)"
ps aux --sort=-%cpu | head -n $PROCESS_COUNT
echo ""

echo "Listeneing Ports"
ss -tulnp
echo ""

echo "Failed Services"
systemctl --failed --no-pager
echo ""

echo ""
echo "Check Complete"
echo ""
