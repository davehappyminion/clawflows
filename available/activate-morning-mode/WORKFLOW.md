---
name: activate-morning-mode
description: Morning mode — bright warm lighting, comfortable thermostat, and energizing music to start the day.
requires:
  - name: openhue
    description: Philips Hue smart bulbs
  - name: lutron
    description: Lutron Caseta light switches and dimmers
  - name: nest
    description: Google Nest smart thermostats
  - name: sonos
    description: Sonos wireless speakers
---

# Morning Mode

Bright warm lights, comfortable temperature, and energizing music to start the day.

## Run It

```bash
bash {baseDir}/scripts/run.sh
```

## What It Does

1. **Warm bright lights** — full brightness, warm white (Hue)
2. **Light switches on** — all dimmers to 80% (Lutron)
3. **Thermostat comfortable** — set to HEAT at your target temp (Nest)
4. **Morning music** — plays an energizing playlist (Sonos)

## After Running

Report what succeeded and what failed — one line per item.

## Config

Copy `config.example.env` to `config.env` and set your values:

```bash
cp config.example.env config.env
```

| Variable | What it is |
|----------|-----------|
| `ROOM` | Hue room name to brighten |
| `SPEAKER` | Sonos speaker name |
| `PLAYLIST` | Spotify playlist URI for morning music |
| `TEMP` | Target thermostat temperature (°F) |

## Notes

- The script sources `config.env` — no hardcoded values
- Schedule via cron for automatic morning activation (e.g., 6:30 AM)
