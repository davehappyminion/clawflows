---
name: draft-weekly-update
emoji: 📝
description: Weekly update drafter — compiles the week's work from git commits, completed tasks, and meetings into a polished manager-ready email, formatted and ready to send.
author: @davehappyminion
schedule: "friday 4pm"
---

# Draft Weekly Update

Turn a week of scattered work into a clean, manager-ready update email. Pull from real data — commits, tasks, meetings — so nothing gets forgotten and the user doesn't have to write it from scratch.

## 1. Gather Git Activity

For each repo the user actively works in, pull the commit log for the current week (Monday through today):
- Filter to the user's commits only (by author email/name)
- Group commits by repo and branch
- Extract commit messages and summarize the theme of each group
- Note PRs opened, merged, or reviewed by the user
- Ignore trivial commits (typo fixes, merge commits, linting) unless they represent meaningful cleanup work

If the user works across many repos, focus on the ones with the most activity this week.

## 2. Gather Completed Tasks

Check the user's task management system for tasks completed this week:
- Pull tasks marked done in the last 7 days
- Include the task title, project, and completion date
- Note any tasks that were started but not finished (in-progress items for the "Next Week" section)
- Flag blocked tasks with the reason for the block

If no task system is integrated, skip this step and note it in the draft as a section the user should fill in manually.

## 3. Gather Meeting Context

Scan the user's calendar for meetings attended this week:
- List meetings with their titles, dates, and key attendees
- If meeting notes exist, pull out action items and decisions made
- Identify meetings that led to work output (e.g., "after the design review, I updated the API spec")
- Skip routine standups and 1:1s unless something notable came out of them

## 4. Identify Themes and Highlights

Analyze the raw data and extract:
- **Top 3-5 accomplishments** — the most impactful things completed this week
- **Key decisions made** — anything that changed direction or unblocked work
- **Collaboration highlights** — cross-team work, unblocking others, code reviews
- **Risks or blockers** — anything slowing progress that management should know about
- **Next week's focus** — based on in-progress tasks and upcoming deadlines

## 5. Draft the Email

Compose a polished, professional email in this structure:

```
Subject: Weekly Update — [User Name] — Week of [Date Range]

Hi [Manager Name],

Here's my update for the week.

HIGHLIGHTS
----------
- [Accomplishment 1 — one sentence, outcome-focused]
- [Accomplishment 2]
- [Accomplishment 3]

DETAILS
-------
[Project/Area 1]
- [What was done and why it matters — 1-2 sentences]
- [Specific deliverables: PRs merged, features shipped, docs written]

[Project/Area 2]
- [What was done and why it matters]
- [Specific deliverables]

COLLABORATION
-------------
- Reviewed [X] PRs for [team/person]
- [Unblocked / paired with / supported someone on something]

BLOCKERS / RISKS
----------------
- [Blocker description and what's needed to resolve it]
  (or "None this week" if clean)

NEXT WEEK
---------
- [Focus area 1]
- [Focus area 2]
- [Any upcoming deadlines or milestones]

Thanks,
[User Name]
```

## 6. Review and Deliver

- Present the full draft to the user for review.
- Call out any sections that feel thin — "I only found 2 commits this week in repo X. Did you do other work there that wasn't committed?"
- Suggest additions if the gathered data seems incomplete.
- Offer to adjust the tone (more detailed, more concise, more casual) based on user preference.

## Notes

- **NEVER send the email automatically.** Draft only. The user reviews, edits, and sends it themselves.
- The goal is an 80% complete draft that the user can polish in 5 minutes, not a perfect email that takes the agent 20 minutes to generate.
- Tone should be professional but not stiff. Write like a competent person talking to their manager, not a corporate press release.
- If the user has sent weekly updates before (check sent mail), match the style, length, and formatting of previous updates.
- Avoid inflating small work into big accomplishments. A config file change is a config file change, not "architected infrastructure improvements."
- If it was a genuinely light week (PTO, oncall, meetings-heavy), say so honestly. Managers respect transparency over padding.
- The first run may need the user to provide their manager's name and any project names they want used. Cache this for future runs.
- If the user provides feedback on the draft ("too long," "skip the collaboration section"), remember it for next week.
