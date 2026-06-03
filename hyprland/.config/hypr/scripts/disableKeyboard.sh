#!/usr/bin/env bash

export STATUS_FILE="$XDG_RUNTIME_DIR/keyboard.status"

enable_keyboard() {
    printf "true" >"$STATUS_FILE"
    notify-send -u normal "Enabling Keyboard"
    hyprctl eval 'hl.device({name="at-translated-set-2-keyboard", enabled = true})'
}

disable_keyboard() {
    printf "false" >"$STATUS_FILE"
    notify-send -u normal "Disabling Keyboard"
    hyprctl eval 'hl.device({name="at-translated-set-2-keyboard", enabled = false})'
}

if ! [ -f "$STATUS_FILE" ]; then
  enable_keyboard
else
  if [ $(cat "$STATUS_FILE") = "true" ]; then
    disable_keyboard
  elif [ $(cat "$STATUS_FILE") = "false" ]; then
    enable_keyboard
  fi
fi
