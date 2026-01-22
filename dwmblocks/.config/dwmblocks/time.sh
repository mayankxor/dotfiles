#!/usr/bin/env bash

time=$(date +%T)
echo "$time"

case $BUTTON in
	1) notify-send "time pressed";;
esac
