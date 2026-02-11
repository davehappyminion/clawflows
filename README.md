# ⚡️ ClawFlows

<p align="center">
  <img src="assets/header.png" alt="ClawFlows" width="100%" />
</p>

33 ready-to-use workflows for [OpenClaw](https://github.com/openclaw/openclaw). One install, and your agent learns to:

- **"Sleep mode"** — Turn off every light, stop the music, drop the thermostat, flip on the bedroom fan. One command, five systems, zero fumbling with apps.
- **"Check my email"** — Auto-unsubscribe from junk, archive the noise, and get a clean summary of what actually needs your attention.
- **"Morning briefing"** — Wake up to today's weather, your calendar, and anything urgent — delivered before you open your eyes.
- **"Prep for my meeting"** — Research every attendee, pull conversation history, and generate talking points. Ready before you join the call.
- **"Build something while I sleep"** — Your agent picks an idea from a queue and builds a working project overnight. You wake up to a finished tool.

These aren't prompts you hope work. They're tested runbooks your agent executes reliably, every time. No crossed fingers required.

## The Daily Rhythm

13 workflows that automate your entire day — from wake to sleep.

| | Workflow | When | What it does |
|---|----------|------|--------------|
| 1 | ✨ [send-morning-inspiration](available/send-morning-inspiration/) | 7am | Inspirational quote themed to your goals |
| 2 | ☀️ [send-morning-briefing](available/send-morning-briefing/) | 7am | Weather, calendar, priorities, overnight alerts |
| 3 | 📅 [check-calendar](available/check-calendar/) | Morning + evening | 48-hour radar with conflicts and prep notes |
| 4 | ✅ [triage-tasks](available/triage-tasks/) | Morning | What's due, what's overdue, top 3 priorities |
| 5 | 📰 [send-news-digest](available/send-news-digest/) | Morning or evening | Curated news on topics you care about |
| 6 | 🎯 [build-meeting-prep](available/build-meeting-prep/) | Before calls | Attendee context, history, talking points |
| 7 | 📧 [process-email](available/process-email/) | 2-3x/day | Auto-unsubscribe, archive junk, summarize important |
| 8 | 🔔 [check-follow-ups](available/check-follow-ups/) | Daily | Unanswered emails, promises you made, balls about to drop |
| 9 | 💬 [check-messages](available/check-messages/) | Ongoing | Unified Slack, Discord, Telegram, WhatsApp triage |
| 10 | 🐦 [check-x](available/check-x/) | 1-2x/day | Mentions, DMs, engagement, content |
| 11 | 🧍 [build-standup](available/build-standup/) | 9am | Auto-generate standup from git + tasks |
| 12 | 🌆 [send-daily-wrap](available/send-daily-wrap/) | 9pm | What you accomplished, what's pending, tomorrow preview |
| 13 | 😴 [send-bedtime-reminder](available/send-bedtime-reminder/) | 10pm | Tomorrow's first event, sleep math, wind-down nudge |

```
MORNING     ✨ inspiration → ☀️ briefing → 📅 calendar → ✅ tasks → 📰 news → 🧍 standup
MIDDAY      🎯 meeting-prep → 📧 email → 🔔 follow-ups → 💬 messages → 🐦 X
EVENING     🌆 daily-wrap → 😴 bedtime-reminder
```

Enable them all at once:
```bash
clawflows enable send-morning-inspiration send-morning-briefing check-calendar triage-tasks send-news-digest build-meeting-prep process-email check-follow-ups check-messages check-x build-standup send-daily-wrap send-bedtime-reminder
```

## Install

```bash
curl -fsSL https://raw.githubusercontent.com/davehappyminion/clawflows/main/install.sh | bash
```

Then enable your first workflow:

```bash
clawflows enable check-repos
```

Tell your agent to run it — it scans every git repo on your machine for uncommitted changes, stale branches, and unpushed commits. No API keys, no config — just works.

Run `clawflows list` to see all 33.

## All Workflows

### 🏠 Smart Home

| Workflow | What it does |
|----------|-------------|
| 🛏️ [activate-sleep-mode](available/activate-sleep-mode/) | Turns off all lights, speakers, thermostats + turns on bedroom fan |
| 🌙 [activate-night-mode](available/activate-night-mode/) | Dims lights to warm red, plays sleep music |
| 🌅 [activate-morning-mode](available/activate-morning-mode/) | Bright warm lights, comfortable thermostat, energizing music |
| 🧘 [activate-focus-mode](available/activate-focus-mode/) | Bright daylight lights, mutes speakers, blocks distracting sites |
| 🚪 [activate-away-mode](available/activate-away-mode/) | Everything off, thermostat to eco — for when you leave the house |

### 💬 Communication

| Workflow | What it does |
|----------|-------------|
| 📧 [process-email](available/process-email/) | Auto-unsubscribes, archives noise, summarizes what needs attention |
| 🔔 [check-follow-ups](available/check-follow-ups/) | Finds unanswered emails, promises you made, and balls about to drop |
| 💬 [check-messages](available/check-messages/) | Unified triage across Slack, Discord, Telegram, WhatsApp |
| 🐦 [check-x](available/check-x/) | X/Twitter engagement — notifications, mentions, content, custom PFPs |
| 📇 [process-contacts](available/process-contacts/) | Deduplicates macOS contacts, flags missing fields, identifies stale entries |

### 📊 Productivity

| Workflow | What it does |
|----------|-------------|
| 📅 [check-calendar](available/check-calendar/) | 48-hour radar with conflict detection, travel time, and prep notes |
| ✅ [triage-tasks](available/triage-tasks/) | Morning task review — what's due, overdue, and your top 3 priorities |
| 🎯 [build-meeting-prep](available/build-meeting-prep/) | Prep doc with attendee research, history, and talking points |
| 🧍 [build-standup](available/build-standup/) | Auto-generates daily standup from git commits and completed tasks |
| 📊 [build-weekly-review](available/build-weekly-review/) | Compiles the week's git commits, calendar, and accomplishments |
| 📝 [build-changelog](available/build-changelog/) | Generates a formatted changelog from git history since the last tag |
| 🔨 [build-nightly-project](available/build-nightly-project/) | Picks an idea from a queue and builds a small project overnight |
| 📆 [sync-calendar-tasks](available/sync-calendar-tasks/) | Extracts action items from calendar events, suggests tasks |

### 📨 Briefings & Reports

| Workflow | What it does |
|----------|-------------|
| ☀️ [send-morning-briefing](available/send-morning-briefing/) | Weather, calendar, priorities, urgent items — your daily command center |
| ✨ [send-morning-inspiration](available/send-morning-inspiration/) | Inspirational quote to start the day, themed to your goals |
| 📰 [send-news-digest](available/send-news-digest/) | Curated news on topics you care about — no doom-scrolling required |
| 🌆 [send-daily-wrap](available/send-daily-wrap/) | End-of-day summary — what you accomplished, what's pending, tomorrow preview |
| 😴 [send-bedtime-reminder](available/send-bedtime-reminder/) | Tomorrow preview, sleep math, and wind-down suggestions |
| 📋 [send-weekly-digest](available/send-weekly-digest/) | Week-in-review summary delivered via messaging |
| 💰 [send-expense-report](available/send-expense-report/) | Scans Gmail for receipts, categorizes spending, sends a monthly report |

### 🔧 System & Cleanup

| Workflow | What it does |
|----------|-------------|
| 💾 [check-disk](available/check-disk/) | Disk space audit — large files, caches, cleanup recommendations |
| 🔍 [check-repos](available/check-repos/) | Scans local git repos for uncommitted changes, stale branches, unpushed commits |
| 🔒 [check-security](available/check-security/) | Security hygiene — updates, open ports, FileVault, Firewall status |
| 📦 [sync-dotfiles](available/sync-dotfiles/) | Backs up dotfiles and Homebrew config to a git repo |
| 📥 [process-downloads](available/process-downloads/) | Organizes downloads by file type, removes duplicates, archives old files |
| 📸 [process-screenshots](available/process-screenshots/) | Sorts screenshots into dated folders, removes duplicates, cleans up old ones |
| 🔕 [process-notifications](available/process-notifications/) | Audits macOS notification settings, identifies noisy apps, suggests silencing |
| 🔖 [sync-bookmarks](available/sync-bookmarks/) | Checks bookmarks for dead links, removes duplicates, organizes by topic |

## Configuration

Some workflows need setup — smart home devices, messaging tokens, API keys. After enabling:

```bash
cd ~/.clawflows/enabled/activate-sleep-mode
cp config.example.env config.env
# Edit config.env with your values
```

Workflows that need config will tell you when you enable them.

## Scheduling

Run workflows automatically with cron:

```bash
openclaw cron create \
  --name "Sleep Mode" \
  --schedule "20 21 * * *" \
  --tz "America/New_York" \
  --message "Run the activate-sleep-mode workflow"
```

## Creating Your Own

See [docs/creating-workflows.md](docs/creating-workflows.md) for the full guide — format, naming, scripts, and configuration.

Community workflows go in `available/` via pull request. Personal workflows go in `enabled/` (it's gitignored).

Workflows follow the [Agent Skills](https://agentskills.io) format, so they work with Claude Code, OpenClaw, and any agent that supports the spec.

## CLI Reference

| Command | What it does |
|---------|-------------|
| `clawflows list` | Show all workflows with enabled/disabled status |
| `clawflows enable <name>` | Enable a workflow and update AGENTS.md |
| `clawflows disable <name>` | Disable a workflow and update AGENTS.md |
| `clawflows sync` | Regenerate the ClawFlows section in AGENTS.md |

When you enable a workflow, the CLI updates your agent's `AGENTS.md` so it discovers workflows automatically at startup. Set `AGENTS_MD` to override the default path (`~/.openclaw/workspace/AGENTS.md`).

## License

MIT
