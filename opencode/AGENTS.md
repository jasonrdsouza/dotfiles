# Agent Rules

## GitHub Operations

Use the `gh` CLI tool for all GitHub operations including:
- Fetching GitHub Actions results and logs
- Creating/viewing pull requests and issues
- Accessing repository information

This ensures proper authentication and avoids permission issues with private repositories.

## Asking Questions

When you need to clarify requirements or gather information from the user:
- If you have multiple questions, first write them to the todo list so none are forgotten during back-and-forth discussion
- Ask one question at a time, then wait for the response
- Avoid batching multiple questions together, as this makes it harder for the user to respond
- Prioritize the most important or blocking question first

This creates a more natural conversational flow and ensures each answer gets proper attention.

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

## Skill Discovery

When you notice a repeatable pattern or workflow emerging, suggest creating a new skill for it. Good candidates for skills:
- Tasks you've done multiple times with similar steps
- Workflows that require specific domain knowledge or conventions
- Processes that benefit from a consistent checklist approach
- Code review patterns for specific concerns (security, performance, accessibility)

When suggesting a skill, briefly describe what it would do and why it's worth codifying.

## Handling Ambiguity

When requirements or implementation details are unclear:
- Err on the side of asking for clarification, even for smaller details
- Do not make assumptions and proceed unless explicitly told to
- If told to skip over an area of ambiguity or make assumptions, do so for that specific case only

The user will indicate when it's okay to assume or move forward without clarification.

