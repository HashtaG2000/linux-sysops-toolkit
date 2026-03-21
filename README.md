# Linux SysOps Toolkit

**The Goal:** Eliminate manual "command fatigue" by consolidating fragmented system data into one automated report. Essential for rapid incident response and pre-deployment sanity checks.

## Features
* **`health_check.sh`**: A single-touch script that pulls Memory, Disk, CPU-heavy processes, Networking, and Systemd failures into one view.

## Usage
```bash
chmod +x health_check.sh && ./health_check.sh
