#!/usr/bin/env bash
CONFIG="$(dirname "$0")/../config.env"
[ -f "$CONFIG" ] && source "$CONFIG"

echo "Activating Night Mode..."

# Light switches: all off
~/.openclaw/workspace/skills/lutron/scripts/lutron.sh all 0
echo "Done: Light switches off"

# Smart lights: warm red, low brightness
openhue set room "$ROOM" --on --color red --brightness 15
echo "Done: Night mode lighting"

# Sleep music
sonos stop --name "$SPEAKER" 2>/dev/null
sonos queue clear --name "$SPEAKER" 2>/dev/null
sonos open --name "$SPEAKER" "$PLAYLIST"
echo "Done: Sleep music playing"

echo "Night Mode active. Sweet dreams!"
