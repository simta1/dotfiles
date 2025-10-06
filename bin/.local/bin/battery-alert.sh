#!/usr/bin/env bash
set -euo pipefail

# 배터리 장치명 확인 필요(BAT0)
BATTERY_PATH="/sys/class/power_supply/BAT0/capacity"
STATUS_PATH="/sys/class/power_supply/BAT0/status"

WARN=20
CRIT=10
FULL=80

capacity=$(<"$BATTERY_PATH")
status=$(<"$STATUS_PATH")

if [[ "$status" == "Discharging" ]]; then
    if (( capacity <= CRIT )); then
        notify-send -u critical -i ~/.local/bin/icons/battery-caution.svg \
            "Battery Warning" "<span font='16' foreground='#e53935'><b>Battery at ${capacity}%</b></span>"
    elif (( capacity <= WARN )); then
        notify-send -u normal -i ~/.local/bin/icons/battery-low.svg \
            "Battery Notice" "<span font='16' foreground='#fb8c00'><b>Battery at ${capacity}%</b></span>"
    fi
elif [[ "$status" == "Charging" ]]; then
    if (( capacity >= FULL )); then
        notify-send -u normal -i ~/.local/bin/icons/battery-full.svg \
			"Battery Notice" "<span font='16' foreground='#43a047'><b>Battery at ${capacity}%. Consider unplugging.</b></span>"
    fi
fi
