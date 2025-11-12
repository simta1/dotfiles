#!/usr/bin/env bash

DIR="$HOME/Pictures/wallpapers"
STATE="$HOME/.cache/current_bg"

MAX_INDEX=3

if [[ -f "$STATE" ]]; then
    index=$(<"$STATE")
else
    index=0
fi

swaymsg "output * bg $DIR/bg${index}.jpg fill"

echo "$index" > "$STATE"

