#!/usr/bin/env bash
# Sleep Mode
#
# Customize the commands below for your setup:
# - Replace room names with yours ("Living room" -> your room)
# - Replace speaker names with yours
# - Replace device names with yours ("Bedroom fan" -> your device)
# - Update skill paths if installed elsewhere

echo "Activating Sleep Mode..."

# Smart lights: all off
openhue set room "Living room" --off
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
# Update speaker name to yours
sonos pause --name "Living Room" 2>/dev/null
echo "Done: Speakers off"

# Fan: on
# Update device name to yours
~/.openclaw/workspace/skills/kasa/scripts/kasa.sh "Bedroom fan" on
echo "Done: Fan on"

echo "Sleep Mode active. Good night!"
