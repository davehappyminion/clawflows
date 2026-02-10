---
name: send-morning-briefing
description: Daily morning briefing — gathers weather, calendar events, and news, then delivers a summary via messaging.
requires:
  - name: telegram
    description: Telegram messaging
---

# Morning Briefing

Generate and deliver a daily morning summary.

## Process

1. Gather today's information:
   - Weather forecast for the day
   - Calendar events for the next 24-48 hours
   - Any urgent unread emails or notifications
   - News relevant to the user's interests
2. Format into a concise summary
3. Deliver via messaging (Telegram, Slack, etc.)
4. Add a warm greeting

## Tracking

Track delivery to avoid sending twice in one day:

```json
{
  "lastMorningBriefing": "2026-02-06"
}
```

Only send if `lastMorningBriefing` is not today's date.

## Notes

- Schedule via cron for automatic morning delivery (e.g., 7:00-8:00 AM)
- Keep it concise — highlight what matters, skip the noise
