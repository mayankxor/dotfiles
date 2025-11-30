#!/usr/bin/env bash

DATA=$(nmcli -t -f SSID,SIGNAL,BARS dev wifi list)
CHOICE=$(echo "$DATA" | wofi --dmenu)
SIGNAL=$(echo "$CHOICE" | awk -F: '{print $2}')
SSID=$(echo "$CHOICE" | awk -F: '{print $1}')
nmcli dev wifi connect "$SSID"
