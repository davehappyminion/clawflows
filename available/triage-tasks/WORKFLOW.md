---
name: triage-tasks
emoji: ✅
description: Daily task triage — reviews your task list, identifies what's due and overdue, and suggests your top 3 priorities for the day.
schedule: "8am"
---

# Triage Tasks

Morning task review — what's due, what's overdue, and what matters most today.

## 1. Fetch All Tasks

Using your **task manager skill**, pull:
- Tasks due today
- Overdue tasks
- Tasks due this week
- Tasks without due dates (backlog)

## 2. Categorize Tasks

### Overdue
- Tasks past their due date
- Flag how many days overdue
- Highlight anything 3+ days overdue as critical

### Due Today
- Everything with today's date
- Include time-specific deadlines

### Due This Week
- Next 7 days
- Group by day

### No Due Date
- Backlog items
- Consider if any should be promoted to today

## 3. Suggest Top 3 Priorities

Analyze and recommend the 3 most important tasks:

**Prioritization factors:**
1. **Deadlines** — Hard due dates beat soft ones
2. **Dependencies** — Tasks blocking others go first
3. **Effort vs. time** — Match task size to available time
4. **Momentum** — One quick win early builds energy
5. **Commitments** — Things promised to others

## 4. Present the Full Picture

```
📋 Task Triage — {Date}

🔴 OVERDUE ({count})
• {Task} — {X} days overdue
• {Task} — {X} days overdue

🟡 DUE TODAY ({count})
• {Task}
• {Task}

🟢 THIS WEEK ({count})
• Monday: {tasks}
• Tuesday: {tasks}

🎯 SUGGESTED TOP 3
1. {Task} — {Why: deadline/blocking/promised}
2. {Task} — {Why}
3. {Task} — {Why}

💡 QUICK WINS (under 15 min)
• {Small task}
• {Small task}
```

## 5. After Running

Ask if they want to:
- Reschedule overdue tasks
- Add anything new
- Adjust the top 3

## Notes

- Run first thing in the morning
- Don't overwhelm — even with 50 tasks, show top 3 priorities
- Celebrate if clear: "Nothing overdue — you're on top of it!"
- Pair with send-daily-wrap to close the loop
