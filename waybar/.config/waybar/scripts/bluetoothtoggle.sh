#!/usr/bin/env bash

if bluetoothctl show | grep -q "Powered: yes"; then
    bluetoothctl power off
    notify-send "Bluetooth off"
else
    bluetoothctl power on
    notify-send "Bluetooth on"
fi
