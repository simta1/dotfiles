#!/bin/bash

STATE=$(pactl get-source-mute @DEFAULT_SOURCE@ | awk '{print $2}')

if [ "$STATE" = "yes" ]; then
    ICON=""   # 마이크 꺼짐 아이콘
    TEXT="muted"
else
    ICON=""   # 마이크 켜짐 아이콘
    TEXT="on"
fi

echo "{\"text\": \"$ICON $TEXT\", \"class\": \"$STATE\"}"
