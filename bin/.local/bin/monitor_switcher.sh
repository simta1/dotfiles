#!/bin/sh

OPTIONS="1. Single Display (eDP-1)\n2. Dual Extend (Side-by-Side)\n3. Dual Duplicate (Mirroring)"

SELECTION=$(echo -e "$OPTIONS" | rofi -dmenu \
    -p "Select Display Mode:" -i \
    -no-default-config \
    -config ~/.config/rofi/clipboard.rasi)

case "$SELECTION" in
	"1. Single Display (eDP-1)")
        swaymsg 'output HDMI-A-1 disable; output eDP-1 enable mode 1920x1080 position 0 0'
        ;;
    "2. Dual Extend (Side-by-Side)")
        swaymsg 'output eDP-1 enable mode 1920x1080 position 0 0; output HDMI-A-1 enable mode 1920x1080 position 1920 0'
        ;;
    "3. Dual Duplicate (Mirroring)")
        swaymsg 'output eDP-1 enable mode 1920x1080 position 0 0; output HDMI-A-1 enable mode 1920x1080 position 0 0'
        ;;
esac
