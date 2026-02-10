---
name: send-bedtime-reminder
description: Bedtime reminder — a friendly nudge with tomorrow's schedule, sleep calculation, and wind-down suggestions.
requires:
  - name: telegram
    description: Telegram messaging
---

# Bedtime Reminder

Time to wind down. Tomorrow's preview and a gentle push toward rest.

## 1. Check Tomorrow's Schedule

Find the first event tomorrow:

```bash
icalBuddy -f -nc -n -nrd -li 1 -df "%Y-%m-%d" -tf "%H:%M" -po "datetime,title" eventsFrom:tomorrow to:tomorrow+1
```

Also get full tomorrow schedule:
```bash
icalBuddy -f -nc -n -nrd -df "%Y-%m-%d" -tf "%H:%M" eventsFrom:tomorrow to:tomorrow+1
```

Extract:
- First event time
- Total meetings
- Any early morning events
- High-stakes meetings to note

## 2. Calculate Sleep Opportunity

Based on current time and first event:

```
Current time: 10:30 PM
First event: 9:00 AM standup
Wake time needed: ~8:15 AM (45 min buffer)
Time to sleep: 9 hours 45 minutes available

If you sleep now: 9+ hours ✓
If you sleep in 1 hour: 8+ hours ✓
If you sleep in 2 hours: 7+ hours ⚠️
```

### Sleep Quality Tiers
- **9+ hours available:** "Plenty of time — no rush"
- **7-9 hours:** "Sweet spot — good night ahead"
- **6-7 hours:** "Getting tight — consider wrapping up"
- **<6 hours:** "Short night ahead — prioritize rest"

## 3. Wind-Down Suggestions

Based on time and context:

### Before 10 PM
- "Still have time — read a chapter, stretch, or journal"
- "Good time for a relaxing activity before bed"

### 10-11 PM
- "Good timing — start your bedtime routine"
- "Screens off soon for better sleep"

### 11 PM - Midnight
- "Running a bit late — head to bed after this"
- "Quick wind-down: 5 minutes of breathing, then sleep"

### After Midnight
- "Night owl hours — sleep when you can"
- "Tomorrow's going to come fast — rest up"

### Contextual Suggestions
- **Big meeting tomorrow:** "Important day ahead — prioritize rest"
- **Early start:** "6 AM alarm coming — every hour of sleep counts"
- **Light schedule tomorrow:** "Flexible morning — no stress if you're up late"

## 4. Optional: Today's Wrap Reference

If send-daily-wrap ran earlier, reference it:
- "You got a lot done today — {X} tasks, {Y} commits"
- "Lighter day — tomorrow's a fresh start"

## 5. Format the Reminder

```
🌙 Time to wind down!

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📅 TOMORROW STARTS WITH
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
{Event name} at {Time}
{Total meetings} meeting(s) scheduled

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
😴 SLEEP MATH
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
If you sleep now: ~{X} hours of sleep
Wake time for tomorrow: ~{Time}

{Sleep tier message}

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
💡 SUGGESTION
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
{Contextual wind-down suggestion}

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

{Closing based on context}
"Rest well — you've earned it! 🌟"
"Big day tomorrow — get some good sleep! 💪"
"Sweet dreams! See you in the morning ☀️"
```

### Compact Version (for late night)
```
🌙 Quick reminder: {Event} at {Time} tomorrow.
Sleep now = {X} hours rest.
{One-line suggestion}
Good night! 💤
```

## 6. Deliver

Send via messaging:

```bash
telegram send --message "REMINDER_CONTENT"
```

## 7. Pair with Sleep Mode (Optional)

Offer to trigger sleep automations:

```
Ready for sleep mode?
→ Reply "sleep" to activate (lights off, music off, fan on)
```

If user responds, trigger activate-sleep-mode workflow.

## Tracking

```json
{
  "lastBedtimeReminder": "2026-02-09",
  "preferredBedtime": "22:30",
  "timezone": "America/New_York",
  "skipWeekends": false
}
```

Only send if `lastBedtimeReminder` is not today.

## Notes

- Schedule for user's target bedtime (default: 10 PM)
- Runs after send-daily-wrap (wrap closes the day, this closes the night)
- Skip weekends if user prefers (configurable)
- Don't be preachy — friendly nudge, not a lecture
- If tomorrow is free: "Nothing on the calendar — sleep in if you like!"
- Pair with activate-night-mode or activate-sleep-mode for full automation
