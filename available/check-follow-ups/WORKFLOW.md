---
name: check-follow-ups
description: Follow-up checker — scans for unanswered emails, promises you made, and things about to slip through the cracks.
requires:
  - name: gog
    description: Google Gmail CLI
---

# Check Follow-Ups

Find the balls you're about to drop — unanswered emails, promises you made, stale threads.

## 1. Scan Unanswered Emails

Find emails that need responses:

```bash
gog gmail search 'in:inbox is:unread from:(-me) older_than:2d' --account YOUR_EMAIL
```

### Filter for Real People
Exclude automated senders:
- `noreply@`, `no-reply@`, `notifications@`
- `@mail.`, `@newsletter.`, `@updates.`
- Calendar invites, receipts, shipping notifications

### Identify Response-Needed
Look for signals that a reply is expected:
- Questions (sentences ending in ?)
- Direct requests ("Can you...", "Would you...", "Please...")
- Time-sensitive language ("by Friday", "this week", "ASAP")
- Waiting language ("Let me know", "Looking forward to hearing")

## 2. Find Promises You Made

Scan your **sent** emails for commitments:

```bash
gog gmail search 'in:sent newer_than:14d' --account YOUR_EMAIL
```

### Commitment Phrases to Detect
- "I'll send you..."
- "I'll follow up..."
- "Let me get back to you..."
- "I'll check and..."
- "Will do!"
- "I'll have it by..."
- "Give me until..."
- "I'll take a look..."

### Check If Fulfilled
For each promise found:
1. What did you promise?
2. To whom?
3. When did you say it?
4. Is there a follow-up sent email fulfilling it?
5. If not, flag it

## 3. Find Stale Threads

Conversations where you were last to reply and they went silent:

```bash
gog gmail search 'in:sent newer_than:7d' --account YOUR_EMAIL
```

For each sent email:
- Check if there's a reply from them after your message
- If no reply after 3+ days, might need a bump

## 4. Check Overdue Tasks

If integrated with task manager:
- Pull tasks past due date
- Pull tasks with "follow up" or "waiting" labels

## 5. Present the Report

```
📬 Follow-Up Check — {Date}

🔴 NEEDS RESPONSE ({count})
Emails waiting for your reply:

1. {Sender} — {Subject}
   Received: {X days ago}
   They asked: "{Key question or request}"

2. {Sender} — {Subject}
   Received: {X days ago}
   Action needed: {What they want}

⚠️ PROMISES YOU MADE ({count})
Things you said you'd do:

1. "{I'll send you the deck}"
   To: {Person} — {X days ago}
   Status: Not yet sent

2. "{Let me check on that}"
   To: {Person} — {X days ago}
   Status: No follow-up found

💤 STALE THREADS ({count})
You replied, they went quiet:

1. {Person} — {Subject}
   Your last reply: {X days ago}
   Consider: Gentle bump?

✅ ALL CLEAR
{If nothing found: "No dropped balls — you're good!"}
```

## 6. Offer Quick Actions

For each item, suggest:
- "Reply now" — draft a response
- "Snooze 2 days" — remind later
- "Mark done" — if you handled it elsewhere
- "Not needed" — dismiss (they probably forgot too)

## Tracking

```json
{
  "lastFollowUpCheck": "2026-02-09",
  "dismissedItems": ["thread_id_1"],
  "snoozedItems": [{"id": "thread_id_2", "until": "2026-02-11"}]
}
```

## Notes

- Run daily, ideally mid-morning after email triage
- Don't nag — if they dismissed something, respect it
- Celebrate zero items: "Nothing slipping through — inbox hero!"
- This is about awareness, not guilt. Frame it helpfully.
