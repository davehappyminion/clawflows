---
name: check-disk
description: Disk space audit — finds large files, bloated caches, and recommends cleanup actions.
---

# Check Disk

Disk space audit — large files, caches, and cleanup recommendations.

## 1. Overall Disk Usage

Check available space:

```bash
df -h /
```

Get top-level space usage:

```bash
du -sh ~/* 2>/dev/null | sort -rh | head -20
```

## 2. Find Large Files

Look for files over 500MB:

```bash
find ~ -type f -size +500M -not -path "*/Library/*" -not -path "*/.Trash/*" 2>/dev/null
```

Check Downloads for large forgotten files:

```bash
du -sh ~/Downloads/* 2>/dev/null | sort -rh | head -20
```

## 3. Check Caches

Audit common cache locations:

```bash
du -sh ~/Library/Caches/* 2>/dev/null | sort -rh | head -10
du -sh ~/.npm 2>/dev/null
du -sh ~/.cache 2>/dev/null
du -sh ~/Library/Developer/Xcode/DerivedData 2>/dev/null
du -sh ~/Library/Developer/CoreSimulator 2>/dev/null
```

## 4. Check Homebrew

Find old Homebrew versions:

```bash
brew cleanup --dry-run 2>/dev/null
```

## 5. Check Docker

If Docker is installed, check image/container space:

```bash
docker system df 2>/dev/null
```

## After Running

Report:
- Total disk usage and available space
- Top 10 space consumers in home directory
- Large files that could be removed
- Cache sizes and cleanup recommendations
- Estimated space recoverable

Provide cleanup commands for each recommendation.

## Notes

- Don't delete anything automatically — present recommendations with commands
- Be cautious about Library folders — some caches are important
- Distinguish between safe-to-delete and needs-review items
