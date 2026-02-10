---
name: build-weekly-review
description: Weekly review generator — compiles the week's git commits, calendar events, and accomplishments into a review document.
triggers:
  - weekly review
  - week in review
  - what did I do this week
  - weekly summary
---

# Weekly Review

Compile the week's activity and accomplishments into a review doc.

## 1. Gather Git Activity

Using **git**, find commits from the past 7 days across all your repositories:
- Number of commits per repo
- Key changes (features, fixes, refactors)
- Files most frequently changed

Summarize by repository.

## 2. Gather Calendar Events

Using your **calendar skill**, pull events from the past 7 days:
- Total meetings and hours
- 1-on-1s
- External meetings
- Key meetings and their outcomes

## 3. Gather Task Completions

Using your **task manager skill** (if available):
- Tasks completed this week
- Tasks still in progress
- Overdue items

## 4. Compile the Review

Create a markdown document:

```markdown
# Week of YYYY-MM-DD

## Accomplishments
- [Key things shipped or completed]
- [Milestones reached]
- [Problems solved]

## Code Activity
- X commits across Y repos
- [Notable changes]
- [PRs merged]

## Meetings
- X meetings (Y hours total)
- [Key meetings and outcomes]
- [Decisions made]

## Still In Progress
- [Ongoing work]
- [Blockers]

## Next Week
- [Priorities]
- [Upcoming deadlines]
- [Key meetings]

## Reflection
[Brief thoughts on the week — what went well, what could improve]
```

## 5. Save and Present

Save the review to a consistent location:
- `~/Documents/reviews/week-of-YYYY-MM-DD.md`
- Or your preferred location

Highlight the top 3 accomplishments.

## Notes

- Schedule for end of week (Friday afternoon or Sunday evening)
- Focus on outcomes, not just activity — "shipped feature X" beats "made 47 commits"
- Keep it concise — one page max
- Use for performance reviews, standups, or personal reflection
