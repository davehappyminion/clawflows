---
name: send-expense-report
description: Expense report generator — scans Gmail for receipts, categorizes spending, and sends a monthly summary. Use when the user says "expense report", "check my spending", "monthly expenses", or "send expense report".
requires:
  - name: gog
    description: Google Gmail CLI
  - name: telegram
    description: Telegram messaging
---

# Expense Report

Scan Gmail for receipts, categorize spending, send a monthly report.

## 1. Find Receipts

Search Gmail for receipt emails from the past month:

```bash
gog gmail search 'subject:(receipt OR order OR payment OR invoice OR confirmation) newer_than:30d' --account YOUR_EMAIL
```

Read each potential receipt:

```bash
gog gmail get <message_id> --account YOUR_EMAIL
```

## 2. Extract Amounts

For each receipt email, extract:
- **Amount** — total charged
- **Vendor** — who charged it
- **Date** — when the charge occurred
- **Category** — auto-categorize (see below)

### Categories
- **Subscriptions** — recurring charges (streaming, SaaS, memberships)
- **Food & Dining** — restaurants, delivery, groceries
- **Shopping** — Amazon, retail purchases
- **Travel** — flights, hotels, rideshare
- **Services** — utilities, phone, internet
- **Other** — everything else

## 3. Build Report

Format the expense report:

```markdown
# Expense Report — [Month YYYY]

## Summary
- **Total:** $X,XXX.XX
- **Transactions:** XX

## By Category
| Category | Amount | Count |
|----------|--------|-------|
| Subscriptions | $XX.XX | X |
| Food & Dining | $XX.XX | X |
| Shopping | $XX.XX | X |

## All Transactions
| Date | Vendor | Amount | Category |
|------|--------|--------|----------|
| MM/DD | Vendor | $XX.XX | Category |

## Notable
- Largest expense: [vendor] ($XX.XX)
- Most frequent: [vendor] (X transactions)
- New subscriptions: [any new recurring charges]
```

## 4. Deliver

Send the summary via messaging:

```bash
telegram send --message "EXPENSE_REPORT"
```

## Notes

- Schedule via cron for the 1st of each month
- Amounts are extracted from email content — may not catch everything
- Review the report for accuracy before using for actual expense tracking
