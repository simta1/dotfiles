#!/bin/bash

if pgrep -x swayidle > /dev/null; then
    echo '{"text":" Idle: On","class":"on"}'
else
    echo '{"text":" Idle: Off","class":"off"}'
fi
