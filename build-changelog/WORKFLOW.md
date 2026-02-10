---
name: build-changelog
description: Changelog generator — creates a formatted changelog from git history since the last tag or release. Use when the user says "build changelog", "generate changelog", "what changed since last release", or "release notes".
---

# Build Changelog

Generate a formatted changelog from git history since the last tag.

## 1. Find Last Tag

Get the most recent tag:

```bash
git describe --tags --abbrev=0 2>/dev/null
```

If no tags exist, use the first commit:

```bash
git rev-list --max-parents=0 HEAD
```

## 2. Gather Commits

Get all commits since the last tag:

```bash
git log --oneline --no-merges LAST_TAG..HEAD
```

For more detail:

```bash
git log --format="%h %s (%an, %ar)" --no-merges LAST_TAG..HEAD
```

## 3. Categorize Changes

Group commits by type based on commit message prefixes:
- **Features** — `feat:`, `add:`, `new:`
- **Bug Fixes** — `fix:`, `bugfix:`
- **Improvements** — `improve:`, `update:`, `enhance:`
- **Refactoring** — `refactor:`, `cleanup:`
- **Documentation** — `docs:`, `doc:`
- **Other** — everything else

If commits don't use conventional prefixes, categorize by reading the message.

## 4. Build Changelog

Format the changelog:

```markdown
# Changelog

## [Unreleased] — YYYY-MM-DD

### Features
- Description of feature ([commit hash])

### Bug Fixes
- Description of fix ([commit hash])

### Improvements
- Description of improvement ([commit hash])

### Other
- Description ([commit hash])

---
**X commits** by Y contributors since LAST_TAG
```

## After Running

Present the changelog. Offer to:
1. Save it to `CHANGELOG.md` in the repo
2. Copy it to clipboard for a GitHub release

## Notes

- Link commit hashes if the repo has a remote URL
- Combine related commits into single entries where it makes sense
- Keep descriptions user-facing — "added dark mode" not "refactored theme provider"
