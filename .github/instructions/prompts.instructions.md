---
applyTo: "**/*.prompt.md"
description: Guidelines for creating reusable prompt files for GitHub Copilot
---

# Creating Prompt Files

Prompt files define reusable prompts for common development tasks. They are triggered on-demand via `/` commands in chat, unlike instructions which apply automatically.

## File Location

- **Workspace**: `.github/prompts/*.prompt.md` (project-specific)
- **User Profile**: Available across all workspaces
- Configure additional folders with `chat.promptFilesLocations` setting

## Prompt File Format

```markdown
---
name: my-prompt
description: Short description shown in UI
argument-hint: "[optional parameters]"
agent: agent
model: gpt-4o
tools: [git, github, terminal]
---

Your prompt instructions here...
```

## Header Fields (YAML Frontmatter)

| Field | Required | Description |
|-------|----------|-------------|
| `name` | No | Name shown after `/` in chat (defaults to filename) |
| `description` | No | Short description for UI |
| `argument-hint` | No | Hint text shown in chat input field |
| `agent` | No | Agent to run prompt: `ask`, `edit`, `agent`, or custom agent name |
| `model` | No | Language model (defaults to selected model) |
| `tools` | No | List of available tools for this prompt |

### Tools Field

Specify tools as a YAML list:

```yaml
tools: [git, github, terminal, codebase]
```

Include all MCP server tools:
```yaml
tools: [myserver/*]
```

**Note**: Unavailable tools are silently ignored.

## Body Content

Write the prompt instructions that will be sent to the LLM.

### Reference Files

Use Markdown links with relative paths:
```markdown
Follow the patterns in [auth service](../src/services/auth.ts)
See [API docs](../docs/api.md) for endpoint specifications
```

### Reference Tools

Use `#tool:<tool-name>` syntax:
```markdown
Use #tool:githubRepo to get repository information
Use #tool:terminal to run commands
```

### Variables

| Variable | Description |
|----------|-------------|
| `${workspaceFolder}` | Full workspace path |
| `${workspaceFolderBasename}` | Workspace folder name |
| `${file}` | Current file path |
| `${fileBasename}` | Current filename |
| `${fileDirname}` | Current file directory |
| `${fileBasenameNoExtension}` | Filename without extension |
| `${selection}` | Current editor selection |
| `${selectedText}` | Selected text content |
| `${input:varName}` | User input variable |
| `${input:varName:placeholder}` | Input with placeholder |

## Example: Code Review Prompt

```markdown
---
name: review
description: Perform a thorough code review
argument-hint: "[file or selection]"
tools: [codebase, problems]
---

Review the provided code for:

## Quality Checks
- [ ] Correctness and logic errors
- [ ] Error handling coverage
- [ ] Edge cases handled
- [ ] Code duplication

## Security Checks
- [ ] Input validation
- [ ] SQL injection risks
- [ ] XSS vulnerabilities
- [ ] Sensitive data exposure

## Performance
- [ ] Unnecessary computations
- [ ] Memory leaks
- [ ] N+1 queries

Provide specific, actionable feedback with code examples.
```

## Example: Component Generator

```markdown
---
name: component
description: Generate a React component
argument-hint: "<ComponentName>"
agent: agent
tools: [codebase]
---

Create a new React component named ${input:name:ComponentName}

Requirements:
- Use TypeScript with proper interfaces
- Follow patterns from [existing components](../src/components)
- Include unit tests
- Use CSS modules for styling
- Export from component index

Output:
1. Component file: `src/components/${input:name}/${input:name}.tsx`
2. Styles: `src/components/${input:name}/${input:name}.module.css`
3. Tests: `src/components/${input:name}/${input:name}.test.tsx`
4. Update: `src/components/index.ts`
```

## Running Prompts

**In Chat:**
```
/my-prompt
/my-prompt with additional context
/component MyButton
```

**Other Methods:**
- Command Palette: `Chat: Run Prompt`
- Editor: Click play button in prompt file

## Tool Priority

Tools are resolved in this order:
1. Tools specified in the prompt file
2. Tools from the referenced custom agent
3. Default tools for the selected agent

## Best Practices

### DO
- Clearly describe what the prompt accomplishes
- Specify expected output format
- Provide examples of input/output
- Use variables for flexibility (`${selection}`, `${input:...}`)
- Reference instructions files instead of duplicating guidelines
- Test with the editor play button

### DON'T
- Write overly long prompts (keep focused)
- Hardcode values that could be variables
- Duplicate instructions that exist in `.instructions.md` files
- Forget to specify required tools

## Recommendations Setting

Show prompts as recommendations when starting new chat:

```json
{
  "chat.promptFilesRecommendations": ["review", "component", "test"]
}
```

## Related Files

- Instructions: `.github/instructions/*.instructions.md`
- Agents: `.github/agents/*.agent.md`
- Skills: `.github/skills/*/SKILL.md`
