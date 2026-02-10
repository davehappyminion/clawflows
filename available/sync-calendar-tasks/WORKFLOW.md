---
name: sync-calendar-tasks
description: Calendar task extractor — scans calendar events for action items and suggests tasks to create.
---

# Sync Calendar Tasks

Extract action items from calendar events and suggest tasks.

## 1. Scan Recent Events

Pull events from the past 7 days:

```bash
icalBuddy -f -nc -nrd -df "%Y-%m-%d" -tf "%H:%M" -po "datetime,title,notes" eventsFrom:today-7 to:today
```

## 2. Extract Action Items

For each event, look for action items in:
- **Event notes** — look for "TODO", "action item", "follow up", "next steps"
- **Event title** — deadlines ("due", "deadline", "submit by")
- **Recurring meetings** — check if prep is needed for the next occurrence

## 3. Check Upcoming Deadlines

Scan the next 14 days for deadline-like events:

```bash
icalBuddy -f -nc -nrd -df "%Y-%m-%d" -tf "%H:%M" -po "datetime,title" eventsFrom:today to:today+14
```

Flag events with keywords: "due", "deadline", "submit", "review", "launch".

## 4. Suggest Tasks

For each action item found, suggest a task:

```markdown
## Suggested Tasks

- [ ] [Action item] — from [Meeting Name] on [Date]
- [ ] Prepare for [Upcoming Meeting] on [Date]
- [ ] Follow up on [Topic] with [Person]
- [ ] [Deadline item] due [Date]
```

## After Running

Present:
- Action items extracted (grouped by meeting)
- Upcoming deadlines
- Suggested tasks to create
- Meetings that need prep

## Notes

- Don't create tasks automatically — present suggestions for the user to approve
- Prioritize items with deadlines
- Flag overdue items prominently
