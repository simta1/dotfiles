#!/bin/bash

WS_ID=$(hyprctl activeworkspace -j | jq '.id')
ADDRS=$(hyprctl clients -j | jq -r ".[] | select(.workspace.id == $WS_ID) | .address")

if [ $(echo "$ADDRS" | wc -l) -lt 2 ]; then
    exit 0
fi

FIRST_ADDR=$(echo "$ADDRS" | head -n 1)
hyprctl dispatch focuswindow address:$FIRST_ADDR
hyprctl dispatch togglegroup

echo "$ADDRS" | tail -n +2 | while read -r addr; do
    hyprctl dispatch focuswindow address:$addr
    for dir in l r u d; do
        hyprctl dispatch moveintogroup $dir
    done
done
