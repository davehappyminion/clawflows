#!/usr/bin/env bash
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/../config.env"

echo "Activating Sleep Mode..."

# Smart lights: all off
openhue set room "$ROOM" --off
echo "Done: Smart lights off"

# Light switches: all off
# Update path to your lutron skill
~/.openclaw/workspace/skills/lutron/scripts/lutron.sh all 0
echo "Done: Light switches off"

# Thermostats: all off
# Update path to your nest skill
~/.openclaw/workspace/skills/nest/scripts/nest.sh mode OFF
echo "Done: Thermostats off"

# Speakers: pause
sonos pause --name "$SPEAKER" 2>/dev/null
echo "Done: Speakers off"

# Fan: on
# Update path to your kasa skill
~/.openclaw/workspace/skills/kasa/scripts/kasa.sh "$FAN_DEVICE" on
echo "Done: Fan on"

echo "Sleep Mode active. Good night!"
