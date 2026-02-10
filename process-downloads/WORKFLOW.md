---
name: process-downloads
description: Downloads folder cleanup — organizes files by type, removes duplicates, and archives old downloads. Use when the user says "clean up downloads", "organize downloads", "process downloads", or "my downloads folder is a mess".
---

# Process Downloads

Organize the Downloads folder by file type, remove duplicates, archive old files.

## 1. Inventory Downloads

Scan the Downloads folder:

```bash
ls -la ~/Downloads/ | head -50
```

Categorize files by type:
- **Documents:** `.pdf`, `.doc`, `.docx`, `.txt`, `.md`, `.csv`, `.xlsx`
- **Images:** `.png`, `.jpg`, `.jpeg`, `.gif`, `.svg`, `.webp`
- **Archives:** `.zip`, `.tar`, `.gz`, `.dmg`, `.pkg`
- **Code:** `.py`, `.js`, `.ts`, `.sh`, `.json`, `.yaml`
- **Media:** `.mp3`, `.mp4`, `.mov`, `.wav`

## 2. Organize by Type

Create category folders and move files:

```bash
mkdir -p ~/Downloads/_sorted/{documents,images,archives,code,media,other}
mv ~/Downloads/*.pdf ~/Downloads/_sorted/documents/
```

## 3. Remove Duplicates

Find files with identical names (with ` (1)`, ` (2)` suffixes):

```bash
find ~/Downloads -name "* (1)*" -o -name "* (2)*" -o -name "* (3)*"
```

Compare with the original and remove the duplicate if identical.

## 4. Archive Old Files

Find files older than 60 days that haven't been accessed:

```bash
find ~/Downloads -maxdepth 1 -type f -atime +60
```

Move them to `~/Downloads/_archive/YYYY-MM/`.

## After Running

Report:
- Files sorted by category (count per type)
- Duplicates removed
- Old files archived
- Space reclaimed

## Notes

- Don't touch files in existing subfolders — only process top-level files
- Ask before deleting anything that isn't an obvious duplicate
