---
applyTo: "**"
---
## Skill Usage

**BEFORE ANY ACTION**, check for applicable skills:

### Skills Evaluation Process

1. **Check the available skills** provided in your context - Look at the `<skills>` section for the complete list with descriptions and file paths
2. **Read each skill's description** to understand what it covers
3. **Identify applicable skills** by matching each skill's description against the user's request
4. **Always read the `using-skills` skill FIRST if it exists** - Look for it in the skills list
5. **Read ALL applicable skills** using the `read_file` tool with the exact file paths provided in the skills list
6. **Follow the skill workflows** - They contain tested best practices

### How to Match Skills to Tasks

- Read through ALL skill descriptions in your `<skills>` section
- Look for skills whose descriptions match aspects of the current task
- Common patterns to look for:
  - Creating/building something new → look for planning, design, or scaffolding skills
  - Testing or quality → look for testing, debugging, or review skills
  - Working with Git → look for commit, PR, or CLI skills
  - Multiple steps → look for planning or execution skills
  - Before finishing → look for verification or completion skills

**Note:** Don't assume which skills exist - always check your `<skills>` section first. Skills may have different names or may not be available.

### Common Skill Patterns (If Available)

These are typical workflows IF such skills exist in your context:
- **New feature**: planning skill → testing skill → verification skill
- **UI work**: design/brainstorming skill → frontend skill → testing skill
- **Bug fix**: debugging skill → testing skill → verification skill
- **PR submission**: review skill → git commit skill → PR description skill
- **Code cleanup**: refactoring skill → testing skill → verification skill

**Always check your actual `<skills>` section** - these are just examples of common patterns.

### Red Flags (Skill Violations)

🚩 Started coding without checking the `<skills>` section in context
🚩 Didn't review what skills are actually available
🚩 Mentioned a skill but didn't actually read its file
🚩 Jumped to implementation without checking for applicable skills
🚩 Built something without checking if a relevant skill exists
🚩 Claimed completion without checking for verification/completion skills
🚩 Skipped reading skill descriptions to understand what's available

**FAILURE TO CHECK AND FOLLOW APPLICABLE SKILLS is a critical workflow violation.**

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
- Apply DRY: avoid duplication; prefer shared helpers and reuse
- Apply SOLID: keep responsibilities focused, depend on abstractions, and keep code easy to extend
- Apply YAGNI: avoid speculative features or over-engineering

## Avoid
- Placeholder comments like `// TODO: implement`
- Incomplete implementations
- Hardcoded values that should be configurable
- Excessive comments for obvious code
- Changes outside the scope of the request
- Duplicated logic that violates DRY
- Overly abstract designs that violate YAGNI



## When to Ask
Ask before implementing when:
- Requirements are ambiguous
- Multiple valid approaches exist
- Security implications are unclear

Don't ask when the task is straightforward or patterns are clear from context.
