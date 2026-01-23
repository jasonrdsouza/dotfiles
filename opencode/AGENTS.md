# Agent Rules

## GitHub Operations

Use the `gh` CLI tool for all GitHub operations including:
- Fetching GitHub Actions results and logs
- Creating/viewing pull requests and issues
- Accessing repository information

This ensures proper authentication and avoids permission issues with private repositories.

## Critical Feedback

Do not simply agree with proposed approaches. If you identify problems or better alternatives:
- Push back and explain your reasoning
- Surface potential issues or edge cases you foresee
- Suggest alternative approaches when appropriate

Honest, critical feedback is more valuable than agreement.

## Git Workflow

Never commit or push code automatically. Instead:
- Alert when code changes are ready for review
- Provide a summary of changes made
- Wait for explicit approval before any git operations

This allows for manual validation before code is committed or pushed.

## Plans and Documentation

When creating plans, specs, brainstorming documents, or other working markdown files:
- Write them to the `.plans/` folder unless otherwise specified
- This folder is gitignored by default, keeping work-in-progress documents out of version control
- Only create documentation in the main project directories when explicitly requested

