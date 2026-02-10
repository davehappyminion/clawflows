---
name: check-messages
description: Unified message triage — checks Slack, Discord, Telegram, WhatsApp, and other messaging platforms for what needs your attention.
requires:
  - name: slack
    description: Slack workspace CLI
  - name: discord
    description: Discord bot/CLI
  - name: telegram
    description: Telegram messaging
---

# Check Messages

Unified inbox for all your messaging platforms. One summary instead of five apps.

## 1. Gather Messages

Check each platform for unread messages and mentions:

### Slack
```bash
# Get unread DMs
slack conversations list --types im --exclude-archived

# Get mentions
slack search messages --query "to:me" --sort timestamp

# Get channels with unreads
slack conversations list --exclude-archived | filter unread_count > 0
```

### Discord
```bash
# Check DMs
discord dm list --unread

# Check mentions across servers
discord mentions list

# Check specific channels
discord channel messages --channel CHANNEL_ID --limit 50 --after LAST_READ
```

### Telegram
```bash
telegram messages list --unread
telegram messages list --mentions
```

### WhatsApp
- Requires WhatsApp Web automation or API
- Check for unread conversations
- Flag messages with questions or action items

### iMessage (macOS)
```bash
sqlite3 ~/Library/Messages/chat.db "SELECT text, handle_id, date FROM message WHERE is_read=0 ORDER BY date DESC LIMIT 20"
```

## 2. Categorize Messages

### Priority Tiers

**🔴 Urgent — Respond Now**
- Direct questions waiting for you
- Time-sensitive requests ("can you join in 10 min?")
- Messages from VIPs (boss, key clients, family)
- Anything with "urgent", "ASAP", "help"

**🟡 Important — Respond Today**
- Conversations you're active in
- Action items assigned to you
- Threads where you were mentioned
- Messages from close colleagues

**🟢 FYI — Read When Free**
- Channel announcements
- Group chat noise
- News/updates that don't need response
- Bot notifications

**⚪ Skip**
- Automated notifications you don't need
- Channels you're muted in
- Old messages (>24h) in fast-moving channels

## 3. Present the Summary

```
💬 Message Triage — {Date} {Time}

🔴 URGENT ({count})

[Slack] @jane in #engineering (2 min ago)
"Can you review this PR before standup?"
→ Needs: PR review

[Telegram] Mom (1 hour ago)
"Are you coming to dinner Sunday?"
→ Needs: Confirm or decline

🟡 IMPORTANT ({count})

[Discord] @mike in #general (3 hours ago)
"Thoughts on the new design?"
→ Needs: Opinion

[Slack] Thread in #product (5 hours ago)
"@you what's the status on the integration?"
→ Needs: Status update

🟢 FYI ({count})
• [Slack] #announcements — New PTO policy posted
• [Discord] #releases — v2.3.0 shipped
• [Telegram] Group — 47 messages (general chat)

📊 Summary
• {X} messages across {Y} platforms
• {Z} need responses
• Oldest urgent: {time}
```

## 4. Quick Actions

For each message, offer:
- **Reply** — Draft a response
- **Snooze** — Remind in 1hr/tomorrow
- **Mark read** — Dismiss without action
- **Open** — Jump to the app/thread

## 5. Deliver Summary (Optional)

If running on schedule, send summary to preferred channel:

```bash
telegram send --message "TRIAGE_SUMMARY"
```

## Tracking

```json
{
  "lastMessageCheck": "2026-02-09T14:30:00",
  "platforms": {
    "slack": {"lastCheck": "...", "unreadCount": 5},
    "discord": {"lastCheck": "...", "unreadCount": 12},
    "telegram": {"lastCheck": "...", "unreadCount": 3}
  }
}
```

## Notes

- Run on-demand ("check my messages") or on schedule (every few hours)
- Don't overwhelm — if 200 unread messages, summarize don't list all
- Learn which channels matter vs. noise
- Respect focus time — don't interrupt with non-urgent stuff
- Platform availability depends on installed skills/integrations
