---
name: build-weekly-review
description: Weekly review generator — compiles the week's git commits, calendar events, and accomplishments into a review document.
---

# Weekly Review

Compile the week's git commits, activity, and accomplishments into a review doc.

## 1. Gather Git Activity

For each repo the user works in, pull this week's commits:

```bash
git log --oneline --after="$(date -v-7d +%Y-%m-%d)" --author="$(git config user.name)" --all
```

Summarize by repo:
- Number of commits
- Key changes (features, fixes, refactors)
- Files most frequently changed

## 2. Gather Calendar Events

Pull events from the past 7 days:

```bash
icalBuddy -f -nc -nrd -df "%Y-%m-%d" -tf "%H:%M" -po "datetime,title" eventsFrom:today-7 to:today
```

Categorize:
- Meetings attended (count, total hours)
- 1-on-1s
- External meetings

## 3. Compile Review

Create a markdown file: `~/Documents/reviews/week-of-YYYY-MM-DD.md`

```markdown
# Week of YYYY-MM-DD

## Accomplishments
- [Key things shipped or completed]

## Code Activity
- X commits across Y repos
- [Notable changes]

## Meetings
- X meetings (Y hours total)
- [Key meetings and outcomes]

## Next Week
- [Carry-over items or upcoming priorities]
```

## After Running

Present the review document and save it. Highlight the top 3 accomplishments.

## Notes

- Focus on outcomes, not just activity — "shipped feature X" beats "made 47 commits"
- If the user has a standup or status update format, adapt to match it
- Keep it concise — one page max
