---
name: track-habits
emoji: 📊
description: Daily habit tracker — logs exercise, water, reading, meditation, and sleep, then delivers a weekly scorecard with streaks, trends, and encouragement.
author: @davehappyminion
schedule: "9pm"
---

# Track Habits

Log daily habits and build a weekly scorecard. Runs nightly to capture the day's activity, and on Sundays compiles a full weekly report.

## 1. Check the Log File

Look for the habit log at `~/.openclaw/data/habits/habit-log.json`. If it doesn't exist, create it with an empty array. Each entry is a JSON object with: `date`, `exercise` (bool + notes), `water_glasses` (int), `reading` (bool + notes), `meditation` (bool + minutes), `sleep_hours` (float), `sleep_quality` (great/good/okay/poor).

## 2. Ask About Today's Habits

Prompt the user for each habit. Keep it conversational, not interrogative.

- **Exercise** — Did you move today? What did you do? (yes/no + optional notes)
- **Water** — How many glasses? (number, default 0)
- **Reading** — Read anything today? (yes/no + optional notes)
- **Meditation** — Any meditation or mindfulness? (yes/no + optional minutes)
- **Sleep** — How'd you sleep last night? Hours and quality (great/good/okay/poor)

If the user gives short answers, that's fine. Don't push for detail.

## 3. Save Today's Entry

Write the entry to the log file. If an entry for today already exists, update it rather than duplicating.

## 4. Daily Summary or Weekly Report

If today is **not Sunday**, give a quick summary and stop:

```
📊 Habits logged for {Date}

  Exercise: ✅ (30 min run)    Water: 💧 8 glasses
  Reading: ✅ (20 pages)       Meditation: ✅ (15 min)
  Sleep: 😴 7.5 hrs (good)

🔥 {streak_count}-day streak on exercise!
```

If today **is Sunday**, continue to step 5.

## 5. Compile Weekly Scorecard

Pull the last 7 days from the log and calculate:

- **Completion rate** per habit (e.g., Exercise: 5/7 days)
- **Current streaks** — consecutive days for each habit
- **Longest streaks** — all-time bests (scan the full log)
- **Averages** — water/day, sleep hours/day, meditation minutes/day
- **Trends** — compare this week to last week (up, down, or steady)

## 6. Present Weekly Report

```
📊 Weekly Habit Scorecard — Week of {Start Date}

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🏆 THIS WEEK
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  Exercise:    ████████░░  5/7 (71%)
  Water (8+):  ██████████  7/7 (100%) 🔥
  Reading:     ██████░░░░  4/7 (57%)
  Meditation:  ████░░░░░░  3/7 (43%)
  Sleep (7+):  ████████░░  6/7 (86%)

🔥 STREAKS: Water 14d (best!) | Exercise 5d | Sleep 6d

📈 vs LAST WEEK
  Exercise: ↑ up from 3/7 | Water: → steady | Sleep: ↓ 7.8→7.2 hrs

💬 {Personalized encouragement and observations}
```

## 7. Deliver

Send the daily summary (or weekly report on Sundays) via your **messaging skill**.

## Notes

- Never guilt-trip. Frame missed days positively: "Room to grow" not "You failed."
- If the user skips a day, don't backfill — just log what you have.
- Sleep quality is subjective. Don't challenge it.
- If the log grows past 365 entries, archive older data to a yearly file.
- The weekly report is the real value — daily logging is just the input.
