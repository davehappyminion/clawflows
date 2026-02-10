---
name: build-standup
emoji: 🧍
description: Standup generator — automatically creates your daily standup update from git commits, completed tasks, and today's plan.
triggers:
  - build standup
  - generate standup
  - standup update
  - daily standup
---

# Build Standup

Auto-generate your daily standup so you can copy-paste and move on.

## 1. Gather Yesterday's Work

### Git Commits
Using **git**, find your commits from yesterday:
- All repositories you work in
- Summarize what was done

### Completed Tasks
Using your **task manager skill**, get tasks completed yesterday.

### Meetings Attended
Using your **calendar skill**, list meetings from yesterday.

## 2. Gather Today's Plan

### Tasks Due Today
Using your **task manager skill**, get today's tasks.

### Calendar Events
Using your **calendar skill**, get today's meetings.

### Carryover
Items started but not finished yesterday.

## 3. Identify Blockers

Look for:
- PRs awaiting review
- Tasks marked "blocked" or "waiting"
- Dependencies on others
- Questions needing answers

## 4. Generate the Standup

### Standard Format
```
**Yesterday:**
• Finished the auth refactor (PR #234)
• Fixed bug in payment flow
• 1:1 with Sarah — discussed roadmap

**Today:**
• Code review for Mike's PR
• Start dashboard redesign
• Team sync at 2pm

**Blockers:**
• Waiting on API docs from backend team
```

### Compact Format
```
✅ Yesterday: Auth refactor, payment fix, 1:1 w/ Sarah
📋 Today: Code review, dashboard, team sync
🚧 Blockers: Waiting on API docs
```

### Detailed Format (for async teams)
```
## Standup — {Date}

### Completed
- **Auth refactor** — Merged. Reduced login time by 40%.
- **Payment bug** — Safari users couldn't checkout. Fixed.

### In Progress
- **Dashboard redesign** — Starting today, ETA Friday

### Planned
- Team sync at 2pm
- Write tests for auth

### Blockers
- **API docs** — Need from backend team

### Notes
- Out early Friday for appointment
```

## 5. Deliver

Options:
- **Copy to clipboard** — Ready to paste
- **Post to channel** — Send directly to #standup
- **Display** — Just show, user decides

## Tracking

Remember:
- Last standup date
- Preferred format
- Standup channel

## Notes

- Run at start of workday
- If no commits/tasks: "Light day — planning and research"
- Don't fabricate — authenticity over impressiveness
- Skip weekends unless user works weekends
