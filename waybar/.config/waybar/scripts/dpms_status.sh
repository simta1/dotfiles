#!/usr/bin/env bash

# 출력들 중 하나라도 dpms 꺼져있으면 OFF, 모두 켜져있으면 ON
if swaymsg -t get_outputs -r | jq -e '[.[] | select(.active==true) | .dpms // true] | all' >/dev/null; then
  echo " ON"
else
  echo " OFF"
fi
