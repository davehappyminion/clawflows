---
name: activate-away-mode
description: Away mode — turns everything off and sets thermostat to eco mode for when you leave the house.
requires:
  - name: openhue
    description: Philips Hue smart bulbs
  - name: lutron
    description: Lutron Caseta light switches and dimmers
  - name: nest
    description: Google Nest smart thermostats
  - name: kasa
    description: TP-Link Kasa smart plugs
  - name: sonos
    description: Sonos wireless speakers
---

# Away Mode

Everything off, thermostat to eco — the house is empty.

## Run It

```bash
bash {baseDir}/scripts/run.sh
```

## What It Does

1. **Smart lights off** — all rooms (Hue)
2. **Light switches off** — all dimmers to 0% (Lutron)
3. **Thermostat eco** — set to ECO mode (Nest)
4. **Speakers off** — pause all playback (Sonos)
5. **Smart plugs off** — all non-essential plugs (Kasa)

## After Running

Report what succeeded and what failed — one line per item.

## Config

Copy `config.example.env` to `config.env` and set your values:

```bash
cp config.example.env config.env
```

| Variable | What it is |
|----------|-----------|
| `ROOM` | Hue room name to turn off |
| `SPEAKER` | Sonos speaker name |
| `SMART_PLUGS` | Comma-separated Kasa smart plug names to turn off |

## Notes

- The script sources `config.env` — no hardcoded values
- Pairs well with a geofence trigger or manual activation
