---
name: send-expense-report
emoji: 💰
description: Expense report generator — scans email for receipts, categorizes spending, and sends a monthly summary.
triggers:
  - expense report
  - spending summary
  - monthly expenses
  - receipt summary
---

# Expense Report

Scan email for receipts, categorize spending, send a monthly report.

## 1. Find Receipts

Using your **email skill**, search for receipt emails from the past month:
- Subject contains: receipt, order, payment, invoice, confirmation
- From common vendors (Amazon, Apple, Uber, etc.)
- Has attachments (PDF receipts)

## 2. Extract Amounts

For each receipt email, extract:
- **Amount** — Total charged
- **Vendor** — Who charged it
- **Date** — When the charge occurred
- **Category** — Auto-categorize (see below)

### Categories
- **Subscriptions** — Recurring charges (streaming, SaaS, memberships)
- **Food & Dining** — Restaurants, delivery, groceries
- **Shopping** — Amazon, retail purchases
- **Travel** — Flights, hotels, rideshare
- **Services** — Utilities, phone, internet
- **Other** — Everything else

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
| Travel | $XX.XX | X |
| Services | $XX.XX | X |
| Other | $XX.XX | X |

## All Transactions
| Date | Vendor | Amount | Category |
|------|--------|--------|----------|
| MM/DD | Vendor | $XX.XX | Category |
...

## Notable
- Largest expense: [vendor] ($XX.XX)
- Most frequent: [vendor] (X transactions)
- New subscriptions: [any new recurring charges]
```

## 4. Deliver

Using your **messaging skill**, send the summary to the user.

Optionally:
- Save as PDF
- Email to accountant
- Export to spreadsheet

## Tracking

Remember:
- Last report date
- Previous month's total (for comparison)

## Notes

- Schedule for the 1st of each month
- Amounts are extracted from email content — may not catch everything
- Review the report for accuracy before using for actual expense tracking
- Flag unusual spending patterns
