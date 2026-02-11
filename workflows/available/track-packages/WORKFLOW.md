---
name: track-packages
emoji: 📦
description: Package tracker — pulls tracking info from order confirmation emails, builds a consolidated status board, and alerts when deliveries are arriving today or running late.
schedule: "8am, 5pm"
---

# Track Packages

Consolidate all your incoming shipments into one clean status board. Know what's arriving today, what's delayed, and what's gone silent.

## 1. Scan Email for Order Confirmations and Shipping Notifications

Search the user's email from the last 30 days for:
- "shipped" OR "tracking number" OR "out for delivery" OR "order confirmed"
- "delivery scheduled" OR "package on the way" OR "carrier notification"
- Known retailer shipping emails (Amazon, Apple, Best Buy, Target, Walmart, eBay, Etsy, etc.)
- Carrier notifications (UPS, FedEx, USPS, DHL, OnTrac, etc.)

Extract from each match:
- Order description / item name (or retailer + order number if item name isn't clear)
- Tracking number
- Carrier
- Estimated delivery date (from the most recent update)
- Shipping destination (verify it's going to the right address if multiple are on file)

## 2. Check Live Tracking Status

For each tracking number found, query the carrier's tracking data:
- Current status (label created, in transit, out for delivery, delivered, exception)
- Last known location and timestamp
- Updated estimated delivery date (carriers often revise this)
- Any exception or hold flags

If a tracking number doesn't resolve or the carrier can't be identified, flag it for manual review.

## 3. Classify Each Package

Assign a status to every shipment:
- **Arriving Today** — out for delivery or ETA is today
- **In Transit** — moving, ETA is in the future
- **Delayed** — past the original ETA with no delivery confirmation
- **Exception** — carrier flagged a problem (address issue, customs hold, weather delay)
- **Delivered** — confirmed delivered in the last 48 hours (show briefly, then drop off)
- **Stale** — label created but no movement in 5+ days

## 4. Present the Status Board

```
PACKAGE TRACKER — [Date, Time]
====================================

ARRIVING TODAY:
  [Item/Retailer]  |  [Carrier] [tracking]  |  Out for delivery since [time]
  [Item/Retailer]  |  [Carrier] [tracking]  |  ETA today by [time]

IN TRANSIT:
  [Item/Retailer]  |  [Carrier] [tracking]  |  ETA [date]  |  Last: [city, state]
  [Item/Retailer]  |  [Carrier] [tracking]  |  ETA [date]  |  Last: [city, state]

NEEDS ATTENTION:
  [Item/Retailer]  |  [Carrier] [tracking]  |  DELAYED — was due [date], no update since [date]
  [Item/Retailer]  |  [Carrier] [tracking]  |  EXCEPTION — [reason]
  [Item/Retailer]  |  [Carrier] [tracking]  |  STALE — label created [date], no scans

RECENTLY DELIVERED:
  [Item/Retailer]  |  Delivered [date] at [time]  |  [location/signed by]
```

## 5. Send Alerts

- **Morning run (8am):** Send the full status board. Highlight anything arriving today at the top.
- **Evening run (5pm):** Send only changes since the morning — new deliveries, status updates, new delays. Skip if nothing changed.
- If something shifts to "Delayed" or "Exception" status, mark the message as high priority.

## 6. Clean Up

- Drop packages from the board 48 hours after confirmed delivery.
- If an order confirmation email exists but no shipping notification followed within 7 days, flag it as "Not Yet Shipped" so nothing slips through.

## Notes

- **NEVER sign for packages, authorize redirects, or change delivery instructions.** This workflow is read-only observation and reporting.
- Tracking numbers can appear in multiple emails (confirmation, shipped, delivered). Deduplicate by tracking number, always use the most recent status.
- Some retailers (especially Amazon) ship multi-item orders in separate packages. Treat each tracking number as its own line item.
- If the user has a delivery locker, PO box, or specific delivery preferences noted in their profile, mention when a package is going somewhere unexpected.
- International shipments may have two tracking numbers (origin carrier + local carrier). Track both if available.
