---
name: send-morning-briefing
emoji: ☀️
description: Daily morning briefing — gathers weather, calendar, priorities, and urgent items, then delivers a comprehensive summary to start your day.
author: @davehappyminion
schedule: "7am"
tags: [essentials, daily, messaging]
---

# Morning Briefing

Your daily command center. Everything you need to know before the day begins — weather, schedule, priorities, overnight urgency, and the small details that make or break a morning. This is the single most important message of the day: after reading it, you should know exactly what's ahead and what needs your attention first.

---

## 0. Pre-Flight Checks

Before gathering any data, do the following:

### Duplicate Prevention
Check whether a morning briefing has already been sent today. If it has, **stop here** — do not send a duplicate. One briefing per day, always.

### Determine the Day Context
Note today's date and day of the week. You'll need this for:
- Day-specific greetings (Step 8)
- Calendar lookups
- Task deadlines
- Scheduling the delivery window

### Identify the User's Location
Use the user's configured home location (city, zip, or coordinates) from their profile or config. If the user's calendar shows they're traveling (hotel booking, flights, events in another city), use the travel location instead and note the switch in the briefing.

---

## 1. Weather Intelligence

Using your **weather skill** or weather service, pull a comprehensive forecast for the user's location.

### Data to Gather
- **Current conditions** — temperature, sky conditions (sunny, overcast, rain, etc.)
- **Today's high and low**
- **Feels-like temperature** — wind chill or heat index if significantly different from actual temp
- **Precipitation** — probability, type (rain, snow, sleet, hail), and timing. "30% chance of rain" is not enough. You need: "Rain likely between 2pm and 5pm (70% chance)" or "Scattered showers all afternoon"
- **Hourly breakdown** — at minimum: morning, midday, afternoon, evening conditions
- **Wind** — speed and gusts. Only include if notable (sustained 15+ mph or gusts 25+ mph)
- **Humidity** — only if above 70% or below 20% (uncomfortable extremes)
- **UV index** — only if 6+ (high or very high)
- **Severe weather alerts** — any NWS warnings, watches, or advisories. Tornado, severe thunderstorm, winter storm, flood, extreme heat, air quality — these ALWAYS get surfaced, prominently

### Weather-Smart Suggestions
Based on conditions, provide **exactly one line** of actionable advice. Choose the most relevant:

| Condition | Suggestion |
|-----------|------------|
| Rain expected | "Grab an umbrella — rain starts around {time}" |
| Snow/ice | "Roads may be icy this morning — allow extra commute time" |
| Feels-like below 25F | "Bundle up — wind chill makes it feel like {X}F" |
| Feels-like above 95F | "Heat advisory territory — stay hydrated, limit outdoor time" |
| UV index 8+ | "Sunscreen day — UV is very high" |
| UV index 6-7 | "Wear sunscreen if you'll be outside midday" |
| Large temp swing (25F+) | "Dress in layers — starts at {low}F, hits {high}F" |
| Wind gusts 30+ mph | "Gusty winds today — secure anything loose outside" |
| Perfect weather | "Beautiful day — find an excuse to get outside" |

### Outfit Hint
One brief suggestion based on conditions. Keep it casual and practical:
- "T-shirt weather" / "Light jacket morning, warm afternoon" / "Full winter layers" / "Rain jacket essential" / "Layers — big temperature swing today"

### Severe Weather Override
If there is any severe weather alert (tornado watch, winter storm warning, flood advisory, extreme heat, etc.), it becomes the **first thing** in the entire briefing, before the greeting. Use clear, urgent language:

```
WARNING: Winter Storm Warning in effect until 6pm tomorrow.
Expected: 8-12 inches of snow, 40mph wind gusts.
Travel will be hazardous. Consider rescheduling non-essential commitments.
```

---

## 2. Calendar Deep-Dive

Using your **calendar skill**, pull today's full schedule and tomorrow's first event.

### Today's Events
For each event, extract:
- Title
- Start time and end time
- Location (video link, room name, or address)
- Attendees (names/count)
- Whether it's recurring or one-time
- Any notes or agenda attached

### Smart Annotations
Don't just list events — analyze them:

**First event of the day** — mark it clearly. This is when the day "starts." If it's early (before 8am), note it. If there's nothing until noon, say so — that's a gift of a morning.

**Meeting load analysis** — Count meetings and total meeting hours, then characterize the day:
- 0-1 meetings: "Wide open day — great for deep work or a passion project"
- 2-3 meetings: "Balanced day — good mix of collaboration and focus time"
- 4-5 meetings: "Meeting-heavy day — protect your breaks"
- 6+ meetings: "Wall-to-wall meetings — defend your lunch and block 15 min between calls to decompress"

**Conflict detection** — Flag any overlapping events. If two meetings overlap, call it out: "Conflict: Team Standup (9:00-9:30) overlaps with Design Review (9:15-10:00). You'll need to choose or reschedule one."

**Back-to-back detection** — If two or more meetings are consecutive with zero gap, flag it: "Back-to-back: 10:00-11:00 and 11:00-12:00 — no break between. Consider starting the second one 5 min late."

**Prep-needed flags** — Flag meetings that likely need preparation:
- External meetings (clients, partners, vendors) — "External call — review notes beforehand"
- Presentations — "You're presenting — test screen share in advance"
- 1:1 with manager — "Manager 1:1 — have your updates and asks ready"
- First meeting with someone — "First meeting with {name} — do a quick lookup"
- Interview (as interviewer or candidate) — "Interview — review prep doc"

**Free time blocks** — Identify gaps of 30+ minutes between meetings. Highlight the largest block: "Best focus window: 1:30-4:00 PM (2.5 hours)."

**After-hours events** — Dinner plans, social events, workouts, personal appointments. List separately so the user sees their full day, not just work.

### Tomorrow's Early Preview
Pull tomorrow's first event. If it's early (before 9am), mention it: "Heads up: Tomorrow starts early — 7:30 AM breakfast meeting with the advisory board."

If tomorrow is notably different from today (e.g., today is packed but tomorrow is empty, or vice versa), note the contrast: "Tomorrow is much lighter — only 2 meetings."

---

## 3. Overnight Urgency Scan

Scan for anything that arrived while the user was sleeping — roughly the last 8-10 hours, or since the previous evening's daily wrap if available.

### Urgent Emails
Using your **email skill**, check the inbox for unread messages received overnight. Flag emails that match **any** of these criteria:

**Sender-based urgency:**
- From the user's manager or skip-level
- From anyone in the user's VIP/important contacts list
- From C-suite or leadership
- From key clients or partners

**Content-based urgency:**
- Subject contains: "urgent", "ASAP", "time-sensitive", "action required", "EOD", "by morning", "before noon", "emergency", "critical", "P0", "incident", "outage"
- Body contains requests with same-day deadlines
- Reply-all threads with 5+ participants and rapid back-and-forth (something blew up)

**For each urgent email, report:**
- Sender name
- Subject line
- One-sentence summary of what they need
- Do NOT quote full email content — just the gist

### Messaging Mentions
Using your **messaging skills** (Slack, Discord, Teams, etc.), check for overnight @mentions:
- Direct mentions of the user
- Mentions in channels the user has marked as important or high-priority
- DMs from key people

Report: who mentioned you, in which channel, and a one-line summary.

### System Alerts
Check for:
- Failed CI/CD pipelines or deployments
- Server/infrastructure alerts (downtime, high CPU, disk full, certificate expiry)
- Security notifications (login from new device, failed auth attempts, vulnerability alerts)
- Monitoring/pager alerts

Report each with severity and a one-line summary.

### Social Media (If Relevant)
If the user has social monitoring enabled:
- Mentions or tags on Twitter/X
- Notable engagement spikes
- DMs from verified or high-follower accounts

Only include this section if the user has configured it. Skip entirely otherwise.

### The All-Clear
If nothing urgent was found across all channels, say: **"Clear overnight — smooth start!"** This is reassuring and important. Don't skip it.

---

## 4. Priorities and Tasks

Using your **task manager skill**, pull the user's task landscape.

### Overdue Items
Tasks past their due date. This is the red-flag section.
- List each with its title, original due date, and how many days overdue
- If anything is 7+ days overdue, escalate it: "This has been overdue for over a week — reschedule or remove?"
- If nothing is overdue: skip the section entirely (absence of overdue is a good thing, no need to announce it)

### Due Today
Tasks with today's due date.
- List each with title and any time-specific deadline
- If there are more than 5, list the top 5 and note how many remain: "(+3 more due today)"

### Top 3 Priorities
Analyze all tasks and recommend the three most important for today. Prioritize using:

1. **Hard deadlines** beat soft deadlines
2. **External commitments** (promised to others) beat internal goals
3. **Blocking tasks** (others waiting on you) beat independent work
4. **Quick wins** are good to slot as the first priority for momentum — but only if something important isn't being displaced
5. **Calendar-aware scheduling** — if the user has a 3-hour free block in the afternoon, a deep-work task fits there; if they only have 15-minute gaps, suggest small tasks

For each priority, explain briefly **why** it's a priority: "Due today", "Blocking the design team", "Promised to Sarah by EOD."

### Approaching Deadlines
Tasks due in the next 3-5 days that aren't on today's radar yet. A gentle heads-up: "Coming up: Project proposal draft due Thursday. Start today if it needs review time."

---

## 5. Contextual Intelligence

These are the details that make the briefing feel thoughtful and personal. Each sub-section is **optional** — only include it if you have actual data. Never fabricate or guess.

### Package Deliveries
Using your **email skill**, search for shipping confirmation and tracking update emails from the last 7 days. Look for delivery-today notifications:
- Carrier and tracking status
- Expected delivery window if available
- What's in the package (parsed from order confirmation if possible)
- "Your Amazon order (wireless earbuds) arrives today by 8pm"

### Bills Due
If the **check-bills** workflow has recent data, pull any bills due today or in the next 3 days:
- Biller name, amount, due date
- Whether autopay is handling it or manual action is needed
- Only show bills that require attention — skip autopay-covered bills unless they're unusually high

### Birthdays and Anniversaries
Check the user's contacts and calendar for birthdays or anniversaries today:
- Name and relationship
- "Today is Mom's birthday — don't forget to call!"
- "It's Jake's work anniversary (3 years)"

### Days Until Milestones
If the user has upcoming milestones or events on their calendar (vacation, product launch, wedding, conference, move-in date):
- "{Event} is in {X} days"
- Only show events within the next 14 days
- "Vacation starts in 4 days!" or "Product launch in 6 days — crunch time"

### This Day Last Year
If historical data is available (previous briefings, completed tasks, git history, calendar archives):
- "This day last year: You shipped the v2.0 redesign and closed 12 tickets"
- "One year ago: You were in Austin for SXSW"
- If no data is available, skip this entirely. Never fabricate history.

---

## 6. Day-Specific Flavor

Adjust the greeting and tone based on the day of the week. This is applied in the final briefing template (Step 8), not as a separate section.

### Monday
- Greeting: "Welcome back" or "Fresh week ahead"
- Include a brief week preview: count of meetings this week, any big events, deadlines approaching
- "This week: 14 meetings, quarterly review on Wednesday, project deadline Friday"

### Tuesday - Thursday
- Standard greeting: "Good morning" with the day and date
- No special additions

### Friday
- Greeting: "Home stretch" or "Happy Friday"
- If the user's calendar has weekend events, preview them: "Weekend ahead: Saturday brunch at 11am, Sunday open"
- "Almost there — finish strong today"

### Saturday / Sunday
- If the workflow runs on weekends (it shouldn't by default, but if triggered manually):
- Lighter tone: "Weekend mode"
- Only show what's truly relevant — skip work tasks, focus on personal events, weather, deliveries

### Holidays
If today is a recognized holiday (New Year's Day, MLK Day, Presidents Day, Memorial Day, Independence Day, Labor Day, Thanksgiving, Christmas, etc.):
- Acknowledge it: "Happy Thanksgiving!"
- Note if the user has events despite the holiday (some people work holidays)
- Lighter format — skip task triage if it's a day off

### User's Birthday
If today matches the user's birthday (from profile or contacts):
- Special greeting at the top: "Happy birthday! Hope today is a great one."
- Keep the rest of the briefing normal — they still need their schedule

---

## 7. Data Source Failures and Safety Rules

### If a Data Source Is Unavailable
Skills and services sometimes fail. Handle it gracefully:

- **Weather unavailable:** Skip the weather section. Add a note at the bottom: "Could not reach weather service — check weather manually today."
- **Calendar unavailable:** Skip the calendar section. Note: "Calendar is unreachable — check your schedule manually."
- **Email unavailable:** Skip the urgency scan. Note: "Could not check email — review your inbox when you get a chance."
- **Task manager unavailable:** Skip the priorities section. Note: "Task manager is unreachable — check your tasks manually."

**Never fabricate data to fill a gap.** A briefing with three solid sections and one "unavailable" note is infinitely better than a briefing with made-up information. The user's trust in the briefing depends on its accuracy.

### Never Guess at Meeting Content
You may know a meeting title and attendees, but do NOT invent agendas, topics, or discussion points. If no agenda is attached to the calendar event, just list it by title. Don't write "You'll probably discuss Q3 planning" — you don't know that.

### Never Summarize Email Bodies
For urgent emails, report the sender, subject, and that it exists. Do not summarize or quote the full email body in the briefing — the user will read it themselves. A one-sentence gist is the maximum: "Sarah needs your sign-off on the vendor contract."

### Sensitive Information
- Do not include financial account numbers in the briefing
- Do not include passwords, tokens, or credentials found in any email
- Do not include confidential HR or legal content — just flag that an email from HR/Legal arrived

---

## 8. Compile the Briefing

Assemble everything into the final format. The briefing must be **scannable in 30 seconds** for someone checking their phone right after waking up.

### Template

Use the following structure. Omit any section that has no data (don't show empty sections with "Nothing here" — just remove them). If a data source failed, add it to the footer notes.

```
{Severe weather alert, if any — this goes FIRST, before everything}

Good morning! Here's your {Day}, {Month} {Date}:
{Day-specific flavor line — see Step 6}

WEATHER — {City}
{Conditions emoji} {Current temp}F, feels like {feels-like}F
High {X}F / Low {Y}F
{Precipitation line with timing, if any}
{Weather-smart suggestion}
{Outfit hint}

TODAY'S SCHEDULE ({X} meetings, ~{Y} hours of free time)
{First event time} — {Event} <-- Day starts here
{Time} — {Event} ({duration})
{Time} — {Event} ({duration})
  {Conflict or back-to-back warning, inline}
{Time} — {Event} ({duration})
  {Prep note, inline}
---
Best focus window: {Start}-{End} ({duration})
{Meeting load commentary}
{Tomorrow's early preview, if relevant}

NEEDS ATTENTION
{Urgent emails: sender — subject — one-line gist}
{Messaging mentions: who, where, what}
{System alerts: service — status — severity}
{Or: "Clear overnight — smooth start!"}

TODAY'S PRIORITIES
{Overdue: task (X days overdue)}
1. {Top priority} — {why}
2. {Second priority} — {why}
3. {Third priority} — {why}
Approaching: {Task due in X days}

ALSO ON YOUR RADAR
{Package deliveries}
{Bills due}
{Birthdays/anniversaries}
{Milestone countdowns}
{This day last year}

---
{Day summary line}
{Total meetings} meetings | {Free hours} hours free | {Pending tasks} tasks pending
{Closing: "Have a great day!" or day-specific closer}
```

### Formatting Guidelines

- **Use emoji sparingly and consistently** for section headers and inline indicators. The briefing should feel clean, not cluttered.
- **Temperatures in Fahrenheit** by default. If the user's locale is metric, use Celsius.
- **Times in 12-hour format** with AM/PM unless the user prefers 24-hour.
- **Keep it tight.** Each line should earn its place. If a section has nothing to report, omit it entirely.
- **The summary line at the bottom** gives the user a 5-second snapshot: total meetings, free hours, and pending task count. This is always present.

### Length Target
The full briefing should be **readable in under 60 seconds**. If it's getting long (more than ~40 lines), tighten it. Cut the lowest-value contextual items first ("this day last year" is the first to go, then milestone countdowns).

---

## 9. Deliver

Using your **messaging skill**, send the compiled briefing to the user.

### Delivery Rules
- **Send only once per day.** If the workflow is triggered again on the same day, do not send a second briefing. Log that it was already sent and exit.
- **Deliver before the day starts.** The scheduled time (7am) should be before the user's first event in most cases. If their first event is at 6:30am, they'll need the briefing earlier — note this for future schedule adjustment.
- **Delivery order:** If the `send-morning-inspiration` workflow is also enabled, that should deliver first (inspiration), then this briefing (logistics). Respect the ordering.
- **If messaging is down:** Write the briefing to a local file as a fallback so it's not lost. Log the delivery failure.

---

## Tracking

Maintain a record for each run:
- Date of briefing
- Sections included / sections skipped (and why)
- Delivery status (sent, already sent today, delivery failed)
- Data source health (which skills responded, which failed)

This history powers the "this day last year" feature and helps diagnose issues if the briefing stops arriving.

---

## Notes

- This is the flagship daily workflow. Everything else in the morning (inspiration, task triage, weather alerts) can be standalone, but this briefing is the one that ties the day together.
- Schedule it 15-30 minutes before the user's typical wake time. 7am is the default but can be adjusted.
- Deliver **after** `send-morning-inspiration` if both are enabled. Inspiration first, then logistics.
- Keep it scannable. A busy person checking their phone at 7:01am needs the gist in 30 seconds and the details in 60.
- If nothing urgent happened overnight and the calendar is light, lean into that: "Light day ahead — a rare gift. Use it well."
- If the day is chaotic (6+ meetings, overdue tasks, urgent emails), acknowledge it with empathy: "Packed day ahead. Take it one thing at a time."
- The tone should be warm, competent, and concise — like a sharp chief of staff who respects your time.
- Over time, the briefing should get smarter: learning which sections the user engages with, which they skip, and what level of detail they prefer. But that's a future optimization — for now, deliver everything and let the user give feedback.
