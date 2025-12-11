#!/usr/bin/env bash

DIR="$HOME/Pictures/wallpapers"
STATE="$HOME/.cache/current_bg"

if [[ -f "$STATE" ]]; then
    index=$(<"$STATE")
else
    index=0
fi

shopt -s nullglob
file_array=( "$DIR/bg${index}."* )
file_path="${file_array[0]}"

if [[ -f "$file_path" ]]; then
    swaymsg "output * bg $file_path fill"
    echo "$index" > "$STATE"
else
    notify-send -u critical "no wallpaper" "can't find $DIR/bg${index}.*"
fi
