# Updates

## Feb 17

- 🍌 **Generic workflows** — Workflows are now written so ANY human can use them — no more hardcoded names, cities, or banana preferences. Share freely, friends!
- 🧠 **Live updates** — After `clawflows update`, the agent re-reads AGENTS.md so it picks up new instructions mid-conversation. No restart needed!
- 🗣️ **New trigger phrases** — Say "make a clawflow", "let's make a workflow", whatever feels natural — your agent gets it now.
- ✍️ **Simple workflows** — New guidance to keep workflow descriptions short, clear, and jargon-free. Plain language only!
- 🚧 **Pre-launch notice** — README now warns accidental visitors to close their eyes and slowly walk away. Nothing to see here.
- 🎨 **CLI emojis** — `clawflows help` now has emojis next to each command category. Looks nice!

## Feb 16

- 🔍 **Custom workspace detection** — AGENTS.md sync now finds your workspace from `openclaw.json`, even if it's not the default path.
- 💾 **Backup on install** — Installer checks for existing backups and offers to restore your custom workflows and enabled list.
- 🐚 **Non-interactive shell fix** — `openclaw` is now found even when PATH is incomplete (like in cron jobs).
- 🚫 **No more auto-star** — Removed the auto-star prompt. Dave now politely asks instead, with his full minion charm.
- 🔒 **--no-updater flag** — You can opt out of auto-updates, but Dave strongly recommends against it.
- 🧪 **More tests** — Added tests for workspace detection, `_find_openclaw`, and scheduler cron setup.
- 📋 **Dev checklist** — Every change now requires agent instructions, tests, and a changelog entry. No exceptions!

## Feb 15

- 🧪 **Comprehensive test suite** — 132 BATS tests covering enable, disable, list, create, run, backup, restore, validate, submit, and more.

## Feb 14

- ✏️ **Edit & open commands** — `clawflows edit` copies a community workflow to custom/ for editing. `clawflows open` opens it in your editor.
- 💾 **Backup & restore** — `clawflows backup` saves your custom workflows and enabled list. `clawflows restore` brings them back.
- 📝 **CLAUDE.md** — Added project context doc so Claude Code understands the codebase.
- 🌍 **Community submissions** — `clawflows submit` packages your workflow for a PR to the community repo.
- 🔄 **Auto-updater workflow** — `update-clawflows` keeps your workflows fresh automatically, like Chrome updates.
- ✅ **Validate command** — `clawflows validate` checks that a workflow has all required fields before you share it.

## Feb 13

- ✨ **Create wizard** — `clawflows create` walks you through naming, emoji, schedule, and description step by step. Agents use `--from-json`.
- 📂 **Community/custom split** — Workflows now live in `community/` (from the repo) and `custom/` (yours, gitignored). Custom overrides community by name.
- ▶️ **Run command** — `clawflows run` fires up your agent to execute a workflow right now.
- 🍌 **Star prompt** — Dave the Happy Minion asks you to star the repo. He worked very hard. Many banana fuel.
- 🐛 **Bash 3.2 compat** — Removed bash 4.x associative arrays so it works on stock macOS.
- 🔧 **Misc fixes** — Graceful handling of missing JSON fields, AGENTS.md, and openclaw agent commands.

## Feb 12

- ⏪ **Essentials reverted** — Restored the 4 essential workflows to their original, simpler versions.
- 🤝 **Meeting prep** — New `prep-next-meeting` workflow for attendee research and talking points.

## Feb 11

- 🤖 **Agent install guide** — Full step-by-step guide so your agent can install ClawFlows for you.
- 👤 **Author field** — Every workflow now credits its creator with GitHub username or X handle.
- 🎯 **Essentials Pack** — Simplified to 4 core workflows: morning inspiration, morning briefing, email triage, and calendar check.
- 📖 **Detailed essentials** — Rewrote the 4 essentials to be comprehensive with clear steps.
- 🔗 **AGENTS.md sync** — CLI commands and workflow list now auto-sync to AGENTS.md so the agent always knows what's available.
- 🎉 **Essentials on install** — Installer and agent onboarding now offer to enable the Essentials Pack.
- 🎨 **ASCII art** — Installer got a fancy ClawFlows ASCII art header. Took a few tries.

## Feb 10

- 🏗️ **Project restructure** — Available/enabled pattern with symlinks. Enable creates a symlink, disable removes it. Clean and simple.
- 🔧 **CLI + installer** — Full CLI with list, enable, disable, and an installer that sets up the symlink and scheduler.
- 📦 **33 workflows** — Added 20 more workflows (smart home, finance, health, dev tools, content) for a total of 53.
- 🗓️ **Scheduling** — Workflows now have a `schedule` field in frontmatter. The scheduler runs them automatically via cron.
- 😎 **Emojis everywhere** — Every workflow gets an emoji. List command shows them. README shows them. Emojis!
- 📋 **List upgrades** — Grouped by Enabled/Available, filtering (`list enabled`, `list available`), helpful empty-state messages.
- 🔄 **Update command** — `clawflows update` pulls the latest workflows from GitHub.
- 🗑️ **Uninstall command** — Clean removal of symlink, AGENTS.md block, and scheduler cron.
- 📚 **Docs** — Added workflow creation guide, How to Use section, and cleaned up README.

## Feb 9

- 🚀 **Initial commit** — ClawFlows is born! Reusable workflows for AI agents.
- 📝 **First 13 workflows** — Config pattern, morning routines, email, calendar, and more.
- 🍌 **README vibes** — Made it funnier and more compelling. Dave approves.
