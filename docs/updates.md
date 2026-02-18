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
- 🌐 **Dave's website** — Star message now links to davehappyminion.com.
- 🔒 **--no-updater flag** — You can opt out of auto-updates, but Dave strongly recommends against it.
- 🧪 **More tests** — Added tests for workspace detection, `_find_openclaw`, and scheduler cron setup.
- 📋 **Dev checklist** — Every change now requires agent instructions, tests, and a changelog entry. No exceptions!

## Feb 15

- 🧪 **Comprehensive test suite** — 132 BATS tests covering enable, disable, list, create, run, backup, restore, validate, submit, and more.

## Feb 14

- ✏️ **Edit command** — `clawflows edit` copies a community workflow to custom/ so you can modify it without losing changes on update.
- 📂 **Open command** — `clawflows open` opens any workflow in your editor.
- 💾 **Backup command** — `clawflows backup` saves your custom workflows and enabled list to a tar.gz.
- ♻️ **Restore command** — `clawflows restore` brings back your workflows from a backup.
- 📝 **CLAUDE.md** — Added project context doc so Claude Code understands the codebase.
- 🌍 **Community submissions** — `clawflows submit` packages your workflow for a PR to the community repo.
- 🔄 **Auto-updater workflow** — `update-clawflows` keeps your workflows fresh automatically, like Chrome updates.
- ✅ **Validate command** — `clawflows validate` checks that a workflow has all required fields before you share it.

## Feb 13

- ✨ **Create wizard** — `clawflows create` walks you through naming, emoji, schedule, and description step by step.
- 🤖 **JSON API** — Agents create workflows programmatically with `clawflows create --from-json`.
- 📂 **Community/custom split** — Workflows now live in `community/` (from the repo) and `custom/` (yours, gitignored). Custom overrides community by name.
- ⚠️ **Uninstall warning** — `clawflows uninstall` now warns you about custom workflow deletion before nuking the directory.
- 🐛 **Bash 3.2 compat** — Removed bash 4.x associative arrays so it works on stock macOS.
- 💡 **Wizard UX** — Create wizard now suggests verb-prefixed names and clarifies the author field.
- 📍 **File path after create** — After creating a workflow, shows the file path so you know where to edit it.
- ▶️ **Run command** — `clawflows run` fires up your agent to execute a workflow right now.
- 📝 **Simpler agent instructions** — Simplified workflow creation instructions for agents.
- 🔌 **Openclaw agent integration** — Workflows run via `openclaw agent --local` with the right flags.
- 🔧 **Misc fixes** — Graceful handling of missing JSON fields, AGENTS.md, and openclaw agent command syntax.
- 🍌 **Star prompt** — Dave the Happy Minion asks you to star the repo. He worked very hard. Many banana fuel.

## Feb 12

- ⏪ **Essentials reverted** — Restored the 4 essential workflows to their original, simpler versions.
- 🤝 **Meeting prep** — New `prep-next-meeting` workflow for attendee research and talking points.

## Feb 11

- 🤖 **Agent install guide** — Full step-by-step guide so your agent can install ClawFlows for you.
- 👤 **Author field** — Added author field to frontmatter spec and credited every workflow's creator.
- 🎛️ **Agent-driven setup** — Agent can now drive the full setup flow, not just humans in a terminal.
- 🎯 **Essentials Pack** — Simplified to 4 core workflows: morning inspiration, morning briefing, email triage, and calendar check.
- 📖 **Detailed essentials** — Rewrote the 4 essentials to be comprehensive with clear steps.
- 🗺️ **Natural language mapping** — Agent guide now maps what users say ("check my email") to which workflow to run.
- 🔗 **AGENTS.md sync** — CLI commands and workflow list now auto-sync to AGENTS.md so the agent always knows what's available.
- 🎉 **Essentials on install** — Installer and agent onboarding now offer to enable the Essentials Pack.
- 🎨 **ASCII art** — Installer got a fancy ClawFlows ASCII art header. Took a few tries to get right.
- 🔐 **Security fix** — Replaced curl|bash with explicit commands in agent install guide.

## Feb 10

- 🏗️ **Project restructure** — Available/enabled pattern with symlinks. Enable creates a symlink, disable removes it.
- 🔧 **CLI** — Full CLI with list, enable, and disable commands.
- 📥 **Installer** — Install script sets up the symlink, scheduler, and directory structure.
- 🧪 **First test suite** — Initial test suite for the clawflows CLI.
- 🦞 **Header image** — Added the lobster minion header image to README. Bello!
- ⭐ **Essentials Pack** — 13 core daily workflows for morning routines, email, calendar, and more.
- 🔓 **Tool-agnostic workflows** — Rewrote all workflows to work with any tool, not just specific integrations.
- 😎 **Emojis everywhere** — Added emoji field to all 33 workflows. List command shows them. README shows them.
- ✨ **Morning inspiration** — Renamed `send-morning-quote` to `send-morning-inspiration`.
- 📦 **20 more workflows** — Habits, meals, weather, journal, birthdays, subscriptions, packages, bills, deals, weekly update, PRs, deps, docker, logs, network, reading list, social posts, podcasts, photos, and interview prep.
- 🗓️ **Scheduling** — Workflows now have a `schedule` field in frontmatter. The scheduler runs them via cron.
- 🚫 **Config files removed** — Dropped config.env — agent uses skills for device context instead.
- 🐛 **Stdin leak fix** — Fixed curl|bash stdin leak by redirecting /dev/null for openclaw cron commands.
- 📭 **Empty state message** — `clawflows list` now shows a helpful message when no workflows are found.
- 🔗 **Symlink fix** — Fixed symlink resolution so `clawflows list` works when invoked via `~/.local/bin` symlink.
- 🔄 **Update command** — `clawflows update` pulls the latest workflows from GitHub.
- 🔇 **Quieter installer** — Suppressed openclaw cron stdout/stderr noise.
- ⏭️ **Skip duplicate cron** — Scheduler setup now skips if the cron job already exists.
- 🎨 **Installer redesign** — ASCII art, colors, workflow count, and next steps in the installer output.
- 🎯 **Emoji rendering fix** — Replaced Unicode escapes with actual emoji characters so they render properly.
- 📋 **List upgrades** — Grouped by Enabled/Available, filtering (`list enabled`, `list available`).
- ❓ **Help command** — `clawflows help` shows all commands with descriptions and examples.
- 🗑️ **Uninstall command** — Clean removal of symlink, AGENTS.md block, and scheduler cron.
- 📚 **Docs** — Added workflow creation guide, How to Use section, and cleaned up README.

## Feb 9

- 🚀 **Initial commit** — ClawFlows is born! Reusable workflows for AI agents.
- 📝 **Config pattern** — Added config.env to separate personal values from workflow logic.
- 🔧 **Config optional** — Made config.env optional so workflows work out of the box.
- 🍌 **README vibes** — Made it funnier and more compelling. Dave approves.
- 📦 **20 workflows** — Focus mode, morning mode, away mode, plus process, check, build, send, and sync workflows.
