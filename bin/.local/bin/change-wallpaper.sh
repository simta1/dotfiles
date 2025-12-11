#!/usr/bin/env bash

DIR="$HOME/Pictures/wallpapers"
STATE="$HOME/.cache/current_bg"

if [[ -f "$STATE" ]]; then
    index=$(<"$STATE")
else
    index=0
fi

next=$(( index + 1 ))

shopt -s nullglob
file_array=( "$DIR/bg${next}."* )
file_path="${file_array[0]}"

if [[ -z "$file_path" ]]; then
    next=0
    file_array=( "$DIR/bg${next}."* )
    file_path="${file_array[0]}"
fi

if [[ -f "$file_path" ]]; then
    swaymsg "output * bg $file_path fill"
    echo "$next" > "$STATE"
fi
