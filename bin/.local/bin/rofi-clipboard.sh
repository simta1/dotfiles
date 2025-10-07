#!/usr/bin/env bash
set -euo pipefail

sel=$(cliphist list | rofi -dmenu -p "Clipboard" -no-default-config -config ~/.config/rofi/clipboard.rasi)

# rofi에서 esc누른경우 걸러내는 용
if [ -n "$sel" ]; then
	echo "$sel" | cliphist decode | wl-copy
fi
