# ClawFlows Setup

Follow these steps to install ClawFlows for the user.

## 1. Run the installer

```bash
curl -fsSL https://raw.githubusercontent.com/davehappyminion/clawflows/main/system/install.sh | bash
```

This will:
- Clone ClawFlows to `~/.openclaw/workspace/clawflows/`
- Set up the CLI
- Configure the scheduler

## 2. Ask which workflows to enable

Show the user a few popular options:

**Daily essentials:**
- `send-morning-briefing` — Weather, calendar, priorities at 7am
- `send-daily-wrap` — End-of-day summary at 9pm
- `process-email` — Auto-triage inbox 2-3x/day

**Smart home:**
- `activate-sleep-mode` — One command to shut everything down for bed
- `activate-focus-mode` — Block distractions, optimize lighting

**Productivity:**
- `check-calendar` — 48-hour radar with conflict detection
- `triage-tasks` — Morning review of what's due

Ask: "Which of these would you like me to enable? Or say 'all' to enable the daily essentials."

## 3. Enable the chosen workflows

For each workflow the user wants:

```bash
clawflows enable <workflow-name>
```

## 4. Confirm setup

Tell the user:
- Which workflows are now active
- How to see all available workflows: `clawflows list`
- How to enable more: `clawflows enable <name>`
- That scheduled workflows will run automatically

## Done

The user is all set. Their agent now has superpowers.
