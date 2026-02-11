---
name: process-notifications
emoji: 🔕
description: Notification audit — reviews notification settings, identifies noisy apps, and suggests which to silence.
author: @davehappyminion
---

# Process Notifications

Audit notification settings, identify noisy apps, suggest silencing.

## 1. List Notification Sources

Using your **system skill**, identify apps with notification access:
- Apps that can send notifications
- Current notification style for each (banner, alert, none)
- Sound enabled/disabled
- Badge counts enabled/disabled

## 2. Identify Noisy Apps

Check for apps that are likely high-volume notification sources:

### Usually Noisy
- Social media apps (Twitter, Instagram, Facebook, TikTok)
- News apps
- Marketing/promotional apps
- Games
- Shopping apps

### Usually Important
- Messages, Phone, FaceTime
- Calendar, Reminders
- Email (primary account)
- Work apps (Slack, Teams)

## 3. Review Current Settings

For each app, note:
- Notification style (banner vs alert)
- Sound enabled
- Badge count enabled
- Lock screen visibility
- Notification grouping

## 4. Recommend Changes

Categorize apps into:
- **Keep as-is** — Important communications
- **Reduce** — Change from alert to banner, disable sound
- **Silence** — Turn off notifications entirely
- **Schedule** — Use Focus filters for time-based delivery

## 5. Present Recommendations

```
🔔 Notification Audit

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📊 SUMMARY
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
• Apps with notifications: 47
• Recommended to silence: 12
• Recommended to reduce: 8
• Keep as-is: 27

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🔇 SILENCE THESE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
• Instagram — Social noise
• Twitter — Social noise
• News app — Constant updates
• Game — Engagement bait
...

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🔉 REDUCE THESE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
• Slack — Disable sound, keep banner
• Email — Disable sound, keep badge
...

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅ KEEP AS-IS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
• Messages
• Calendar
• Phone
...
```

## 6. Apply Changes (Optional)

Using your **system skill**, apply the recommended changes:
- Offer to apply all recommendations
- Or apply selectively

## Notes

- Don't change notification settings automatically — present recommendations first
- Focus on reducing noise without missing important alerts
- Consider setting up Focus modes for different contexts
- Run after installing new apps or when feeling overwhelmed
