#!/usr/bin/env bash

# 1. Update the Front App Name (Standard)
if [ "$SENDER" = "front_app_switched" ]; then
  sketchybar --set $NAME label="$INFO" icon.background.image="app.$INFO" \
    --set $NAME icon.background.image.scale=0.8 \
    icon.background.image.scale=0.8

  # 2. Force Workspace Update
  # FIX 2: Wait 0.2s for the zombie window to clear from AeroSpace
  sleep 0.2

  # Trigger the event that 'space.x' items are listening for.
  sketchybar --trigger aerospace_workspace_change
fi
