#!/bin/bash

HOSTNAME=$(hostname)
OS_NAME=$(grep '^PRETTY_NAME' /etc/os-release 2>/dev/null | cut -d= -f2 | tr -d '"')
OS_NAME=${OS_NAME:-$(uname -s)}
KERNEL=$(uname -r)
UPTIME=$(uptime -p 2>/dev/null | sed 's/^up //')
DISK=$(df -h --output=used,size,pcent / | awk 'NR==2 {print $1 " used of " $2 " (" $3 ")"}')
MEMORY=$(free -h 2>/dev/null | awk '/^Mem:/ {print $3 " used of " $2}')
USERS=$(who | awk '{print $1}' | sort -u | paste -sd, -)
USERS=${USERS:-none}
NOW=$(date '+%Y-%m-%d %H:%M:%S')

# --- Print the Report -----------------------
LINE="--------------------------------"

echo "$LINE"
echo "  SYSTEM INFORMATION"
echo "$LINE"
printf " %-10s %s\n" "Hostname:" "$HOSTNAME"
printf " %-10s %s\n" "OS:" 	 "$OS_NAME"
printf " %-10s %s\n" "Kernel:" 	 "$KERNEL"
printf " %-10s %s\n" "Uptime:"	 "$UPTIME"
printf " %-10s %s\n" "Disk (/):" "$DISK"
printf " %-10s %s\n" "Memory:" 	 "$MEMORY"
printf " %-10s %s\n" "Users:" 	 "$USERS"
printf " %-10s %s\n" "Checked:"  "$NOW"
echo "$LINE"
