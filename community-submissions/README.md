# Community Submissions

This folder contains workflow submissions from the community waiting for review.

## How to Submit a Workflow

1. **Create your workflow** using the CLI:
   ```bash
   clawflows create
   ```

2. **Test it** to make sure it works:
   ```bash
   clawflows run your-workflow-name
   ```

3. **Submit it** for review:
   ```bash
   clawflows submit your-workflow-name
   ```
   This copies your workflow here and opens a PR.

4. **Wait for review** — maintainers will review and merge approved workflows.

See [CONTRIBUTING.md](../CONTRIBUTING.md) for the full guide.

## Template

Check out `_template/WORKFLOW.md` for the standard format.

## Placeholder Syntax for Secrets

If your workflow needs API keys or credentials, use this format:

```
{{SECRET:API_KEY_NAME}} — Description of what this key is for
```

Examples:
- `{{SECRET:OPENAI_API_KEY}}` — OpenAI API key for GPT calls
- `{{SECRET:GITHUB_TOKEN}}` — GitHub personal access token
- `{{SECRET:SLACK_WEBHOOK}}` — Slack webhook URL for notifications

Users will add their own keys when enabling the workflow.
