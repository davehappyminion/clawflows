---
name: check-calendar
description: Calendar review — scans the next 48 hours for events, detects conflicts, and generates prep notes.
---

# Check Calendar

48-hour calendar review with conflict detection and prep notes.

## 1. Fetch Upcoming Events

Pull events for the next 48 hours:

```bash
icalBuddy -f -nc -n -ea -nrd -df "%Y-%m-%d" -tf "%H:%M" -po "datetime,title,attendees,location,notes" eventsFrom:today to:today+2
```

If `icalBuddy` isn't available, use AppleScript:

```bash
osascript -e 'tell application "Calendar"
  set now to current date
  set tomorrow to now + (2 * days)
  set output to ""
  repeat with cal in calendars
    repeat with evt in (every event of cal whose start date >= now and start date <= tomorrow)
      set output to output & (start date of evt) & " | " & (summary of evt) & linefeed
    end repeat
  end repeat
  return output
end tell'
```

## 2. Detect Conflicts

Compare event times and flag:
- **Overlapping events** — two events at the same time
- **Back-to-back meetings** — no gap between consecutive events
- **Early/late events** — anything before 8 AM or after 6 PM

## 3. Generate Prep Notes

For each meeting:
- **Who's attending** — list attendees and their roles if known
- **What it's about** — summarize from the event title and notes
- **What to prepare** — suggest agenda items or documents to review
- **Travel time** — if the location is different from the previous event

## After Running

Present a clean schedule:
1. Today's remaining events
2. Tomorrow's events
3. Conflicts and warnings
4. Prep notes for each meeting

## Notes

- Highlight the most important events (1-on-1s with manager, external meetings, deadlines)
- If no events are found, say so — don't make things up
