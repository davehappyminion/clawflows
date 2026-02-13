---
name: activate-away-mode
emoji: 🚪
description: Away mode — turns everything off and sets thermostat to eco mode for when you leave the house.
author: @davehappyminion
---

# Away Mode

Everything off, thermostat to eco — the house is empty.

## 1. Turn Off Lights

Using your **smart lighting skill**, turn off all lights:
- Smart bulbs (all rooms)
- Light switches and dimmers to 0%

## 2. Set Thermostat to Eco

Using your **thermostat skill**, set to ECO or AWAY mode:
- Lower heating target
- Raise cooling target
- Or use the thermostat's built-in away mode

## 3. Stop Music/Media

Using your **speaker skill**, pause all playback:
- Living room speakers
- Bedroom speakers
- Any active media

## 4. Turn Off Smart Plugs

Using your **smart plug skill**, turn off non-essential plugs:
- Entertainment devices
- Decorative lighting
- Non-critical appliances

Keep essential plugs on (refrigerator, etc.).

## 5. Security (Optional)

If available, using your **security skill**:
- Arm the security system
- Enable cameras
- Lock smart locks

## After Running

Report what succeeded and what failed — one line per item:

```
🚪 Away Mode Activated

✅ Lights: All off
✅ Thermostat: ECO mode (62°F)
✅ Speakers: Paused
✅ Smart plugs: 4 turned off
⚠️ Security: Not configured

House is buttoned up. See you later!
```

## Notes

- Pairs well with a geofence trigger or manual activation
- Can be reversed with activate-morning-mode or a "home" mode
- Don't turn off plugs that power things that shouldn't be interrupted
