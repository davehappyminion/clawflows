#!/usr/bin/env bash
# Night Mode
#
# Customize the commands below for your setup:
# - Replace room names, speaker names, and playlist URIs with yours

echo "Activating Night Mode..."

# Light switches: all off
~/.openclaw/workspace/skills/lutron/scripts/lutron.sh all 0
echo "Done: Light switches off"

# Smart lights: warm red, low brightness
openhue set room "Living room" --on --color red --brightness 15
echo "Done: Night mode lighting"

# Sleep music
sonos stop --name "Living Room" 2>/dev/null
sonos queue clear --name "Living Room" 2>/dev/null
sonos open --name "Living Room" "spotify:playlist:YOUR_PLAYLIST_ID"
echo "Done: Sleep music playing"

echo "Night Mode active. Sweet dreams!"
