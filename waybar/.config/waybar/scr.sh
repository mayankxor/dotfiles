#!/usr/bin/env bash

while true; do
    player=$(
        playerctl -a status --format '{{playerName}}^{{status}}' |
        awk -F'^' '$2=="Playing"{print $1; exit}'
    )

    if [ -n "$player" ]; then
        playerctl -p "$player" metadata \
            --format '{{ artist }} - {{ title }}'
    else
        echo ""
    fi

    sleep 1
done | zscroll -l 20 --delay 0.3
