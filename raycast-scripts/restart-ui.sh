#!/bin/bash

# @raycast.schemaVersion 1
# @raycast.title Restart Omarchy UI
# @raycast.mode silent
# @raycast.packageName System

# @raycast.icon ♻️

# Restart the services
/opt/homebrew/bin/brew services restart sketchybar
/opt/homebrew/bin/brew services restart borders
/Applications/AeroSpace.app/Contents/MacOS/AeroSpace reload-config

echo "UI Restarted"
