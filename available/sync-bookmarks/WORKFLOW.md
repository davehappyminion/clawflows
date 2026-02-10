---
name: sync-bookmarks
description: Bookmark maintenance — checks bookmarks for dead links, removes duplicates, and organizes by topic.
triggers:
  - sync bookmarks
  - check bookmarks
  - bookmark cleanup
  - dead links
---

# Sync Bookmarks

Check bookmarks for dead links, remove duplicates, organize by topic.

## 1. Export Bookmarks

Using your **browser skill** or file system, get bookmarks from the default browser:
- Chrome, Safari, Firefox, or other installed browser
- All bookmarks including folders

## 2. Check for Dead Links

Test each bookmark URL:
- **200** — Alive, working
- **301/302** — Redirect (update the URL)
- **404** — Dead (flag for removal)
- **Timeout** — May be temporarily down (flag for review)

Rate limit checks to avoid being blocked (1 request per second).

## 3. Find Duplicates

Check for:
- Identical URLs
- URLs that differ only by trailing slash
- Same URL with different protocols (http vs https)
- Same domain + path with different query parameters

## 4. Organize by Topic

Suggest folder organization based on bookmark content:
- **Dev/Programming** — GitHub, Stack Overflow, documentation
- **News/Reading** — News sites, blogs, articles
- **Tools/Apps** — Web apps, SaaS tools
- **Reference** — Wikipedia, docs, tutorials
- **Shopping** — Retail sites
- **Social** — Social media links
- **Misc** — Everything else

## 5. Present Findings

```
🔖 Bookmark Audit

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📊 SUMMARY
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
• Total bookmarks: 342
• Dead links: 18
• Duplicates: 12
• Redirects to update: 8

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
💀 DEAD LINKS (18)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
• old-blog.com/article — 404
• defunct-startup.io — Domain expired
• example.com/removed — 404
...

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🔄 REDIRECTS (8)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
• http://github.com → https://github.com
• old-domain.com → new-domain.com
...

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
👥 DUPLICATES (12)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
• github.com — 3 copies
• stackoverflow.com — 2 copies
...

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📁 SUGGESTED REORGANIZATION
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
• 45 bookmarks → Dev/Programming
• 28 bookmarks → News/Reading
• 15 bookmarks → Tools/Apps
...
```

## 6. Offer Actions

For each finding:
- **Remove** — Delete dead links
- **Update** — Fix redirect URLs
- **Dedupe** — Remove duplicate entries
- **Reorganize** — Move to suggested folders

## Notes

- Don't delete bookmarks automatically — present findings for review
- Some sites block HEAD requests — fall back to GET if needed
- Run quarterly for maintenance
