#!/bin/bash

if pgrep -x swayidle > /dev/null; then
    pkill -x swayidle
else
    ~/.local/bin/start-idle.sh &
fi

pkill -RTMIN+8 waybar
