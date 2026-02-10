---
name: build-meeting-prep
emoji: 🎯
description: Meeting prep generator — creates a comprehensive prep document for any meeting with attendee research, history, talking points, and questions.
---

# Meeting Prep

Never walk into a meeting cold. Context, history, and talking points — ready to go.

## 1. Identify the Meeting

Using your **calendar skill**, find the target meeting:
- Next upcoming meeting, OR
- Specific meeting if user says "prep for my 2pm with Jake"

Extract:
- Meeting title
- Date/time
- Location (video link or physical)
- Attendees
- Any existing notes/agenda

## 2. Research Attendees

For each attendee:

### Internal (Colleagues)
- Role/title
- Team/department
- Recent interactions

### External (Clients, Partners)
- Company and role
- Previous correspondence
- Company context

Using your **email skill**, check recent threads with attendees.

### VIP Flags
- Manager? → Higher stakes
- Skip-level? → Know your highlights
- Client/prospect? → Know their business
- First meeting? → Extra research

## 3. Review History

### Previous Meetings
Using your **calendar skill**, find past events with same attendees or title. Look for:
- Previous notes
- Action items
- Decisions made
- Open questions

### Email Threads
What have you been discussing? Any pending items?

## 4. Build the Prep Doc

```markdown
# Meeting Prep: {Meeting Title}

📅 **When:** {Date} at {Time}
📍 **Where:** {Location/Link}
⏱️ **Duration:** {Length}
🎯 **Type:** {1:1 / Group / External}

---

## 👥 Attendees

### {Name} — {Role}
- **Context:** {Relationship, how you know them}
- **Recent:** {Last interaction}
- **Note:** {Preferences, topics to avoid}

---

## 📜 History

### Last Meeting ({Date})
- Discussed: {Key topics}
- Decided: {Outcomes}
- Action items: {Status}

---

## 🎯 Agenda

1. {Topic 1}
2. {Topic 2}
3. {Topic 3}

---

## 💬 Talking Points

### Must Cover
1. **{Topic}** — {Why important}
2. **{Topic}** — {Context}

### Follow-ups from Last Time
- {Action item status}

---

## ❓ Questions to Ask

1. {Question}
2. {Question}

---

## ⚡ Quick Prep Checklist

- [ ] Review relevant docs
- [ ] Test screen share if presenting
- [ ] Have tabs open
- [ ] Silence notifications
```

## 5. Deliver

Options:
- **Display** — Show the prep doc
- **Save** — Write to a file
- **Send** — Message to self for reference

## Timing

- **>24 hours out:** Basic prep
- **2-24 hours:** Full prep doc
- **<2 hours:** Quick summary only
- **<15 minutes:** "60-second briefing"

## Notes

- Run automatically before important meetings
- First meeting with someone? Go deeper
- Internal routine syncs? Keep it light
- Store prep docs for future reference
