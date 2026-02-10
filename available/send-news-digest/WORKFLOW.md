---
name: send-news-digest
description: Curated news digest — gathers news on topics you care about and delivers a concise summary via messaging.
requires:
  - name: telegram
    description: Telegram messaging
---

# News Digest

Curated news on topics you care about — no doom-scrolling required.

## 1. Define Topics

The user should configure their interests. Common categories:

- **Tech:** AI, startups, product launches, funding rounds
- **Crypto:** Bitcoin, Ethereum, DeFi, regulation
- **Business:** Markets, earnings, M&A, economy
- **Industry-specific:** Healthcare, fintech, climate, etc.
- **Personal interests:** Hobbies, sports teams, local news

Store preferences:
```json
{
  "newsTopics": ["AI", "startups", "crypto"],
  "newsSourcesPreferred": ["TechCrunch", "The Verge", "Hacker News"],
  "newsSourcesBlocked": ["source-to-avoid"]
}
```

## 2. Gather News

### Sources to Check

**Tech & Startups**
- Hacker News top stories: `https://news.ycombinator.com/`
- TechCrunch: `https://techcrunch.com/`
- The Verge: `https://www.theverge.com/`
- Product Hunt (new launches): `https://www.producthunt.com/`

**Crypto**
- CoinDesk: `https://www.coindesk.com/`
- The Block: `https://www.theblock.co/`

**General**
- Reuters: `https://www.reuters.com/`
- AP News: `https://apnews.com/`

**Social/Trends**
- X/Twitter trending in user's niche
- Reddit top posts in relevant subreddits

### Fetching
Use browser automation or RSS feeds to pull headlines and summaries.

## 3. Filter and Rank

**Include:**
- Stories matching user's topics
- High-signal sources (user's preferred list)
- Breaking news or significant developments

**Exclude:**
- Clickbait headlines
- Duplicate stories (same news from multiple sources)
- Stories older than 24 hours (unless major)
- Blocked sources

**Rank by:**
1. Relevance to user's topics
2. Recency
3. Source credibility
4. Engagement/importance signals

## 4. Format the Digest

```
📰 Your Daily Digest — {Date}

**Top Story**
{Headline}
{2-3 sentence summary}
{Link}

**AI & Tech**
• {Headline} — {One sentence} [Source]
• {Headline} — {One sentence} [Source]

**Crypto**
• {Headline} — {One sentence} [Source]

**Worth Reading**
• {Longer piece or analysis worth bookmarking}

—
{Total: X stories from Y sources}
```

Keep it to 5-10 items max. Quality over quantity.

## 5. Deliver

Send via messaging:

```bash
telegram send --message "DIGEST_CONTENT"
```

## Tracking

```json
{
  "lastNewsDigest": "2026-02-09",
  "storiesSent": ["story_id_1", "story_id_2"]
}
```

- Only send once per day
- Track sent stories to avoid repeats tomorrow

## Notes

- Schedule for morning (with briefing) or evening (wind-down reading)
- User can reply "more on [topic]" to get deeper coverage
- If no significant news, say so: "Quiet news day — nothing major in your topics"
- Link to full articles — don't try to replace reading, just curate
