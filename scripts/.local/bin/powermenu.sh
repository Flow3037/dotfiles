#!/bin/bash
choice=$(printf "Shut down\nRestart\nLog out\n" | rofi -dmenu -i -p Power)
case "$choice" in
    "Shut down") systemctl poweroff ;;
    "Restart") systemctl reboot ;;
    "Log out") niri msg action quit --skip-confirmation ;;
esac
