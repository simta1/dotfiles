#!/bin/bash
swayidle -w \
    timeout 510 'notify-send "Idle" "화면 자동꺼짐까지 90초"' \
    timeout 540 'notify-send "Idle" "화면 자동꺼짐까지 60초"' \
    timeout 570 'notify-send "Idle" "화면 자동꺼짐까지 30초"' \
    timeout 600 'hyprlock & hyprctl dispatch dpms off' \
    resume 'hyprctl dispatch dpms on' \
    before-sleep 'hyprlock'
