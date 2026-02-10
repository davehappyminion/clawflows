---
name: process-contacts
description: Contacts cleanup — deduplicates macOS contacts, flags entries with missing fields, and identifies stale contacts. Use when the user says "clean up contacts", "deduplicate contacts", "process contacts", or "organize my address book".
---

# Process Contacts

Deduplicate macOS contacts, flag missing fields, identify stale entries.

## 1. Export Contacts

Pull all contacts from macOS Contacts:

```bash
osascript -e 'tell application "Contacts" to get name of every person'
```

For detailed info:

```bash
osascript -e 'tell application "Contacts"
  set output to ""
  repeat with p in every person
    set output to output & (name of p) & "|" & (value of first email of p) & "|" & (value of first phone of p) & linefeed
  end repeat
  return output
end tell'
```

## 2. Find Duplicates

Look for contacts that share:
- Same first + last name
- Same email address
- Same phone number

List duplicate groups and recommend which to merge.

## 3. Flag Missing Fields

Identify contacts missing key information:
- No email address
- No phone number
- No company/organization
- No last name

## 4. Identify Stale Contacts

Flag contacts that may be outdated:
- Company email addresses from companies that no longer exist
- Contacts with no recent interaction
- Entries with only partial information (just a name, nothing else)

## After Running

Report:
- Total contacts scanned
- Duplicate groups found
- Contacts with missing fields (grouped by what's missing)
- Stale contacts flagged for review

## Notes

- Never delete contacts automatically — only recommend changes
- Export a backup before any modifications
