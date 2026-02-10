# Clawflows

Reusable workflows for AI agents. Each workflow is a self-contained folder that tells an agent exactly what to do — step by step, with the specific commands to run.

Workflows follow the [Agent Skills](https://agentskills.io) format so they work with Claude Code, OpenClaw, and any agent that supports the spec.

## What's a Workflow?

A workflow is a repeatable task broken down into clear steps. Instead of telling your agent "go clean up my email" and hoping for the best, you give it a `WORKFLOW.md` with exact instructions — what tools to use, what order to do things, and what to report back.

Think of it as a runbook for your AI agent.

## Structure

Each workflow is a folder with a `WORKFLOW.md` and optional scripts:

```
activate-sleep-mode/
├── WORKFLOW.md       # Instructions (frontmatter + steps)
└── scripts/          # Optional automation scripts
    └── run.sh
```

### WORKFLOW.md Format

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

**Frontmatter fields:**

| Field | Required | Description |
|-------|----------|-------------|
| `name` | Yes | Matches the folder name. Lowercase, hyphenated, verb-first. |
| `description` | Yes | What it does + trigger phrases (how the agent knows when to use it). |
| `requires` | No | Skills and tools needed. Each has a `name` and `description`. |

## Naming Convention

Workflow names start with a verb. Pick from these six:

| Verb | Use for | Examples |
|------|---------|----------|
| **activate** | Toggle a mode or state | `activate-sleep-mode`, `activate-night-mode` |
| **process** | Clean up or transform data | `process-email`, `process-notifications` |
| **check** | Monitor or review something | `check-x`, `check-calendar` |
| **build** | Create something new | `build-nightly-project`, `build-cards` |
| **send** | Deliver output to someone | `send-morning-briefing`, `send-report` |
| **sync** | Reconcile data between systems | `sync-contacts`, `sync-calendar` |

## Included Workflows

| Workflow | What it does |
|----------|-------------|
| [activate-sleep-mode](activate-sleep-mode/) | Turns off all lights, speakers, thermostats + turns on bedroom fan |
| [activate-night-mode](activate-night-mode/) | Dims lights to warm red, plays sleep music |
| [build-nightly-project](build-nightly-project/) | Picks an idea from a queue and builds a small project overnight |
| [check-x](check-x/) | Checks X/Twitter notifications, engages with followers |
| [process-email](process-email/) | Unsubscribes from junk, archives mailing lists, summarizes important mail |
| [send-morning-briefing](send-morning-briefing/) | Gathers weather, calendar, news and delivers a daily summary |

## The `requires` Field

Each workflow lists what tools and services it needs. This tells you (and the agent) what has to be set up before the workflow will work.

```yaml
requires:
  - name: openhue
    description: Philips Hue smart bulbs
  - name: lutron
    description: Lutron Caseta light switches and dimmers
  - name: sonos
    description: Sonos wireless speakers
```

The `name` matches the skill name (from that skill's `SKILL.md` frontmatter). The `description` explains what it is in plain English — so anyone reading the workflow understands what they need, even if they've never heard of the specific tool.

## How to Use

### 1. Pick a workflow

Browse the folders. Each `WORKFLOW.md` explains what it does.

### 2. Check requirements

Look at the `requires` field. Make sure you have those tools installed and configured. If you use different tools (e.g., LIFX instead of Hue), swap the commands in the workflow.

### 3. Customize

- Replace placeholder values (`YOUR_EMAIL`, `YOUR_PLAYLIST_ID`, room names, device names)
- Update scripts with your specific setup
- Adjust the steps to match your tools

### 4. Run it

Tell your agent to follow the workflow:

```
Read and follow workflows/activate-sleep-mode/WORKFLOW.md
```

Or schedule it with a cron:

```bash
openclaw cron create \
  --name "Sleep Mode" \
  --schedule "20 21 * * *" \
  --tz "America/New_York" \
  --message "Read and follow workflows/activate-sleep-mode/WORKFLOW.md"
```

## Creating Your Own

1. Create a folder: `workflows/<verb-noun>/`
2. Add a `WORKFLOW.md` with frontmatter (`name`, `description`, `requires`) and step-by-step instructions
3. Optionally add `scripts/run.sh` for executable automation
4. Keep it self-contained — someone reading just the `WORKFLOW.md` should be able to follow it

## License

MIT
