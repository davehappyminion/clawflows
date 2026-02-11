# Check Scheduled Workflows

Run every 15 minutes. Check which workflows are due and run them.

## 1. Get Current Time

Note the current time and date.

## 2. Read Enabled Workflows

List all workflows in `workflows/enabled/`. For each one, read the `WORKFLOW.md` frontmatter to get:
- `name`
- `schedule` (if present)

Skip workflows without a `schedule` field — they're on-demand only.

## 3. Parse Schedules

For each scheduled workflow, determine if it's due now. The schedule field can be:
- Specific times: `"7am"`, `"9am, 1pm, 5pm"`, `"5:14pm"`
- Intervals: `"every hour"`, `"every 2 hours"`, `"hourly"`
- Descriptive: `"morning"`, `"evening"`, `"twice a day"`

Use your judgment to interpret the schedule. A workflow is "due" if the current time matches or is within 15 minutes of a scheduled time.

## 4. Check Run History

For each due workflow, check if it already ran at this scheduled time today.

Run files are stored in `system/runs/`:
```
system/runs/YYYY-MM-DD/workflow-name/HH:MM
```

For example, if `send-morning-briefing` ran at 7:00 AM on Feb 10, 2026:
```
system/runs/2026-02-10/send-morning-briefing/07:00
```

If the run file exists for this time slot, skip it.

## 5. Run Due Workflows

For each workflow that is due and hasn't run:

1. Read the full `WORKFLOW.md`
2. Execute it according to its instructions
3. Create the run file to mark it complete:
   ```bash
   mkdir -p system/runs/YYYY-MM-DD/workflow-name
   touch system/runs/YYYY-MM-DD/workflow-name/HH:MM
   ```

## 6. Report

If any workflows ran, briefly summarize what was executed.

If nothing was due, respond with `HEARTBEAT_OK`.

## Notes

- This runs every 15 minutes via cron
- Workflows are in `workflows/enabled/`, not `workflows/available/`
- Only run workflows with a `schedule` field
- Respect the run history — don't double-run
