---
name: process-contacts
emoji: 📇
description: Contacts cleanup — deduplicates contacts, flags entries with missing fields, and identifies stale contacts.
---

# Process Contacts

Deduplicate contacts, flag missing fields, identify stale entries.

## 1. Export Contacts

Using your **contacts skill**, pull all contacts:
- Name (first, last)
- Email addresses
- Phone numbers
- Company/organization
- Notes

## 2. Find Duplicates

Look for contacts that share:
- Same first + last name
- Same email address
- Same phone number
- Similar names (fuzzy matching)

Group duplicates together for review.

## 3. Flag Missing Fields

Identify contacts missing key information:
- No email address
- No phone number
- No company/organization
- No last name (first name only)
- No photo

## 4. Identify Stale Contacts

Flag contacts that may be outdated:
- Company email addresses from companies that no longer exist
- Old job titles (if trackable)
- Entries with only partial information (just a name, nothing else)
- Contacts you haven't interacted with in years

## 5. Present Findings

```
📇 Contacts Audit

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📊 SUMMARY
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
• Total contacts: 847
• Duplicate groups: 23
• Missing email: 156
• Missing phone: 203
• Potentially stale: 45

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
👥 DUPLICATES (23 groups)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
John Smith (3 entries)
  • john@work.com, john@personal.com
  • Recommend: Merge

Jane Doe (2 entries)
  • Same email, different phones
  • Recommend: Merge

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⚠️ INCOMPLETE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
• 156 contacts have no email
• 45 contacts are name-only

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🗑️ POTENTIALLY STALE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
• 12 contacts with defunct company emails
• 33 contacts with minimal info
```

## 6. Offer Actions

For each finding, offer:
- **Merge** — Combine duplicate entries
- **Update** — Add missing information
- **Archive** — Move to a "stale" group
- **Delete** — Remove (with confirmation)

## Notes

- Never delete contacts automatically — only recommend changes
- Export a backup before any modifications
- Run quarterly for maintenance
