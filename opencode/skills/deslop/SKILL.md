---
name: deslop
description: Review and clean up newly written code to follow good coding practices, removing AI-generated slop patterns
---

## Purpose

Clean up code that may contain "slop" - patterns commonly introduced by AI code generation or hasty development that reduce code quality.

## What to look for

### Unnecessary verbosity
- Overly defensive null checks that aren't needed
- Redundant type annotations the compiler can infer
- Comments that just restate what the code does
- Excessive intermediate variables that obscure intent

### Poor naming
- Generic names like `data`, `result`, `temp`, `item`, `value`
- Abbreviated names that sacrifice clarity (`usr`, `cfg`, `ctx` when not conventional)
- Boolean names that don't read as questions (`valid` vs `isValid`)
- Function names that don't describe what they do

### Structural issues
- Functions doing too many things (break them up)
- Deeply nested conditionals (invert and early return)
- Copy-pasted code that should be abstracted
- Dead code or unreachable branches
- Inconsistent error handling patterns

### AI-specific slop patterns
- Apologetic or hedging comments ("This might not be perfect...")
- Overly generic implementations when specific ones are cleaner
- Unnecessary abstraction layers "for flexibility"
- Console.log/print statements left in production code
- TODO comments without actionable context
- Placeholder error messages ("Something went wrong")

## How to apply

1. Read the code carefully before making changes
2. Preserve the original intent and functionality
3. Make surgical improvements - don't rewrite for the sake of it
4. Prefer idiomatic patterns for the language/framework in use
5. Keep changes reviewable - explain non-obvious improvements

## What NOT to do

- Don't add complexity in the name of "best practices"
- Don't change working code just because you'd write it differently
- Don't introduce new dependencies
- Don't refactor beyond the scope of the code being reviewed
- Don't add comments to "explain" already-clear code
