#!/usr/bin/env bash

# Left click to mute
#if [ "$BLOCK_BUTTON" = "1" ]; then
  #pactl set-sink-mute @DEFAULT_SINK@ toggle
#fi
#
## Scroll = Volume Change
#if [[ "$BLOCK_BUTTON" = "4" ]]; then
  #pactl set-sink-volume @DEFAULT_SINK@ +5%
#fi
#if [ "$BLOCK_BUTTON" = "5" ]; then
    #pactl set-sink-volume @DEFAULT_SINK@ -5%
#fi

# Read mute status
MUTED=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')

# Read current volume
VOLUME=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}')
VOLUME="${VOLUME//%/}" # strip "%"
VOLUME="${VOLUME//[^0-9]/}" # Convert string to int

# Output volume level(muted icon incase muted)
if [[ "$MUTED" = "yes" ]]; then
  ICON=" "
elif [[ "$VOLUME" -le 5 ]]; then
  ICON=" "
elif [[ "$VOLUME" -le 30 ]]; then
  ICON=" "
else
  ICON=" "
fi
echo "$ICON$VOLUME"
case $BUTTON in
	1) notify-send "volume pressed";;
esac
