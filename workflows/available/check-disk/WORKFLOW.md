---
name: check-disk
emoji: 💾
description: Disk space audit — finds large files, bloated caches, and recommends cleanup actions.
---

# Check Disk

Disk space audit — large files, caches, and cleanup recommendations.

## 1. Overall Disk Usage

Using your **file system skill**, check available disk space:
- Total disk size
- Used space
- Available space
- Percentage used

Flag if usage is above 80%.

## 2. Top Space Consumers

Find the largest directories in the home folder:
- Top 10-20 space consumers
- Grouped by category (Documents, Downloads, Code, etc.)

## 3. Find Large Files

Look for files over 500MB:
- Exclude system/library folders
- Focus on user-created files
- Note file type and last accessed date

Check Downloads folder specifically for large forgotten files.

## 4. Audit Caches

Check common cache locations:
- Browser caches
- Package manager caches (npm, pip, homebrew)
- IDE caches (Xcode DerivedData, etc.)
- System caches

Report sizes and recommend which can be cleared.

## 5. Check Development Tools

If applicable, audit:
- Docker images and containers
- Virtual machines
- Old node_modules folders
- Build artifacts

## 6. Present Findings

Report the audit:

```
💾 Disk Space Audit

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📊 OVERVIEW
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Total: 500 GB
Used: 412 GB (82%) ⚠️
Available: 88 GB

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📁 TOP SPACE CONSUMERS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
1. ~/Library — 45 GB
2. ~/Documents — 38 GB
3. ~/Projects — 32 GB
...

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🗑️ CLEANUP OPPORTUNITIES
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
• npm cache: 8.2 GB — Safe to clear
• Xcode DerivedData: 12 GB — Safe to clear
• Old Downloads: 4.5 GB — Review needed
• Docker images: 15 GB — Review needed

Estimated recoverable: ~25 GB
```

## 7. Provide Cleanup Commands

For each recommendation, provide the command to clean it up.

## Notes

- Don't delete anything automatically — present recommendations with commands
- Be cautious about Library folders — some caches are important
- Distinguish between safe-to-delete and needs-review items
- Schedule monthly for maintenance
