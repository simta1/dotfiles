#!/bin/bash

SELECTED=$(find ~/.password-store -type f -name "*.gpg" -printf "%P\n" | sed 's/\.gpg$//' | sort | rofi \
    -no-default-config \
    -config ~/.config/rofi/otp.rasi \
    -dmenu -p "OTP")
[ -z "$SELECTED" ] && exit

NOTIFY_ID=$(notify-send -p "OTP 복사됨" "시간 계산 중...")

CODE=$(pass otp code "$SELECTED")
echo "$CODE" | wl-copy

while true; do
    if ! makoctl list | grep -q "$NOTIFY_ID"; then break; fi

    REMAINING=$((30 - $(date +%s) % 30))
    notify-send -r $NOTIFY_ID "OTP Copied($SELECTED)" \
        "<span size='16pt' font='monospace' weight='bold'>$CODE</span>\n남은 시간: <b>${REMAINING}초</b>"

    if [ $REMAINING -le 1 ]; then
        notify-send -r $NOTIFY_ID "OTP 만료" "코드가 만료되었습니다."
        break
    fi
    sleep 1
done
