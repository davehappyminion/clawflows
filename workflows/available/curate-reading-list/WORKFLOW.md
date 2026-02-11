---
name: curate-reading-list
emoji: 📚
description: Scan Hacker News, Reddit, RSS feeds, and newsletters for articles matching your interests. Deduplicate, rank, and deliver a clean reading list every morning.
schedule: "8am"
---

# Curate Reading List

Gather the best articles from across the web, filter out noise, and deliver a focused reading list tailored to the user's interests.

## 1. Load User Interests

Read the user's interest profile from their OpenClaw config or memory. Look for:
- Explicit topic preferences (e.g., "AI/ML", "systems programming", "startup strategy")
- Past reading history if available (previously saved reading lists)
- Any blocked domains or topics the user has flagged as uninteresting

If no interest profile exists, ask the user to provide 3-5 topics they care about before proceeding.

## 2. Gather Sources

Pull recent content from the following sources:
1. **Hacker News** — Top 30 stories from the front page and any "Show HN" posts
2. **Reddit** — Top posts from subreddits matching user interests (e.g., r/programming, r/machinelearning, r/startups)
3. **RSS feeds** — If the user has configured RSS feed URLs, fetch and parse the latest entries
4. **Newsletters** — Check for any forwarded newsletter content in the user's configured inbox or saved newsletter directory

For each item, capture: title, URL, source, brief description or summary, and approximate reading time.

## 3. Filter and Deduplicate

- Remove any articles the user has already seen (check against previous reading lists if available)
- Deduplicate by URL and by content similarity (same story reported by multiple sources — keep the best version)
- Filter out paywalled content unless the user has indicated they have a subscription
- Remove clickbait, listicles, and low-substance content unless explicitly in the user's interests

## 4. Rank by Relevance

Score each remaining article on:
- **Topic match** (0-5): How closely does it align with stated interests?
- **Quality signal** (0-3): Upvotes, comment quality, source reputation
- **Freshness** (0-2): Published in last 24 hours scores higher

Sort by total score descending. Select the top 5-10 articles.

## 5. Enrich Summaries

For each selected article:
- Write a 2-3 sentence summary of the key takeaway
- Note why it was selected (which interest it matches)
- Estimate reading time
- Flag if it is particularly long, technical, or time-sensitive

## 6. Present Reading List

Deliver the curated list using this template:

```
# Reading List — [DATE]

## Top Picks

### 1. [Article Title]
**Source:** [Hacker News / Reddit / RSS] | **Reading time:** ~X min
[2-3 sentence summary]
[URL]

### 2. [Article Title]
**Source:** [source] | **Reading time:** ~X min
[2-3 sentence summary]
[URL]

[...repeat for 5-10 articles...]

## Honorable Mentions
- [Title] — [one-line reason it didn't make top picks] ([URL])
- [Title] — [one-line reason] ([URL])

## Topics Covered Today
- [Topic 1]: X articles
- [Topic 2]: X articles

---
Curated from [N] sources | [N] articles scanned | [N] duplicates removed
```

## 7. Save and Archive

- Save the reading list to the user's configured output location
- Update the "already seen" list with today's URLs to avoid future duplicates
- If the user has a read-later service configured (Pocket, Instapaper, etc.), offer to send articles there

## Notes

- This workflow runs daily at 8am but can also be triggered on demand.
- Never auto-subscribe the user to anything. This is read-only gathering.
- If a source is unreachable, skip it and note the failure in the report rather than blocking the whole workflow.
- Respect rate limits on all APIs. Space out requests if needed.
- The reading list should feel curated, not exhaustive. Quality over quantity. Five great articles beat ten mediocre ones.
