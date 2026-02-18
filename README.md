> [!IMPORTANT]
> **This project hasn't launched yet!** If you stumbled here by accident, please close your eyes and slowly walk away. Nothing to see here. Just a minion and his bananas. We're only public to get feedback from a few people — you saw nothing. 🍌🙈

# ⚡️ Claw Workflows - Superpowers For Your Agent

<p align="center">
  <img src="docs/header.png" alt="ClawFlows" width="100%" />
</p>

Give your [OpenClaw](https://github.com/openclaw/openclaw) agent ⚡️ superpowers in 10 seconds. 

Some examples:
- 📧 **Process my email** — Junk unsubscribed, noise archived, important stuff summarized. Your inbox, handled.
- ☀️ **Morning briefing** — Weather, calendar, priorities, and fires — delivered before you open your eyes.
- 🛏️ **Sleep mode** — Every light off, music stopped, thermostat down, bedroom fan on. One command. Five systems. Done.
- 🎯 **Prep for my meeting** — Attendees researched, history pulled, talking points written. Ready before you are.
- 🔨 **Build something while I sleep** — Picks an idea, builds it overnight, hands you a finished project in the morning.

<br>

## 🚀 Get Started In 10 Seconds

### Option 1: Let your agent do it

Send this message to your OpenClaw agent:

```
Install https://raw.githubusercontent.com/davehappyminion/clawflows/main/system/AGENT.md
```

Your agent will install everything and ask which workflows you want to enable.

### Option 2: Manual install

```bash
curl -fsSL https://raw.githubusercontent.com/davehappyminion/clawflows/main/system/install.sh | bash
```

Then enable workflows with `clawflows enable <name>`.

<br>

## The Essentials

| Workflow | When | What it does |
|----------|------|--------------|
| ✨ [send-morning-inspiration](workflows/available/community/send-morning-inspiration/) | 7am | Inspirational quote themed to your goals |
| ☀️ [send-morning-briefing](workflows/available/community/send-morning-briefing/) | 7am | Weather, calendar, priorities, overnight alerts |
| 📧 [process-email](workflows/available/community/process-email/) | 2-3x/day | Auto-unsubscribe, archive junk, summarize important |
| 📅 [check-calendar](workflows/available/community/check-calendar/) | Morning + evening | 48-hour radar with conflicts and prep notes |

<br>

## 🧞‍♂️ All Workflows

### 🏠 Smart Home

| Workflow | What it does |
|----------|-------------|
| 🛏️ [activate-sleep-mode](workflows/available/community/activate-sleep-mode/) | Turns off all lights, speakers, thermostats + turns on bedroom fan |
| 🌙 [activate-night-mode](workflows/available/community/activate-night-mode/) | Dims lights to warm red, plays sleep music |
| 🌅 [activate-morning-mode](workflows/available/community/activate-morning-mode/) | Bright warm lights, comfortable thermostat, energizing music |
| 🧘 [activate-focus-mode](workflows/available/community/activate-focus-mode/) | Bright daylight lights, mutes speakers, blocks distracting sites |
| 🚪 [activate-away-mode](workflows/available/community/activate-away-mode/) | Everything off, thermostat to eco — for when you leave the house |

### 🧘 Daily Life & Health

| Workflow | What it does |
|----------|-------------|
| 📊 [track-habits](workflows/available/community/track-habits/) | Log daily habits and get a weekly scorecard with streaks, trends, and encouragement |
| 🍽️ [plan-meals](workflows/available/community/plan-meals/) | Weekly meal plan based on your diet, what's in season, and calendar busyness + grocery list |
| 🌦️ [check-weather-alerts](workflows/available/community/check-weather-alerts/) | Proactive weather alerts tied to your calendar — rain before your outdoor meeting, freeze tonight |
| 📝 [morning-journal](workflows/available/community/morning-journal/) | Guided journaling — reflection questions, pattern detection, mood tracking over time |
| 🎂 [send-birthday-reminders](workflows/available/community/send-birthday-reminders/) | Upcoming birthdays and anniversaries with gift ideas and message templates |

### 💰 Finance & Shopping

| Workflow | What it does |
|----------|-------------|
| 💳 [check-subscriptions](workflows/available/community/check-subscriptions/) | Find forgotten subscriptions, calculate monthly burn, suggest what to cancel |
| 📦 [track-packages](workflows/available/community/track-packages/) | Consolidated delivery status board from order confirmation emails |
| 🧾 [check-bills](workflows/available/community/check-bills/) | Upcoming bills, due dates, and amount spikes — nothing slips through |
| 🏷️ [find-deals](workflows/available/community/find-deals/) | Monitor price drops on wishlist items, alert when they hit your target price |
| 💰 [send-expense-report](workflows/available/community/send-expense-report/) | Scans Gmail for receipts, categorizes spending, sends a monthly report |

### 💬 Communication

| Workflow | What it does |
|----------|-------------|
| 📧 [process-email](workflows/available/community/process-email/) | Auto-unsubscribes, archives noise, summarizes what needs attention |
| 🔔 [check-follow-ups](workflows/available/community/check-follow-ups/) | Finds unanswered emails, promises you made, and balls about to drop |
| 💬 [check-messages](workflows/available/community/check-messages/) | Unified triage across Slack, Discord, Telegram, WhatsApp |
| 🐦 [check-x](workflows/available/community/check-x/) | X/Twitter engagement — notifications, mentions, content, custom PFPs |
| 📇 [process-contacts](workflows/available/community/process-contacts/) | Deduplicates macOS contacts, flags missing fields, identifies stale entries |

### 📊 Productivity

| Workflow | What it does |
|----------|-------------|
| 📅 [check-calendar](workflows/available/community/check-calendar/) | 48-hour radar with conflict detection, travel time, and prep notes |
| ✅ [triage-tasks](workflows/available/community/triage-tasks/) | Morning task review — what's due, overdue, and your top 3 priorities |
| 🎯 [build-meeting-prep](workflows/available/community/build-meeting-prep/) | Prep doc with attendee research, history, and talking points |
| 🔍 [prep-next-meeting](workflows/available/community/prep-next-meeting/) | Auto-researches external attendees for meetings in the next hour |
| 💼 [prep-interview](workflows/available/community/prep-interview/) | Company research, interviewer profiles, and practice questions — full prep packet |
| 🧍 [build-standup](workflows/available/community/build-standup/) | Auto-generates daily standup from git commits and completed tasks |
| 📝 [draft-weekly-update](workflows/available/community/draft-weekly-update/) | Polished manager-ready weekly update from git, tasks, and meetings |
| 📊 [build-weekly-review](workflows/available/community/build-weekly-review/) | Compiles the week's git commits, calendar, and accomplishments |
| 📝 [build-changelog](workflows/available/community/build-changelog/) | Generates a formatted changelog from git history since the last tag |
| 🔨 [build-nightly-project](workflows/available/community/build-nightly-project/) | Picks an idea from a queue and builds a small project overnight |
| 📆 [sync-calendar-tasks](workflows/available/community/sync-calendar-tasks/) | Extracts action items from calendar events, suggests tasks |

### 📨 Briefings & Reports

| Workflow | What it does |
|----------|-------------|
| ☀️ [send-morning-briefing](workflows/available/community/send-morning-briefing/) | Weather, calendar, priorities, urgent items — your daily command center |
| ✨ [send-morning-inspiration](workflows/available/community/send-morning-inspiration/) | Inspirational quote to start the day, themed to your goals |
| 📰 [send-news-digest](workflows/available/community/send-news-digest/) | Curated news on topics you care about — no doom-scrolling required |
| 🌆 [send-daily-wrap](workflows/available/community/send-daily-wrap/) | End-of-day summary — what you accomplished, what's pending, tomorrow preview |
| 😴 [send-bedtime-reminder](workflows/available/community/send-bedtime-reminder/) | Tomorrow preview, sleep math, and wind-down suggestions |
| 📋 [send-weekly-digest](workflows/available/community/send-weekly-digest/) | Week-in-review summary delivered via messaging |

### 📚 Content & Learning

| Workflow | What it does |
|----------|-------------|
| 📚 [curate-reading-list](workflows/available/community/curate-reading-list/) | Scan HN, Reddit, RSS for articles you'd love — deduplicated and ranked |
| 📱 [draft-social-posts](workflows/available/community/draft-social-posts/) | Generate a week of social media content from your recent work and interests |
| 🎧 [summarize-podcasts](workflows/available/community/summarize-podcasts/) | Key takeaways and timestamps from any podcast episode |
| 📷 [backup-photos](workflows/available/community/backup-photos/) | Organize, deduplicate, and sort photos — separates screenshots from real photos |

### 🔧 Dev Tools

| Workflow | What it does |
|----------|-------------|
| 🔍 [check-repos](workflows/available/community/check-repos/) | Scans local git repos for uncommitted changes, stale branches, unpushed commits |
| 📋 [review-prs](workflows/available/community/review-prs/) | Daily PR hygiene — stale reviews, new comments, merge-ready, failing CI |
| 📦 [check-dependencies](workflows/available/community/check-dependencies/) | Outdated deps, known CVEs, available updates across npm, pip, cargo, brew |
| 🐳 [clean-docker](workflows/available/community/clean-docker/) | Prune dangling images, stopped containers, unused volumes — asks before deleting |
| 📜 [rotate-logs](workflows/available/community/rotate-logs/) | Archive old logs, flag fast-growing files, report disk usage |

### 🔧 System & Network

| Workflow | What it does |
|----------|-------------|
| 💾 [check-disk](workflows/available/community/check-disk/) | Disk space audit — large files, caches, cleanup recommendations |
| 🌐 [check-network](workflows/available/community/check-network/) | Scan home network for devices, check speed, verify DNS/VPN, flag unknowns |
| 🔒 [check-security](workflows/available/community/check-security/) | Security hygiene — updates, open ports, FileVault, Firewall status |
| 📦 [sync-dotfiles](workflows/available/community/sync-dotfiles/) | Backs up dotfiles and Homebrew config to a git repo |
| 📥 [process-downloads](workflows/available/community/process-downloads/) | Organizes downloads by file type, removes duplicates, archives old files |
| 📸 [process-screenshots](workflows/available/community/process-screenshots/) | Sorts screenshots into dated folders, removes duplicates, cleans up old ones |
| 🔕 [process-notifications](workflows/available/community/process-notifications/) | Audits macOS notification settings, identifies noisy apps, suggests silencing |
| 🔖 [sync-bookmarks](workflows/available/community/sync-bookmarks/) | Checks bookmarks for dead links, removes duplicates, organizes by topic |

<br>

## How to Use

Once installed, just talk to your agent naturally:

```
"Run my morning briefing"
"Check my calendar for conflicts"
"Turn on sleep mode"
"Process my email"
```

Or use the CLI to manage workflows directly:

```bash
# See what's available
clawflows list

# Enable a workflow
clawflows enable send-morning-briefing

# Disable one you don't need
clawflows disable check-x

# Get the latest workflows
clawflows update
```

When you enable a workflow, your agent automatically knows about it — no restart needed.

<br>

## Scheduling

Workflows run on autopilot from the schedule in the WORKFLOW.md file — no manual trigger needed!

```yaml
schedule: "8am, 6pm"
```

You can use plain English: `"7am"`, `"every 2 hours"`, `"morning"`, etc.

<br>

## Creating Your Own

Build your custom workflow:

```bash
clawflows create
```

This walks you through creating a new workflow. See [Creating Workflows](docs/creating-workflows.md) for the full guide.

## Share With the Community

Have a workflow others would love? Submit it!

```bash
# 1. Create and test your workflow
clawflows create
clawflows run your-workflow-name

# 2. Submit it for review
clawflows submit your-workflow-name

# 3. Open a pull request (instructions shown after submit)
```

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

<br>

## CLI

| Command | What it does |
|---------|-------------|
| `clawflows list` | See all workflows and what's enabled |
| `clawflows list enabled` | Show only enabled workflows |
| `clawflows list available` | Show only available workflows |
| `clawflows create` | Create a new custom workflow |
| `clawflows run <name>` | Run a workflow now |
| `clawflows enable <name>` | Turn on a workflow |
| `clawflows disable <name>` | Turn off a workflow |
| `clawflows edit <name>` | Copy a community workflow to custom/ for editing |
| `clawflows open <name>` | Open a workflow in your editor |
| `clawflows validate <name>` | Check a workflow has required fields |
| `clawflows submit <name>` | Submit a custom workflow for community review |
| `clawflows update` | Pull the latest workflows from GitHub |
| `clawflows sync-agent` | Refresh your agent's workflow list in AGENTS.md |
| `clawflows uninstall` | Remove clawflows and clean up |

<br>

## License

MIT
