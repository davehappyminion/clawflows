---
name: send-bedtime-reminder
description: Bedtime reminder — sends a friendly nudge with tomorrow's first event and a wind-down suggestion. Use when the user says "bedtime reminder", "remind me to go to bed", or when triggered by evening cron.
requires:
  - name: telegram
    description: Telegram messaging
---

# Bedtime Reminder

Friendly bedtime nudge with tomorrow's first event.

## 1. Check Tomorrow's Schedule

Find the first event tomorrow:

```bash
icalBuddy -f -nc -n -nrd -li 1 -df "%Y-%m-%d" -tf "%H:%M" -po "datetime,title" eventsFrom:tomorrow to:tomorrow+1
```

Calculate how many hours of sleep if going to bed now vs the first event.

## 2. Format Reminder

Structure the message:

```
🌙 Time to wind down!

Tomorrow starts with: [Event Name] at [Time]
If you sleep now, that's ~[X] hours of sleep.

Suggestion: [wind-down activity based on time]
```

Wind-down suggestions by time:
- Before 10 PM: "Still have time — read a chapter or do some stretching"
- 10-11 PM: "Good timing — start your bedtime routine"
- After 11 PM: "Running late — head to bed soon for a solid night"

## 3. Deliver

Send via messaging:

```bash
telegram send --message "REMINDER_CONTENT"
```

## Tracking

Track delivery to avoid double-sending:

```json
{
  "lastBedtimeReminder": "2026-02-09"
}
```

Only send if `lastBedtimeReminder` is not today.

## Notes

- Schedule via cron for your target bedtime (e.g., 10:00 PM)
- Pairs well with activate-night-mode or activate-sleep-mode
- Skip sending on weekends if preferred
