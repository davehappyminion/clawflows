# Creating Workflows

How to build your own ClawFlows workflow.

## Workflow Structure

Each workflow is a folder with a `WORKFLOW.md` and optional supporting files:

```
my-workflow/
├── WORKFLOW.md          # Instructions (frontmatter + steps)
├── config.env           # Optional: environment variables
└── scripts/             # Optional: helper scripts
    └── do-thing.sh
```

The only required file is `WORKFLOW.md`. Scripts and config are optional — most workflows don't need them.

## WORKFLOW.md Format

```yaml
---
name: send-morning-briefing
emoji: ☀️
description: Daily morning briefing — gathers weather, calendar, priorities, and news into one summary.
author: nikilster @nikil
schedule: "7am"
requires:
  - name: calendar
    description: Google Calendar or similar
  - name: weather
    description: Weather service
---

# Morning Briefing

## What It Does
1. Check today's calendar
2. Get weather forecast
3. Summarize priorities
4. Deliver briefing

## After Running
Send the briefing to the user's preferred channel.
```

## Frontmatter Fields

| Field | Required | Description |
|-------|----------|-------------|
| `name` | Yes | Matches the folder name. Lowercase, hyphenated, verb-first. |
| `emoji` | No | Single emoji for display. |
| `description` | Yes | What it does — a plain description the agent can match on. |
| `author` | No | Who made it. GitHub username and/or X handle, space-separated. |
| `schedule` | No | When to run automatically. Omit for on-demand only. |
| `requires` | No | Skills and tools needed. Each has a `name` and `description`. |

### The `author` Field

Credit yourself with your GitHub username, X handle, or both:

```yaml
author: nikilster              # GitHub only
author: @nikil                 # X only
author: nikilster @nikil       # Both
```

- No `@` → links to `github.com/username`
- With `@` → links to `x.com/handle`
- Space-separated if you want both

### Writing Good Descriptions

The `description` field tells humans and agents what the workflow does. Write a clear, concise description — the agent matches on it naturally:

```yaml
description: Bedtime automation — turns off all lights, thermostats, and music, then turns on the bedroom fan.
```

### The `schedule` Field

Set when the workflow runs automatically. Use simple times like `"7am"` or multiple times like `"9am, 1pm, 5pm"`:

```yaml
schedule: "7am"                    # Once daily
schedule: "9am, 1pm, 5pm"          # Three times daily
schedule: "8am, 6pm"               # Twice daily
```

Times are in 12-hour format with am/pm. No days — scheduled workflows run daily at the specified times.

Omit the `schedule` field for on-demand workflows that only run when triggered manually.

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

## Workflow Content

Write clear, numbered steps the agent can follow:

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

### To the community

1. Create your workflow folder in `workflows/available/`
2. Submit a pull request

### For personal use

1. Create your workflow folder in `workflows/enabled/`
2. It's gitignored, so it stays local

## Optional: Config Files

If your workflow needs user-specific settings, add a `config.env`:

```bash
# config.env
EMAIL=user@example.com
SLACK_CHANNEL=#general
```

Reference it in your workflow:

```markdown
## 1. Load Config

Source the config file:
` ` `bash
source config.env
` ` `
```

The agent will prompt users to fill in their values when they enable the workflow.

## Optional: Scripts

For complex logic, add helper scripts in a `scripts/` folder:

```
my-workflow/
├── WORKFLOW.md
└── scripts/
    ├── fetch-data.sh
    └── process.py
```

Reference them in your workflow:

```markdown
## 2. Fetch Data

Run the fetch script:
` ` `bash
./scripts/fetch-data.sh
` ` `
```

Keep scripts simple and well-commented. The agent will execute them as instructed.

## Tips

- Keep it self-contained — someone reading just the `WORKFLOW.md` should be able to follow it
- Include example commands with placeholders (`YOUR_EMAIL`, etc.)
- Be specific about what to do, not theory
- End with an "After Running" or "Notes" section
- Test it before submitting
