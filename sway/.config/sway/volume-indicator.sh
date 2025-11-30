#!/usr/bin/env bash

# Get current volume & mute
MUTED=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')
VOLUME=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}')
VOLUME="${VOLUME//%/}"

# Decide icon
if [[ "$MUTED" = "yes" ]]; then
  ICON=" "
elif [[ "$VOLUME" -le 5 ]]; then
  ICON=""
elif [[ "$VOLUME" -le 30 ]]; then
  ICON=" "
else
  ICON=" "
fi

# Show notification (short timeout)
notify-send -h string:x-canonical-private-synchronous:volume " $ICON $VOLUME%" -t 800

