---
name: build-meeting-prep
description: Meeting prep generator — creates a comprehensive prep document for any meeting with attendee research, history, talking points, and questions.
---

# Meeting Prep

Never walk into a meeting cold. Context, history, and talking points — ready to go.

## 1. Identify the Meeting

Find the target meeting:

```bash
# Next upcoming meeting
icalBuddy -f -nc -n -ea -nrd -li 1 -df "%Y-%m-%d" -tf "%H:%M" -po "datetime,title,attendees,location,notes" eventsToday+1
```

Or if user specifies: "Prep me for my 2pm with Jake"

Extract:
- Meeting title
- Date/time
- Location (Zoom link, room, address)
- Attendees
- Any existing notes/agenda

## 2. Research Attendees

For each attendee:

### Internal (Colleagues)
- Role/title
- Team/department
- Recent interactions (emails, meetings)
- Shared projects or dependencies

### External (Clients, Partners, New Contacts)
- Company and role
- LinkedIn summary (if accessible)
- Previous correspondence
- Company news or context

```bash
# Check recent emails with attendee
gog gmail search "from:attendee@email.com OR to:attendee@email.com" --limit 10 --account YOUR_EMAIL
```

### VIP Flags
- Is this your manager? → Higher stakes, be prepared
- Is this a skip-level? → Know your highlights
- Is this a prospect/client? → Know their business
- First meeting ever? → Extra research needed

## 3. Review History

### Previous Meetings
```bash
# Find past events with same attendees or title
icalBuddy -f -nc -nrd -df "%Y-%m-%d" -po "datetime,title,notes" eventsFrom:today-90 to:today | grep -i "SEARCH_TERM"
```

Look for:
- Previous meeting notes
- Action items assigned
- Decisions made
- Open questions

### Email Threads
Recent email context with attendees:
- What have you been discussing?
- Any pending items?
- Promises made (by you or them)?

### Shared Documents
- Google Docs recently shared
- Slack threads
- Project boards (Linear, Notion, etc.)

## 4. Build the Prep Doc

```markdown
# Meeting Prep: {Meeting Title}

📅 **When:** {Date} at {Time}
📍 **Where:** {Location/Link}
⏱️ **Duration:** {Length}
🎯 **Type:** {1:1 / Group / External / Interview}

---

## 👥 Attendees

### {Name} — {Role/Title}
- **Context:** {How you know them, relationship}
- **Recent:** {Last interaction, what you discussed}
- **Note:** {Anything to remember — preferences, style, topics to avoid}

### {Name 2} — {Role/Title}
{...}

---

## 📜 History

### Last Meeting ({Date})
- Discussed: {Key topics}
- Decided: {Outcomes}
- Action items:
  - [ ] {Your item} — Status: {done/pending}
  - [ ] {Their item} — Status: {unknown}

### Recent Email Thread
- Topic: {Subject line}
- Status: {Where it left off}
- Your last message: "{Summary}"

---

## 🎯 Agenda / Purpose

{If agenda exists, list it}
{If no agenda, infer purpose from title and context}

1. {Topic 1}
2. {Topic 2}
3. {Topic 3}

---

## 💬 Talking Points

### Must Cover
1. **{Topic}** — {Why it's important, what you need from it}
2. **{Topic}** — {Context or data to reference}

### If Time Permits
3. **{Topic}** — {Nice to discuss but not critical}

### Follow-ups from Last Time
- "{Action item}" — {Status update to share}

---

## ❓ Questions to Ask

1. {Question based on open items}
2. {Question based on their expertise}
3. {Question to understand their priorities}

---

## 📎 Reference Materials

- {Link to relevant doc}
- {Link to project board}
- {Attachment or screenshot}

---

## ⚡ Quick Prep Checklist

- [ ] Review the doc/deck being discussed
- [ ] Test screen share if presenting
- [ ] Have relevant tabs open
- [ ] Silence notifications
- [ ] {Custom item}

---

## 🧠 Notes Space

{Leave blank for live note-taking}
```

## 5. Deliver

Options:
- **Display** — Show in terminal/chat
- **Save as file** — `meeting-prep-{date}-{title}.md`
- **Copy to clipboard** — Ready to paste into notes app
- **Send to self** — Email or message for reference

## Timing

Generate prep based on meeting proximity:
- **>24 hours out:** Basic prep, flag for deeper research
- **2-24 hours:** Full prep doc
- **<2 hours:** Quick summary + critical points only
- **<15 minutes:** "Here's what you need to know in 60 seconds"

## Notes

- Run automatically before important meetings (via cron or calendar trigger)
- Integrate with check-calendar to identify meetings needing prep
- First meeting with someone? Go deeper on research
- Internal routine syncs? Keep it light
- Store prep docs for future reference — builds meeting history
