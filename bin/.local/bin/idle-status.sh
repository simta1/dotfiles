#!/bin/bash

PIDFILE="/tmp/swayidle-toggle.pid"

if [ -f "$PIDFILE" ]; then
    STATUS=$(cat "$PIDFILE")
    if [ "$STATUS" = "on" ]; then
        echo '{"text":" Idle: On","class":"on"}'
    else
        echo '{"text":" Idle: Off","class":"off"}'
    fi
else
    echo '{"text":" Idle: Off","class":"off"}'
fi
