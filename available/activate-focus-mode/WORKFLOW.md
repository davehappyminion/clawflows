---
name: activate-focus-mode
description: Focus mode — bright daylight lighting, mutes speakers, and blocks distracting websites.
requires:
  - name: openhue
    description: Philips Hue smart bulbs
  - name: lutron
    description: Lutron Caseta light switches and dimmers
  - name: sonos
    description: Sonos wireless speakers
---

# Focus Mode

Bright lights, no noise, no distractions — time to do deep work.

## Run It

```bash
bash {baseDir}/scripts/run.sh
```

## What It Does

1. **Bright daylight lights** — full brightness, cool white (Hue)
2. **Light switches up** — all dimmers to 100% (Lutron)
3. **Speakers muted** — pause all playback (Sonos)
4. **Distractions blocked** — adds distracting sites to /etc/hosts

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
| `BLOCKED_SITES` | Comma-separated list of sites to block |

## Notes

- The script sources `config.env` — no hardcoded values
- Run the script again with `--off` to unblock sites and restore normal mode
