# ClawFlows

## What is this used for?

The most common question heard around the world in the last week is: **"What are you using your OpenClaw for?"**

And the next question is always: **"How do I set that up?"**

This is the answer to both. You're welcome.

ClawFlows is a collection of ready-to-use workflows for AI agents. Each workflow is a complete automation — step-by-step instructions your agent follows to get real things done, with the exact commands to run.

**Here's what that looks like in practice:**

- **"Sleep mode"** — Say goodnight and your agent turns off every light in your house, pauses the music, shuts down the thermostat, and flips on your bedroom fan. One command, five systems, zero fumbling with apps. Your spouse will think you've finally become useful. You haven't. But they don't need to know that.

- **"Check my email"** — Your agent scans your inbox, auto-unsubscribes from newsletters you never read (yes, that one from 2019), archives the noise, and gives you a clean summary of what actually matters. It's like having an assistant, except this one doesn't judge you for subscribing to 47 Substacks.

- **"Morning briefing"** — Wake up to a message with today's weather, your calendar, and anything urgent — delivered before you even ask. It's like having a butler, minus the weird British accent and the judgment about your sleep schedule.

- **"Build something while I sleep"** — Your agent picks an idea from your queue and builds a working project overnight. You wake up to a finished tool with documentation. Finally, a use for those 3am "genius" ideas you keep having.

These aren't prompts you hope work. They're battle-tested runbooks your agent executes reliably, every time. No crossed fingers required.

Workflows follow the [Agent Skills](https://agentskills.io) format, so they work with Claude Code, OpenClaw, and any agent that supports the spec.

## Why Use ClawFlows?

Centralized workflows give AI agents a major advantage over ad-hoc prompting. Also they make you look like you know what you're doing:

1. **Easily shareable** — Share workflows between teams, communities, or projects. Someone solves a problem once, everyone benefits. It's like open source, but for making your robot do things.
2. **Deterministic execution** — Scripts handle specific functions reliably. No guessing, no variation. The agent follows the same steps every time. Unlike your coworker Dave.
3. **Efficient and lightweight** — One workflow library serves all your agents. No bloated prompts eating up context windows. Your token bill will thank you. Your accountant might actually smile.
4. **No duplication** — Common patterns live in one place. Update once, apply everywhere. No more copy-pasting the same steps across different automations like some kind of caveman.
5. **Version controlled** — Track changes, roll back mistakes, collaborate with others. Workflows evolve with your needs. Git blame your past self when things break.
6. **Agent-agnostic** — Works with Claude Code, OpenClaw, or any agent that supports the Agent Skills spec. Switch agents without rewriting everything. Commitment issues? We got you.

## Structure

Each workflow is a folder with a `WORKFLOW.md` and optional scripts:

```
activate-sleep-mode/
├── WORKFLOW.md          # Instructions (frontmatter + steps)
├── config.example.env   # Example config (commit this)
├── config.env           # Your config (gitignored)
└── scripts/             # Optional automation scripts
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

### 3. Configure

For workflows with scripts, copy the example config and fill in your values:

```bash
cd activate-sleep-mode
cp config.example.env config.env
# Edit config.env with your room names, speaker names, etc.
```

The `config.env` file is gitignored so your personal setup stays local. Scripts source it automatically — no hardcoded values to find and replace.

Config is optional. Scripts still work without it — they'll just use whatever values are hardcoded in the script itself.

For workflows without scripts, update the `WORKFLOW.md` steps directly.

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
4. If using scripts, add a `config.example.env` with placeholder values (users copy to `config.env`)
5. Keep it self-contained — someone reading just the `WORKFLOW.md` should be able to follow it

## License

MIT
