---
name: send-morning-quote
description: Morning inspiration — delivers an uplifting quote to start the day, optionally themed to your goals or current challenges.
requires:
  - name: telegram
    description: Telegram messaging
---

# Morning Quote

Start the day with inspiration. A carefully chosen quote delivered to your inbox.

## 1. Select a Quote

Choose a quote that fits:

### Default: Timeless Wisdom
Pull from a collection of motivational quotes — stoic philosophy, entrepreneurship, creativity, perseverance.

### Personalized Options
If you know the user's current focus:
- **Building something:** Quotes about shipping, iteration, starting before you're ready
- **Struggling:** Quotes about resilience, failure as learning, persistence
- **Big week ahead:** Quotes about focus, priorities, saying no
- **Feeling good:** Quotes about gratitude, momentum, paying it forward

### Quote Sources
- Classic philosophers (Marcus Aurelius, Seneca, Epictetus)
- Modern thinkers (Naval Ravikant, Paul Graham, Seth Godin)
- Builders and creators (Steve Jobs, Elon Musk, Sahil Lavingia)
- Writers (Anne Lamott, Stephen King, Steven Pressfield)

## 2. Format the Message

```
☀️ Good morning!

"{Quote text}"
— {Author}

{Optional: One sentence connecting it to their day/goals}

Have a great {day of week}!
```

Keep it short. The quote should breathe.

## 3. Deliver

Send via messaging:

```bash
telegram send --message "QUOTE_CONTENT"
```

## Tracking

Track delivery to avoid duplicates:

```json
{
  "lastMorningQuote": "2026-02-09",
  "recentQuotes": ["quote_id_1", "quote_id_2"]
}
```

- Only send if `lastMorningQuote` is not today
- Don't repeat quotes from `recentQuotes` (keep last 30)

## Notes

- Schedule via cron for early morning (e.g., 6:30-7:00 AM)
- Deliver BEFORE the morning briefing — inspiration first, logistics second
- Rotate themes weekly to keep it fresh
- If the user replies with feedback ("love this" or "meh"), learn their preferences
