---
name: morning-briefing
emoji: ☀️
description: Daily morning briefing — weather, inspirational quote, top goals, birthday reminders, and calendar preview.
author: @davehappyminion
schedule: "6am"
---

# Morning Briefing

Start the day with everything your human needs in one message.

## 1. Weather

Get today's forecast for the user's location:
- Current temperature and conditions
- High/low for the day
- Rain/snow probability
- What to wear / bring (umbrella, jacket, etc.)

Use any weather tool available — `wttr.in`, a weather skill, or web search.

## 2. Inspirational Quote

Find a short, motivating quote to kick off the day. Pick something relevant to building, creating, or personal growth. Keep it fresh — don't repeat recent ones.

## 3. Top Goals for Today

Pull today's priorities from whatever task management the user has:
- Check task managers (Things, Todoist, Notion, etc.)
- Check for overdue or due-today items
- Pick the top 3 to focus on
- If nothing is set, suggest 3 meaningful goals based on recent context

## 4. Birthday Reminders

Check contacts and memory for birthdays happening:
- **Today** — wish them happy birthday!
- **This week** — heads up to prepare

If no birthdays are found, skip this section entirely.

## 5. Calendar Preview

Pull today's schedule from the user's calendar:
- All events with times
- First event of the day
- Any conflicts or back-to-back meetings
- Free blocks for deep work

If no calendar is configured, skip this section.

## 6. Deliver the Briefing

Send a clean, visually structured message to the user:

```
┌─────────────────────────┐
   ☀️  {Day}, {Date}
└─────────────────────────┘

🌤  𝗪𝗲𝗮𝘁𝗵𝗲𝗿
     {Conditions} · {Temp} (feels {FeelsLike})
     ↑ {High}° ↓ {Low}° · {Rain info}
     {Forecast summary}
     {Advice emoji} {What to wear}

💡  𝗤𝘂𝗼𝘁𝗲 𝗼𝗳 𝘁𝗵𝗲 𝗗𝗮𝘆
     "{Quote}"
      — {Author}

🎯  𝗧𝗼𝗱𝗮𝘆'𝘀 𝗚𝗼𝗮𝗹𝘀
     1. {Goal 1}
     2. {Goal 2}
     3. {Goal 3}

🎂  𝗕𝗶𝗿𝘁𝗵𝗱𝗮𝘆𝘀
     {Name} — {Relationship} (today/this week!)

📅  𝗖𝗮𝗹𝗲𝗻𝗱𝗮𝗿
     {Time} — {Event 1}
     {Time} — {Event 2}
     Free: {X}:{XX} - {Y}:{YY}

━━━━━━━━━━━━━━━━━━━━━━━
Have a great day! 🍌
— {Your name}
```

Keep it concise. No walls of text. If a section has nothing, skip it entirely.
