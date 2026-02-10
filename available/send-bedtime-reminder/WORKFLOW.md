---
name: send-bedtime-reminder
description: Bedtime reminder — a friendly nudge with tomorrow's schedule, sleep calculation, and wind-down suggestions.
triggers:
  - bedtime reminder
  - time for bed
  - sleep reminder
---

# Bedtime Reminder

Time to wind down. Tomorrow's preview and a gentle push toward rest.

## 1. Check Tomorrow's Schedule

Using your **calendar skill**, get tomorrow's events:
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
Available sleep: 9 hours 45 minutes

If you sleep now: 9+ hours ✓
If you sleep in 1 hour: 8+ hours ✓
If you sleep in 2 hours: 7+ hours ⚠️
```

### Sleep Tiers
- **9+ hours:** "Plenty of time — no rush"
- **7-9 hours:** "Sweet spot — good night ahead"
- **6-7 hours:** "Getting tight — wrap up soon"
- **<6 hours:** "Short night — prioritize rest"

## 3. Wind-Down Suggestions

Based on time:

### Before 10 PM
"Still have time — read, stretch, or journal"

### 10-11 PM
"Good timing — start your bedtime routine"

### 11 PM - Midnight
"Running late — head to bed after this"

### After Midnight
"Night owl hours — rest when you can"

### Contextual
- **Big meeting tomorrow:** "Important day — prioritize rest"
- **Early start:** "6 AM alarm — every hour counts"
- **Light schedule:** "Flexible morning — no stress"

## 4. Format the Reminder

```
🌙 Time to wind down!

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📅 TOMORROW STARTS WITH
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
{Event name} at {Time}
{Total} meeting(s) scheduled

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
😴 SLEEP MATH
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
If you sleep now: ~{X} hours
Wake time: ~{Time}

{Sleep tier message}

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
💡 SUGGESTION
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
{Wind-down suggestion}

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

{Closing}
"Rest well — you've earned it! 🌟"
```

### Compact Version (late night)
```
🌙 Quick reminder: {Event} at {Time} tomorrow.
Sleep now = {X} hours rest.
{One-line suggestion}
Good night! 💤
```

## 5. Deliver

Using your **messaging skill**, send the reminder to the user.

## 6. Pair with Sleep Mode (Optional)

Offer to trigger sleep automations:
```
Ready for sleep mode?
→ Reply "sleep" to activate
```

## Tracking

- Only send if not already sent today
- Remember preferred bedtime
- Skip weekends if configured

## Notes

- Schedule for user's target bedtime (default: 10 PM)
- Runs after send-daily-wrap
- Don't be preachy — friendly nudge, not lecture
- If tomorrow free: "Nothing on calendar — sleep in!"
- Pair with activate-night-mode or activate-sleep-mode
