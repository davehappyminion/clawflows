---
name: build-nightly-project
description: Autonomous nightly build — picks an idea from a queue, builds it as a small project, tests it, and reports what was built. Use when the user says "nightly build", "build something", or when triggered by a scheduled cron.
requires:
  - name: claude-code
    description: Anthropic Claude Code AI coding agent
---

# Nightly Build

Every night, wake up and build something small but helpful.

## Process

1. Check `ideas.md` for the next item in the queue
2. Create a new folder: `builds/YYYY-MM-DD-project-name/`
3. Use an AI coding agent to build it
4. Test it works
5. Write a `README.md` explaining what it does and how to use it
6. Move the idea from "Queue" to "Completed" in ideas.md
7. Send a morning message summarizing what you built

## Constraints

- Max 2 hours of work
- Must be functional and tested
- Keep it simple — MVP only
- Document clearly so it can be used immediately

## Output Format

After building, report:

```
Nightly Build Complete!

Built: [Project Name]
Location: builds/YYYY-MM-DD-name/
What it does: [1-2 sentences]
How to use: [Quick example]
```
