#!/usr/bin/env bash
pactl set-source-mute @DEFAULT_SOURCE@ toggle

pkill -RTMIN+8 waybar
