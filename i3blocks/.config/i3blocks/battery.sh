#!/usr/bin/env bash
# i3blocks battery script:
# - Icons vary by percentage
# - Charging uses the matching "lightning" variant of the same icon
# - When charging, the color is always green
# - Proper 3-line i3blocks output (full_text / short_text / color)
# - Handles "Full" and "No battery" cases

ACPI_LINE=$(acpi -b 2>/dev/null | head -n1)

if [[ -z "$ACPI_LINE" ]]; then
    echo "󰂑"
    echo ""
    echo "#888888"
    exit 0
fi

# Percentage (e.g. "42%")
BAT=$(echo "$ACPI_LINE" | grep -o '[0-9]\+%')
if [[ -z "$BAT" ]]; then
    echo "󰂑"
    echo ""
    echo "#888888"
    exit 0
fi
PCT=${BAT%?}    # numeric percentage

# Status: Charging / Discharging / Full (remove trailing commas)
STATUS=$(echo "$ACPI_LINE" | awk '{print $3}' | tr -d ',')

# Discharging icons (by bucket)
dis_100="󰁹"   # full
dis_90="󰂂"
dis_80="󰂁"
dis_70="󰂀"
dis_60="󰁿"
dis_50="󰁾"
dis_40="󰁽"
dis_30="󰁼"
dis_20="󰁻"
dis_10="󰁺"
dis_0="󰂃"

# Charging icons (matching shapes but charging variants)
chg_100="󰂅"  # full + lightning
chg_90="󰂋"
chg_80="󰂊"
chg_70="󰢞"
chg_60="󰂉"
chg_50="󰢝"
chg_40="󰂈"
chg_30="󰂇"
chg_20="󰂆"
chg_10="󰢜"
chg_0="󰢟"

# Colors
GREEN="#19e639"   # forced when charging
COL_90="#19e639"
COL_80="#3edd22"
COL_70="#6cd629"
COL_60="#86d32c"
COL_50="#7bd52a"
COL_40="#a9d32c"
COL_30="#e1a01e"
COL_20="#e24e1d"
COL_10="#eb2e14"
COL_0="#ff0000"

# Choose icon and color by percentage (discharging defaults)
choose_by_pct() {
    local pct=$1
    if   [[ $pct -ge 100 ]]; then echo "$dis_100" "$GREEN"
    elif [[ $pct -ge 90  ]]; then echo "$dis_90"  "$COL_90"
    elif [[ $pct -ge 80  ]]; then echo "$dis_80"  "$COL_80"
    elif [[ $pct -ge 70  ]]; then echo "$dis_70"  "$COL_70"
    elif [[ $pct -ge 60  ]]; then echo "$dis_60"  "$COL_60"
    elif [[ $pct -ge 50  ]]; then echo "$dis_50"  "$COL_50"
    elif [[ $pct -ge 40  ]]; then echo "$dis_40"  "$COL_40"
    elif [[ $pct -ge 30  ]]; then echo "$dis_30"  "$COL_30"
    elif [[ $pct -ge 20  ]]; then echo "$dis_20"  "$COL_20"
    elif [[ $pct -ge 10  ]]; then echo "$dis_10"  "$COL_10"
    else                            echo "$dis_0"   "$COL_0"
    fi
}

# Same but for charging icons
choose_chg_by_pct() {
    local pct=$1
    if   [[ $pct -ge 100 ]]; then echo "$chg_100"
    elif [[ $pct -ge 90  ]]; then echo "$chg_90"
    elif [[ $pct -ge 80  ]]; then echo "$chg_80"
    elif [[ $pct -ge 70  ]]; then echo "$chg_70"
    elif [[ $pct -ge 60  ]]; then echo "$chg_60"
    elif [[ $pct -ge 50  ]]; then echo "$chg_50"
    elif [[ $pct -ge 40  ]]; then echo "$chg_40"
    elif [[ $pct -ge 30  ]]; then echo "$chg_30"
    elif [[ $pct -ge 20  ]]; then echo "$chg_20"
    elif [[ $pct -ge 10  ]]; then echo "$chg_10"
    else                            echo "$chg_0"
    fi
}

if [[ "$STATUS" == "Charging" ]]; then
    # Charging: icon matches the pct (charging variant), color forced green
    icon=$(choose_chg_by_pct "$PCT")
    color=$GREEN
elif [[ "$STATUS" == "Full" ]]; then
    # Full: use full icon and green color
    icon=$chg_100
    color=$GREEN
else
    # Discharging (or unknown): icon+color depend on percentage
    read -r icon color <<< "$(choose_by_pct "$PCT")"
fi

## HANDLE CLICKS HERE
if [[ -n "$BLOCK_BUTTON" ]]; then
  case "$BLOCK_BUTTON" in
    1) # Left click
      notify-send "Battery Status" "Status: $STATUS, Level: $PCT%"
      ;;
    2) # Middle click
      ;;
    3)
      gnome-power-statistics > /dev/null 2>&1 < /dev/null &
      ;;
  esac

fi
## /HANDLE CLICKS HERE

# i3blocks: full_text / short_text / color
echo "$icon $BAT"
echo ""
echo "$color"

