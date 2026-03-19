#!/bin/bash

if pgrep -x swayidle > /dev/null; then
    pkill -x swayidle
else
    swayidle &
fi

pkill -RTMIN+8 waybar
