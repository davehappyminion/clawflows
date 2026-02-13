---
name: check-dependencies
emoji: 📦
description: Weekly supply chain hygiene — scans projects for outdated dependencies, known CVEs, and available updates across npm, pip, cargo, and brew.
author: @davehappyminion
schedule: "monday 8am"
---

# Check Dependencies

Scan local projects for outdated packages, known vulnerabilities, and available major/minor/patch updates. Covers npm, pip, cargo, and Homebrew.

## 1. Discover Projects

Locate projects with dependency manifests. Search the user's workspace and common project directories:

```
find ~/.openclaw/workspace ~/Projects ~/src -maxdepth 3 \
  -name "package.json" -o -name "requirements.txt" -o -name "Pipfile" \
  -o -name "pyproject.toml" -o -name "Cargo.toml" -o -name "go.mod" \
  2>/dev/null
```

- Group results by project root directory.
- Note the package manager type for each project.
- Skip `node_modules`, `.venv`, `target`, and other build artifact directories.

## 2. Check for Outdated Packages

Run the appropriate outdated check for each project type:

- **npm/yarn:** `npm outdated --json` or `yarn outdated --json` in the project root.
- **pip:** `pip list --outdated --format=json` (use the project's venv if one exists).
- **cargo:** `cargo outdated --format json` if `cargo-outdated` is installed, otherwise note it is unavailable.
- **Homebrew:** `brew outdated --json` (run once, globally).

For each outdated package, record: name, current version, latest version, and whether the update is major, minor, or patch.

## 3. Scan for Known Vulnerabilities

Run security audit tools where available:

- **npm:** `npm audit --json`
- **pip:** `pip-audit --format=json` if installed, or `safety check --json` as fallback.
- **cargo:** `cargo audit --json` if `cargo-audit` is installed.
- **Homebrew:** No built-in audit; skip.

For each vulnerability found, record: package name, severity (critical/high/medium/low), CVE ID if available, and whether a fix version exists.

## 4. Classify Results

Group findings into priority tiers:

- **Critical** — Known CVEs with severity high or critical, especially with fix versions available.
- **Stale** — Major version behind (e.g., v3.x when v5.x is out). Likely needs migration effort.
- **Updatable** — Minor or patch updates available, no known vulnerabilities. Low-risk updates.
- **Clean** — Project is fully up to date with no known issues.

## 5. Present Findings

```
## Dependency Report — <date>

### Vulnerabilities Found (X)
| Project | Package | Severity | CVE | Current | Fix Version |
|---------|---------|----------|-----|---------|-------------|
| ...     | ...     | HIGH     | ... | 1.2.3   | 1.2.5       |

### Major Updates Available (X)
| Project | Package | Current | Latest | Type  |
|---------|---------|---------|--------|-------|
| ...     | ...     | 2.1.0   | 4.0.0  | major |

### Minor/Patch Updates (X)
| Project | Package | Current | Latest | Type  |
|---------|---------|---------|--------|-------|
| ...     | ...     | 3.1.0   | 3.2.1  | minor |

### Clean Projects (X)
- project-name (npm) — all up to date
- project-name (cargo) — all up to date

### Skipped / Errors
- project-name: reason (e.g., no lockfile, tool not installed)

**Summary:** Scanned X projects. Y vulnerabilities found (Z critical).
W packages have updates available.
```

## Notes

- This workflow is read-only. It does NOT install, update, or modify any packages.
- If a project has a lockfile but no `node_modules` or `.venv`, note that dependencies are not installed and audit results may be incomplete.
- `cargo-outdated` and `cargo-audit` are optional cargo subcommands. If missing, suggest installing them.
- `pip-audit` is preferred over `safety` for pip projects. If neither is installed, skip the vulnerability scan for that project and note it.
- For monorepos with multiple `package.json` files, check each workspace root individually.
- Homebrew is checked once globally, not per-project.
- When reporting CVEs, include a link to the advisory if the audit tool provides one.
