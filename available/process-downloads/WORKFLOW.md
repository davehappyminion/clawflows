---
name: process-downloads
emoji: 📥
description: Downloads folder cleanup — organizes files by type, removes duplicates, and archives old downloads.
triggers:
  - process downloads
  - clean downloads
  - organize downloads
  - downloads folder
---

# Process Downloads

Organize the Downloads folder by file type, remove duplicates, archive old files.

## 1. Inventory Downloads

Using your **file system skill**, scan the Downloads folder:
- List all files (top-level only)
- Note file types, sizes, and dates
- Count total files and space used

## 2. Categorize by Type

Group files into categories:
- **Documents:** PDF, DOC, DOCX, TXT, MD, CSV, XLSX
- **Images:** PNG, JPG, JPEG, GIF, SVG, WEBP
- **Archives:** ZIP, TAR, GZ, DMG, PKG
- **Code:** PY, JS, TS, SH, JSON, YAML
- **Media:** MP3, MP4, MOV, WAV
- **Other:** Everything else

## 3. Organize Files

Create category folders and move files:
- `~/Downloads/_sorted/documents/`
- `~/Downloads/_sorted/images/`
- `~/Downloads/_sorted/archives/`
- etc.

Or use the user's preferred organization scheme.

## 4. Remove Duplicates

Find duplicate files:
- Files with `(1)`, `(2)`, `(3)` suffixes
- Files with identical sizes and similar names
- Compare checksums if needed

Remove duplicates, keeping the original.

## 5. Archive Old Files

Find files older than 60 days that haven't been accessed:
- Move to `~/Downloads/_archive/YYYY-MM/`
- Or flag for user review

## 6. Present Results

```
📥 Downloads Cleanup

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📊 BEFORE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
• Files: 234
• Size: 8.7 GB
• Oldest: 6 months ago

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📁 SORTED
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
• Documents: 45 files → _sorted/documents/
• Images: 89 files → _sorted/images/
• Archives: 23 files → _sorted/archives/
• Other: 12 files → _sorted/other/

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🗑️ CLEANED
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
• Duplicates removed: 18 files (450 MB)
• Archived (60+ days): 34 files (1.2 GB)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅ AFTER
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
• Space recovered: 1.65 GB
• Downloads folder: Clean!
```

## Notes

- Don't touch files in existing subfolders — only process top-level files
- Ask before deleting anything that isn't an obvious duplicate
- Run weekly or monthly for maintenance
