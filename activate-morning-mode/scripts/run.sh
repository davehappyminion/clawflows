#!/usr/bin/env bash
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
[ -f "$SCRIPT_DIR/../config.env" ] && source "$SCRIPT_DIR/../config.env"

echo "Activating Morning Mode..."

# Smart lights: bright warm white
openhue set room "$ROOM" --on --color warm-white --brightness 100
echo "Done: Bright warm lights"

# Light switches: on
~/.openclaw/workspace/skills/lutron/scripts/lutron.sh all 80
echo "Done: Light switches at 80%"

# Thermostat: comfortable heat
~/.openclaw/workspace/skills/nest/scripts/nest.sh mode HEAT
~/.openclaw/workspace/skills/nest/scripts/nest.sh temp "$TEMP"
echo "Done: Thermostat set to ${TEMP}°F"

# Morning music
sonos stop --name "$SPEAKER" 2>/dev/null
sonos queue clear --name "$SPEAKER" 2>/dev/null
sonos open --name "$SPEAKER" "$PLAYLIST"
echo "Done: Morning music playing"

echo "Morning Mode active. Good morning!"
