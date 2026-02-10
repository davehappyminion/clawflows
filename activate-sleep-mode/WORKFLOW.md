---
name: activate-sleep-mode
description: Bedtime automation — turns off all lights, thermostats, and music, then turns on the bedroom fan. Use when the user says "sleep mode", "bedtime", "going to bed", or "shut everything down".
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

# Sleep Mode

Turn everything off for bed.

## Run It

```bash
bash {baseDir}/scripts/run.sh
```

## What It Does

1. **Smart lights off** — all rooms (Hue via `openhue`)
2. **Light switches off** — all dimmers to 0% (Lutron)
3. **Thermostats off** — all set to OFF mode (Nest)
4. **Speakers off** — pause playback (Sonos)
5. **Fan on** — bedroom fan smart plug (Kasa)

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
| `FAN_DEVICE` | Kasa smart plug name for the fan |

## Notes

- The script sources `config.env` — no hardcoded values
- Schedule via cron for automatic nightly activation
