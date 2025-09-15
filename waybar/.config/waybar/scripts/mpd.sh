#!/bin/bash

status=$(mpc status)

if [[ -z "$status" ]]; then
    echo '{"text":"Off","tooltip":"MPD disconnected"}'
    exit 0
fi

song=$(mpc current -f %file%)
song=$(basename "$song")
state=$(echo "$status" | sed -n 2p | awk '{print $1}')
time=$(echo "$status" | sed -n 2p | awk '{print $3, $4}')

case $state in
    "[playing]") icon="" ;;
    "[paused]")  icon="" ;;
    *)           icon="" ;;
esac

maxlen=10
if [ ${#song} -gt $maxlen ]; then
    short="${song:0:$maxlen}"
	short=$(echo "$short" | sed 's/[[:space:]-]*$//')
	short="${short}…"
else
    short="$song"
fi


if [ -n "$short" ]; then
    text="$icon $short"
else
    text="$icon"
fi

echo "{\"text\":\"$text\",\"tooltip\":\"$time\"}"
