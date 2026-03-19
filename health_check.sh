#!/bin/bash

#clear screen  for a clean look

echo ""
echo "System Health check"
echo ""
date
echo ""

echo "Memory"
free -h
echo ""

echo "Disk"
df -h | grep '^/dev/'
echo ""

echo "Top Process (CPU %)"
ps aux --sort=-%cpu | head -n 6
echo ""

echo "Listeneing Ports"
ss -tuln4
echo ""

echo "Failed Services"
systemctl --failed --no-pager
echo ""

echo ""
echo "Check Complete"
echo ""
