---
name: activate-night-mode
description: Wind-down mode — dims lights to a warm color, turns off bright switches, and plays sleep music. Use when the user says "night mode", "wind down", "dim the lights", or "relaxation mode".
requires:
  - name: openhue
    description: Philips Hue smart bulbs
  - name: lutron
    description: Lutron Caseta light switches and dimmers
  - name: sonos
    description: Sonos wireless speakers
---

# Night Mode

Wind down for the evening — dim warm lighting and sleep music.

## Run It

```bash
bash {baseDir}/scripts/run.sh
```

## What It Does

1. **Light switches off** — all dimmers to 0% (Lutron)
2. **Smart lights dimmed** — warm red, low brightness (Hue)
3. **Sleep music** — plays a sleep playlist on speakers (Sonos)

## After Running

Report what succeeded and what failed.

## Config

Copy `config.example.env` to `config.env` and set your values:

```bash
cp config.example.env config.env
```

| Variable | What it is |
|----------|-----------|
| `ROOM` | Hue room name to dim |
| `SPEAKER` | Sonos speaker name |
| `PLAYLIST` | Spotify playlist URI for sleep music |

## Notes

- The script sources `config.env` — no hardcoded values
- Schedule via cron for automatic evening activation
