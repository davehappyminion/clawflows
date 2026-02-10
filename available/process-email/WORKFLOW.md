---
name: process-email
description: Email processing — auto-unsubscribes from newsletters, archives mailing lists, and gives you a clean summary of what actually needs attention.
requires:
  - name: gog
    description: Google Gmail CLI
---

# Process Email

Inbox zero without the work. Unsubscribe from the noise, archive the junk, surface what matters.

## 1. Fetch Recent Emails

Pull emails from the last 12 hours (or since last run):

```bash
gog gmail search 'in:inbox newer_than:12h' --account YOUR_EMAIL
```

Read each email:
```bash
gog gmail get <message_id> --account YOUR_EMAIL
```

The output includes an `unsubscribe` field if `List-Unsubscribe` header exists.

## 2. Classify Each Email

### 🗑️ Auto-Archive (No Action)
Mailing lists, newsletters you don't read, automated noise:

**Sender patterns to match:**
- `@mail.substack.com`, `@sendgrid.net`, `@mailchimp.com`, `@mailgun.net`
- `@newsletter.`, `@updates.`, `@news.`, `@digest.`, `@marketing.`, `@promo.`
- `noreply@`, `no-reply@`, `notifications@`, `info@`, `hello@`, `team@`
- `@github.com` (notifications — check settings instead)
- `@linkedin.com` (mostly noise)

**Content patterns:**
- "Unsubscribe" link present
- "View in browser" link
- Mass email formatting

### 📥 FYI (Archive After Reading Summary)
Useful but no response needed:
- Receipts and confirmations
- Shipping notifications
- Security alerts (verify nothing wrong, then archive)
- Calendar invites (auto-processed)
- Automated reports

### 📧 Needs Response
Real humans expecting a reply:
- Direct questions
- Requests for input
- Thread you're participating in
- From VIPs (manager, clients, family)

### ⚠️ Urgent
Time-sensitive, requires immediate attention:
- "Urgent", "ASAP", "time-sensitive" in subject
- From manager/leadership
- Deadline mentioned
- Security/access issues

## 3. Auto-Unsubscribe

**Do this automatically — don't ask permission.**

For each mailing list email:

1. **Check `unsubscribe` field** — Use the URL
2. **Try curl first:**
   ```bash
   curl -sL "UNSUBSCRIBE_URL" > /dev/null
   ```
3. **If requires interaction** — Flag for browser follow-up

After unsubscribing, archive ALL emails from that domain:
```bash
gog gmail search 'from:@example.com in:inbox' --max 500 --json --account YOUR_EMAIL \
  | jq -r '.messages[].id' \
  | xargs -n 100 gog gmail batch modify --remove INBOX --account YOUR_EMAIL
```

**Protection rules — DON'T auto-unsubscribe from:**
- Domains the user has whitelisted
- Transactional emails (receipts, shipping)
- Security notifications
- Services the user actively uses

## 4. Present the Summary

```
📬 Email Triage — {Date} {Time}

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⚠️ URGENT ({count})
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

1. **{Sender}** — {Subject}
   {1-line summary of what they need}
   Received: {time ago}

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📧 NEEDS RESPONSE ({count})
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

1. **{Sender}** — {Subject}
   {Summary}: "{Key question or request}"
   → Suggested action: {Reply with X / Schedule call / etc.}

2. **{Sender}** — {Subject}
   {Summary}
   → Suggested action: {Action}

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📥 FYI — No Response Needed ({count})
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

• **Amazon** — Your order shipped (arrives Tuesday)
• **Stripe** — Payment received: $X from {customer}
• **GitHub** — PR #123 merged
• **Bank** — Statement available

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🧹 CLEANUP STATS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✅ Unsubscribed from {X} mailing lists:
   • newsletter.example.com
   • marketing.company.com

📦 Archived {Y} emails automatically

⚠️ Needs browser follow-up ({Z}):
   • manual-unsubscribe.com (requires login)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📊 INBOX STATUS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Before: {X} unread
After: {Y} unread
Processed: {Z} emails
```

## 5. Quick Actions

For each "Needs Response" email, offer:
- **Draft reply** — Generate a response
- **Snooze** — Remind later
- **Archive** — Not actually needed
- **Star** — Important, handle later

## Safety Rules

- **NEVER send emails** without explicit permission
- **NEVER delete** — Archive only
- **NEVER unsubscribe** from whitelisted senders
- **ALWAYS preserve** anything with attachments from real people
- **Flag uncertainty** — If not sure, don't auto-archive

## Tracking

```json
{
  "lastEmailProcess": "2026-02-09T14:30:00",
  "unsubscribedDomains": ["newsletter.example.com"],
  "whitelistedDomains": ["company.com", "client.com"],
  "stats": {
    "totalProcessed": 150,
    "autoArchived": 120,
    "unsubscribed": 5
  }
}
```

## Notes

- Run 2-3x daily for best results
- Morning run catches overnight accumulation
- Afternoon run catches midday noise
- Celebrate: "Inbox at 5 emails — nice work!"
- Learn from corrections: if user un-archives something, remember that sender
