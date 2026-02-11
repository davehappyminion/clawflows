---
name: rotate-logs
emoji: 📜
description: Log rotation and hygiene — checks log files across projects and system locations, archives old logs, flags fast-growing files, and reports disk usage.
---

# Rotate Logs

Audit log files across project directories and system locations. Identify large logs, archive old ones, flag anything growing suspiciously fast, and report total disk space consumed by logs.

## 1. Define Search Locations

Scan these locations for log files:

- `~/.openclaw/logs/`
- `~/Library/Logs/` (macOS user logs)
- `/usr/local/var/log/` (Homebrew service logs)
- Project directories: search for `*.log`, `*.log.*`, and `logs/` directories in `~/Projects`, `~/src`, and `~/.openclaw/workspace`.
- Docker container logs if Docker is running: `docker inspect --format='{{.LogPath}}' $(docker ps -q)`

Do NOT scan:
- `/var/log/` system logs (requires root; skip unless the user explicitly asks).
- `node_modules`, `.venv`, `target`, or other dependency/build directories.

## 2. Inventory All Log Files

For each log file found, record:

- Full path
- File size (human-readable)
- Last modified date
- Age (days since last modification)
- Owner (project or system component)

Sort by size descending. Use:

```
find <path> -name "*.log" -o -name "*.log.*" -o -name "*.log.gz" | \
  xargs stat -f "%z %m %N" 2>/dev/null | sort -rn
```

## 3. Detect Fast Growers

Check if any log file has grown significantly in the last 24 hours. Compare current size against what the filesystem reports:

```
find <path> -name "*.log" -mtime -1 -size +10M
```

- Flag any log file over 10 MB that was modified in the last 24 hours as a "fast grower."
- Flag any log file over 100 MB regardless of age as "oversized."
- If a log file exceeds 500 MB, mark it as **critical** and highlight it in the report.

## 4. Classify Log Files

Group each log into a category:

- **Critical** — Over 500 MB, or growing fast and already large. Needs immediate attention.
- **Oversized** — Over 100 MB. Should be rotated or archived.
- **Stale** — Not modified in 30+ days and over 1 MB. Safe to archive or delete.
- **Active** — Modified recently, reasonable size. Leave alone.
- **Already Rotated** — Files matching `*.log.1`, `*.log.gz`, `*.log.*.gz`. Informational.

## 5. Archive Stale Logs

For logs classified as Stale or Oversized, offer to compress them:

```
gzip -k <logfile>  # keeps original, creates .gz alongside it
```

- **ASK the user before archiving.** Present the list of files to be compressed.
- After compression, report the space saved per file.
- Do NOT delete originals unless the user explicitly asks. The `-k` flag keeps them.

## 6. Present Findings

```
## Log Rotation Report — <date>

### Disk Usage by Logs
| Location | File Count | Total Size |
|----------|-----------|------------|
| ~/.openclaw/logs/ | X | Y MB |
| ~/Library/Logs/ | X | Y MB |
| Project logs | X | Y MB |
| Docker logs | X | Y MB |
| **Total** | X | **Y MB** |

### Critical (X) -- needs attention
| File | Size | Last Modified | Growth |
|------|------|---------------|--------|
| /path/to/file.log | 650 MB | today | +120 MB/day |

### Oversized (X)
| File | Size | Last Modified |
|------|------|---------------|
| /path/to/file.log | 150 MB | 3 days ago |

### Stale (X) -- safe to archive
| File | Size | Last Modified | Age |
|------|------|---------------|-----|
| /path/to/file.log | 12 MB | 45 days ago | 45d |

### Active (X)
| File | Size | Last Modified |
|------|------|---------------|
| /path/to/file.log | 2 MB | today |

### Already Rotated (X)
- /path/to/file.log.1.gz (4 MB)
- /path/to/file.log.2.gz (3 MB)

### Space Savings (if archived)
| File | Original | Compressed | Saved |
|------|----------|-----------|-------|
| ...  | 150 MB   | 12 MB     | 138 MB |

**Summary:** X log files found using Y MB total.
Z files flagged for attention. W files are stale and archivable.
```

## Notes

- This workflow does NOT delete log files unless the user explicitly requests it. Compression with `gzip -k` is the default safe action.
- On macOS, `stat` syntax differs from Linux. Use `stat -f "%z %m %N"` (BSD) not `stat -c` (GNU).
- Docker container logs can grow unbounded if the logging driver does not set `max-size`. If large Docker logs are found, suggest adding log rotation to the Docker daemon config (`/etc/docker/daemon.json`).
- Some applications (like Homebrew services) write to fixed log paths and do not handle external rotation. Note this when recommending compression of active service logs.
- If `logrotate` is installed, check `/etc/logrotate.d/` for existing rotation configs and mention them in the report to avoid conflicts.
- Consider suggesting the user set up a scheduled run of this workflow if log growth is a recurring problem.
