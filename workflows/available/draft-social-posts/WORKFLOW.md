---
name: draft-social-posts
emoji: 📱
description: Generate a week's worth of social media content based on your recent work, blog posts, or interests. Presents drafts for review — never posts automatically.
---

# Draft Social Posts

Create a batch of social media drafts the user can review, edit, and post on their own schedule. This workflow never posts anything automatically.

## 1. Gather Source Material

Collect recent content the user has produced or engaged with:
1. **Blog posts** — Check the user's blog directory or CMS for posts from the last 2 weeks
2. **Project updates** — Look at recent git commits, changelogs, or release notes from active projects
3. **Reading list** — Check previously curated reading lists for articles the user might want to share
4. **Notes and ideas** — Check the user's notes directory for any drafts tagged "social" or "share"
5. **Manual input** — Ask the user if there are specific topics, launches, or announcements to include

If no source material is found, ask the user what they'd like to post about this week.

## 2. Determine Platforms and Voice

Check the user's config for:
- **Target platforms**: Twitter/X, LinkedIn, Mastodon, Bluesky, etc.
- **Voice and tone preferences**: Professional, casual, technical, witty, etc.
- **Content guidelines**: Any topics to avoid, hashtag preferences, emoji usage

If not configured, default to a professional-but-approachable tone and ask which platforms to target.

## 3. Generate Draft Posts

Create 5-7 draft posts for the week, aiming for variety:
- **2-3 original thought posts** — Insights, opinions, or lessons learned from the user's work
- **1-2 sharing posts** — Recommending an article, tool, or resource with the user's take
- **1 engagement post** — A question, poll, or discussion starter relevant to the user's field
- **1 milestone/update post** — Celebrating a launch, reaching a goal, or sharing progress

For each draft, adapt the content to each target platform's constraints and culture:
- Twitter/X: 280 chars, punchy, thread-friendly
- LinkedIn: Longer form, professional framing, no hashtag spam
- Mastodon: 500 chars, community-oriented tone
- Bluesky: 300 chars, conversational

## 4. Add Scheduling Suggestions

For each post, suggest:
- **Best day**: Spread across the week (Mon-Fri typically, weekends if appropriate)
- **Best time**: Based on general engagement data for the platform
- **Rationale**: Brief note on why this timing works

## 5. Present Drafts for Review

Deliver the batch using this template:

```
# Social Media Drafts — Week of [DATE]

## Source Material Used
- [Blog post title / project name / article title]
- [...]

---

### Post 1 of [N] — [Day, Date]
**Platform:** [Twitter/X, LinkedIn, etc.]
**Suggested time:** [Time]
**Type:** [Original thought / Share / Engagement / Update]

> [Draft post content here]

**Alt text (if image):** [description]
**Notes:** [Any context or suggestions for the user]

---

### Post 2 of [N] — [Day, Date]
[...repeat format...]

---

## Weekly Content Mix
- Original thoughts: X posts
- Shares/recommendations: X posts
- Engagement/questions: X posts
- Updates/milestones: X posts

## Suggested Hashtags
- [#hashtag1] — used X times this week in your niche
- [#hashtag2] — trending in relevant communities
```

## 6. Collect Feedback

After presenting drafts:
- Ask the user to approve, edit, or reject each post
- Note any tone or content adjustments for future runs
- Save approved posts to the user's configured drafts location

Do NOT proceed to posting. The user handles publishing on their own terms.

## Safety Rules

- **Never post anything automatically.** This workflow produces drafts only.
- **Never fabricate achievements or credentials.** Only reference real work and real content.
- **Never include confidential project details** unless the user explicitly marks them as public.
- **Never generate engagement-bait or misleading content.** Authenticity over virality.
- **Always disclose AI assistance** if the user's platform guidelines or personal preference requires it.

## Notes

- This workflow is on-demand only. No schedule.
- The user may run this weekly or whenever they need a content batch.
- If the user provides feedback on drafts ("too formal", "more humor"), save those preferences for next time.
- Image suggestions can be included but the workflow should not generate or source images without explicit permission.
- Thread/carousel formats are fine to suggest but keep individual posts self-contained too.
