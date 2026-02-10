---
name: check-repos
description: Git repo health check — scans local repos for uncommitted changes, stale branches, and unpushed commits.
---

# Check Repos

Scan local git repos for uncommitted changes, stale branches, and unpushed commits.

## 1. Find Git Repos

Scan common locations for git repositories:

```bash
find ~/Projects ~/Developer ~/Code ~/repos ~/src -maxdepth 3 -name ".git" -type d 2>/dev/null
```

Also check the home directory:

```bash
find ~ -maxdepth 2 -name ".git" -type d 2>/dev/null
```

## 2. Check Each Repo

For each repository found:

### Uncommitted Changes
```bash
cd /path/to/repo && git status --porcelain
```

### Unpushed Commits
```bash
git log --oneline @{u}..HEAD 2>/dev/null
```

### Stale Branches
```bash
git branch --merged main | grep -v "main\|master\|\*"
git branch -v | grep '\[gone\]'
```

### Last Commit Date
```bash
git log -1 --format="%ar" 2>/dev/null
```

## 3. Summarize Findings

Group repos by status:
- **Needs attention** — uncommitted changes or unpushed commits
- **Has stale branches** — merged branches that can be cleaned up
- **Clean** — everything committed and pushed

## After Running

Report:
- Total repos scanned
- Repos with uncommitted changes (list files)
- Repos with unpushed commits (count per repo)
- Stale branches that can be deleted
- Repos that haven't been touched in over 30 days

## Notes

- Don't make any changes — just report what you find
- Skip repos inside `node_modules`, `.cache`, or other dependency folders
