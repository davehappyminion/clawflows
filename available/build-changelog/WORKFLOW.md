---
name: build-changelog
emoji: 📝
description: Changelog generator — creates a formatted changelog from git history since the last tag or release.
triggers:
  - build changelog
  - generate changelog
  - what changed
  - release notes
---

# Build Changelog

Generate a formatted changelog from git history since the last tag.

## 1. Find Last Tag

Using **git**, find the most recent tag:
- Look for semantic version tags (v1.0.0, 1.2.3, etc.)
- If no tags exist, use the first commit as the starting point

## 2. Gather Commits

Get all commits since the last tag:
- Exclude merge commits (focus on actual changes)
- Include commit hash, message, author, and date

## 3. Categorize Changes

Group commits by type based on commit message patterns:

### Categories
- **Features** — `feat:`, `add:`, `new:`
- **Bug Fixes** — `fix:`, `bugfix:`
- **Improvements** — `improve:`, `update:`, `enhance:`
- **Refactoring** — `refactor:`, `cleanup:`
- **Documentation** — `docs:`, `doc:`
- **Other** — everything else

If commits don't use conventional prefixes, categorize by reading the message content.

## 4. Build the Changelog

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

## 5. Present and Save

Present the changelog. Offer to:
1. Save it to `CHANGELOG.md` in the repo
2. Copy it to clipboard for a GitHub release
3. Append to existing changelog

## Notes

- Link commit hashes if the repo has a remote URL
- Combine related commits into single entries where it makes sense
- Keep descriptions user-facing — "added dark mode" not "refactored theme provider"
- If the repo uses conventional commits, categorization is automatic
