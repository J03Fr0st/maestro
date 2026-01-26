# Prompt Files

## Overview

Prompt files are reusable Markdown-based templates for standardized development tasks. They enable developers to build libraries of consistent workflows without duplicating guidelines across interactions.

Prompt files are stored in `copilot/prompts/`. Copy them to `.github/prompts/` in your project for VS Code auto-discovery.

## Prompt Categories

### Development (`dev/`)

| Prompt | Purpose |
|--------|---------|
| `commit.prompt.md` | Smart git commit with conventional commit messages and pre-commit quality checks |
| `performance.prompt.md` | Performance optimization |
| `pr.prompt.md` | Generate a comprehensive pull request description from git changes |
| `review.prompt.md` | Code review checklist |

### Documentation (`docs/`)

| Prompt | Purpose |
|--------|---------|
| `prd.prompt.md` | Product requirements document |
| `planning.prompt.md` | Technical planning |
| `adr.prompt.md` | Architecture decision records |
| `changelog.prompt.md` | Changelog entries |

## Prompt File Format

Prompt files use the `.prompt.md` extension with optional YAML frontmatter:

```markdown
---
name: bugfix
description: Diagnose and fix a bug with root cause analysis
agent: agent
model: gpt-4o
tools:
  - search
  - read
  - execute
---

# Bug Fix Request

**What's happening:**
${input:description:Describe the current buggy behavior}

**Expected behavior:**
${input:expected:What should happen instead}

**Steps to reproduce:**
${selection}

Please:
1. Identify the root cause
2. Explain why this bug occurs
3. Provide a fix with code changes
4. Suggest prevention strategies
```

## Frontmatter Fields

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `name` | string | No | Display name for `/` command invocation |
| `description` | string | No | Brief summary of the prompt's purpose |
| `argument-hint` | string | No | Guidance text in chat input field |
| `agent` | string | No | Agent type: `ask`, `edit`, `agent`, or custom agent name |
| `model` | string | No | Language model selection |
| `tools` | list | No | Available tools; use `<server>/*` for MCP servers |

## Variables

Prompt files support several variable types:

### Built-in Variables

| Variable | Description |
|----------|-------------|
| `${workspaceFolder}` | Path to the workspace root |
| `${selection}` | Currently selected text in editor |
| `${file}` | Current file path |
| `${fileBasename}` | Current filename without path |

### Input Variables

Prompt for user input when the prompt runs:

```markdown
${input:variableName:Placeholder text shown to user}
```

Examples:
```markdown
${input:feature:Describe the feature to implement}
${input:scope:What areas of code are affected?}
```

### File References

Include workspace files using relative Markdown links:

```markdown
Follow the patterns in [auth module](../src/auth/README.md).
Use the types defined in [models](../src/types/models.ts).
```

### Tool References

Reference tools using the `#tool:` syntax:

```markdown
Use #tool:search/codebase to find related code.
Use #tool:read/problems to check for errors.
```

## Using Prompt Files

### Via Slash Command
Type `/` followed by the prompt name in chat:
```
/bugfix
/refactor
```

### Via Command Palette
1. Open Command Palette (Ctrl+Shift+P / Cmd+Shift+P)
2. Run "Chat: Run Prompt"
3. Select the prompt to execute

### Via Editor
1. Open the `.prompt.md` file
2. Click the play button in the editor title bar
3. Prompt executes with current context

### With Context
Add files or selections before running:
```
/bugfix #file:src/auth/login.ts
```

## Storage Locations

| Type | Location | Scope |
|------|----------|-------|
| Workspace prompts | `.github/prompts/` | Current workspace only |
| User prompts | VS Code profile folder | All workspaces |

## Creating New Prompts

1. Create a file with `.prompt.md` extension
2. Add optional YAML frontmatter
3. Write the prompt body with instructions
4. Use variables for dynamic content
5. Test using the editor play button

### Example: Security Review Prompt

```markdown
---
name: security-review
description: Perform a security review of the codebase
agent: ask
---

# Security Review

Review the following code for security vulnerabilities:

${selection}

Focus on:
1. **Input Validation** - Check for injection vulnerabilities
2. **Authentication** - Verify auth mechanisms
3. **Authorization** - Check access controls
4. **Data Exposure** - Look for sensitive data leaks
5. **Dependencies** - Flag known vulnerable packages

Return findings grouped by severity (Critical, High, Medium, Low).
```

## Best Practices

### Clarity
- Clearly articulate objectives and expected output formats
- Be specific about what the prompt should accomplish

### Structure
- Use numbered steps for multi-part tasks
- Include input/output examples when helpful

### Reusability
- Reference custom instructions via Markdown links instead of duplicating
- Use variables for content that changes between uses

### Testing
- Test iteratively using the editor play button
- Verify with different inputs and contexts

### Organization
- Group related prompts in subdirectories
- Use consistent naming conventions

## Tool Priority

When prompts specify tools, they take precedence:
1. Prompt file tools
2. Referenced custom agent tools
3. Default agent tools
