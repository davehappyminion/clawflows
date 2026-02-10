---
name: process-screenshots
description: Screenshot organizer — sorts screenshots from Desktop and Downloads into dated folders, identifies duplicates, and deletes old ones.
---

# Process Screenshots

Sort screenshots into `~/Pictures/Screenshots/YYYY-MM/`, remove duplicates, clean up old ones.

## 1. Find Screenshots

Scan these locations for screenshot files:

```bash
find ~/Desktop ~/Downloads -maxdepth 1 -name "Screenshot*" -o -name "Screen Shot*" -o -name "CleanShot*" 2>/dev/null
```

Also check for common screenshot patterns: `*.png` files with timestamps in the name.

## 2. Organize by Date

For each screenshot:
1. Extract the date from the filename or file metadata
2. Create the target folder if needed: `~/Pictures/Screenshots/YYYY-MM/`
3. Move the file:

```bash
mkdir -p ~/Pictures/Screenshots/2026-02/
mv ~/Desktop/Screenshot\ 2026-02-09.png ~/Pictures/Screenshots/2026-02/
```

## 3. Remove Duplicates

Check for duplicate files by comparing sizes and names:

```bash
find ~/Pictures/Screenshots -name "Screenshot*" -type f | sort
```

Flag any files with identical sizes and similar names for removal.

## 4. Clean Up Old Screenshots

List screenshots older than 90 days:

```bash
find ~/Pictures/Screenshots -type f -mtime +90
```

Report how many old screenshots were found and ask before deleting.

## After Running

Report:
- How many screenshots were moved (and from where)
- How many duplicates found and removed
- How many old screenshots flagged for cleanup
- Total space saved

## Notes

- Never delete without confirming first (except obvious duplicates)
- Preserve original filenames — just move them into dated folders
