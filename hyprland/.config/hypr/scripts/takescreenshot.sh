#!/usr/bin/env bash
grim -g "$(slurp)" - | wl-copy
responsedunst=$(dunstify --action="open,open" "Screenshot copied to clipboard")
case "$responsedunst" in
  open)
    wl-paste --type image/png | feh -
    ;;
esac
