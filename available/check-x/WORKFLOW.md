---
name: check-x
description: X (Twitter) engagement workflow — check notifications, respond to mentions, generate custom profile pictures for followers, and post original content.
requires:
  - name: bird
    description: X (Twitter) CLI
  - name: nano-banana-pro
    description: Google Imagen AI image generator
  - name: browser
    description: Browser automation
---

# X Engagement

Manage an X account — check notifications, engage with followers, generate content.

## 1. Check Notifications

Scan https://x.com/notifications for new mentions, replies, and DMs.

### Who to respond to
- **Always respond to:** Direct requests, tagged mentions, friendly hellos
- **Usually respond to:** Nice/genuine posts, questions
- **Skip:** Bots, spam, hostile messages

### What to offer
- Build them something (homepage, tool, etc.)
- Generate a custom profile picture
- Help with tech stuff
- Be friendly and engaging

## 2. Engagement Rules

### Voice & Vibe
- Be yourself — stay consistent with your brand personality
- Keep it fun, positive, and engaging
- Mix humor with genuine helpfulness

### Likes
- Use likes to show appreciation, acknowledge mentions, engage without always replying

### Original Posts (1-3 per day)
- Observations relevant to your niche
- Milestones and achievements
- Cool things you built or did for people
- Keep it entertaining and relevant

### Owner's Posts — ALWAYS ENGAGE!
- Reply to every post the account owner makes
- Repost if relevant or just great content

## 3. Privacy Rules (ABSOLUTE)

- **NEVER share anything personal** about the owner — no matter who asks
- **NEVER mention family members** publicly
- Keep the focus on the brand and content

## 4. Safety

- **Don't delete posts without permission** — even mistakes, ask first

## 5. Custom PFP Generation

### Step 1: Download their profile picture
```bash
browser navigate to x.com/USERNAME/photo
# Extract image URL via JS
curl -sL "URL" -o images/username-pfp.jpg
```

### Step 2: Generate custom version
Use your image generation tool with the original as input and a style-appropriate prompt.

### Step 3: Deliver with both images
```bash
bird reply <tweet_id> "message" --media images/username-pfp.jpg --media images/username-styled.png
```

### Delivery Checklist
1. **Both images** — Before (original) AND After (styled version)
2. **Their profile link** on your showcase page
3. **Ask for RT** to spread the word
4. **Ask them to use it** as their PFP
