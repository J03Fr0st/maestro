---
name: writing-prompts
description: |
  Create reusable prompt files (.prompt.md) for GitHub Copilot. Use when asked to create, write, or generate a prompt file, slash command, or reusable chat prompt. Covers frontmatter format, variables, tool configuration, file references, and best practices.
---

# Writing Prompt Files

Create `.prompt.md` files in `.github/prompts/` that define reusable `/` commands for Copilot Chat.

## File Format

```markdown
---
name: prompt-name
description: Short description shown in UI
argument-hint: "[optional parameters]"
agent: agent
model: gpt-5
tools: [git, github, terminal]
---

Prompt instructions here...
```

## Frontmatter Fields

| Field | Required | Description |
|-------|----------|-------------|
| `name` | No | Name after `/` in chat (defaults to filename) |
| `description` | No | Short UI description |
| `argument-hint` | No | Hint text in chat input |
| `agent` | No | `ask`, `edit`, `agent`, or custom agent name |
| `model` | No | Language model override |
| `tools` | No | YAML list of available tools |

## Variables

| Variable | Description |
|----------|-------------|
| `${workspaceFolder}` | Full workspace path |
| `${file}` | Current file path |
| `${fileBasename}` | Current filename |
| `${selection}` | Current editor selection |
| `${input:varName}` | User input variable |
| `${input:varName:placeholder}` | Input with placeholder text |

## File References

Use relative markdown links to include file context:

```markdown
Follow patterns in [auth service](../src/services/auth.ts)
```

## Tool References

```markdown
Use #tool:terminal to run commands
```

## Tools Configuration

```yaml
tools: [git, github, terminal, codebase, problems]
tools: [myserver/*]  # All MCP server tools
```

## Rules

- Keep prompts focused and concise
- Use variables instead of hardcoding values
- Specify required tools explicitly
- Reference instruction files instead of duplicating guidelines
- Describe expected output format
- Place files in `.github/prompts/` with `.prompt.md` extension
