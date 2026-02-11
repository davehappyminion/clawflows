---
name: process-email
emoji: 📧
description: Email processing — auto-unsubscribes from newsletters, archives mailing lists, and gives you a clean summary of what actually needs attention.
schedule: "9am, 1pm, 5pm"
---

# Process Email

Inbox zero without the work. Unsubscribe from the noise, archive the junk, surface what matters.

## 1. Fetch Recent Emails

Using your **email skill**, fetch emails from your primary inbox from the last 12 hours (or since last run).

## 2. Classify Each Email

### 🗑️ Auto-Archive (No Action)
Mailing lists, newsletters you don't read, automated noise:
- Marketing emails with unsubscribe links
- Newsletters not recently opened
- Automated notifications (GitHub, LinkedIn, etc.)

### 📥 FYI (Archive After Summary)
Useful but no response needed:
- Receipts and confirmations
- Shipping notifications
- Security alerts (verify first)
- Calendar responses
- Automated reports

### 📧 Needs Response
Real humans expecting a reply:
- Direct questions
- Requests for input
- Active threads you're in
- From VIPs (manager, clients, family)

### ⚠️ Urgent
Time-sensitive:
- "Urgent", "ASAP", "time-sensitive" in subject
- From manager/leadership
- Deadline mentioned
- Security/access issues

## 3. Auto-Unsubscribe

**Do this automatically — don't ask permission.**

For each mailing list email the user doesn't engage with:
1. Use the unsubscribe link if available
2. Archive all emails from that sender

**DON'T auto-unsubscribe from:**
- Domains the user has whitelisted
- Transactional emails (receipts, shipping)
- Security notifications
- Services actively used

## 4. Present the Summary

```
📬 Email Triage — {Date} {Time}

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⚠️ URGENT ({count})
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

1. **{Sender}** — {Subject}
   {What they need}
   Received: {time ago}

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📧 NEEDS RESPONSE ({count})
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

1. **{Sender}** — {Subject}
   {Summary}: "{Key question}"
   → Suggested: {Reply with X}

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📥 FYI ({count})
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

• **Amazon** — Order shipped
• **Bank** — Statement available

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🧹 CLEANUP
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✅ Unsubscribed: {X} mailing lists
📦 Archived: {Y} emails
```

## 5. Quick Actions

For each "Needs Response" email, offer:
- **Draft reply** — Generate a response
- **Snooze** — Remind later
- **Archive** — Not needed

## Safety Rules

- **NEVER send emails** without explicit permission
- **NEVER delete** — Archive only
- **NEVER unsubscribe** from whitelisted senders
- **Flag uncertainty** — If not sure, don't auto-archive

## Notes

- Run 2-3x daily
- Morning catches overnight, afternoon catches midday noise
- Celebrate: "Inbox at 5 — nice work!"
- Learn from corrections: if user un-archives something, remember that sender
