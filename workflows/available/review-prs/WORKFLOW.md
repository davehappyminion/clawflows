---
name: review-prs
emoji: "\U0001F4CB"
description: Daily PR hygiene — scans open PRs across GitHub repos for stale reviews, new comments, merge-ready approvals, and CI failures.
schedule: "9am"
---

# Review PRs

Scan all open pull requests across the user's GitHub repos. Surface what needs attention: stale PRs, new activity, merge-ready approvals, and failing checks.

## 1. Discover Repos

Use `gh` to get the list of repos the user owns or contributes to:

```
gh repo list --limit 100 --json nameWithOwner,isArchived
```

- Exclude archived repos.
- If the user has a config file specifying watched repos, prefer that list over the full enumeration.
- Note the total repo count for the report.

## 2. Fetch Open PRs

For each repo, pull all open PRs:

```
gh pr list --repo <owner/repo> --state open --json number,title,author,createdAt,updatedAt,reviewDecision,isDraft,labels,headRefName,url,reviewRequests,statusCheckRollup
```

- Record author, age (days since creation), last update time, review status, and CI status.
- Skip draft PRs in the main triage but list them separately.

## 3. Classify Each PR

Sort every PR into exactly one category:

- **Ready to Merge** — `reviewDecision` is `APPROVED` and all status checks pass. These can be merged now.
- **Needs Review** — No reviews yet, or reviews are pending. Note who was requested.
- **Changes Requested** — A reviewer asked for changes. Note who and when.
- **Stale** — No update in 7+ days and not approved. Flag these for follow-up.
- **Failing CI** — Status checks are failing regardless of review state. Note which checks failed.
- **Draft** — PR is marked as draft. List separately as informational.

## 4. Check for New Comments

For PRs updated in the last 24 hours, fetch recent comments:

```
gh api repos/<owner>/<repo>/pulls/<number>/comments --jq '.[].body' | head -5
```

- Flag PRs with new comments since the user's last activity on them.
- Summarize the comment thread briefly (who said what, any action items).

## 5. Present Findings

```
## PR Review — <date>

### Ready to Merge (X)
| Repo | PR | Title | Approved By | Age |
|------|----|-------|-------------|-----|
| ...  | #N | ...   | @reviewer   | Xd  |

### Needs Review (X)
| Repo | PR | Title | Waiting On | Age |
|------|----|-------|------------|-----|
| ...  | #N | ...   | @reviewer  | Xd  |

### Changes Requested (X)
| Repo | PR | Title | Requested By | Since |
|------|----|-------|--------------|-------|
| ...  | #N | ...   | @reviewer    | Xd    |

### Stale (X) — no activity in 7+ days
| Repo | PR | Title | Last Update | Age |
|------|----|-------|-------------|-----|
| ...  | #N | ...   | YYYY-MM-DD  | Xd  |

### Failing CI (X)
| Repo | PR | Title | Failed Check |
|------|----|-------|--------------|
| ...  | #N | ...   | check-name   |

### Drafts (X)
- repo#N: title (Xd old)

### New Activity (last 24h)
- repo#N: @user commented — "summary..."

**Summary:** X open PRs across Y repos. Z ready to merge, W need attention.
```

## Notes

- The `gh` CLI must be authenticated. If `gh auth status` fails, stop and report the issue.
- PR age is calculated from `createdAt`, not `updatedAt`.
- "Stale" threshold is 7 days with no update. Adjust if the user specifies a different preference.
- Do not merge anything automatically. This workflow is read-only and informational.
- If rate-limited by the GitHub API, note which repos were skipped and suggest running again later.
