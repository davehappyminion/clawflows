---
name: morning-journal
emoji: 📝
description: Guided daily journaling — asks 3-5 reflection questions, stores entries in dated markdown files, and surfaces patterns over time.
author: @davehappyminion
schedule: "7:30am"
---

# Morning Journal

A guided journaling practice that builds over time. Answer a few reflection questions each morning, and the agent surfaces patterns and insights from your entries.

## 1. Set Up

Ensure the journal directory exists at `~/.openclaw/data/journal/`. Entries are stored as individual markdown files: `2026-02-10.md`. If today's entry already exists, ask if the user wants to add to it or start fresh. Never overwrite without asking.

## 2. Review Recent Context

Scan the last 3-5 entries (silently) to:

- Avoid repeating the same custom question two days running
- Note ongoing themes (project stress, sleep issues, upcoming events)
- Pick up threads: "Yesterday you mentioned the presentation — how did it go?"

Don't summarize past entries back unprompted. Just use them to ask better questions.

## 3. Ask Reflection Questions

Ask 3-5 questions, one at a time. Wait for each answer before asking the next.

**Core (pick 2-3):** How are you feeling this morning? What would make today a success? What are you looking forward to? Is anything weighing on you? How did you sleep?

**Rotating (pick 1-2, vary daily):** Something you're grateful for? Small win from the last 24 hours? Someone you'd like to connect with today? Something you're learning? Something you're putting off?

**Follow-up:** If an answer is emotionally heavy, ask one gentle follow-up. Don't therapize — just show you're listening.

## 4. Save the Entry

Write as a clean markdown file:

```markdown
# Journal — February 10, 2026 (Monday)

**Mood:** Cautiously optimistic

## Reflections

**How are you feeling this morning?**
Pretty good. Slept well for the first time in a few days.

**What would make today a success?**
Getting the proposal draft finished before lunch.

**Something you're grateful for?**
My morning coffee routine. It's become a real anchor.

---
*Logged at 7:34 AM*
```

## 5. Pattern Detection

After saving, scan the last 30 days for patterns. Only surface if clear and actionable.

- **Mood by day** — "You've mentioned feeling tired 4 of the last 5 Mondays"
- **Repeated themes** — same topic 3+ times in a week
- **Sleep correlation** — does mood track with sleep quality?
- **Gratitude patterns** — what keeps showing up?
- **Stress signals** — increasing mentions of pressure or overwhelm
- **Progress** — worries from 2 weeks ago that have resolved

## 6. Present Patterns (When Found)

Most days, skip this. Only show when genuinely interesting.

```
📝 Journal saved for Monday, Feb 10.

💡 PATTERN: You've mentioned sleep in 6 of 7 entries.
Days with 7+ hours had noticeably better mood.
Might be worth protecting that bedtime.

📊 This month: 8/10 days logged ✅
   Most common mood: "good" / "hopeful"
   Streak: 5 days
```

## 7. Deliver

Confirm the entry is saved and share any patterns via your **messaging skill**.

## Notes

- This is a safe, private space. Never judge or evaluate the user's feelings.
- Never reference journal entries in other workflows unless explicitly asked.
- If the user gives one-word answers, respect that. Some days are short-answer days.
- If the user seems in distress, gently note that talking to someone can help. Don't push.
- Journal files are private. Never include content in reports or shared outputs.
- Aim for 3-5 minutes. Don't drag it out.
