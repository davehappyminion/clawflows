---
name: build-meeting-prep
description: Meeting prep generator — creates a prep document for the next upcoming meeting with attendee context and talking points. Use when the user says "prep for my meeting", "meeting prep", "get ready for my next meeting", or "build meeting prep".
---

# Meeting Prep

Generate a prep doc for the next meeting with attendee context and talking points.

## 1. Find Next Meeting

Get the next upcoming calendar event:

```bash
icalBuddy -f -nc -n -ea -nrd -li 1 -df "%Y-%m-%d" -tf "%H:%M" -po "datetime,title,attendees,location,notes" eventsToday+1
```

If the user specifies a particular meeting, find that one instead.

## 2. Gather Attendee Context

For each attendee:
- Check contacts for their title/company
- Check recent email threads with them
- Check previous calendar events with them

## 3. Review Previous Meetings

Find past events with the same title or attendees:

```bash
icalBuddy -f -nc -nrd -df "%Y-%m-%d" -po "datetime,title,notes" eventsFrom:today-30 to:today | grep -i "MEETING_TITLE"
```

Look for notes, action items, or follow-ups from previous sessions.

## 4. Build Prep Doc

Create a prep document:

```markdown
# Meeting Prep: [Meeting Title]
**When:** YYYY-MM-DD HH:MM
**Where:** [Location or video link]

## Attendees
- [Name] — [Role/context]

## Previous Meeting Notes
- [Key points from last time]
- [Open action items]

## Suggested Talking Points
1. [Based on context and previous meetings]
2. [Follow-up items]
3. [New topics]

## Questions to Ask
- [Based on gaps in knowledge or pending items]
```

## After Running

Present the prep doc. If the meeting is within 2 hours, highlight urgent prep items.

## Notes

- Prioritize actionable prep over background research
- If no previous meetings exist with these attendees, note it — it might be a first meeting
- Keep talking points to 3-5 items max
