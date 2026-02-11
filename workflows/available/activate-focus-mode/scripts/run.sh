#!/usr/bin/env bash
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
[ -f "$SCRIPT_DIR/../config.env" ] && source "$SCRIPT_DIR/../config.env"

echo "Activating Focus Mode..."

# Smart lights: bright daylight
openhue set room "$ROOM" --on --color white --brightness 100
echo "Done: Bright daylight lights"

# Light switches: full brightness
~/.openclaw/workspace/skills/lutron/scripts/lutron.sh all 100
echo "Done: Light switches at 100%"

# Speakers: mute
sonos pause --name "$SPEAKER" 2>/dev/null
echo "Done: Speakers muted"

# Block distracting sites
if [ -n "$BLOCKED_SITES" ]; then
    IFS=',' read -ra SITES <<< "$BLOCKED_SITES"
    for site in "${SITES[@]}"; do
        site=$(echo "$site" | xargs)
        sudo sh -c "echo '127.0.0.1 $site' >> /etc/hosts"
    done
    sudo dscacheutil -flushcache
    echo "Done: Distracting sites blocked"
fi

echo "Focus Mode active. Time to do great work!"
