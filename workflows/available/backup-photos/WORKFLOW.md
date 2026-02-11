---
name: backup-photos
emoji: 📷
description: Organize and deduplicate photos from Desktop, Downloads, and common locations. Sort by date, separate screenshots from real photos, identify duplicates. Always asks before deleting.
---

# Backup Photos

Find, organize, and deduplicate photos scattered across the filesystem. Sort them into a clean structure, separate screenshots from real photos, and identify duplicates. This workflow never deletes anything without explicit permission.

## 1. Scan Source Locations

Search the following directories for image files:
1. `~/Desktop`
2. `~/Downloads`
3. `~/Documents/Photos` (or any configured photo directories)
4. `~/Pictures`
5. Any additional paths the user specifies

Look for files matching these extensions: `.jpg`, `.jpeg`, `.png`, `.heic`, `.heif`, `.raw`, `.cr2`, `.nef`, `.dng`, `.tiff`, `.webp`, `.gif`, `.mp4`, `.mov` (for video alongside photos).

Report what was found:
- Total number of image/video files
- Breakdown by location
- Total size on disk
- Date range (oldest to newest)

## 2. Classify Files

Categorize each file into one of these buckets:
- **Photos** — Real camera/phone photos (check EXIF data for camera model, GPS, etc.)
- **Screenshots** — Screen captures (typically exact screen dimensions, no EXIF camera data, filenames starting with "Screenshot" or "Screen Shot")
- **Downloads** — Images downloaded from the web (no camera EXIF, often in Downloads folder)
- **Memes/Social** — Low-resolution images, typically saved from messaging apps or social media
- **Videos** — Video files co-located with photos
- **Unknown** — Cannot be classified confidently

Present the classification summary before proceeding.

## 3. Detect Duplicates

Identify duplicate files using a multi-pass approach:
1. **Exact duplicates** — Files with identical content (compare by hash, e.g., SHA-256)
2. **Near-duplicates** — Photos that are visually very similar (burst shots, minor edits, different resolutions of the same image)
3. **Cross-format duplicates** — Same photo saved as both HEIC and JPG, or RAW + JPG pairs

For each duplicate group, identify the "best" version:
- Prefer highest resolution
- Prefer original format (RAW > HEIC > JPG)
- Prefer the version with intact EXIF metadata
- Prefer the version with the earliest modification date

## 4. Propose Organization Structure

Suggest a target directory structure:

```
~/Pictures/Organized/
  Photos/
    2025/
      2025-01/
      2025-02/
      ...
    2026/
      2026-01/
      2026-02/
  Screenshots/
    2025/
    2026/
  Videos/
    2025/
    2026/
  Downloads/
    [unsorted web images]
  Duplicates/
    [duplicates staged here, not deleted]
```

Present the proposed structure and ask the user to confirm or customize it.

## 5. Present Action Plan

Before moving or touching any files, present a complete action plan:

```
# Photo Backup — Action Plan

## Files Found
- Total files: [N]
- Photos: [N] ([size])
- Screenshots: [N] ([size])
- Videos: [N] ([size])
- Downloads: [N] ([size])
- Unknown: [N] ([size])

## Duplicates Found
- Exact duplicates: [N] groups ([N] files, [size] recoverable)
- Near-duplicates: [N] groups ([N] files)
- Cross-format pairs: [N]

## Proposed Actions
1. Move [N] photos to ~/Pictures/Organized/Photos/ (sorted by date)
2. Move [N] screenshots to ~/Pictures/Organized/Screenshots/
3. Move [N] videos to ~/Pictures/Organized/Videos/
4. Stage [N] duplicate files in ~/Pictures/Organized/Duplicates/
5. Leave [N] unknown files in place (manual review needed)

## Space Impact
- Current total size: [size]
- After dedup (if duplicates removed): [size] ([size] saved)

Proceed? (yes / yes with changes / no)
```

**Do NOT proceed without explicit user confirmation.**

## 6. Execute Organization

Once the user approves:
1. Create the target directory structure
2. Copy (not move) files to their new locations first
3. Verify each copy succeeded (compare file hashes)
4. Only after all copies are verified, remove originals from source locations
5. Move duplicates to the Duplicates staging folder — do NOT delete them

Report progress as you go for large batches.

## 7. Present Final Report

```
# Photo Backup — Complete

## Summary
- Files organized: [N]
- Photos sorted: [N] across [N] months
- Screenshots sorted: [N]
- Videos sorted: [N]
- Duplicates staged for review: [N] ([size])
- Errors: [N]

## Duplicates Pending Review
The following duplicate groups are in ~/Pictures/Organized/Duplicates/:
- [filename] — duplicate of [original path]
- [filename] — duplicate of [original path]
[...]

Review these files and delete them when you're satisfied.

## Errors (if any)
- [file path] — [error description]

## Next Steps
- Review the Duplicates folder and delete when ready
- Review Unknown files manually
- Consider setting up automatic photo import rules to avoid future scatter
```

## Safety Rules

- **NEVER delete any file without explicit user permission.** Duplicates are moved to a staging folder, not deleted.
- **NEVER overwrite an existing file.** If a name conflict occurs in the target directory, append a suffix.
- **Always copy-then-verify-then-remove.** Never move directly — protect against data loss from interrupted operations.
- **Preserve all EXIF metadata.** Do not strip or modify metadata during copy operations.
- **Do not process files in system directories** (e.g., `/Library`, `/System`, application bundles).
- **Stop and ask if total file count exceeds 10,000** — confirm the user wants to proceed with a large batch.

## Notes

- This workflow is on-demand only. No schedule.
- For very large photo libraries (10,000+ files), consider running in phases (one source directory at a time).
- HEIC to JPG conversion can be offered but should not be done by default — some users prefer to keep originals.
- The Duplicates folder is a safety net. Remind the user it exists and suggest periodic cleanup.
- This workflow does not upload to any cloud service. It is local filesystem organization only.
