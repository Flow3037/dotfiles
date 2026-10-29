#!/bin/bash
# Pick a wallpaper with rofi, showing thumbnails.
WALLPAPER_DIR="$HOME/.local/share/rice-wallpapers"
CHOICE=$(fd -e jpg -e jpeg -e png -e webp -e gif . "$WALLPAPER_DIR" | sort | while read -r f; do
    printf '%s\0icon\x1f%s\n' "$(basename "$f")" "$f"
done | rofi -dmenu -i -p "Wallpaper" -show-icons)

[ -n "$CHOICE" ] && exec "$HOME/.local/bin/wall.sh" "$WALLPAPER_DIR/$CHOICE"
