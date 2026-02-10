---
name: send-morning-briefing
description: Daily morning briefing — gathers weather, calendar, priorities, and urgent items, then delivers a comprehensive summary to start your day.
requires:
  - name: telegram
    description: Telegram messaging
---

# Morning Briefing

Your daily command center. Everything you need to know before the day begins.

## 1. Gather Weather

Get today's forecast:

```bash
curl -s "wttr.in/YOUR_CITY?format=%C+%t+%w+%p"
```

Or use a weather API for detailed info:
- Current temperature and conditions
- High/low for the day
- Rain/snow probability
- "Grab an umbrella" or "Sunglasses day" advice

## 2. Gather Calendar

Pull today's events:

```bash
icalBuddy -f -nc -n -nrd -df "%Y-%m-%d" -tf "%H:%M" -po "datetime,title,location" eventsToday
```

Highlight:
- **First event** — When does your day officially start?
- **Key meetings** — 1:1s, external calls, important syncs
- **Free blocks** — Windows for focused work
- **After-hours events** — Dinner plans, personal appointments

## 3. Check Overnight Urgency

Scan for things that can't wait:

### Urgent Emails
```bash
gog gmail search 'in:inbox is:unread newer_than:12h' --account YOUR_EMAIL
```

Flag emails from:
- Your manager
- Direct reports (if applicable)
- VIP contacts
- With "urgent", "ASAP", "time-sensitive" in subject

### Slack/Discord Mentions
Check for overnight @mentions in critical channels.

### System Alerts
- Failed cron jobs
- Server alerts
- Security notifications

## 4. Pull Top Priorities

From task manager:
```bash
todoist list --filter "today | overdue" --limit 5
```

Or reference the output from triage-tasks if run first.

## 5. Compile the Briefing

```
☀️ Good morning! Here's your {Day}, {Date}:

🌤️ WEATHER
{City}: {Conditions}, {Temp}
High {X}° / Low {Y}° — {Rain chance or advice}

📅 TODAY'S SCHEDULE
{First event time} — {Event name} ← Day starts here
{Time} — {Event}
{Time} — {Event}
{X} meetings total, {Y} hours of free time

🎯 TOP PRIORITIES
1. {Most important task}
2. {Second priority}
3. {Third priority}

🚨 NEEDS ATTENTION
{Urgent emails or items from overnight}
• {Item} — {Why it's urgent}

💡 TODAY'S TIP
{Contextual advice based on schedule}
"Heavy meeting day — block 30 min for lunch."
"Light calendar — great day for deep work."
"Back-to-back from 10-3 — prep materials now."

---
Have a great day! ☕
```

## 6. Deliver

Send via messaging:

```bash
telegram send --message "BRIEFING_CONTENT"
```

## Tracking

```json
{
  "lastMorningBriefing": "2026-02-09",
  "deliveryTime": "07:00",
  "timezone": "America/New_York"
}
```

Only send if `lastMorningBriefing` is not today's date.

## Notes

- Schedule for 15-30 min before typical wake time
- Deliver AFTER send-morning-quote (inspiration first, then logistics)
- Keep it scannable — busy mornings need quick info
- If nothing urgent, say so: "Clear overnight — smooth start!"
- Personalize the greeting based on day (Monday motivation vs Friday energy)
