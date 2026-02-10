---
name: check-follow-ups
emoji: 🔔
description: Follow-up checker — scans for unanswered emails, promises you made, and things about to slip through the cracks.
schedule: "9am, 4pm"
---

# Check Follow-Ups

Find the balls you're about to drop — unanswered emails, promises you made, stale threads.

## 1. Scan Unanswered Emails

Using your **email skill**, find emails that need responses:
- Unread emails older than 2 days
- From real people (not automated senders)

### Filter for Real People
Exclude:
- noreply@, notifications@, etc.
- Marketing and newsletters
- Automated alerts

### Identify Response-Needed
Look for signals:
- Questions (sentences ending in ?)
- Direct requests ("Can you...", "Would you...")
- Waiting language ("Let me know", "Looking forward to")
- Time-sensitive ("by Friday", "ASAP")

## 2. Find Promises You Made

Scan your **sent** emails from the last 14 days for commitments:

### Phrases to Detect
- "I'll send you..."
- "I'll follow up..."
- "Let me get back to you..."
- "Will do!"
- "I'll have it by..."
- "Give me until..."

### Check If Fulfilled
For each promise:
1. What did you promise?
2. To whom?
3. When?
4. Did you follow through?

## 3. Find Stale Threads

Conversations where you replied and they went silent:
- Your last message was 3+ days ago
- No reply from them
- Might need a bump

## 4. Check Overdue Tasks

Using your **task manager skill**:
- Tasks past due date
- Tasks labeled "follow up" or "waiting"

## 5. Present the Report

```
📬 Follow-Up Check — {Date}

🔴 NEEDS RESPONSE ({count})
Emails waiting for your reply:

1. **{Sender}** — {Subject}
   Received: {X days ago}
   They asked: "{Key question}"

2. **{Sender}** — {Subject}
   Action needed: {What they want}

⚠️ PROMISES YOU MADE ({count})

1. "{I'll send you the deck}"
   To: {Person} — {X days ago}
   Status: Not yet sent

2. "{Let me check on that}"
   To: {Person} — {X days ago}
   Status: No follow-up found

💤 STALE THREADS ({count})

1. **{Person}** — {Subject}
   Your last reply: {X days ago}
   Consider: Gentle bump?

✅ ALL CLEAR
{If nothing: "No dropped balls — you're good!"}
```

## 6. Quick Actions

For each item, offer:
- **Reply now** — Draft a response
- **Snooze** — Remind in 2 days
- **Mark done** — Handled elsewhere
- **Dismiss** — Not needed

## Tracking

- Remember dismissed items
- Track snoozed items and resurface later

## Notes

- Run daily, mid-morning after email triage
- Don't nag — respect dismissals
- Celebrate zero items: "Nothing slipping — inbox hero!"
- Frame helpfully, not guiltily
