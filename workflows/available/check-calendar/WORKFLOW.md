---
name: check-calendar
emoji: 📅
description: Calendar review — scans the next 48 hours for events, detects conflicts, calculates travel time, and generates prep notes for each meeting.
author: @davehappyminion
schedule: "8am, 6pm"
tags: [essentials, daily, calendar]
---

# Check Calendar

Your 48-hour radar. Every conflict caught, every prep gap filled, every free block claimed — before your day runs you.

This workflow runs twice daily. The **morning run** (8am) focuses on today and gives a lookahead at tomorrow. The **evening run** (6pm) shifts focus to tomorrow and flags anything needing overnight prep. On Friday evenings, it includes a weekend preview.

---

## 1. Determine Run Context

Before fetching events, establish context for the run:

1. **Current time** — Record the exact timestamp of this run.
2. **Run mode** — Determine whether this is a morning run or evening run:
   - **Morning mode** (before 12pm): Primary focus is today. Tomorrow is a preview.
   - **Evening mode** (12pm or later): Primary focus is tomorrow. Today's remaining events are a recap.
3. **Day of week** — Note if today is Friday (triggers weekend preview) or if today is a weekend day (adjusts expectations and tone).
4. **Week position** — Calculate how many meetings the user has already had this week (Monday through now). This feeds the pattern detection in Step 8.
5. **Last run timestamp** — If available, note when this workflow last ran. Anything that changed since then (new invites, cancellations, time changes) should be called out explicitly.

---

## 2. Fetch Events

Using your **calendar skill**, pull all events for the next 48 hours from the current time.

### What to Fetch

For every event in the window, capture:

| Field | Details |
|---|---|
| **Title** | Full event title, untruncated |
| **Start time** | Date and time in the user's local timezone |
| **End time** | Date and time — calculate duration from this |
| **Duration** | In minutes. Flag anything over 90 minutes |
| **Location** | Physical address, video link (Zoom/Meet/Teams URL), phone number, or "none" |
| **Attendees** | List of names and email addresses. Note the organizer separately |
| **Your RSVP status** | Accepted, tentative, declined, or no response |
| **Recurrence** | Is this a recurring event? If so, what cadence (daily, weekly, biweekly, monthly)? |
| **Notes/description** | Full event body — agenda, links, attachments, pre-read materials |
| **Calendar source** | Which calendar it belongs to (work, personal, shared/team, holidays) |
| **Visibility** | Public, private, or confidential |
| **Created/modified** | When the event was created or last changed |
| **Reminders** | What reminders are set, if any |

### Calendar Sources

Fetch from **all** calendar sources the user has connected:

- **Work calendar** — Primary work account (Google Workspace, Outlook 365, etc.)
- **Personal calendar** — Personal Google, iCloud, etc.
- **Shared/team calendars** — Team calendars, project calendars, on-call rotations
- **Holiday calendars** — Public holidays, company holidays, PTO calendars
- **Subscribed calendars** — Sports schedules, school calendars, etc.

### Edge Cases

- **All-day events**: Capture these separately. They provide context (birthdays, deadlines, holidays) but don't block time slots.
- **Multi-day events**: Note the full span but only show relevant portions within the 48-hour window.
- **Cancelled events**: Still fetch them if recently cancelled — the user may not know yet. Mark them clearly.
- **Events you declined**: Include them dimmed/noted — useful context even if not attending.
- **Placeholder/focus time blocks**: Identify "Focus Time", "No Meetings", "Block" type events — these are intentional free time, not actual meetings.
- **Out of office**: If an OOO event is active, note it prominently. The user might not need a full calendar review.

### If Calendar Access Fails

If any calendar source is unreachable:

1. Report which source failed and the error.
2. Continue with available sources — do not abort the entire workflow.
3. Warn that the analysis may be incomplete.
4. Suggest the user check their calendar integration settings.

---

## 3. Conflict Detection

Analyze the fetched events and flag every scheduling problem. Group issues by severity.

### 3a. Hard Conflicts (Severity: Critical)

These require immediate action.

**Overlapping events:**
- Two or more events occupy the same time slot (even partial overlap counts).
- For each overlap, report:
  - Which events conflict (titles, times).
  - Which has more attendees (harder to reschedule).
  - Which was created first (established commitment).
  - Which you organized vs. were invited to.
  - Your RSVP status on each — if you accepted both, that is the problem.
- Suggest which to keep based on: importance signals (external > internal, client > team, your meeting > invited), number of attendees, and recurrence (one-off > recurring, since recurring can be rescheduled more easily).

**Double-booked with conflicts you already declined:**
- If you declined event A but accepted event B at the same time, that is fine — just note it for awareness.
- If you accepted both A and B, flag it as a hard conflict.

**Tentative overlaps:**
- If two tentative events overlap, flag it softer: "You have two tentative events at 2pm — accept one and decline the other."

### 3b. Buffer Issues (Severity: Warning)

These are not broken but will cause stress.

**Back-to-back meetings (no buffer):**
- Two meetings where one ends at the exact minute the next begins (e.g., 10:00-10:30, 10:30-11:00).
- Suggest adding a 5-10 minute buffer. Specify which meeting to shorten or shift.
- If back-to-backs span 3+ meetings in a row, escalate to "marathon block" (see below).

**Context-switch penalties:**
- Video call immediately followed by in-person meeting (need to physically move).
- In-person meeting immediately followed by video call (need to get back to desk, log in).
- Deep-focus block immediately followed by a large group meeting (mental gear shift).
- External/client call immediately followed by casual team sync (tone shift).

**Missing buffers before high-stakes events:**
- If a client call, presentation, or interview has a meeting ending within 15 minutes before it, warn: "Your client call at 2pm has no prep buffer — your 1:1 ends at 1:55pm."

### 3c. Wellness Flags (Severity: Advisory)

These are about sustainability, not schedule correctness.

**No lunch break:**
- Check the 11:30am-1:30pm window. If meetings cover the entire window with no gap of at least 30 minutes, flag it.
- "You have no lunch break today. Your meetings run from 11am to 2pm straight."
- Suggest: decline or move the least important meeting in that window, or shorten one by 15 minutes.

**Marathon blocks:**
- 3 or more hours of continuous meetings (with gaps under 15 minutes between them counting as continuous).
- Flag the block: "You have a 3.5-hour meeting marathon from 9am to 12:30pm."
- Note the burnout risk and suggest where to insert a break.

**Early birds and night owls:**
- Any meeting before 8:00am — "Heads up: 7am standup tomorrow. Set an alarm."
- Any meeting after 6:00pm — "Late meeting at 7pm. Consider your work-life balance."
- Let the user know but do not be preachy. Some people prefer early/late meetings.

**Weekend meetings:**
- Any meeting on Saturday or Sunday.
- Flag it clearly: "You have a meeting on Saturday at 10am. Intentional?"
- Do not assume it is wrong — some users expect weekend meetings. But always call it out.

**Meeting load for the day:**
- If total meeting time exceeds 6 hours in a single day, flag it: "You have 7 hours of meetings today — that leaves very little time for actual work."
- If total meeting time exceeds 5 hours, note it without alarm.

---

## 4. Travel and Location Intelligence

For every pair of consecutive events, analyze the location transition.

### 4a. Physical-to-Physical Transitions

When two consecutive events both have physical locations:

1. **Identify the addresses** — Extract the full address or building/room name from each event.
2. **Calculate travel time** — Use a maps/routing skill if available. If not, estimate:
   - Same building, different room: 5 minutes.
   - Same campus/complex: 10 minutes.
   - Same city, different address: Look up driving/transit time. Default to 20 minutes if unknown.
   - Different city: Flag as likely impossible unless there is significant gap between events.
3. **Compare travel time to available gap** — If the gap between events is shorter than the estimated travel time, flag it:
   - "Your 11am meeting is at 123 Main St and your 12pm meeting is at 456 Oak Ave. Estimated travel: 25 min. Gap: 15 min. You will likely be late."
4. **Suggest adjustments** — Move the later meeting back, leave the earlier meeting early, or attend one remotely.

### 4b. Virtual-to-Physical / Physical-to-Virtual Transitions

When switching between video calls and in-person meetings:

- **Virtual then physical**: "Your Zoom call ends at 11am and your in-person meeting at Building C starts at 11:15am. That's 15 minutes to walk over — cutting it close."
- **Physical then virtual**: "You'll be at 123 Main St until 2pm and have a Zoom at 2:15pm. Make sure you have a quiet spot and good wifi to join from, or head back to your desk."

### 4c. Missing Location Information

Flag events that should have location info but don't:

- **Video call with no link**: Event title or description suggests a call ("sync", "call", "meeting", "check-in") but no Zoom/Meet/Teams/phone link is present. Flag: "No video link for your 2pm call with Sarah. Ask the organizer or check the calendar invite."
- **In-person meeting with no address**: Event says "office" or "conference room" but no specific room or address. Flag: "Your 3pm client meeting says 'downtown office' but has no address. Confirm the location."
- **Ambiguous format**: Cannot tell if a meeting is virtual or in-person. Flag: "Your 4pm with the design team has no location info at all. Clarify before the meeting."

### 4d. Travel Prep Reminders

For events with physical locations outside the user's usual office/home:

- "Leave by 1:30pm to make your 2pm meeting at 456 Oak Ave (25 min drive)."
- "Check traffic before leaving — your route can be slow during lunch hour."
- If weather data is available: "Rain expected at 1pm — allow extra travel time."

---

## 5. Meeting Prep Analysis

For each event in the next 48 hours, classify its type and determine what preparation is needed. This is the heart of the workflow — turning a calendar into an action plan.

### 5a. Meeting Type Classification

Analyze each event's title, attendees, description, and recurrence to classify it:

| Type | Signals | Prep Level |
|---|---|---|
| **1:1 with your manager** | 2 attendees, one is your manager, recurring weekly/biweekly | Medium |
| **1:1 with your report** | 2 attendees, one reports to you, recurring | Medium |
| **1:1 with a peer** | 2 attendees, same team/org, recurring | Low-Medium |
| **External / client meeting** | Attendees from a different domain, or title includes "client", "partner", "vendor" | High |
| **Interview (you are interviewing someone)** | Title contains "interview", "screen", "debrief" + candidate name | High |
| **Interview (you are the candidate)** | Title from external company, "interview", "chat", "meet the team" | Very High |
| **Group standup / sync** | 3+ attendees, recurring daily/weekly, short duration (15-30 min) | Low |
| **Team meeting** | 3+ attendees from your team, recurring, 30-60 min | Low-Medium |
| **Cross-functional meeting** | Attendees from multiple teams/departments | Medium |
| **All-hands / town hall** | Many attendees (20+), recurring monthly/quarterly | Low |
| **Presentation / demo** | Title includes "demo", "presentation", "review" + you are presenting | Very High |
| **Workshop / working session** | Title includes "workshop", "brainstorm", "working session", longer duration (60+ min) | Medium-High |
| **Social / team event** | Title includes "lunch", "happy hour", "celebration", "team building" | None |
| **Focus / block time** | Created by you, no attendees, title like "Focus", "Deep Work", "Block" | None (protect it) |
| **Unknown** | Cannot classify confidently | Low (note uncertainty) |

### 5b. Prep Notes by Meeting Type

Generate specific, actionable prep notes for each classified meeting:

**1:1 with your manager:**
- Review your recent work: What did you ship? What is blocked?
- Check for pending action items from previous 1:1s.
- Prepare your update: progress on goals, any asks/needs, career topics.
- If anything is due soon (deadline, deliverable, decision), mention it.
- Think about what you need from them: decisions, unblocking, feedback, context.

**1:1 with your report:**
- Review their recent commits, PRs, or deliverables (if available).
- Check their goals and progress.
- Prepare feedback — both positive recognition and growth areas.
- Think about their development: are they learning, growing, stuck?
- Check if they have any pending requests from you.

**1:1 with a peer:**
- Review any shared projects or dependencies.
- Check if you owe them anything or vice versa.
- Think about collaboration opportunities or blockers.

**External / client meeting:**
- Research the attendees: names, titles, LinkedIn if unknown.
- Review meeting history: When did you last meet? What was discussed?
- Check the agenda or description for topics.
- Prepare talking points and any materials/data they might ask about.
- Have your key numbers and metrics fresh.
- Note the tone: is this a sales call, a support issue, a partnership discussion, a review?

**Interview (you are the interviewer):**
- Review the candidate's resume/CV.
- Prepare your interview questions aligned with the role.
- Check the interview rubric or scorecard.
- Review the job description.
- Note what previous interviewers covered (avoid overlap).
- Have your assessment form ready.

**Interview (you are the candidate):**
- Research the company: recent news, products, culture.
- Research the interviewer(s): their role, background, recent work.
- Prepare your stories using STAR format for behavioral questions.
- Review the job description and map your experience to it.
- Prepare your questions for them.
- Test your video/audio setup if virtual.
- Have a copy of your resume accessible.

**Group standup / daily sync:**
- Prepare your update: what you did yesterday, what you are doing today, any blockers.
- Check the shared board/tracker for your items.
- Keep it concise — standups should be fast.

**Team meeting:**
- Check the agenda. If there is no agenda, note: "No agenda set for team meeting at 2pm — consider asking the organizer."
- Prepare any updates for your items.
- Review pre-read materials if shared.

**Cross-functional meeting:**
- Understand why you are invited — what is your role in this meeting?
- Prepare your team's perspective/update.
- Review shared documents or project status.

**All-hands / town hall:**
- Low prep. Just attend.
- If there is a Q&A, think about questions you might want to ask.
- Note: "All-hands at 3pm — low prep, just be present."

**Presentation / demo (you are presenting):**
- This is the highest prep category. Flag it prominently.
- Check your slides/materials: Are they done? Do they need updates?
- Practice your key talking points.
- Test screen sharing, demos, links.
- Know your audience: Who will be there? What do they care about?
- Prepare for questions.
- Have a backup plan if tech fails.
- Suggest a dry run if time allows.

**Workshop / working session:**
- Review the topic and any pre-work.
- Bring ideas and come ready to contribute.
- Check if you need to prepare any materials or data.

### 5c. Prep Time Estimation

For each meeting that needs prep, estimate the time required:

| Prep Level | Estimated Time |
|---|---|
| None | 0 minutes |
| Low | 5 minutes (quick glance at agenda) |
| Low-Medium | 10 minutes (review notes, check status) |
| Medium | 15-20 minutes (review materials, prepare updates) |
| Medium-High | 30 minutes (review docs, prepare contributions) |
| High | 30-45 minutes (research, prepare materials, rehearse) |
| Very High | 60+ minutes (full preparation, practice, research) |

### 5d. Prep Scheduling

After estimating prep time for all meetings, schedule when to do the prep:

1. **List all prep tasks** with their estimated time and the meeting they serve.
2. **Find free blocks** in the schedule (see Step 7 for free time analysis).
3. **Assign prep to free blocks** using these rules:
   - Prep should happen before the meeting it serves, ideally with a buffer.
   - High-prep items get priority for longer free blocks.
   - Do not schedule prep during lunch unless there is truly no other option.
   - If there is not enough free time for all prep, flag it: "You need ~90 minutes of prep time today but only have 45 minutes free. Prioritize the client call prep and the presentation."
4. **Output a prep schedule**: "Use your 8:30-9:00 free block to prep for the 9:30 client call."

---

## 6. Free Time Analysis

Identify and characterize all unscheduled time in the 48-hour window.

### 6a. Find Free Blocks

Scan the schedule and identify every gap between events that is **30 minutes or longer**. Shorter gaps are noted as "buffer" but not counted as usable free time.

For each free block, record:
- **Start time** and **end time**.
- **Duration** in minutes.
- **What comes before** (the meeting ending just before this block).
- **What comes after** (the meeting starting just after this block).

### 6b. Label Free Blocks

Assign a label to each free block based on its time and context:

| Label | Criteria |
|---|---|
| **Deep work window** | 90+ minutes, not adjacent to high-energy meetings. Ideal for coding, writing, complex tasks |
| **Prep window** | 30-60 minutes before a meeting that needs preparation |
| **Recovery buffer** | 15-30 minutes after a marathon block or high-stakes meeting |
| **Lunch** | Overlaps with 11:30am-1:30pm and is 30+ minutes |
| **Morning ramp-up** | Before first meeting of the day |
| **End-of-day wind-down** | After last meeting of the day |
| **Short break** | 15-29 minutes between meetings — only good for a breather, snack, or quick task |

### 6c. Free Time Suggestions

Based on pending tasks (if a task skill is available) and the nature of the free blocks:

- **Deep work windows**: "You have 2 hours free from 2-4pm. Great for focused project work."
- **Prep windows**: "Use 1:30-2pm to prep for your client call at 2pm."
- **Short breaks**: "15 minutes between meetings at 10:30 — stretch, grab water."
- **End of day**: "Nothing after 4pm — wrap up or leave early."

If no task context is available, still label the blocks and note their quality:
- "Your best focus window today is 2-4pm (2 hours, no interruptions)."
- "Tomorrow's schedule is packed — your only free block is 12-12:30 (lunch)."

### 6d. Time Budget Summary

Calculate and present:

| Metric | Today | Tomorrow |
|---|---|---|
| Total meetings | X | Y |
| Total meeting hours | Xh Ym | Yh Zm |
| Total free hours (30+ min blocks) | Xh Ym | Yh Zm |
| Longest free block | X min (time range) | Y min (time range) |
| Prep time needed | X min | Y min |
| Net free time (free minus prep) | Xh Ym | Yh Zm |
| Meeting-to-free ratio | X:Y | X:Y |

---

## 7. Pattern Detection

Look beyond today and tomorrow. Surface smart observations about the user's calendar habits and recurring patterns.

### 7a. Attendee Clustering

- "You have 3 meetings with Sarah this week (Monday 1:1, Wednesday project sync, Friday review). Could any be combined?"
- "You are meeting with the Platform team 4 times this week. Is there an open question that a single longer session could resolve?"
- Track who the user meets with most frequently and flag when it seems excessive.

### 7b. Day-of-Week Patterns

- "Your Tuesdays are always packed — averaging 6 hours of meetings. Consider blocking focus time on Tuesdays."
- "You have no meetings on Fridays — great deep work day. Protect it."
- "Mondays are heavy with syncs — front-loading the week."

### 7c. Recurring Meeting Health

- "Your weekly design review has had no agenda for 3 consecutive weeks. Is it still needed?"
- "The biweekly planning meeting was last cancelled 2 months ago. Consider if the cadence is right."
- "You have 12 recurring meetings per week. That is X hours committed before any ad-hoc meetings."

### 7d. Workload Trends

- "You've been in meetings X hours this week already (Mon-now). That is above/below your usual average."
- "Your meeting load has increased 20% over the past month."
- "You had 3 meetings cancelled this week — your schedule opened up."

### 7e. Anomalies

- "New meeting: You were just invited to a 'Project Phoenix Kickoff' on Thursday you have not seen before."
- "Time change: Your 1:1 with Jordan moved from 2pm to 4pm."
- "Cancellation: The all-hands on Friday was cancelled."
- Anything that changed since the last run should be called out clearly.

---

## 8. Present the Schedule View

Build a clean, scannable calendar view. This is what the user sees — make it beautiful and immediately useful.

### Priority Indicators

Every event gets a color-coded indicator based on classification:

- **Red** (high-stakes) — External calls, client meetings, interviews, presentations. Needs prep, cannot be late, reputation matters.
- **Yellow** (prep-needed) — 1:1s with manager, cross-functional meetings, workshops. Should prepare but lower stakes.
- **Green** (routine) — Standups, team syncs, recurring check-ins. Low prep, familiar format.
- **White** (personal) — Personal calendar events, social events, appointments.
- **Gray** (declined / cancelled) — Events you are not attending. Shown for context only.

### The View

```
===========================================================
CALENDAR CHECK — {Day}, {Month} {Date}, {Year} at {Time}
===========================================================


TODAY — {Full Day Name}, {Month} {Date}
-----------------------------------------------------------

  All-day: {All-day event title} (if any)

  {indicator} {Time} — {Title} ({Duration})
     Location: {location or "Video" or "No location"}
     Attendees: {count} ({key names})
     Prep: {prep note or "None needed"}
     {warning if any}

  {indicator} {Time} — {Title} ({Duration})
     ...

  --- {free block label}: {start}-{end} ({duration}) ---

  {indicator} {Time} — {Title} ({Duration})
     ...


TOMORROW — {Full Day Name}, {Month} {Date}
-----------------------------------------------------------

  {Same format as today}


WARNINGS
-----------------------------------------------------------

  [CONFLICT] {Description of the conflict and suggestion}
  [NO BUFFER] {Description of back-to-back issue}
  [NO LUNCH] {Description}
  [MARATHON] {Description of long meeting stretch}
  [EARLY/LATE] {Description}
  [MISSING INFO] {Description of missing link/location}
  [TRAVEL] {Description of travel time issue}


PREP NEEDED
-----------------------------------------------------------

  1. {Meeting title} at {time} — {prep description} (~{X} min)
     Suggested prep time: {free block time range}

  2. {Meeting title} at {time} — {prep description} (~{X} min)
     Suggested prep time: {free block time range}


FREE BLOCKS
-----------------------------------------------------------

  Today:
    {time range} — {label} ({duration})
    {time range} — {label} ({duration})

  Tomorrow:
    {time range} — {label} ({duration})


PATTERNS
-----------------------------------------------------------

  {Any pattern observations from Step 7}


SUMMARY
-----------------------------------------------------------

  Today:    {X} meetings | {Y}h {Z}m in meetings | {A}h {B}m free
  Tomorrow: {X} meetings | {Y}h {Z}m in meetings | {A}h {B}m free
  Prep needed for: {N} meetings (~{T} min total)
  Week so far: {H} hours in meetings (Mon-today)

===========================================================
```

### Empty Calendar

If there are no events in the 48-hour window:

```
===========================================================
CALENDAR CHECK — {Day}, {Month} {Date}, {Year} at {Time}
===========================================================

No meetings for the next 48 hours. Calendar is wide open.

Your next event: {title} on {day} at {time} ({X days away})

Use this time well — deep work, planning, or rest.
===========================================================
```

---

## 9. Quick Actions

After presenting the schedule, offer actionable next steps. These are suggestions — the user decides.

### Conflict Resolution
- "Decline the 3pm sync — it conflicts with your client call."
- "Move your 1:1 with Alex to Thursday to avoid the overlap."
- "Ask Sarah if the project review can be async this week."

### Buffer Management
- "Add a 15-minute buffer before your 2pm client call (shorten the 1:30 meeting)."
- "Block 12-12:30 for lunch — you have meetings from 11am to 2pm otherwise."
- "Add 10 minutes between your back-to-back standups."

### Prep Actions
- "Set a reminder at 1:30pm to prep for the 2pm client call."
- "Review the slide deck for tomorrow's presentation — link: {url from event}."
- "Pull up the candidate resume for the 3pm interview."

### Schedule Optimization
- "Block 2-4pm for deep work — it is your only open window today."
- "Move your 1:1 with Jordan to the morning — afternoons are packed."
- "This Thursday has 8 hours of meetings. Cancel or delegate one."

### Communication
- "Ask the organizer for a Zoom link for the 2pm call."
- "Confirm the address for the 4pm offsite meeting."
- "Send a pre-read to attendees of tomorrow's workshop."

Present only the most relevant 3-5 actions. Do not overwhelm with every possible suggestion. Prioritize by urgency and impact.

---

## 10. Evening Mode

When the workflow runs at 6pm (or any time after 12pm), shift the focus and tone.

### Tomorrow Focus

- Lead with tomorrow's schedule, not today's.
- Today's remaining events are shown as a brief "rest of today" section, if any.
- Highlight anything tomorrow that needs attention tonight.

### Overnight Prep Flags

- "Tomorrow at 9am you have a client presentation. Make sure your slides are ready tonight."
- "Interview at 10am tomorrow. Review the candidate's resume tonight."
- "Board meeting at 8am tomorrow. Read the board packet tonight."

### Early Morning Warnings

- "7am standup tomorrow. Set your alarm for 6:30."
- "8am flight to New York. Wake-up by 5:30 if you want to make it."
- Any event before 8:30am gets flagged with an alarm suggestion.

### Friday Evening — Weekend Preview

When the evening run happens on Friday:

- Show Saturday and Sunday events (expanding the window beyond 48 hours for weekend visibility).
- Flag weekend meetings: "You have a Saturday 10am call. Intentional?"
- Note any Monday morning meetings that need weekend prep: "Monday 9am all-hands — if you need to prepare anything, do it this weekend."
- If the weekend is clear: "Weekend is clear. Enjoy the break."

### Wind-Down Tone

The evening run should feel like a calm end-of-day review, not a stressful alarm. Use language like:
- "Tomorrow looks manageable — 3 meetings, plenty of free time."
- "Heavy day tomorrow — get some rest tonight."
- "One thing to prep tonight, otherwise you are set."

---

## 11. Safety and Privacy Rules

These rules are non-negotiable. Follow them on every run.

### Never Modify Without Permission

- **Never** create, edit, move, or delete calendar events automatically.
- **Never** send RSVPs (accept/decline/tentative) without the user confirming.
- **Never** send messages to attendees on the user's behalf.
- Quick actions are **suggestions only**. The user must explicitly approve before any action is taken.

### Privacy

- **Never** share attendee names, email addresses, or event details outside of the summary presented to the user.
- **Never** include event details in logs, analytics, or external systems.
- If an event is marked **private** or **confidential**, show only: "{time} — Private event ({duration})". Do not show title, attendees, or description.
- Personal calendar events should be shown with reduced detail by default.

### Accuracy

- **Never** assume a meeting's importance. Let the classification system determine it and let the user override.
- **Never** fabricate attendee information (titles, roles) — only use what is available in the calendar data or user's contact information.
- If you cannot determine something (meeting type, location, etc.), say so. Do not guess.
- If the calendar data is ambiguous, present both possibilities: "This might be a video call or in-person — no location info."

### Graceful Failures

- If calendar access fails entirely: "Could not access your calendar. Check your integration settings. Here is the error: {error}."
- If one calendar source fails: "Could not reach your work calendar. Personal calendar loaded fine. Analysis may be incomplete."
- If zero events are found: Present the empty calendar view (see Step 8). Do not treat this as an error.
- If event data is malformed: Skip the bad event, note it ("1 event could not be parsed"), and continue.

---

## Notes

- **Schedule**: Runs at 8am (morning mode) and 6pm (evening mode). Can also be run on demand at any time.
- **Priority indicators**: Red = high-stakes, Yellow = prep-needed, Green = routine, White = personal, Gray = declined/cancelled.
- **Pairs well with**: `build-meeting-prep` (for deep prep on specific meetings), `triage-tasks` (to fill free blocks with tasks), `send-morning-briefing` (calendar is a key input).
- **Learning**: If the user consistently overrides your meeting type classifications or ignores certain warnings, note the pattern and adjust in future runs. For example, if the user never cares about weekend meetings, stop flagging them.
- **Efficiency**: If nothing has changed since the last run (no new events, no modifications, no cancellations), say so: "No changes since this morning's check. Schedule is the same." Still show the summary but skip the detailed analysis.
- **Tone**: Be informative, not bossy. The user is in control. You are their calendar assistant, not their calendar police.
