---
name: triage-tasks
description: Daily task triage — reviews your task list, identifies what's due and overdue, and suggests your top 3 priorities for the day.
requires:
  - name: todoist
    description: Todoist task manager CLI
---

# Triage Tasks

Morning task review — what's due, what's overdue, and what matters most today.

## 1. Fetch All Tasks

Pull tasks from your task manager:

### Todoist
```bash
todoist list --filter "today | overdue"
todoist list --filter "next 7 days"
```

### Things 3 (macOS)
```bash
osascript -e 'tell application "Things3"
  set output to ""
  repeat with toDo in to dos of list "Today"
    set output to output & (name of toDo) & linefeed
  end repeat
  return output
end tell'
```

### Linear
```bash
linear issue list --filter "assignee:me state:todo,in_progress"
```

## 2. Categorize Tasks

Sort into buckets:

### Overdue
- Tasks past their due date
- Flag how many days overdue
- Highlight anything more than 3 days overdue as critical

### Due Today
- Everything with today's date
- Include time-specific tasks (meetings, deadlines)

### Due This Week
- Next 7 days
- Group by day

### No Due Date
- Backlog items floating without dates
- Consider if any should be promoted to today

## 3. Suggest Top 3 Priorities

Analyze and recommend the 3 most important tasks for today:

**Prioritization factors:**
1. **Deadlines** — Hard due dates beat soft ones
2. **Dependencies** — Tasks blocking others go first
3. **Effort vs. time** — If you have 2 hours, don't suggest a 6-hour task
4. **Momentum** — One quick win early builds energy
5. **Commitments** — Things you promised others

### Format
```
🎯 Today's Top 3:

1. [Task name] — [Why it's priority: deadline/blocking/promised]
2. [Task name] — [Why]
3. [Task name] — [Why]
```

## 4. Present the Full Picture

```
📋 Task Triage — {Date}

🔴 OVERDUE ({count})
- [Task] — {X days overdue}

🟡 DUE TODAY ({count})
- [Task] — {due time if applicable}

🟢 THIS WEEK ({count})
- Monday: [tasks]
- Tuesday: [tasks]
...

🎯 SUGGESTED TOP 3
1. [Task] — [reason]
2. [Task] — [reason]
3. [Task] — [reason]

💡 Quick wins (under 15 min):
- [Small task]
- [Small task]
```

## After Running

Ask if they want to:
- Reschedule any overdue tasks
- Add anything new that came to mind
- Adjust the top 3

## Notes

- Run first thing in the morning, after the quote and briefing
- Don't overwhelm — if there are 50 tasks, still just show top 3 priorities
- Celebrate if inbox is clear: "Nothing overdue — you're on top of it!"
- Pair with send-daily-wrap to close the loop at end of day
