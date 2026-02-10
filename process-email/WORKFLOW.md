---
name: process-email
description: Email processing workflow — fetch recent emails, auto-unsubscribe from mailing lists, archive junk, and summarize important emails. Use when the user says "check email", "process email", "clean up inbox", or "email patrol".
requires:
  - name: gog
    description: Google Gmail CLI
---

# Process Email

Clean up the inbox — unsubscribe from junk, archive mailing lists, summarize what matters.

## 1. Fetch Recent Emails

Pull all emails from the last 12 hours:

```bash
gog gmail search 'newer_than:12h' --account YOUR_EMAIL
```

Read each email:

```bash
gog gmail get <message_id> --account YOUR_EMAIL
```

The output includes an `unsubscribe` field if the email has a `List-Unsubscribe` header.

## 2. Clean Up Mailing Lists

**Do this automatically — don't ask permission.**

### Identify mailing lists

Check the `unsubscribe` field — if present, it's a mailing list. Also match common sender patterns:

- `@mail.substack.com`, `@sendgrid.net`, `@mailchimp`, `@mailgun`
- `@newsletter.`, `@updates.`, `@news.`, `@digest.`, `@marketing.`, `@promo.`, `@campaigns.`
- `noreply@`, `no-reply@`, `notifications@`, `info@`, `hello@`, `team@`

### For each mailing list:

1. **Unsubscribe** using the URL from the `unsubscribe` field. Try `curl` first — if it requires browser interaction, use the browser.

2. **Archive ALL emails from that domain:**
   ```bash
   gog gmail messages search 'from:@example.com in:inbox' --max 500 --json --account YOUR_EMAIL \
     | jq -r '.messages[].id' \
     | xargs -n 100 gog gmail batch modify --remove INBOX --account YOUR_EMAIL
   ```

**Important:**
- Search with `in:inbox` so you only get inbox messages
- The JSON wraps results in `{"messages": [...]}` — use `.messages[].id`
- If `nextPageToken` is present, repeat with `--page <token>`
- Search by domain (`from:@example.com`) not exact sender

## 3. Summarize Important Emails

After cleaning, report what's left:

**Emails That Might Need Response** — numbered list with:
- Who it's from
- What it's about (one line)
- Whether any action is needed

**FYI - No Response Needed** — bullet list (receipts, security alerts, shipping, etc.)

**Cleanup Stats:**
- How many mailing lists unsubscribed from (and which ones)
- Which unsubscribes succeeded vs need browser follow-up
- How many total emails archived

## Notes

- Unsubscribe and archive automatically — don't ask permission
- Do NOT reply, forward, or send emails unless explicitly told to
