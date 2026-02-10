---
name: sync-bookmarks
description: Bookmark maintenance — checks bookmarks for dead links, removes duplicates, and organizes by topic.
---

# Sync Bookmarks

Check bookmarks for dead links, remove duplicates, organize by topic.

## 1. Export Bookmarks

Get bookmarks from the default browser:

### Chrome
```bash
cat ~/Library/Application\ Support/Google/Chrome/Default/Bookmarks | python3 -m json.tool
```

### Safari
```bash
plutil -convert json -o - ~/Library/Safari/Bookmarks.plist 2>/dev/null
```

### Firefox
```bash
find ~/Library/Application\ Support/Firefox/Profiles -name "places.sqlite" 2>/dev/null
```

## 2. Check for Dead Links

Test each bookmark URL:

```bash
curl -sL -o /dev/null -w "%{http_code}" "URL" --max-time 10
```

Categorize results:
- **200** — alive
- **301/302** — redirect (update the URL)
- **404** — dead (flag for removal)
- **Timeout** — may be temporarily down (flag for review)

## 3. Find Duplicates

Check for:
- Identical URLs
- URLs that differ only by trailing slash or protocol (http vs https)
- Same domain + path with different query parameters

## 4. Organize by Topic

Suggest folder organization based on bookmark content:
- **Dev/Programming** — GitHub, Stack Overflow, documentation sites
- **News/Reading** — news sites, blogs, articles
- **Tools/Apps** — web apps, SaaS tools
- **Reference** — Wikipedia, docs, tutorials
- **Shopping** — retail sites
- **Social** — social media links

## After Running

Report:
- Total bookmarks scanned
- Dead links found (with URLs)
- Duplicates identified
- Suggested reorganization
- Links with updated URLs (redirects)

## Notes

- Don't delete bookmarks automatically — present findings for review
- Rate limit URL checks to avoid being blocked (1 request per second)
- Some sites block HEAD requests — fall back to GET if needed
