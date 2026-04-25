#!/usr/bin/env bash

if pgrep -x hypridle > /dev/null; then
    pkill -x hypridle
else
    hypridle &
fi

pkill -RTMIN+8 waybar
