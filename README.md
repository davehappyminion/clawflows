# ⚡️ Claw Workflows - Superpowers For Your Agent

<p align="center">
  <img src="docs/header.png" alt="ClawFlows" width="100%" />
</p>

Ready-to-use workflows for your [OpenClaw](https://github.com/openclaw/openclaw) agent. Install once, then:

- 🛏️ **Sleep mode** — Every light off, music stopped, thermostat down, bedroom fan on. One command. Five systems. Done.
- 📧 **Check my email** — Junk unsubscribed, noise archived, important stuff summarized. Your inbox, handled.
- ☀️ **Morning briefing** — Weather, calendar, priorities, and fires — delivered before you open your eyes.
- 🎯 **Prep for my meeting** — Attendees researched, history pulled, talking points written. Ready before you are.
- 🔨 **Build something while I sleep** — Picks an idea, builds it overnight, hands you a finished project in the morning.

## The Daily Rhythm

13 workflows that automate your entire day — from wake to sleep.

| | Workflow | When | What it does |
|---|----------|------|--------------|
| 1 | ✨ [send-morning-inspiration](workflows/available/send-morning-inspiration/) | 7am | Inspirational quote themed to your goals |
| 2 | ☀️ [send-morning-briefing](workflows/available/send-morning-briefing/) | 7am | Weather, calendar, priorities, overnight alerts |
| 3 | 📅 [check-calendar](workflows/available/check-calendar/) | Morning + evening | 48-hour radar with conflicts and prep notes |
| 4 | ✅ [triage-tasks](workflows/available/triage-tasks/) | Morning | What's due, what's overdue, top 3 priorities |
| 5 | 📰 [send-news-digest](workflows/available/send-news-digest/) | Morning or evening | Curated news on topics you care about |
| 6 | 🎯 [build-meeting-prep](workflows/available/build-meeting-prep/) | Before calls | Attendee context, history, talking points |
| 7 | 📧 [process-email](workflows/available/process-email/) | 2-3x/day | Auto-unsubscribe, archive junk, summarize important |
| 8 | 🔔 [check-follow-ups](workflows/available/check-follow-ups/) | Daily | Unanswered emails, promises you made, balls about to drop |
| 9 | 💬 [check-messages](workflows/available/check-messages/) | Ongoing | Unified Slack, Discord, Telegram, WhatsApp triage |
| 10 | 🐦 [check-x](workflows/available/check-x/) | 1-2x/day | Mentions, DMs, engagement, content |
| 11 | 🧍 [build-standup](workflows/available/build-standup/) | 9am | Auto-generate standup from git + tasks |
| 12 | 🌆 [send-daily-wrap](workflows/available/send-daily-wrap/) | 9pm | What you accomplished, what's pending, tomorrow preview |
| 13 | 😴 [send-bedtime-reminder](workflows/available/send-bedtime-reminder/) | 10pm | Tomorrow's first event, sleep math, wind-down nudge |

## Get Started

```bash
curl -fsSL https://raw.githubusercontent.com/openclaw/clawflows/main/system/install.sh | bash
clawflows enable check-repos
```

That's it. Tell your agent to run it. Run `clawflows list` to see everything available.

## All Workflows

### 🏠 Smart Home

| Workflow | What it does |
|----------|-------------|
| 🛏️ [activate-sleep-mode](workflows/available/activate-sleep-mode/) | Turns off all lights, speakers, thermostats + turns on bedroom fan |
| 🌙 [activate-night-mode](workflows/available/activate-night-mode/) | Dims lights to warm red, plays sleep music |
| 🌅 [activate-morning-mode](workflows/available/activate-morning-mode/) | Bright warm lights, comfortable thermostat, energizing music |
| 🧘 [activate-focus-mode](workflows/available/activate-focus-mode/) | Bright daylight lights, mutes speakers, blocks distracting sites |
| 🚪 [activate-away-mode](workflows/available/activate-away-mode/) | Everything off, thermostat to eco — for when you leave the house |

### 💬 Communication

| Workflow | What it does |
|----------|-------------|
| 📧 [process-email](workflows/available/process-email/) | Auto-unsubscribes, archives noise, summarizes what needs attention |
| 🔔 [check-follow-ups](workflows/available/check-follow-ups/) | Finds unanswered emails, promises you made, and balls about to drop |
| 💬 [check-messages](workflows/available/check-messages/) | Unified triage across Slack, Discord, Telegram, WhatsApp |
| 🐦 [check-x](workflows/available/check-x/) | X/Twitter engagement — notifications, mentions, content, custom PFPs |
| 📇 [process-contacts](workflows/available/process-contacts/) | Deduplicates macOS contacts, flags missing fields, identifies stale entries |

### 📊 Productivity

| Workflow | What it does |
|----------|-------------|
| 📅 [check-calendar](workflows/available/check-calendar/) | 48-hour radar with conflict detection, travel time, and prep notes |
| ✅ [triage-tasks](workflows/available/triage-tasks/) | Morning task review — what's due, overdue, and your top 3 priorities |
| 🎯 [build-meeting-prep](workflows/available/build-meeting-prep/) | Prep doc with attendee research, history, and talking points |
| 🧍 [build-standup](workflows/available/build-standup/) | Auto-generates daily standup from git commits and completed tasks |
| 📊 [build-weekly-review](workflows/available/build-weekly-review/) | Compiles the week's git commits, calendar, and accomplishments |
| 📝 [build-changelog](workflows/available/build-changelog/) | Generates a formatted changelog from git history since the last tag |
| 🔨 [build-nightly-project](workflows/available/build-nightly-project/) | Picks an idea from a queue and builds a small project overnight |
| 📆 [sync-calendar-tasks](workflows/available/sync-calendar-tasks/) | Extracts action items from calendar events, suggests tasks |

### 📨 Briefings & Reports

| Workflow | What it does |
|----------|-------------|
| ☀️ [send-morning-briefing](workflows/available/send-morning-briefing/) | Weather, calendar, priorities, urgent items — your daily command center |
| ✨ [send-morning-inspiration](workflows/available/send-morning-inspiration/) | Inspirational quote to start the day, themed to your goals |
| 📰 [send-news-digest](workflows/available/send-news-digest/) | Curated news on topics you care about — no doom-scrolling required |
| 🌆 [send-daily-wrap](workflows/available/send-daily-wrap/) | End-of-day summary — what you accomplished, what's pending, tomorrow preview |
| 😴 [send-bedtime-reminder](workflows/available/send-bedtime-reminder/) | Tomorrow preview, sleep math, and wind-down suggestions |
| 📋 [send-weekly-digest](workflows/available/send-weekly-digest/) | Week-in-review summary delivered via messaging |
| 💰 [send-expense-report](workflows/available/send-expense-report/) | Scans Gmail for receipts, categorizes spending, sends a monthly report |

### 🔧 System & Cleanup

| Workflow | What it does |
|----------|-------------|
| 💾 [check-disk](workflows/available/check-disk/) | Disk space audit — large files, caches, cleanup recommendations |
| 🔍 [check-repos](workflows/available/check-repos/) | Scans local git repos for uncommitted changes, stale branches, unpushed commits |
| 🔒 [check-security](workflows/available/check-security/) | Security hygiene — updates, open ports, FileVault, Firewall status |
| 📦 [sync-dotfiles](workflows/available/sync-dotfiles/) | Backs up dotfiles and Homebrew config to a git repo |
| 📥 [process-downloads](workflows/available/process-downloads/) | Organizes downloads by file type, removes duplicates, archives old files |
| 📸 [process-screenshots](workflows/available/process-screenshots/) | Sorts screenshots into dated folders, removes duplicates, cleans up old ones |
| 🔕 [process-notifications](workflows/available/process-notifications/) | Audits macOS notification settings, identifies noisy apps, suggests silencing |
| 🔖 [sync-bookmarks](workflows/available/sync-bookmarks/) | Checks bookmarks for dead links, removes duplicates, organizes by topic |

## Scheduling

Workflows can run on autopilot. Add a schedule and they'll run themselves — no manual trigger needed.

```yaml
schedule: "8am, 6pm"
```

You can use plain English: `"7am"`, `"every 2 hours"`, `"morning"`, etc.

## Creating Your Own

Want to build a custom workflow? See [docs/creating-workflows.md](docs/creating-workflows.md) for the full guide.

Share yours with the community via pull request, or keep personal workflows private in `workflows/enabled/` (it's gitignored).

## CLI

| Command | What it does |
|---------|-------------|
| `clawflows list` | See all workflows and what's enabled |
| `clawflows enable <name>` | Turn on a workflow |
| `clawflows disable <name>` | Turn off a workflow |
| `clawflows sync` | Refresh your agent's workflow list |

## License

MIT
