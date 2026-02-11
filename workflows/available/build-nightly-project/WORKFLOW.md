---
name: build-nightly-project
emoji: 🔨
description: Autonomous nightly build — picks an idea from a queue, builds it as a small project, tests it, and reports what was built.
---

# Nightly Build

Every night, wake up and build something small but helpful.

## 1. Pick an Idea

Check your ideas file (e.g., `ideas.md`, `TODO.md`, or task manager) for the next item in the queue.

Look for:
- Ideas marked as "ready" or "next"
- Small scope items (can be completed in 1-2 hours)
- Clear requirements

## 2. Set Up the Project

Create a new folder for the build:
- Location: `builds/YYYY-MM-DD-project-name/`
- Initialize with appropriate structure for the project type

## 3. Build It

Using your **coding skill** or AI coding assistant:
- Implement the idea
- Keep it simple — MVP only
- Focus on functionality over polish
- Write clean, readable code

### Constraints
- Max 2 hours of work
- Must be functional and tested
- No scope creep — build what was planned

## 4. Test It

Verify the build works:
- Run the code
- Test key functionality
- Fix any obvious bugs

## 5. Document It

Write a `README.md` explaining:
- What it does
- How to use it
- Any dependencies or setup needed

## 6. Update the Queue

Move the idea from "Queue" to "Completed" in your ideas file.

## 7. Report

Using your **messaging skill**, send a summary:

```
🌙 Nightly Build Complete!

Built: [Project Name]
Location: builds/YYYY-MM-DD-name/
What it does: [1-2 sentences]
How to use: [Quick example]

Ready for you to try!
```

## Notes

- Schedule to run overnight or during idle time
- Start with high-value, low-complexity ideas
- Document clearly so builds can be used immediately
- If an idea is too big, break it down and build part of it
