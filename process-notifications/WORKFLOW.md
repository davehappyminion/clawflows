---
name: process-notifications
description: Notification audit — reviews macOS notification settings, identifies noisy apps, and suggests which to silence. Use when the user says "audit notifications", "too many notifications", "process notifications", or "fix notification overload".
---

# Process Notifications

Audit macOS notification settings, identify noisy apps, suggest silencing.

## 1. List Notification Settings

Get current notification preferences:

```bash
defaults read com.apple.ncprefs 2>/dev/null
```

List apps with notification access:

```bash
lsappinfo list | grep -i bundleID
```

## 2. Identify Noisy Apps

Check for apps that are likely high-volume notification sources:
- Social media apps (Twitter, Instagram, Facebook, TikTok)
- News apps
- Marketing/promotional apps
- Games
- Shopping apps

## 3. Review Notification Style

For each app, check:
- Banner vs Alert style
- Sound enabled
- Badge count enabled
- Lock screen visibility
- Notification grouping

## 4. Recommend Changes

Categorize apps into:
- **Keep as-is** — important communications (Messages, Phone, Calendar)
- **Reduce** — change from alert to banner, disable sound
- **Silence** — turn off notifications entirely
- **Schedule** — use Focus filters for time-based delivery

Provide the commands to apply changes:

```bash
# Example: disable notifications for an app
defaults write com.apple.ncprefs apps -dict-add "com.example.app" '<dict><key>flags</key><integer>0</integer></dict>'
```

## After Running

Report:
- Total apps with notifications enabled
- Noisy apps identified
- Recommended changes (keep/reduce/silence/schedule)
- Commands to apply the changes

## Notes

- Don't change notification settings automatically — present recommendations first
- Focus on reducing noise without missing important alerts
