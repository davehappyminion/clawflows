#!/usr/bin/env bash
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
[ -f "$SCRIPT_DIR/../config.env" ] && source "$SCRIPT_DIR/../config.env"

echo "Activating Away Mode..."

# Smart lights: all off
openhue set room "$ROOM" --off
echo "Done: Smart lights off"

# Light switches: all off
~/.openclaw/workspace/skills/lutron/scripts/lutron.sh all 0
echo "Done: Light switches off"

# Thermostat: eco mode
~/.openclaw/workspace/skills/nest/scripts/nest.sh mode ECO
echo "Done: Thermostat set to eco"

# Speakers: pause
sonos pause --name "$SPEAKER" 2>/dev/null
echo "Done: Speakers off"

# Smart plugs: all off
if [ -n "$SMART_PLUGS" ]; then
    IFS=',' read -ra PLUGS <<< "$SMART_PLUGS"
    for plug in "${PLUGS[@]}"; do
        plug=$(echo "$plug" | xargs)
        ~/.openclaw/workspace/skills/kasa/scripts/kasa.sh "$plug" off
    done
    echo "Done: Smart plugs off"
fi

echo "Away Mode active. See you later!"
