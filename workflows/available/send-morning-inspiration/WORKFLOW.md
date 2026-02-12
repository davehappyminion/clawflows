---
name: send-morning-inspiration
emoji: ✨
description: Morning inspiration — delivers an uplifting quote to start the day, optionally themed to your goals or current challenges.
author: @davehappyminion
schedule: "7am"
tags: [essentials, daily, messaging]
---

# Morning Inspiration

A carefully chosen quote delivered each morning — not random, but selected to meet the user where they are today. This workflow reads the room before it speaks.

## 1. Load History and Preferences

Before anything else, check the quote history and user preferences.

### Quote History

Read the history file at `~/.openclaw/data/morning-inspiration/history.json`. This file tracks every quote sent, in this format:

```json
[
  {
    "date": "2026-02-10",
    "quote": "The obstacle is the way.",
    "author": "Marcus Aurelius (paraphrased by Ryan Holiday)",
    "theme": "perseverance",
    "source_tradition": "stoic",
    "feedback": null
  }
]
```

If the file doesn't exist, create it with an empty array. This history is sacred — it prevents repeats and tracks what resonates.

### User Preferences

Check for a preferences file at `~/.openclaw/data/morning-inspiration/preferences.json`. Optional fields:

```json
{
  "name": "Dave",
  "favorite_authors": ["Ursula K. Le Guin", "Marcus Aurelius", "Mary Oliver"],
  "favorite_books": ["Meditations", "Bird by Bird", "The Tao Te Ching"],
  "avoid_authors": [],
  "avoid_themes": [],
  "preferred_traditions": [],
  "tone": "warm",
  "include_reflection_prompt": true,
  "include_history_moment": false
}
```

If no preferences file exists, use sensible defaults: include the reflection prompt, skip the history moment, warm tone, no name.

## 2. Gather Context

Before choosing a quote, build a picture of the user's current situation. Check each of the following signals. Not all will be available — use whatever you can find and skip what you can't. Do this silently; none of this context is shared with the user directly.

### 2a. Calendar — What kind of day is ahead?

Using your **calendar skill**, check today's events:

- **Heavy meeting day** (4+ meetings) — they need focus, energy, or a reminder to breathe
- **One big event** (presentation, interview, launch, review) — they need courage or calm confidence
- **Light day** (1-2 events or none) — space for creativity, reflection, or ambition
- **Vacation / PTO** — they need permission to rest, or something playful and expansive
- **First day back** (from vacation, weekend, holiday) — they need a gentle reentry, not a fire hose
- **Back-to-back day** (no gaps between meetings) — they need endurance or humor about the grind

Note the first event time. If their day starts unusually early, keep the message especially concise.

### 2b. Day of Week — What's the energy?

- **Monday** — fresh start energy. Themes: intention, possibility, building momentum
- **Tuesday** — the workhorse. Themes: focus, craft, getting into flow
- **Wednesday** — midweek pivot. Themes: perseverance, perspective, halfway-there encouragement
- **Thursday** — the home stretch. Themes: finishing strong, discipline, clarity
- **Friday** — earned energy. Themes: celebration, reflection on the week, lightness
- **Saturday** — freedom. Themes: play, curiosity, adventure, rest, hobbies
- **Sunday** — the reset. Themes: stillness, gratitude, preparation, inner life

### 2c. Recent Mood and Energy (if available)

Check for recent journal entries at `~/.openclaw/data/journal/` (from the `morning-journal` workflow). Read the last 3 entries silently. Look for:

- **Mood keywords** — stressed, tired, excited, anxious, grateful, stuck, inspired
- **Sleep quality** — did they mention poor sleep?
- **Recurring themes** — the same worry or project showing up repeatedly
- **Trajectory** — are things getting better or worse over the past few days?

Also check habit tracking data at `~/.openclaw/data/habits/` if available. Look for:

- Broken streaks (they may need encouragement, not guilt)
- Strong streaks (celebrate consistency)
- Missed days (don't mention it — just factor it into tone)

If no journal or habit data exists, skip this step entirely. Don't prompt or ask about it.

### 2d. Upcoming Milestones

Check the calendar for the next 7 days:

- **Birthdays** — theirs or someone close to them
- **Anniversaries** — personal or work (1 year at company, etc.)
- **Project launches or deadlines** — big delivery dates
- **Holidays** — upcoming long weekends or celebrations
- **Travel** — trips coming up

If a milestone is today, weight the quote selection toward that event.

### 2e. Season and Time of Year

Factor in the broader context:

- **New Year (Jan 1-15)** — beginnings, intention-setting, optimism
- **Deep winter (Jan-Feb)** — warmth, endurance, inner light, cozy perseverance
- **Spring (Mar-May)** — renewal, growth, planting seeds, energy returning
- **Summer (Jun-Aug)** — expansion, adventure, abundance, slowing down to enjoy
- **Early fall (Sep-Oct)** — harvest, reflection, back-to-work focus, crisp clarity
- **Late fall (Nov)** — gratitude, letting go, preparing for rest
- **Holiday season (Dec)** — generosity, connection, year-in-review, hope
- **User's birthday week** — something celebratory and personal
- **Daylight saving transitions** — acknowledge the shift, be gentle about energy

## 3. Select the Quote

Now choose a quote. This is the heart of the workflow. Be deliberate.

### 3a. Determine the Theme

Based on the context gathered in Step 2, select one primary theme for today's quote. Choose from:

| Theme | When to use |
|-------|------------|
| **Courage** | Big event ahead, facing something hard, starting something new |
| **Patience** | Waiting on results, long project, things not moving fast enough |
| **Creativity** | Light day, maker day, stuck on a problem that needs lateral thinking |
| **Simplicity** | Overwhelmed, too many priorities, scattered energy |
| **Perseverance** | Midweek grind, long-running challenge, repeated setbacks |
| **Gratitude** | Good stretch, Friday/Sunday, after a win, holiday season |
| **Curiosity** | Stale routine, learning something new, bored |
| **Rest** | Burnout signals, vacation, weekend, broken sleep |
| **Ambition** | Monday, new quarter, after a win, project launch |
| **Joy** | Friday, birthday, celebration, light day, summer |
| **Focus** | Heavy meeting day, scattered week, too many tabs open |
| **Connection** | Loneliness signals, big team week, holidays |
| **Impermanence** | Seasonal transitions, endings, grief, letting go |
| **Humor** | Tense week, overly serious stretch, needed lightness |
| **Self-compassion** | Broken streak, rough week, harsh self-talk in journal |

### 3b. Choose the Source Tradition

Rotate through diverse source traditions so the user encounters a range of voices. Track which traditions have been used recently in the history file and lean toward underrepresented ones.

- **Stoic philosophy** — Marcus Aurelius, Epictetus, Seneca
- **Eastern philosophy** — Lao Tzu, Thich Nhat Hanh, Rumi, Matsuo Basho, Shunryu Suzuki
- **Modern builders and founders** — Paul Graham, Naval Ravikant, Sahil Lavingia, Stewart Butterfield, Werner Vogels
- **Writers and poets** — Mary Oliver, Ursula K. Le Guin, Anne Lamott, Rilke, Wendell Berry, James Baldwin, Toni Morrison, Jorge Luis Borges
- **Scientists and explorers** — Marie Curie, Richard Feynman, Carl Sagan, Ada Lovelace, Rachel Carson
- **Artists and musicians** — Georgia O'Keeffe, John Coltrane, Agnes Martin, Hayao Miyazaki, Brian Eno
- **Athletes and coaches** — John Wooden, Serena Williams, Phil Jackson, Eliud Kipchoge
- **Leaders and activists** — Frederick Douglass, Harriet Tubman, Vaclav Havel, Wangari Maathai, Desmond Tutu
- **Indigenous and oral traditions** — Proverbs from Yoruba, Maori, Navajo, Japanese, Ethiopian, Irish traditions (always attribute the culture, never a made-up individual)
- **Comedians and observers** — Nora Ephron, Terry Pratchett, Ursula K. Le Guin, Kurt Vonnegut
- **User's favorites** — If `favorite_authors` or `favorite_books` are configured, draw from them roughly once a week

### 3c. Quote Selection Rules

Follow these rules strictly:

1. **No repeats within 60 days.** Check the history file. If a quote (by content, not just by author) was sent in the last 60 days, skip it.
2. **No author repeats within 7 days.** Spread the voices around. Check the last 7 entries in history.
3. **Prefer lesser-known quotes.** Avoid the most overused quotes in the Western canon. If you've seen the quote on a thousand coffee mugs, dig deeper. For example:
   - Instead of "Be the change you wish to see in the world" (overused, also misattributed), find a deeper Gandhi passage
   - Instead of "The journey of a thousand miles begins with a single step," find a less-quoted Lao Tzu verse
   - Instead of "Stay hungry, stay foolish," find a less-repeated Jobs interview passage
4. **Match the user's situation specifically.** A generic "be positive" quote is a failure. The quote should feel like it was chosen *for them, today*.
5. **Include the full attribution.** Author name and, when relevant, the source work:
   - "Marcus Aurelius, *Meditations*"
   - "Mary Oliver, from *Upstream*"
   - "Yoruba proverb"
   - "Thich Nhat Hanh, *The Miracle of Mindfulness*"
6. **If pulling from the user's favorite books**, reference the book: "From one of your favorites — *Meditations*."

### 3d. Integrity Rules

These are non-negotiable:

- **Never fabricate a quote.** If you are not confident a person said these exact words, do not attribute it to them. This is the single most important rule.
- **Never misattribute.** Many famous quotes are wrongly attributed (Einstein didn't say half the things the internet claims). If unsure of the origin, say "commonly attributed to" or "often credited to" — or choose a different quote you're certain about.
- **If paraphrasing**, say so: "paraphrased from" or "loosely adapted from."
- **For translated works**, it's fine to note the translator if notable: "Rumi, translated by Coleman Barks."
- **Prefer quotes you can verify.** From published books, recorded speeches, documented interviews, or well-sourced collections.

## 4. Compose the Message

Build the message with care. The goal: it should feel like a thoughtful friend left a note on your desk, not like a corporate wellness app sent a push notification.

### 4a. Greeting

Vary the greeting. Never use the same opener two days in a row. Rotate through options like:

**Standard warmth:**
- "Good morning, {name}."
- "Morning."
- "Rise and shine."
- "Happy {day of week}."

**Day-specific:**
- Monday: "New week, fresh slate." / "Here we go." / "Monday's got potential."
- Friday: "You made it to Friday." / "Almost weekend." / "Friday energy."
- Weekend: "Easy morning." / "No rush today." / "Slow morning."

**Seasonal:**
- Winter: "Cold morning, warm thought."
- Summer: "Long days, good days."
- First day of a season: "Welcome to {season}."

**Context-specific:**
- Before a big event: "Big day ahead."
- Light day: "Quiet day on tap."
- Birthday: "Happy birthday, {name}."

**Minimalist (use sometimes):**
- Skip the greeting entirely. Just start with the quote. Let it speak for itself.

If the user's name is available in preferences, use it sometimes — not every day. Maybe 2-3 times a week. Overusing names feels robotic.

### 4b. The Quote

Present the quote with breathing room. Format:

```
"{Quote text}"
 -- {Author}, {Source (if applicable)}
```

If the quote is from a user's favorite book or author, add a subtle note:
```
From one of your favorites:

"{Quote text}"
 -- {Author}, {Source}
```

Keep the quote itself short-to-medium. Ideal length: 1-3 sentences. If a longer passage is perfect for the moment, include it — but never more than 5 sentences.

### 4c. Reflection Prompt (Optional)

If `include_reflection_prompt` is true (or not set, since it defaults to true), add a one-line question after the quote. This prompt should:

- Connect the quote to the user's actual day or situation
- Be open-ended, not yes/no
- Be genuinely thought-provoking, not cheesy
- Be optional — frame it lightly, not as homework

Examples:
- "What would it look like to apply this today?"
- "Where in your day could you practice this?"
- "What's one thing you could let go of today?"
- "Who comes to mind when you read this?"
- "What would the courageous version of today look like?"
- "If you only did one thing today, what would matter most?"

If the quote is already self-contained and powerful, skip the prompt. Not every quote needs commentary.

### 4d. This Day in History (Optional)

If `include_history_moment` is true, add a brief "on this day" moment that thematically connects to the quote. Keep it to one line.

Examples:
- If the quote is about perseverance and today is Feb 11: "On this day in 1990, Nelson Mandela walked out of prison after 27 years."
- If the quote is about creativity: "On this day in 1847, Thomas Edison was born."

Rules:
- The historical moment must genuinely connect to the theme. Don't force it.
- Verify the date is correct. If you're not confident, skip it.
- If nothing interesting connects, skip it. An irrelevant history tidbit is worse than none.
- Keep it factual and brief. One sentence maximum.

### 4e. Closing

End with something light. Rotate:

- "Have a great {day of week}."
- "Make it a good one."
- "Go get it."
- "Take it easy today." (weekends, light days)
- "You've got this." (before a big event)
- "Enjoy the day."
- Skip the closing entirely sometimes. The quote can be the last word.

### 4f. Full Message Template

Here's the complete structure. Not every element appears every day — vary it.

**Full version:**
```
{Greeting}

"{Quote text}"
 -- {Author}, {Source}

{Reflection prompt}

{This day in history — if enabled}

{Closing}
```

**Minimal version (use 1-2 times a week for variety):**
```
"{Quote text}"
 -- {Author}
```

**With favorite-author callout:**
```
{Greeting}

From one of your favorites:

"{Quote text}"
 -- {Author}, {Source}

{Closing}
```

The message should feel like a breath of air, not a wall of text. When in doubt, cut.

## 5. Deliver

Using your **messaging skill**, send the message to the user.

### Timing

- Deliver **before** the morning briefing (`send-morning-briefing`). Inspiration first, logistics second.
- If both are scheduled at the same time, this workflow takes priority and should run first.

### Delivery Check

- Only send if not already sent today. Check the history file for today's date.
- If already sent today (e.g., workflow was triggered manually after automatic run), skip silently.

## 6. Record in History

After sending, append to the history file (`~/.openclaw/data/morning-inspiration/history.json`):

```json
{
  "date": "2026-02-11",
  "quote": "The only way to do great work is to love what you do. If you haven't found it yet, keep looking. Don't settle.",
  "author": "Steve Jobs",
  "source": "Stanford commencement address, 2005",
  "theme": "ambition",
  "source_tradition": "modern_builder",
  "day_of_week": "Tuesday",
  "context_signals": ["heavy_meeting_day", "midweek"],
  "greeting_used": "Morning.",
  "included_reflection": true,
  "included_history": false,
  "feedback": null
}
```

Track enough detail that future runs can avoid repetition and detect patterns in what resonates.

## 7. Learn from Feedback

If the user responds to the message (through messaging or conversation), update the history entry:

- **Positive feedback** ("love this", "needed that", "great quote", heart reaction) — note it. Weight similar themes, authors, and traditions higher in future selections.
- **Negative feedback** ("meh", "not my thing", "too long") — note it. Avoid that author, theme, or style for the next 2 weeks.
- **Specific requests** ("more poetry", "less business quotes", "I love Stoic stuff") — update the preferences file directly.

Over time, the quote selection should get noticeably better. A history file with 30+ entries and feedback is a goldmine of personalization data.

## Notes

- **Schedule:** Default 7:00 AM. Should run before `send-morning-briefing`.
- **Privacy:** If reading journal entries for context, never reference their content in the message. The user should feel the quote is well-chosen, not that they're being surveilled.
- **Tone:** Warm but not saccharine. Grounded but not cold. Like a thoughtful friend, not a life coach. Never preachy, never condescending, never "you should."
- **Bad days:** If mood signals suggest the user is struggling, lean toward gentleness and self-compassion — not forced positivity. A quote about rest is better than a quote about hustle when someone is burned out.
- **Weekends:** Lighter, more playful, more spacious. Don't quote productivity gurus on a Saturday. Think poets, artists, naturalists.
- **Consistency beats perfection:** A decent quote delivered reliably every morning is better than a perfect quote delivered sporadically. Show up.
- **Length:** The entire message (greeting + quote + reflection + closing) should be readable in under 15 seconds. If you're writing a paragraph of commentary around the quote, you've gone too far.
- **Silence is fine:** If a quote is powerful enough on its own, send it alone with no greeting, no reflection prompt, no closing. Just the words and the author. Sometimes less is everything.
