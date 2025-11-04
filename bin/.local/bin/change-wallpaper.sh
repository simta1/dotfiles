#!/usr/bin/env bash

DIR="$HOME/Pictures/wallpapers"
STATE="$HOME/.cache/current_bg"

MAX_INDEX=3

if [[ -f "$STATE" ]]; then
    index=$(<"$STATE")
else
    index=0
fi

next=$(( (index + 1) % (MAX_INDEX + 1) ))

swaymsg "output * bg $DIR/bg${next}.jpg fill"

echo "$next" > "$STATE"
