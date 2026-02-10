# Creating Workflows

How to build your own ClawFlows workflow.

## Workflow Structure

Each workflow is a folder with a `WORKFLOW.md` and optional scripts:

```
my-workflow/
├── WORKFLOW.md          # Instructions (frontmatter + steps)
├── config.example.env   # Example config (commit this)
├── config.env           # Your config (gitignored)
└── scripts/             # Optional automation scripts
    └── run.sh
```

## WORKFLOW.md Format

```yaml
---
name: activate-sleep-mode
description: What this does and when to trigger it.
requires:
  - name: openhue
    description: Philips Hue smart bulbs
  - name: sonos
    description: Sonos wireless speakers
---

# Sleep Mode

## What It Does
1. Turn off all lights
2. Pause speakers
3. Report results

## After Running
Tell me what worked and what didn't.
```

## Frontmatter Fields

| Field | Required | Description |
|-------|----------|-------------|
| `name` | Yes | Matches the folder name. Lowercase, hyphenated, verb-first. |
| `description` | Yes | What it does — a plain description the agent can match on. |
| `requires` | No | Skills and tools needed. Each has a `name` and `description`. |

### Writing Good Descriptions

The `description` field tells humans and agents what the workflow does. Write a clear, concise description — the agent will match on it naturally without explicit trigger phrases:

```yaml
description: Bedtime automation — turns off all lights, thermostats, and music, then turns on the bedroom fan.
```

### The `requires` Field

List the tools and services the workflow needs. The `name` matches the skill name (from that skill's `SKILL.md` frontmatter). The `description` explains what it is in plain English.

```yaml
requires:
  - name: openhue
    description: Philips Hue smart bulbs
  - name: lutron
    description: Lutron Caseta light switches and dimmers
```

## Naming Convention

Workflow names start with a verb. Pick from these six:

| Verb | Use for | Examples |
|------|---------|----------|
| **activate** | Toggle a mode or state | `activate-sleep-mode`, `activate-night-mode` |
| **process** | Clean up or transform data | `process-email`, `process-notifications` |
| **check** | Monitor or review something | `check-x`, `check-calendar` |
| **build** | Create something new | `build-nightly-project`, `build-changelog` |
| **send** | Deliver output to someone | `send-morning-briefing`, `send-report` |
| **sync** | Reconcile data between systems | `sync-dotfiles`, `sync-calendar` |

## Workflows with Scripts

For workflows that automate hardware or external services, include a `scripts/run.sh`:

```bash
#!/usr/bin/env bash
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
[ -f "$SCRIPT_DIR/../config.env" ] && source "$SCRIPT_DIR/../config.env"

echo "Activating Sleep Mode..."

# Your commands here
openhue set room "$ROOM" --off
echo "Done: Lights off"

echo "Sleep Mode active. Good night!"
```

Add a `config.example.env` with placeholder values so users know what to configure:

```
ROOM=Living room
SPEAKER=Living Room Speaker
```

Users copy it to `config.env` (which is gitignored) and fill in their values. The script sources it automatically.

## Agent-Only Workflows

For workflows that don't need scripts — where the agent follows instructions directly — just include a `WORKFLOW.md` with numbered steps and embedded commands:

```markdown
## 1. Fetch Data

Pull recent data:

` ` `bash
some-command --flag
` ` `

## 2. Process Results

For each result, do X...

## After Running

Report what you found.
```

## Adding Your Workflow

### To the community (available/)

1. Create your workflow folder in `available/`
2. Submit a pull request

### For personal use (enabled/)

1. Create your workflow folder directly in `enabled/`
2. It's gitignored, so it stays local

## Tips

- Keep it self-contained — someone reading just the `WORKFLOW.md` should be able to follow it
- Include example commands with placeholders (`YOUR_EMAIL`, etc.)
- Be specific about what to do, not theory
- End with an "After Running" or "Notes" section
- Test it before submitting
