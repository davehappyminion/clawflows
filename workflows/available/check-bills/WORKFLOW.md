---
name: check-bills
emoji: 🧾
description: Bill monitor — scans email for upcoming bills and due dates, flags unusual amounts or spikes, and makes sure nothing gets missed before it's due.
schedule: "monday 8am"
---

# Check Bills

Stay ahead of every bill. Surface what's due soon, catch anything that looks off, and make sure nothing sneaks past the due date.

## 1. Scan Email for Bills and Statements

Search the user's email from the last 45 days for:
- "bill" OR "statement" OR "amount due" OR "payment due" OR "invoice"
- "balance due" OR "autopay" OR "scheduled payment" OR "minimum payment"
- Known billers: utilities (electric, gas, water, internet, phone), insurance, rent/mortgage, credit cards, loans, streaming services, memberships

Extract from each match:
- Biller / company name
- Amount due
- Due date
- Whether autopay is enabled (if mentioned in the email)
- Account number or last-four (for disambiguation if multiple accounts exist)
- Link to view the full statement (if present)

## 2. Build the Bill Calendar

Organize all extracted bills into a timeline:
- **Overdue** — due date has passed, no payment confirmation found
- **Due This Week** — due in the next 7 days
- **Due This Month** — due in the next 30 days
- **Autopay Scheduled** — autopay is confirmed, payment will process automatically

Sort each group by due date, soonest first.

## 3. Compare Against History

For each bill, compare the current amount against the previous period (if available from older emails):
- Flag increases over 15% with a warning
- Flag any bill that's more than double the historical average
- Note if a bill is lower than usual too (might indicate a partial bill or error)

If no historical data exists yet, note it as "First seen — no comparison available."

## 4. Flag Anomalies and Risks

Call out:
- Bills due in the next 3 days without autopay (highest urgency)
- Significant amount increases with a percentage and dollar change
- New billers that haven't appeared before (could be legitimate or could be a mistake)
- Missing bills — if a regular monthly biller didn't send a statement this cycle, that's worth flagging too
- Late fees or past-due warnings detected in email language

## 5. Present the Report

```
BILL CHECK — Week of [Date]
====================================

TOTAL DUE (next 30 days): $[total]
AUTOPAY COVERED: $[autopay_total]
MANUAL PAYMENT NEEDED: $[manual_total]

ACTION REQUIRED:
  [Biller]         $XXX.XX    Due [date]    No autopay — PAY MANUALLY
  [Biller]         $XXX.XX    Due [date]    No autopay — PAY MANUALLY

UPCOMING (autopay enabled):
  [Biller]         $XXX.XX    Due [date]    Autopay on [payment date]
  [Biller]         $XXX.XX    Due [date]    Autopay on [payment date]

LATER THIS MONTH:
  [Biller]         $XXX.XX    Due [date]    [autopay status]
  [Biller]         $XXX.XX    Due [date]    [autopay status]

FLAGGED:
  ⚠ [Biller] — $XXX.XX is 40% higher than last month ($XXX.XX → $XXX.XX)
  ⚠ [Biller] — No statement received this cycle (usually arrives by [date])
  ⚠ [Biller] — New biller, first time seeing this. Verify it's expected.

OVERDUE:
  [Biller]         $XXX.XX    Was due [date]    [details]
```

## 6. Deliver the Summary

Send the report to the user via their preferred messaging channel. If any bills are overdue or due within 3 days without autopay, mark the message as high priority.

On non-Monday runs (if triggered manually), only show changes since the last report.

## Notes

- **NEVER pay, authorize, or schedule any payment automatically.** This workflow only reads and reports. The user handles all payments themselves.
- **NEVER store or log full account numbers.** Use last-four only for disambiguation.
- Autopay detection is best-effort based on email language ("autopay is scheduled," "will be charged to card ending in..."). If unclear, assume autopay is NOT set and flag for manual attention. Better safe than sorry.
- Some bills arrive as PDF attachments rather than in the email body. Note when a PDF statement is attached but couldn't be read, so the user knows to check it manually.
- If the user has noted specific budget thresholds in their profile, compare bill totals against those thresholds and warn if they're over budget.
- Over time, this workflow builds a baseline for each biller, making anomaly detection more accurate with every run.
