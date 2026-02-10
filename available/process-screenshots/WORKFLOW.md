---
name: process-screenshots
emoji: 📸
description: Screenshot organizer — sorts screenshots from Desktop and Downloads into dated folders, identifies duplicates, and deletes old ones.
---

# Process Screenshots

Sort screenshots into dated folders, remove duplicates, clean up old ones.

## 1. Find Screenshots

Using your **file system skill**, scan for screenshot files:
- Desktop
- Downloads
- Default screenshot location

Look for common screenshot patterns:
- "Screenshot" or "Screen Shot" in filename
- "CleanShot" or other screenshot tool names
- PNG files with timestamp patterns

## 2. Organize by Date

For each screenshot:
1. Extract the date from the filename or file metadata
2. Create the target folder: `~/Pictures/Screenshots/YYYY-MM/`
3. Move the file to the appropriate folder

Preserve original filenames.

## 3. Remove Duplicates

Check for duplicate files:
- Files with identical sizes and similar timestamps
- Files with `(1)`, `(2)` suffixes
- Near-identical screenshots (if image comparison available)

Remove duplicates, keeping the oldest (original).

## 4. Clean Up Old Screenshots

Find screenshots older than 90 days:
- List them for review
- Offer to delete or archive

Most screenshots are temporary — old ones are rarely needed.

## 5. Present Results

```
📸 Screenshot Cleanup

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📊 FOUND
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
• Desktop: 23 screenshots
• Downloads: 8 screenshots
• Total: 31 screenshots (145 MB)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📁 ORGANIZED
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
• → ~/Pictures/Screenshots/2026-02/ (15 files)
• → ~/Pictures/Screenshots/2026-01/ (12 files)
• → ~/Pictures/Screenshots/2025-12/ (4 files)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🗑️ CLEANED
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
• Duplicates removed: 5 files (12 MB)
• Old (90+ days): 8 files flagged for review

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅ RESULT
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Desktop: Clean!
Downloads: Clean!
Space saved: 12 MB
```

## Notes

- Never delete without confirming first (except obvious duplicates)
- Preserve original filenames — just organize into folders
- Run weekly to keep Desktop and Downloads clean
- Consider changing default screenshot location to ~/Pictures/Screenshots/
