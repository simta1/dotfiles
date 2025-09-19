#!/bin/bash

color=$(grim -g "$(slurp -p)" -t ppm - | \
    convert - txt:- | \
    awk 'NR==2 {print $3, $4}')

hex=$(awk '{print $1}' <<< "$color")

echo -n "$color" | wl-copy

notify-send "Color Picked" "<b><span foreground='$hex'>$color</span></b>"
