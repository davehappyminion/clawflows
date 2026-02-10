---
name: sync-calendar-tasks
description: Calendar task extractor — scans calendar events for action items and suggests tasks to create.
triggers:
  - sync calendar tasks
  - extract action items
  - meeting tasks
  - calendar to tasks
---

# Sync Calendar Tasks

Extract action items from calendar events and suggest tasks.

## 1. Scan Recent Events

Using your **calendar skill**, pull events from the past 7 days:
- Event title
- Event notes/description
- Attendees
- Date and time

## 2. Extract Action Items

For each event, look for action items in:

### Event Notes
Look for keywords:
- "TODO", "Action item", "Follow up"
- "Next steps", "Assigned to"
- Bullet points that start with action verbs

### Event Title
Look for deadline indicators:
- "due", "deadline", "submit by"
- "review", "approve", "finalize"

### Recurring Meetings
Check if prep is needed:
- 1:1s — prepare talking points
- Team meetings — prepare updates
- Reviews — prepare materials

## 3. Check Upcoming Deadlines

Using your **calendar skill**, scan the next 14 days for deadline-like events:
- Events with "due", "deadline", "submit"
- Events with "review", "launch", "release"
- All-day events that might be deadlines

## 4. Suggest Tasks

For each action item found, suggest a task:

```markdown
## Suggested Tasks

### From Past Meetings
- [ ] [Action item] — from [Meeting Name] on [Date]
- [ ] Follow up with [Person] about [Topic]
- [ ] Send [Document] to [Person]

### Meeting Prep Needed
- [ ] Prepare for [Upcoming Meeting] on [Date]
- [ ] Review materials for [Meeting] on [Date]

### Upcoming Deadlines
- [ ] [Deadline item] due [Date]
- [ ] Submit [Thing] by [Date]
```

## 5. Present Findings

```
📅 Calendar → Tasks

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📊 SCANNED
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
• Events reviewed: 23
• Action items found: 8
• Upcoming deadlines: 3
• Meetings needing prep: 4

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅ ACTION ITEMS (8)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
From "Team Sync" (Feb 5):
  • Send updated roadmap to team
  • Review Mike's PR

From "1:1 with Sarah" (Feb 6):
  • Follow up on promotion timeline

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⏰ DEADLINES (3)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
• Feb 15 — Q1 planning doc due
• Feb 18 — Performance review submission
• Feb 20 — Project proposal deadline

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📝 PREP NEEDED (4)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
• Feb 12 — Board meeting (prepare slides)
• Feb 14 — Client review (prepare demo)
```

## 6. Create Tasks (Optional)

Using your **task manager skill**, offer to create tasks:
- Add to task manager
- Set due dates
- Assign priorities

## Notes

- Don't create tasks automatically — present suggestions for the user to approve
- Prioritize items with deadlines
- Flag overdue items prominently
- Run weekly or after busy meeting days
