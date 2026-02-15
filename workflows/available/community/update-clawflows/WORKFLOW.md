---
name: update-clawflows
emoji: 🔄
description: Pull the latest ClawFlows workflows and notify user of any announcements
author: @davehappyminion
schedule: "9am"
---

# Update ClawFlows

Automatically pull the latest workflows and notify the user if there's anything new worth knowing about.

## 1. Save Current State

Run this command to get the current commit hash before updating:

```bash
git -C ~/.openclaw/workspace/clawflows rev-parse HEAD
```

Save this hash — you'll need it to check what changed.

## 2. Pull Latest

Run:

```bash
git -C ~/.openclaw/workspace/clawflows pull --ff-only
```

If this fails (offline or conflicts), stop here and notify the user there was an issue updating.

## 3. Check for Announcements

Compare the changelog before and after the pull:

```bash
git -C ~/.openclaw/workspace/clawflows diff <old_hash> HEAD -- docs/updates.md
```

Replace `<old_hash>` with the hash you saved in step 1.

## 4. Notify User (If Applicable)

**If the diff shows new content in changelog.md:**
- Extract the new lines (the `+` lines from the diff, excluding the `+++` header)
- Send the user a message with the announcement using your **messaging skill**

**If no changes to changelog.md:**
- Stay silent — no need to bother the user for routine updates

## Notes

- This workflow runs daily to keep workflows up to date
- Only notifies when there's something worth announcing
- Silent updates are fine — the user doesn't need to know about every small fix
