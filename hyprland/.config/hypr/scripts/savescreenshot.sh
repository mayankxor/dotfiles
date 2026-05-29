#!/usr/bin/env bash
grim -g "$(slurp)" - | wl-copy
filename="$HOME/Pictures/screenshots/shot_$(date '+%B-%d-%Y-%H:%M:%S:%N').png"
wl-paste --type image/png > $filename
responsedunst=$(dunstify --action="open,open" "Screenshot copied and saved")
case "$responsedunst" in
  open)
    feh $filename
    ;;
esac
