#!/usr/bin/env bash
set -euo pipefail

if swaymsg -t get_outputs -r | jq -e '[.[] | select(.active==true) | .dpms // true] | all' >/dev/null; then
  swaymsg 'output * dpms off' >/dev/null
else
  swaymsg 'output * dpms on'  >/dev/null
fi
