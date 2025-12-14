#!/usr/bin/env bash

CONNECTION=$(nmcli -t -f GENERAL.CONNECTION dev show wlo1 | cut -d: -f2-)
SIGNAL=$(nmcli -t -f IN-USE,SIGNAL dev wifi list | grep '^\*' | cut -d: -f2)
if [[ $SIGNAL -ge 75 ]]; then
  ICON="󰤨 "
elif [[ $SIGNAL -ge 50 ]]; then
  ICON="󰤢 "
elif [[ $SIGNAL -ge 25 ]]; then
  ICON="󰤟 "
elif [[ $SIGNAL -ge 0 ]]; then
  ICON="󰤯 "
else
  ICON="󰤮 "
fi
echo "$ICON$CONNECTION"
echo ""
