# ⚡️ ClawFlows — Superpowers for your OpenClaw

<p align="center">
  <img src="assets/header.png" alt="ClawFlows - Lobster Minions doing ALL the tasks" width="100%" />
</p>

**ClawFlows** is a collection of ready-to-use workflows for [OpenClaw](https://github.com/openclaw/openclaw) agents. Each workflow is a complete automation your agent can run — smart home control, email triage, morning briefings, and more. Just install a workflow and your agent learns a new trick.

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

## Essentials Pack

The 13 workflows every agent needs. Your complete daily rhythm — from wake to sleep.

| # | Workflow | When | What it does |
|---|----------|------|--------------|
| 1 | [send-morning-quote](available/send-morning-quote/) | 7am | Inspirational quote to start the day |
| 2 | [send-morning-briefing](available/send-morning-briefing/) | 7am | Weather, calendar, priorities, overnight alerts |
| 3 | [check-calendar](available/check-calendar/) | Morning + evening | 48-hour radar with conflicts and prep notes |
| 4 | [triage-tasks](available/triage-tasks/) | Morning | What's due, what's overdue, top 3 priorities |
| 5 | [send-news-digest](available/send-news-digest/) | Morning or evening | Curated news on topics you care about |
| 6 | [build-meeting-prep](available/build-meeting-prep/) | Before calls | Attendee context, history, talking points |
| 7 | [process-email](available/process-email/) | 2-3x/day | Auto-unsubscribe, archive junk, summarize important |
| 8 | [check-follow-ups](available/check-follow-ups/) | Daily | Unanswered emails, promises you made, balls about to drop |
| 9 | [check-messages](available/check-messages/) | Ongoing | Unified Slack, Discord, Telegram, WhatsApp triage |
| 10 | [check-x](available/check-x/) | 1-2x/day | Mentions, DMs, engagement, content |
| 11 | [build-standup](available/build-standup/) | 9am | Auto-generate daily standup from git + tasks |
| 12 | [send-daily-wrap](available/send-daily-wrap/) | 9pm | What you accomplished, what's pending, tomorrow preview |
| 13 | [send-bedtime-reminder](available/send-bedtime-reminder/) | 10pm | Tomorrow's first event, sleep math, wind-down nudge |

**The daily rhythm:**

```
MORNING     quote → briefing → calendar → tasks → news → standup
MIDDAY      meeting-prep → email → follow-ups → messages → X
EVENING     daily-wrap → bedtime-reminder
```

Enable all essentials at once:
```bash
clawflows enable send-morning-quote send-morning-briefing check-calendar triage-tasks send-news-digest build-meeting-prep process-email check-follow-ups check-messages check-x build-standup send-daily-wrap send-bedtime-reminder
```

## Getting Started

### 1. Install

```bash
curl -fsSL https://raw.githubusercontent.com/davehappyminion/clawflows/main/install.sh | bash
```

This clones the repo to `~/.clawflows`, adds the CLI to your PATH, and syncs with your agent's AGENTS.md.

Already cloned? Run `bash install.sh` from the repo root instead.

### 2. Enable a workflow

```bash
clawflows enable activate-sleep-mode
```

This copies the workflow from `available/` to `enabled/` and automatically updates your agent's `AGENTS.md` with the workflow catalog.

To see what's available:

```bash
clawflows list
```

### 3. Configure (if needed)

Some workflows have scripts with configurable values. Copy the example config and fill in your values:

```bash
cd enabled/activate-sleep-mode
cp config.example.env config.env
# Edit config.env with your room names, speaker names, etc.
```

### 4. Run it

Tell your agent to follow the workflow:

```
Read and follow clawflows/enabled/activate-sleep-mode/WORKFLOW.md
```

Or schedule it with a cron:

```bash
openclaw cron create \
  --name "Sleep Mode" \
  --schedule "20 21 * * *" \
  --tz "America/New_York" \
  --message "Read and follow clawflows/enabled/activate-sleep-mode/WORKFLOW.md"
```

## CLI Reference

The `clawflows` CLI manages your enabled workflows and keeps your agent's `AGENTS.md` in sync.

| Command | What it does |
|---------|-------------|
| `clawflows list` | Show all available workflows with enabled/disabled status |
| `clawflows enable <name>` | Copy workflow from `available/` to `enabled/`, update AGENTS.md |
| `clawflows disable <name>` | Remove workflow from `enabled/`, update AGENTS.md |
| `clawflows sync` | Regenerate the ClawFlows section in AGENTS.md from current `enabled/` |

### AGENTS.md Integration

When you enable or disable a workflow, `clawflows` automatically maintains a section in `AGENTS.md` (between `<!-- clawflows:start -->` and `<!-- clawflows:end -->` markers) with:

- Instructions for managing workflows
- A catalog of all enabled workflows with descriptions and paths

This gives your agent full discovery of available workflows at startup with zero manual maintenance. The agent reads AGENTS.md on every session and knows exactly which workflows are enabled and where to find them.

Set `AGENTS_MD` to override the default path (`~/.openclaw/workspace/AGENTS.md`).

## Available Workflows

| Workflow | What it does |
|----------|-------------|
| [activate-away-mode](available/activate-away-mode/) | Everything off, thermostat to eco — for when you leave the house |
| [activate-focus-mode](available/activate-focus-mode/) | Bright daylight lights, mutes speakers, blocks distracting sites |
| [activate-morning-mode](available/activate-morning-mode/) | Bright warm lights, comfortable thermostat, energizing music |
| [activate-night-mode](available/activate-night-mode/) | Dims lights to warm red, plays sleep music |
| [activate-sleep-mode](available/activate-sleep-mode/) | Turns off all lights, speakers, thermostats + turns on bedroom fan |
| [build-changelog](available/build-changelog/) | Generates a formatted changelog from git history since the last tag |
| [build-meeting-prep](available/build-meeting-prep/) | Comprehensive prep doc with attendee research, history, and talking points |
| [build-nightly-project](available/build-nightly-project/) | Picks an idea from a queue and builds a small project overnight |
| [build-standup](available/build-standup/) | Auto-generates daily standup from git commits and completed tasks |
| [build-weekly-review](available/build-weekly-review/) | Compiles the week's git commits, calendar, and accomplishments into a review doc |
| [check-calendar](available/check-calendar/) | 48-hour radar with conflict detection, travel time, and prep notes |
| [check-disk](available/check-disk/) | Disk space audit — large files, caches, cleanup recommendations |
| [check-follow-ups](available/check-follow-ups/) | Finds unanswered emails, promises you made, and balls about to drop |
| [check-messages](available/check-messages/) | Unified triage across Slack, Discord, Telegram, WhatsApp |
| [check-repos](available/check-repos/) | Scans local git repos for uncommitted changes, stale branches, unpushed commits |
| [check-security](available/check-security/) | Security hygiene — updates, open ports, FileVault, Firewall status |
| [check-x](available/check-x/) | X/Twitter engagement — notifications, mentions, content, custom PFPs |
| [process-contacts](available/process-contacts/) | Deduplicates macOS contacts, flags missing fields, identifies stale entries |
| [process-downloads](available/process-downloads/) | Organizes downloads by file type, removes duplicates, archives old files |
| [process-email](available/process-email/) | Auto-unsubscribes, archives noise, summarizes what needs attention |
| [process-notifications](available/process-notifications/) | Audits macOS notification settings, identifies noisy apps, suggests silencing |
| [process-screenshots](available/process-screenshots/) | Sorts screenshots into dated folders, removes duplicates, cleans up old ones |
| [send-bedtime-reminder](available/send-bedtime-reminder/) | Tomorrow preview, sleep math, and wind-down suggestions |
| [send-daily-wrap](available/send-daily-wrap/) | End-of-day summary — what you accomplished, what's pending, tomorrow preview |
| [send-expense-report](available/send-expense-report/) | Scans Gmail for receipts, categorizes spending, sends a monthly report |
| [send-morning-briefing](available/send-morning-briefing/) | Weather, calendar, priorities, urgent items — your daily command center |
| [send-morning-quote](available/send-morning-quote/) | Inspirational quote to start the day, themed to your goals |
| [send-news-digest](available/send-news-digest/) | Curated news on topics you care about — no doom-scrolling required |
| [send-weekly-digest](available/send-weekly-digest/) | Week-in-review summary delivered via messaging |
| [sync-bookmarks](available/sync-bookmarks/) | Checks bookmarks for dead links, removes duplicates, organizes by topic |
| [sync-calendar-tasks](available/sync-calendar-tasks/) | Extracts action items from calendar events, suggests tasks |
| [sync-dotfiles](available/sync-dotfiles/) | Backs up dotfiles and Homebrew config to a git repo |
| [triage-tasks](available/triage-tasks/) | Morning task review — what's due, overdue, and your top 3 priorities |

## Creating Your Own

See [docs/creating-workflows.md](docs/creating-workflows.md) for the full guide on writing workflows — format, naming conventions, scripts, and configuration.

Add community workflows to `available/` via pull request. Add personal workflows directly to `enabled/` (it's gitignored).

## License

MIT
