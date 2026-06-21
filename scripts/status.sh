#!/bin/sh

TIME=$(date '+%H:%M')
BAT=$(cat /sys/class/power_supply/BAT*/capacity 2>/dev/null | head -n1)

notify-send -r 9999 "$TIME | ${BAT}%"
