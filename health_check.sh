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
AVAILABLE_MEM=$(free -m | grep Mem | awk '{print $7}')

#If else loop for memery status
if [ "$AVAILABLE_MEM" -lt 500 ]; then
    echo "STATUS: WARNING - Low memory ($AVAILABLE_MEM MB)"
elif [ "$AVAILABLE_MEM" -lt 1000 ]; then
    echo "STATUS: CAUTION - Available memory is under 1GB ($AVAILABLE_MEM MB)"
else
    echo "STATUS: OK ($AVAILABLE_MEM MB)"
fi
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
