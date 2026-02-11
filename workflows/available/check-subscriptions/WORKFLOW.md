---
name: check-subscriptions
emoji: 💳
description: Subscription auditor — scans bank statements and email receipts for recurring charges, calculates your total monthly burn, and flags forgotten or suspicious subscriptions.
schedule: "monday 9am"
---

# Check Subscriptions

Find every recurring charge hitting your accounts. Surface the ones you forgot about, calculate the total damage, and suggest what to cut.

## 1. Scan Email for Subscription Receipts

Search the user's email for the last 60 days using queries like:
- "receipt" OR "invoice" OR "subscription" OR "renewal" OR "billing"
- "your payment" OR "charge of" OR "auto-renewed"
- Filter to known subscription senders (Apple, Google, Amazon, Spotify, Netflix, Adobe, etc.)

Extract from each match:
- Service name
- Amount charged
- Billing frequency (monthly, annual, weekly)
- Date of last charge
- Email/account associated

## 2. Scan Bank and Credit Card Statements

If statement data is available (CSV exports, financial tool integrations), scan for:
- Recurring charges with the same merchant and similar amounts
- Charges that repeat on a predictable cycle (monthly, quarterly, annual)
- Small charges that are easy to miss ($1-5 range — often trials that converted)

Cross-reference with email findings to build a complete picture.

## 3. Categorize Each Subscription

Group every subscription into one of these buckets:
- **Active & Used** — user clearly uses this regularly
- **Active & Questionable** — no recent usage signals, or overlaps with another service
- **Forgotten / Unknown** — no engagement in 60+ days, or user may not recognize it
- **Trial Converting Soon** — free trial with an upcoming first charge

## 4. Flag Anomalies

Call out anything unusual:
- Price increases since the last charge
- Duplicate services (e.g., two cloud storage plans, two music services)
- Annual renewals coming up in the next 30 days (chance to cancel before the charge)
- Subscriptions tied to an old email or payment method

## 5. Present the Report

```
SUBSCRIPTION AUDIT — [Date]
==================================

MONTHLY BURN: $[total]/mo ($[annual_total]/yr)

SERVICE              COST        CYCLE     LAST CHARGE   STATUS
---------------------------------------------------------------
[Service Name]       $XX.XX      monthly   [date]        Active & Used
[Service Name]       $XX.XX      annual    [date]        Questionable
[Service Name]       $XX.XX      monthly   [date]        Forgotten
...

FLAGGED FOR REVIEW:
- [Service] — No usage detected in 90 days. Last charge $X.XX on [date].
- [Service] — Annual renewal of $XXX.XX coming up on [date].
- [Service] — Price increased from $X.XX to $Y.YY since last cycle.
- [Service] + [Service] — Possible overlap (both are [category]).

SUGGESTED CANCELLATIONS:
- [Service] — $X.XX/mo — [reason]
- [Service] — $X.XX/mo — [reason]

POTENTIAL SAVINGS: $[amount]/mo ($[annual]/yr)
```

## 6. Deliver the Summary

Send the report to the user via their preferred messaging channel. If annual renewals are approaching within 14 days, mark the message as high priority.

## Notes

- **NEVER cancel, pause, or modify any subscription automatically.** This workflow is read-only. The user decides what to act on.
- **NEVER log into banking portals or payment systems.** Only use data already available through email, exported statements, or authorized integrations.
- Some subscriptions bill annually — normalize everything to a monthly equivalent for the burn calculation, but show the actual billing cycle in the table.
- If a service can't be identified from the merchant name, flag it as "Unknown" and include the raw merchant string so the user can investigate.
- Re-running this weekly builds a history that makes it easier to spot new charges or price creeps over time.
