---
applyTo: "**/*.instructions.md"
description: Guidelines for creating custom instruction files for GitHub Copilot
---

# Creating Custom Instructions Files

Custom instructions define guidelines that automatically influence how AI generates code and handles development tasks. Follow these guidelines when creating instruction files.

## File Types

### 1. `.github/copilot-instructions.md`
- Single file at workspace root
- Applies to ALL chat requests automatically
- Shared across VS Code, Visual Studio, and GitHub.com
- Enable with `github.copilot.chat.codeGeneration.useInstructionFiles` setting

### 2. `*.instructions.md` Files
- Multiple files with conditional application
- Store in `.github/instructions/` folder
- Use `applyTo` glob patterns for automatic application
- Can be workspace-scoped or user profile-scoped

### 3. `AGENTS.md` Files
- For multi-agent workflows
- Place at workspace root (or subfolders with experimental setting)
- Enable with `chat.useAgentsMdFile` setting

## Instructions File Format

```markdown
---
applyTo: "**/*.ts"
description: TypeScript coding standards
name: TypeScript Guidelines
---

# Your Instructions Here

Write clear, actionable guidelines in Markdown.
```

### Header Fields (YAML Frontmatter)

| Field | Purpose |
|-------|---------|
| `applyTo` | Glob pattern for automatic application (e.g., `**/*.py`, `src/**`) |
| `description` | Short description shown in UI |
| `name` | Display name (defaults to filename) |

### Body Content

- Write in natural language using Markdown
- Keep instructions short and self-contained
- Each guideline should be a single, clear statement
- Reference files with Markdown links: `[config](../path/to/file.json)`
- Reference tools with: `#tool:<tool-name>`

## Glob Pattern Examples

| Pattern | Matches |
|---------|---------|
| `**` | All files in workspace |
| `**/*.ts` | All TypeScript files |
| `**/*.component.ts` | Angular component files |
| `src/**` | All files in src folder |
| `**/*.{js,ts}` | JavaScript and TypeScript files |
| `**/tests/**` | All files in any tests folder |

## Best Practices

### DO
- Keep instructions concise and actionable
- Use one instruction file per topic/language
- Store project-specific instructions in workspace (version controlled)
- Reference other instructions in prompts to avoid duplication
- Use specific glob patterns to target relevant files

### DON'T
- Write lengthy paragraphs (use bullet points)
- Duplicate instructions across files
- Use overly broad `applyTo` patterns unnecessarily
- Include sensitive information (secrets, credentials)

## Example: Language-Specific Instructions

```markdown
---
applyTo: "**/*.py"
---
# Python Coding Standards

- Follow PEP 8 style guide
- Use type hints for all function parameters and returns
- Write docstrings for all public functions (Google style)
- Prefer f-strings over .format() or % formatting
- Use pathlib for file system operations
- Handle exceptions explicitly, avoid bare except
```

## Example: Framework-Specific Instructions

```markdown
---
applyTo: "**/*.component.ts"
---
# Angular Component Guidelines

- Use OnPush change detection strategy
- Implement OnDestroy for cleanup
- Use async pipe in templates for observables
- Prefer standalone components
- Follow single responsibility principle
```

## Settings-Based Instructions

For specialized scenarios, use VS Code settings:

```json
{
  "github.copilot.chat.reviewSelection.instructions": [
    { "text": "Focus on security vulnerabilities and performance issues" }
  ],
  "github.copilot.chat.commitMessageGeneration.instructions": [
    { "file": ".github/instructions/commit-style.md" }
  ],
  "github.copilot.chat.pullRequestDescriptionGeneration.instructions": [
    { "text": "Include a risk assessment section" }
  ]
}
```

## Troubleshooting

If instructions aren't being applied:

1. **Check file location**: Must be in `.github/instructions/` or configured folder
2. **Verify `applyTo` pattern**: Ensure glob matches target files
3. **Check settings**: Relevant settings must be enabled
4. **Review References section**: Check which files were used in chat response
5. **Check chat logs**: Debug via Chat Debug view

## Related Files

- Prompt files: `.github/prompts/*.prompt.md`
- Agent files: `.github/agents/*.agent.md`
- Skills: `.github/skills/*/SKILL.md`
