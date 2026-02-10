---
name: send-weekly-digest
description: Weekly digest — compiles a week-in-review summary and delivers it via messaging. Use when the user says "send weekly digest", "week in review", "weekly summary", or "send my weekly update".
requires:
  - name: telegram
    description: Telegram messaging
---

# Weekly Digest

Week-in-review summary delivered via messaging.

## 1. Gather Weekly Data

Compile information from the past 7 days:

### Git activity
```bash
find ~/Projects ~/Developer ~/Code -maxdepth 3 -name ".git" -type d 2>/dev/null | while read gitdir; do
  repo=$(dirname "$gitdir")
  count=$(cd "$repo" && git log --oneline --after="$(date -v-7d +%Y-%m-%d)" --author="$(git config user.name)" 2>/dev/null | wc -l)
  [ "$count" -gt 0 ] && echo "$(basename "$repo"): $count commits"
done
```

### Calendar summary
```bash
icalBuddy -f -nc -nrd -df "%Y-%m-%d" -po "datetime,title" eventsFrom:today-7 to:today
```

### Key accomplishments
Summarize major completions based on git messages and calendar events.

## 2. Format Digest

Structure the message:

```
📋 Weekly Digest — Week of [DATE]

🏗 Code: X commits across Y repos
📅 Meetings: X total (Y hours)
✅ Highlights:
  • [Top accomplishment 1]
  • [Top accomplishment 2]
  • [Top accomplishment 3]

📌 Coming up next week:
  • [Key upcoming event 1]
  • [Key upcoming event 2]
```

## 3. Deliver

Send via Telegram (or other configured messaging):

```bash
telegram send --message "DIGEST_CONTENT"
```

## Tracking

Track delivery to avoid sending twice:

```json
{
  "lastWeeklyDigest": "2026-02-09"
}
```

Only send if `lastWeeklyDigest` is not this week.

## Notes

- Schedule via cron for end of week (e.g., Friday 5:00 PM)
- Keep it scannable — bullet points over paragraphs
- Focus on accomplishments, not just activity
