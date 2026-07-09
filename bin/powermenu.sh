#!/bin/sh

WALL="$HOME/Pictures/wallpapers/wall15.png"

choice=$(printf "Lock\nLogout\nReboot\nShutdown" | dmenu -i -p "Power")

case "$choice" in
    Lock)
        betterlockscreen -l "$WALL" --fx blur
        ;;
    Logout)
        pkill -x dwm
        ;;
    Reboot)
        loginctl reboot
        ;;
    Shutdown)
        loginctl poweroff
        ;;
esac
