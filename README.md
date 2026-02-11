# ⚡️ Claw Workflows - Superpowers For Your Agent

<p align="center">
  <img src="docs/header.png" alt="ClawFlows" width="100%" />
</p>

Give your [OpenClaw](https://github.com/openclaw/openclaw) agent ⚡️ superpowers in 10 seconds. 

Some examples:
- 🛏️ **Sleep mode** — Every light off, music stopped, thermostat down, bedroom fan on. One command. Five systems. Done.
- 📧 **Check my email** — Junk unsubscribed, noise archived, important stuff summarized. Your inbox, handled.
- ☀️ **Morning briefing** — Weather, calendar, priorities, and fires — delivered before you open your eyes.
- 🎯 **Prep for my meeting** — Attendees researched, history pulled, talking points written. Ready before you are.
- 🔨 **Build something while I sleep** — Picks an idea, builds it overnight, hands you a finished project in the morning.

## Get Setup In 10 Seconds

```bash
curl -fsSL https://raw.githubusercontent.com/davehappyminion/clawflows/main/system/install.sh | bash
```

That's it.

## The Essentials

13 workflows that automate your entire day

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

## All Workflows

### 🏠 Smart Home

| Workflow | What it does |
|----------|-------------|
| 🛏️ [activate-sleep-mode](workflows/available/activate-sleep-mode/) | Turns off all lights, speakers, thermostats + turns on bedroom fan |
| 🌙 [activate-night-mode](workflows/available/activate-night-mode/) | Dims lights to warm red, plays sleep music |
| 🌅 [activate-morning-mode](workflows/available/activate-morning-mode/) | Bright warm lights, comfortable thermostat, energizing music |
| 🧘 [activate-focus-mode](workflows/available/activate-focus-mode/) | Bright daylight lights, mutes speakers, blocks distracting sites |
| 🚪 [activate-away-mode](workflows/available/activate-away-mode/) | Everything off, thermostat to eco — for when you leave the house |

### 🧘 Daily Life & Health

| Workflow | What it does |
|----------|-------------|
| 📊 [track-habits](workflows/available/track-habits/) | Log daily habits and get a weekly scorecard with streaks, trends, and encouragement |
| 🍽️ [plan-meals](workflows/available/plan-meals/) | Weekly meal plan based on your diet, what's in season, and calendar busyness + grocery list |
| 🌦️ [check-weather-alerts](workflows/available/check-weather-alerts/) | Proactive weather alerts tied to your calendar — rain before your outdoor meeting, freeze tonight |
| 📝 [morning-journal](workflows/available/morning-journal/) | Guided journaling — reflection questions, pattern detection, mood tracking over time |
| 🎂 [send-birthday-reminders](workflows/available/send-birthday-reminders/) | Upcoming birthdays and anniversaries with gift ideas and message templates |

### 💰 Finance & Shopping

| Workflow | What it does |
|----------|-------------|
| 💳 [check-subscriptions](workflows/available/check-subscriptions/) | Find forgotten subscriptions, calculate monthly burn, suggest what to cancel |
| 📦 [track-packages](workflows/available/track-packages/) | Consolidated delivery status board from order confirmation emails |
| 🧾 [check-bills](workflows/available/check-bills/) | Upcoming bills, due dates, and amount spikes — nothing slips through |
| 🏷️ [find-deals](workflows/available/find-deals/) | Monitor price drops on wishlist items, alert when they hit your target price |
| 💰 [send-expense-report](workflows/available/send-expense-report/) | Scans Gmail for receipts, categorizes spending, sends a monthly report |

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
| 💼 [prep-interview](workflows/available/prep-interview/) | Company research, interviewer profiles, and practice questions — full prep packet |
| 🧍 [build-standup](workflows/available/build-standup/) | Auto-generates daily standup from git commits and completed tasks |
| 📝 [draft-weekly-update](workflows/available/draft-weekly-update/) | Polished manager-ready weekly update from git, tasks, and meetings |
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

### 📚 Content & Learning

| Workflow | What it does |
|----------|-------------|
| 📚 [curate-reading-list](workflows/available/curate-reading-list/) | Scan HN, Reddit, RSS for articles you'd love — deduplicated and ranked |
| 📱 [draft-social-posts](workflows/available/draft-social-posts/) | Generate a week of social media content from your recent work and interests |
| 🎧 [summarize-podcasts](workflows/available/summarize-podcasts/) | Key takeaways and timestamps from any podcast episode |
| 📷 [backup-photos](workflows/available/backup-photos/) | Organize, deduplicate, and sort photos — separates screenshots from real photos |

### 🔧 Dev Tools

| Workflow | What it does |
|----------|-------------|
| 🔍 [check-repos](workflows/available/check-repos/) | Scans local git repos for uncommitted changes, stale branches, unpushed commits |
| 📋 [review-prs](workflows/available/review-prs/) | Daily PR hygiene — stale reviews, new comments, merge-ready, failing CI |
| 📦 [check-dependencies](workflows/available/check-dependencies/) | Outdated deps, known CVEs, available updates across npm, pip, cargo, brew |
| 🐳 [clean-docker](workflows/available/clean-docker/) | Prune dangling images, stopped containers, unused volumes — asks before deleting |
| 📜 [rotate-logs](workflows/available/rotate-logs/) | Archive old logs, flag fast-growing files, report disk usage |

### 🔧 System & Network

| Workflow | What it does |
|----------|-------------|
| 💾 [check-disk](workflows/available/check-disk/) | Disk space audit — large files, caches, cleanup recommendations |
| 🌐 [check-network](workflows/available/check-network/) | Scan home network for devices, check speed, verify DNS/VPN, flag unknowns |
| 🔒 [check-security](workflows/available/check-security/) | Security hygiene — updates, open ports, FileVault, Firewall status |
| 📦 [sync-dotfiles](workflows/available/sync-dotfiles/) | Backs up dotfiles and Homebrew config to a git repo |
| 📥 [process-downloads](workflows/available/process-downloads/) | Organizes downloads by file type, removes duplicates, archives old files |
| 📸 [process-screenshots](workflows/available/process-screenshots/) | Sorts screenshots into dated folders, removes duplicates, cleans up old ones |
| 🔕 [process-notifications](workflows/available/process-notifications/) | Audits macOS notification settings, identifies noisy apps, suggests silencing |
| 🔖 [sync-bookmarks](workflows/available/sync-bookmarks/) | Checks bookmarks for dead links, removes duplicates, organizes by topic |

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

## Scheduling

Workflows run on autopilot from the schedule in the WORKFLOW.md file — no manual trigger needed!

```yaml
schedule: "8am, 6pm"
```

You can use plain English: `"7am"`, `"every 2 hours"`, `"morning"`, etc.


## Creating Your Own

Build your custom workflow! See [Creating Workflows](docs/creating-workflows.md) for the full guide.

Share yours with the community via pull request, or keep personal workflows private in `workflows/enabled/` (it's gitignored).

## CLI

| Command | What it does |
|---------|-------------|
| `clawflows list` | See all workflows and what's enabled |
| `clawflows list enabled` | Show only enabled workflows |
| `clawflows list available` | Show only available workflows |
| `clawflows enable <name>` | Turn on a workflow |
| `clawflows disable <name>` | Turn off a workflow |
| `clawflows update` | Pull the latest workflows from GitHub |
| `clawflows sync` | Refresh your agent's workflow list in AGENTS.md |
| `clawflows uninstall` | Remove clawflows and clean up |

## License

MIT
