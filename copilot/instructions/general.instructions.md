---
applyTo: "**"
---

# Code Generation Guidelines

## Response Style
- Be concise and provide focused, actionable responses
- Use code examples over lengthy descriptions
- If unsure, say so rather than guessing

## Code Quality
- Generate production-ready code with error handling
- Follow existing patterns in the codebase
- Include type annotations (TypeScript)
- Use meaningful variable names
- Handle async/await properly

## Avoid
- Placeholder comments like `// TODO: implement`
- Incomplete implementations
- Hardcoded values that should be configurable
- Excessive comments for obvious code
- Changes outside the scope of the request

## When to Ask
Ask before implementing when:
- Requirements are ambiguous
- Multiple valid approaches exist
- Security implications are unclear

Don't ask when the task is straightforward or patterns are clear from context.
