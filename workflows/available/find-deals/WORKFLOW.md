---
name: find-deals
emoji: 🏷️
description: Deal finder — monitors price drops on wishlist items, checks deal sites and retailer emails, and alerts when something hits the target price.
schedule: "10am"
---

# Find Deals

Watch for price drops on things you actually want. No noise, no junk — just actionable alerts when a wishlist item hits your target price or a genuinely good deal appears.

## 1. Load the Wishlist

Check the user's wishlist for tracked items. Each item should have:
- Product name and/or URL
- Target price (the price at which the user wants to be notified)
- Current known price (from the last check)
- Retailer(s) to monitor
- Priority (nice-to-have vs. waiting-to-buy)

If no wishlist exists yet, note that and skip to Step 3 (email scanning).

## 2. Check Current Prices

For each wishlist item, look up the current price at tracked retailers:
- Compare against the user's target price
- Compare against the last known price (detect drops and increases)
- Check if any coupon codes or promotions apply
- Note if the item is out of stock, discontinued, or has limited availability

Record the price history data point for trend tracking.

## 3. Scan Email for Retailer Promotions

Search the user's email from the last 48 hours for:
- "sale" OR "price drop" OR "deal" OR "coupon" OR "promo code"
- "back in stock" OR "price alert" OR "limited time"
- Known retailer promotional emails (Amazon, Best Buy, Target, Walmart, B&H, Costco, etc.)
- Price alert services (CamelCamelCamel, Honey, Slickdeals notifications)

Extract:
- Product or category on sale
- Discount amount or percentage
- Promo code if included
- Expiration date of the deal
- Whether it matches any wishlist item

## 4. Cross-Reference and Score

For each potential deal found:
- **Direct wishlist match** — item is on the wishlist and at or below target price. Top priority.
- **Wishlist adjacent** — item is related to something on the wishlist (same category, newer model, accessory). Worth mentioning.
- **Notable deal** — significant discount (40%+ off) on a product category the user has shown interest in.
- **Skip** — doesn't match user interests, isn't a meaningful discount, or is from a sketchy source.

Only surface Direct matches and Wishlist adjacent items by default. Include Notable deals only if there are fewer than 3 other items to report.

## 5. Present the Report

```
DEAL WATCH — [Date]
====================================

TARGET PRICE HIT:
  [Product Name]
  Now: $XX.XX (target was $XX.XX) — [Retailer]
  Was: $XX.XX last check | All-time low: $XX.XX
  Link: [url]

PRICE DROPS (not yet at target):
  [Product Name]
  Now: $XX.XX ↓ from $XX.XX (-XX%) — [Retailer]
  Your target: $XX.XX (still $X.XX away)
  Link: [url]

DEALS WORTH A LOOK:
  [Product/Category] — XX% off at [Retailer]
  [Brief description] | Expires [date]
  Code: [PROMO_CODE] (if applicable)
  Link: [url]

PRICE INCREASES (heads up):
  [Product Name] — went UP from $XX.XX to $XX.XX at [Retailer]

NO CHANGE:
  [X] wishlist items checked, no movement.
```

## 6. Deliver Alerts

- **Target price hit:** Send immediately as a high-priority message, even outside the normal schedule. These are time-sensitive.
- **Daily run (10am):** Send the full report if there's anything to report. If nothing changed, send a brief "No deals today — [X] items watched" one-liner.
- If a deal has an expiration within 24 hours, note the urgency clearly.

## Notes

- **NEVER purchase anything automatically.** This workflow finds and reports deals. The user decides whether to buy.
- **NEVER click affiliate links or sign up for deal services on the user's behalf.**
- Price data can be noisy — third-party sellers on Amazon, marketplace fluctuations, "was/now" pricing games. Focus on the actual lowest available price from reputable sellers.
- If a product has been on the wishlist for 90+ days without hitting the target price, suggest whether the target is realistic based on price history.
- When a wishlist item is frequently going in and out of stock, mention the stock pattern so the user can act faster next time.
- Avoid surfacing "deals" that require signing up for a new credit card, subscription, or membership the user doesn't already have.
- If the user hasn't set up a wishlist, prompt them to add items after the first run. The workflow is most useful with a populated wishlist.
