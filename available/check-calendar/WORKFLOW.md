---
name: check-calendar
description: Calendar review — scans the next 48 hours for events, detects conflicts, calculates travel time, and generates prep notes for each meeting.
---

# Check Calendar

Your 48-hour radar. Conflicts, prep needs, and heads-up for what's coming.

## 1. Fetch Upcoming Events

Pull events for the next 48 hours:

```bash
icalBuddy -f -nc -n -ea -nrd -df "%Y-%m-%d" -tf "%H:%M" -po "datetime,title,attendees,location,notes" eventsFrom:today to:today+2
```

If `icalBuddy` isn't available, use AppleScript:

```bash
osascript -e 'tell application "Calendar"
  set now to current date
  set endDate to now + (2 * days)
  set output to ""
  repeat with cal in calendars
    repeat with evt in (every event of cal whose start date >= now and start date <= endDate)
      set output to output & (start date of evt) & " | " & (summary of evt) & " | " & (location of evt) & linefeed
    end repeat
  end repeat
  return output
end tell'
```

## 2. Detect Issues

### Conflicts
- **Overlapping events** — Two meetings at the same time
- **Double-booked** — Accepted both? Need to decline one

### Scheduling Problems
- **Back-to-back** — No gap between consecutive events (need buffer)
- **No lunch** — Meetings through 12-1pm
- **Marathon blocks** — 3+ hours of continuous meetings
- **Early birds** — Anything before 8 AM
- **Late nights** — Anything after 6 PM

### Travel/Location Issues
- **Location change** — Previous meeting in different location, need travel time
- **Video vs in-person** — Mixed formats back-to-back

## 3. Generate Prep Notes

For each significant meeting:

### Attendee Context
- Who's attending (names, roles if known)
- Your relationship (manager, report, external, new contact)
- Last meeting with them (if findable)

### Meeting Type Assessment
- **1:1** — Review previous notes, pending items
- **External** — Research company/person, prep talking points
- **Group sync** — Check agenda, any pre-reads
- **Interview** — Review resume, prep questions
- **All-hands** — Usually just attend, low prep

### Suggested Prep
- Documents to review
- Questions to prepare
- Materials to bring
- Pre-meeting messages to send

## 4. Present the Schedule

```
📅 Calendar Check — {Date} {Time}

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
TODAY — {Day}, {Date}
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🟢 9:00 AM — Team Standup (15 min)
   📍 Zoom · 👥 Engineering team

🟡 10:00 AM — 1:1 with Sarah (30 min)
   📍 Zoom · 👤 Your manager
   ⚠️ Prep: Review Q2 goals discussion

🟢 11:00 AM — Design Review (1 hr)
   📍 Conf Room A · 👥 Product, Design

⚪ 12:00 PM — Lunch (blocked)

🔴 2:00 PM — Client Call — Acme Corp (1 hr)
   📍 Zoom · 👥 External: Jake, Maria
   ⚠️ Prep: Review proposal, test demo
   ⚠️ High stakes — decision meeting

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
TOMORROW — {Day}, {Date}
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🟢 9:00 AM — All Hands (1 hr)
   📍 Main Conf Room

{Continue...}

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⚠️ WARNINGS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🔴 CONFLICT: Design Review overlaps with Eng Sync tomorrow
   → Decline one or request reschedule

🟡 Back-to-back 2-4pm today — no buffer
   → Consider declining optional meetings

🟢 Free blocks: Today 3-5pm, Tomorrow 11am-12pm
   → Good windows for focused work

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📊 SUMMARY
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
• Today: {X} meetings, {Y} hrs committed, {Z} hrs free
• Tomorrow: {X} meetings, {Y} hrs committed, {Z} hrs free
• Prep needed: {N} meetings require advance work
```

## 5. Quick Actions

Offer to:
- **Add buffer** — Create 15-min blocks between back-to-backs
- **Decline** — Send regrets for conflicting/low-priority meetings
- **Reschedule** — Propose new time for conflicts
- **Set reminder** — "Remind me 15 min before client call"

## Notes

- Run morning and evening (what's tomorrow)
- Priority indicators: 🔴 high-stakes, 🟡 prep-needed, 🟢 routine, ⚪ personal
- If no events: "Calendar clear for 48 hours — open road!"
- Integrate with build-meeting-prep for deeper prep on specific meetings
