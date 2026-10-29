#!/bin/bash
# Volume keys with a dunst progress bar (replaces their quickshell OSD).
case $1 in
    up)   wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+ ;;
    down) wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- ;;
    mute) wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle ;;
esac

VOLUME=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2 * 100)}')
if wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q MUTED; then
    dunstify -a volume -u low -h string:x-dunst-stack-tag:volume "Volume muted"
else
    dunstify -a volume -u low -h string:x-dunst-stack-tag:volume -h int:value:"$VOLUME" "Volume $VOLUME%"
fi
