#!/bin/sh

while :; do
    cap=$(cat /sys/class/power_supply/BAT0/capacity)
    stat=$(cat /sys/class/power_supply/BAT0/status)

    ram=$(awk '
        /^MemTotal:/ {total=$2}
        /^MemAvailable:/ {avail=$2}
        END {
            printf "%.0fMB", (total - avail) / 1024
        }
    ' /proc/meminfo)

    xsetroot -name "RAM: ${ram} | ${stat}: ${cap}% | $(date '+%H:%M')"
    sleep 30
done
