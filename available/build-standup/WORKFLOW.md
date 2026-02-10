---
name: build-standup
description: Standup generator — automatically creates your daily standup update from git commits, completed tasks, and today's plan.
requires:
  - name: git
    description: Git version control
---

# Build Standup

Auto-generate your daily standup so you can copy-paste and get on with your day.

## 1. Gather Yesterday's Work

### Git Commits
Find commits from yesterday (or since last standup):

```bash
git log --author="YOUR_EMAIL" --since="yesterday 00:00" --until="today 00:00" --oneline --all
```

For multiple repos:
```bash
for repo in ~/code/*/; do
  echo "=== $(basename $repo) ==="
  git -C "$repo" log --author="YOUR_EMAIL" --since="yesterday" --oneline 2>/dev/null
done
```

### Completed Tasks
Pull from task manager:

```bash
# Todoist
todoist list --filter "completed today"

# Linear
linear issue list --filter "assignee:me state:done updated:yesterday"
```

### Calendar (Meetings Attended)
```bash
icalBuddy -f -nc -nrd -df "%Y-%m-%d" eventsFrom:yesterday to:yesterday
```

## 2. Gather Today's Plan

### Tasks Due Today
```bash
todoist list --filter "today"
```

### Calendar Events
```bash
icalBuddy -f -nc -nrd -li 5 eventsToday
```

### Carryover
Items started but not finished yesterday.

## 3. Identify Blockers

Look for:
- PRs awaiting review (you're waiting on others)
- Tasks marked "blocked" or "waiting"
- Dependencies on other people/teams
- Questions you need answered

```bash
# PRs you're waiting on
gh pr list --author @me --state open --json title,reviews
```

## 4. Generate the Standup

### Standard Format
```
**Yesterday:**
• Finished the auth refactor (PR #234)
• Fixed bug in payment flow
• 1:1 with Sarah — discussed Q2 roadmap

**Today:**
• Code review for Mike's PR
• Start dashboard redesign
• Team sync at 2pm

**Blockers:**
• Waiting on API docs from backend team
```

### Compact Format (for quick syncs)
```
✅ Yesterday: Auth refactor, payment bug fix, 1:1 w/ Sarah
📋 Today: Code review, dashboard, team sync
🚧 Blockers: Waiting on API docs
```

### Detailed Format (for async teams)
```
## Standup — {Date}

### Completed
- **[PR #234] Auth refactor** — Merged. Reduced login time by 40%.
- **Payment bug** — Users on Safari couldn't complete checkout. Fixed.
- **1:1 with Sarah** — Discussed Q2 priorities, agreed on dashboard focus.

### In Progress
- **Dashboard redesign** — Starting today, ETA Friday
- **Code review** — Mike's notification PR, will review this morning

### Planned
- Team sync at 2pm
- Write tests for auth changes

### Blockers
- **API documentation** — Need updated docs from backend team to proceed with integration. Pinged Jake.

### Notes
- Out early Friday for dentist appointment
```

## 5. Deliver

Options:
1. **Copy to clipboard** — Ready to paste into Slack
2. **Post directly** — Send to #standup channel
3. **Display only** — Just show, user decides

```bash
# macOS clipboard
echo "STANDUP_CONTENT" | pbcopy

# Post to Slack
slack chat postMessage --channel standup --text "STANDUP_CONTENT"
```

## Tracking

```json
{
  "lastStandup": "2026-02-09",
  "standupChannel": "#engineering-standup",
  "format": "standard"
}
```

## Notes

- Run at start of workday, before standup meeting
- If no commits/tasks, be honest: "Light day yesterday — planning and research"
- Don't fabricate work — authenticity over impressiveness
- Customize format to match team culture
- Skip weekends unless user works weekends
