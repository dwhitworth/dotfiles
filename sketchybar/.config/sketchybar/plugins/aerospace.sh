#!/usr/bin/env bash

# FIX 1: Ensure the script can find 'aerospace' and 'sketchybar' binaries
export PATH="$PATH:/opt/homebrew/bin"

# 1. Update Background (Focus Logic)
if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
  sketchybar --set $NAME background.drawing=on \
    background.color=0x88FF00FF \
    label.shadow.drawing=on \
    icon.shadow.drawing=on \
    background.border_width=2
else
  sketchybar --set $NAME background.drawing=on \
    background.color=0x44FFFFFF \
    label.shadow.drawing=off \
    icon.shadow.drawing=off \
    background.border_width=0
fi

# 2. Update Icons (Window Logic)
# Query AeroSpace for windows in the specific workspace passed as $1
apps=$(aerospace list-windows --workspace "$1" | awk -F'|' '{gsub(/^ *| *$/, "", $2); print $2}')

icon_strip=" "
if [ "${apps}" != "" ]; then
  while read -r app; do
    # Call the mapping script as an executable
    icon_strip+=" $($CONFIG_DIR/plugins/icon_map_fn.sh "$app")"
  done <<<"${apps}"
else
  icon_strip=""
fi

sketchybar --set space.$1 label="$icon_strip"
