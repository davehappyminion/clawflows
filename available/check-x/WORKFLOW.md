---
name: check-x
description: X (Twitter) engagement — check notifications, respond to mentions, engage authentically, and optionally generate content or custom profile pictures.
requires:
  - name: bird
    description: X (Twitter) CLI
  - name: browser
    description: Browser automation
---

# X Engagement

Manage your X presence — notifications, engagement, and content. Be present without being glued to the app.

## 1. Check Notifications

Scan https://x.com/notifications for:

```bash
bird notifications list --limit 50
```

Or via browser:
```bash
browser navigate to x.com/notifications
```

### Categorize Notifications

**🔴 Respond Now**
- Direct @mentions asking questions
- DMs from real people (not bots)
- Replies to your content needing acknowledgment
- Requests for help

**🟡 Engage Today**
- New followers worth acknowledging
- Nice comments on your posts
- Relevant conversations in your niche
- Mutual follows engaging with you

**🟢 Optional**
- Likes (no action needed, but nice to see)
- Reposts (maybe thank if significant)
- Quote tweets (engage if thoughtful)

**⚪ Skip**
- Bots and spam accounts
- Hostile or bad-faith replies
- Engagement bait
- Crypto scams

## 2. Engagement Guidelines

### Voice & Vibe
- **Be yourself** — Consistent personality across all interactions
- **Be helpful** — Offer value, not just presence
- **Be genuine** — Real engagement beats performative posting
- **Be positive** — Lift people up, don't dunk (usually)

### When to Reply
- **Always:** Direct questions, genuine compliments, requests for help
- **Usually:** Thoughtful comments, fellow builders, mutual follows
- **Sometimes:** Random nice comments (a like might suffice)
- **Never:** Trolls, bots, bad-faith actors (don't feed them)

### When to Like
- Show appreciation without adding noise
- Acknowledge mentions you don't need to reply to
- Support friends' posts
- Bookmark interesting content

### When to Repost
- Content genuinely valuable to your audience
- Friends' wins worth amplifying
- Important news in your niche
- Your own evergreen content (sparingly)

## 3. Respond to Key Mentions

For high-priority mentions:

1. **Understand context** — Read the thread, not just the mention
2. **Match energy** — Casual for casual, professional for professional
3. **Add value** — Answer the question, help with the problem
4. **Be concise** — X rewards brevity

```bash
bird reply <tweet_id> "Your response here"
```

### Response Templates (Adapt, Don't Copy)

**For questions:**
> "{Answer}. Happy to elaborate if helpful!"

**For compliments:**
> "Thanks! Glad it resonated 🙏"

**For help requests:**
> "Happy to help! {Brief answer or offer to DM}"

**For new followers:**
> "Welcome! What brings you here?" (for notable accounts)

## 4. Original Content (1-3 Posts/Day)

### What to Post
- **Observations** — Things you noticed in your domain
- **Lessons** — What you learned (especially from failures)
- **Builds** — What you're working on, progress updates
- **Wins** — Milestones, achievements (not bragging, sharing)
- **Helpful content** — Tips, tutorials, resources
- **Opinions** — Takes on relevant topics (thoughtful, not hot)

### Posting Guidelines
- **Quality > quantity** — One great post beats five mediocre ones
- **Timing** — Morning (8-9am) and evening (5-7pm) often best
- **Engagement window** — Be around for 30 min after posting to reply
- **Threads** — For complex topics, break into digestible chunks

```bash
bird post "Your post content here"
```

## 5. Owner's Posts (If Managing an Account)

**ALWAYS engage with the account owner's posts:**
- Reply with genuine addition to the conversation
- Repost if relevant to the audience
- Like at minimum

## 6. Privacy & Safety Rules

### Absolute Rules
- **NEVER share personal information** about the owner
- **NEVER mention family members** publicly
- **NEVER delete posts** without explicit permission
- **NEVER engage in arguments** that could damage reputation
- **NEVER post when angry** — Draft, wait, review

### Content Boundaries
- Stay in your lane (topics you know)
- Don't comment on breaking news without verification
- Avoid politics unless that's your brand
- Don't subtweet or vague-post

## 7. Custom PFP Generation (Optional)

For followers who engage positively, offer custom profile pictures:

### Download Original
```bash
browser navigate to x.com/USERNAME/photo
# Extract image URL
curl -sL "IMAGE_URL" -o images/username-original.jpg
```

### Generate Styled Version
Use image generation with appropriate prompt for your style/brand.

### Deliver
```bash
bird reply <tweet_id> "Made you something! 🎨" --media images/username-original.jpg --media images/username-styled.png
```

Include:
- Both images (before/after)
- Invite them to use it
- Ask for a repost to spread the word

## 8. Present Summary

```
🐦 X Check — {Date} {Time}

📬 NOTIFICATIONS
• {X} new mentions
• {Y} new followers
• {Z} DMs

✅ RESPONDED TO
• @user1 — Answered their question about X
• @user2 — Thanked for the kind words

👋 NEW FOLLOWERS ({count})
• @notable_person — {Bio snippet, why notable}
• {X} others

💬 ENGAGEMENT OPPORTUNITIES
• @user's thread on {topic} — Could add value
• Trending: #{hashtag} — Relevant to your niche?

📝 POSTING SUGGESTION
Based on recent engagement, consider posting about:
• {Topic that's resonating}
• {Follow-up to previous popular post}
```

## Tracking

```json
{
  "lastXCheck": "2026-02-09T14:30:00",
  "stats": {
    "mentionsToday": 15,
    "repliesSent": 8,
    "postsToday": 2,
    "newFollowers": 12
  }
}
```

## Notes

- Check 2-3x daily max — Don't live on the platform
- Batch engagement — 15-30 min sessions, not constant checking
- Quality interactions > vanity metrics
- Mute liberally, block rarely
- It's okay to not respond to everything
