#!/bin/bash

CONNECTED_MAC="84:5F:04:89:55:82"
DEVICE_NAME=$(bluetoothctl info "$CONNECTED_MAC" | grep 'Name:' | cut -d ' ' -f2-)

if bluetoothctl info "$CONNECTED_MAC" | grep -q "Connected: yes"; then
    echo "$DEVICE_NAME"
else
    echo "Disconnected"
fi
