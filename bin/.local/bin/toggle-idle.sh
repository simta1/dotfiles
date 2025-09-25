#!/bin/bash

PIDFILE="/tmp/swayidle-toggle.pid"

if pgrep -x swayidle > /dev/null; then
    pkill -x swayidle
    echo "off" > "$PIDFILE"
else
    ~/.local/bin/start-idle.sh &
    echo "on" > "$PIDFILE"
fi

pkill -RTMIN+8 waybar
