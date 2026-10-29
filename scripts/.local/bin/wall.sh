#!/bin/bash
# Set a wallpaper and recolour the rice from it.
# Usage: wall.sh [image]   (no image = random one from the folder)
WALLPAPER_DIR="$HOME/.local/share/rice-wallpapers"

if [ -n "$1" ]; then
    WALLPAPER="$1"
else
    WALLPAPER=$(fd -e jpg -e jpeg -e png -e webp -e gif . "$WALLPAPER_DIR" | shuf -n 1)
fi

if [ -z "$WALLPAPER" ] || [ ! -f "$WALLPAPER" ]; then
    notify-send "Wallpaper" "No images found in $WALLPAPER_DIR"
    exit 1
fi

echo "$WALLPAPER" > "$HOME/.config/wallpaper"
awww img "$WALLPAPER" --transition-type center --transition-fps 180 &
matugen image "$WALLPAPER" --source-color-index 0 -t scheme-tonal-spot
sleep 1

dunstctl reload
pkill -SIGUSR1 kitty 2>/dev/null
pkill -SIGUSR2 waybar 2>/dev/null
pkill -USR2 btop 2>/dev/null
notify-send -a walls "Wallpaper changed" "$(basename "$WALLPAPER")"
