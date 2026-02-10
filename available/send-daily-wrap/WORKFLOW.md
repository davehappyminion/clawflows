---
name: send-daily-wrap
description: Daily wrap-up — summarizes what you accomplished today from git, tasks, and calendar, then previews tomorrow.
requires:
  - name: telegram
    description: Telegram messaging
  - name: git
    description: Git version control
---

# Daily Wrap

End-of-day summary — what you did, what's pending, what's tomorrow. Close the loop.

## 1. Gather Today's Accomplishments

### Git Commits
```bash
git log --author="YOUR_EMAIL" --since="today 00:00" --oneline --all
```

For multiple repos:
```bash
for repo in ~/code/*/; do
  commits=$(git -C "$repo" log --author="YOUR_EMAIL" --since="today 00:00" --oneline 2>/dev/null)
  if [ -n "$commits" ]; then
    echo "**$(basename $repo)**"
    echo "$commits"
  fi
done
```

### Completed Tasks
```bash
# Todoist
todoist list --filter "completed today"

# Things 3
osascript -e 'tell application "Things3" to get name of to dos of list "Logbook" whose completion date is today'
```

### Meetings Attended
```bash
icalBuddy -f -nc -nrd eventsFrom:today to:today
```

### Emails Sent
```bash
gog gmail search 'in:sent newer_than:1d' --account YOUR_EMAIL --count
```

## 2. Identify What's Still Open

### Tasks Started But Not Finished
- Items marked "in progress"
- PRs opened but not merged
- Threads awaiting response

### Rolled Over
- Tasks due today that didn't get done
- Will auto-promote to tomorrow

## 3. Preview Tomorrow

### Tomorrow's Calendar
```bash
icalBuddy -f -nc -nrd -li 5 eventsFrom:tomorrow to:tomorrow+1
```

### Tasks Due Tomorrow
```bash
todoist list --filter "tomorrow"
```

### First Event
What time does tomorrow start? Calculate optimal bedtime.

## 4. Generate the Wrap

```
🌙 Daily Wrap — {Day}, {Date}

✅ ACCOMPLISHED
• Merged auth refactor PR (#234)
• Fixed Safari payment bug
• Wrote 3 tests for checkout flow
• Attended team sync, 1:1 with Sarah

📊 BY THE NUMBERS
• {X} commits across {Y} repos
• {Z} tasks completed
• {N} emails sent
• {M} meetings attended

🔄 STILL OPEN
• Dashboard redesign — started, 60% done
• PR review for Mike — will finish tomorrow

📅 TOMORROW
• First event: Team standup at 9:00 AM
• {X} meetings scheduled
• Top priority: Finish dashboard

💡 REFLECTION
{Auto-generated or user's notes}
"Solid progress on auth. Dashboard taking longer than expected —
might need to cut scope or push deadline."

---
{Motivational closing based on productivity}
"Strong day — {X} tasks knocked out. Rest up!"
or
"Lighter day — sometimes that's what you need. Tomorrow's a new one."
```

## 5. Deliver

Send via messaging:

```bash
telegram send --message "WRAP_CONTENT"
```

## 6. Optional: Prompt for Reflection

Ask the user:
- "Anything you want to add about today?"
- "What's the one thing to focus on tomorrow?"
- "Any wins worth celebrating?"

Store their response for weekly review.

## Tracking

```json
{
  "lastDailyWrap": "2026-02-09",
  "dailyStats": {
    "2026-02-09": {"commits": 5, "tasks": 3, "meetings": 2}
  }
}
```

## Notes

- Schedule for end of workday (e.g., 5-6 PM) or before bed (9 PM)
- Pairs with send-bedtime-reminder — wrap first, then sleep nudge
- Keep history for weekly/monthly reviews
- Celebrate consistency: "That's 5 days in a row of closing loops!"
- If nothing accomplished, don't shame — "Planning day. Momentum builds."
