#!/bin/bash
swayidle -w \
    timeout 510 'notify-send "Idle" "화면 자동꺼짐까지 90초"' \
    timeout 540 'notify-send "Idle" "화면 자동꺼짐까지 60초"' \
    timeout 570 'notify-send "Idle" "화면 자동꺼짐까지 30초"' \
    timeout 600 '~/.local/bin/lock.sh & swaymsg "output * dpms off"' \
    resume 'swaymsg "output * dpms on"' \
    before-sleep '~/.local/bin/lock.sh'
