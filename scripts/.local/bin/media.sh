#!/bin/bash
ASSETS=""
TEMP_ICON="/tmp/media-art-$$.jpg"
trap "rm -f '$TEMP_ICON'" EXIT INT TERM

DEBOUNCE=1.2
LAST_TITLE=""
PENDING_PID=""

show_notification() {
    local TITLE="$1" ARTIST="$2" ART="$3"

    if [[ "$ART" == https://* ]]; then
        curl -sf --max-time 3 -o "$TEMP_ICON" "$ART" && ICON="$TEMP_ICON" || ICON="audio-x-generic"
    elif [[ "$ART" == file://* ]]; then
        ICON="${ART#file://}"
    else
        ICON="audio-x-generic"
    fi

    notify-send -a "media" -i "$ICON" -t 5000 "$TITLE" "by $ARTIST"
}

playerctl --follow metadata --format "{{title}}|{{artist}}|{{mpris:artUrl}}" |
while IFS='|' read -r TITLE ARTIST ART; do
    [[ -z "$TITLE" ]] && continue

    [[ -n "$PENDING_PID" ]] && kill "$PENDING_PID" 2>/dev/null

    (
        sleep "$DEBOUNCE"
        show_notification "$TITLE" "$ARTIST" "$ART"
    ) &
    PENDING_PID=$!
done
