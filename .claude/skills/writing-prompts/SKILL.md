---
name: writing-prompts
description: >
  Create reusable prompt files for GitHub Copilot, custom slash commands, chat
  templates, prompt templates. Use whenever the user mentions .prompt.md, slash
  commands, custom commands, reusable prompts, chat templates, or Copilot prompt
  files.
---

# Writing Prompt Files

Create `.prompt.md` files in `.github/prompts/` that define reusable `/` commands
for Copilot Chat. Prompt files turn repetitive multi-step workflows into
one-command actions that the whole team can share.

## File Format

```markdown
---
name: prompt-name
description: Short description shown in UI
argument-hint: "[optional parameters]"
agent: agent
model: copilot-model
tools: [git, github, terminal]
---

Prompt instructions here...
```

## Frontmatter Fields

| Field | Required | Description |
|-------|----------|-------------|
| `name` | No | Name after `/` in chat (defaults to filename). Keep it short and memorable. |
| `description` | No | Short description shown in the command palette — helps teammates discover and understand the prompt. |
| `argument-hint` | No | Placeholder text shown in the chat input after the `/command` — guides the user on what to type. |
| `agent` | No | Which agent handles the prompt: `ask` (read-only answers), `edit` (file modifications), `agent` (autonomous multi-step), or a custom agent name. |
| `model` | No | Language model override. Omit to use the workspace default. |
| `tools` | No | YAML list of tools the prompt can access (see Tools section below). |

## Variables

Variables make prompts reusable across different files and contexts:

| Variable | Description |
|----------|-------------|
| `${workspaceFolder}` | Full workspace path |
| `${file}` | Current file path |
| `${fileBasename}` | Current filename |
| `${selection}` | Current editor selection |
| `${input:varName}` | Prompts the user for input at runtime |
| `${input:varName:placeholder}` | Input prompt with placeholder hint text |

## File References

Use relative markdown links to pull file content into the prompt context. This
gives the model direct access to reference code without the user needing to
attach files manually:

```markdown
Follow patterns in [auth service](../src/services/auth.ts)
Apply rules from [coding standards](../instructions/typescript.instructions.md)
```

## Tool References

Reference tools inline to tell the model what capabilities to use:

```markdown
Use #tool:terminal to run commands
Use #tool:codebase to search for related code
```

## Tools Configuration

The `tools` frontmatter field controls which capabilities the prompt can access.
Specify only what the prompt actually needs — restricting tools prevents
unintended side effects.

| Tool | What it does |
|------|-------------|
| `git` | Read git history, diffs, branches, and commits. |
| `github` | Interact with GitHub issues, pull requests, and actions. |
| `terminal` | Run shell commands. Grant this only when the prompt needs to execute scripts or CLI tools. |
| `codebase` | Search and read files across the workspace using Copilot's index. |
| `problems` | Access the VS Code Problems panel (linting errors, warnings, diagnostics). |

```yaml
# Grant specific tools
tools: [git, github, terminal]

# Grant all tools from an MCP server
tools: [myserver/*]
```

## Rules

- **Keep prompts focused on one task** — a prompt that tries to do everything
  becomes hard to maintain and produces inconsistent results. Split complex
  workflows into multiple prompts that chain together.
- **Use variables instead of hardcoding values** — hardcoded paths and names
  break when the prompt is used in a different context or by a different
  teammate.
- **Specify required tools explicitly** — omitting tools means the prompt cannot
  use them. Listing all tools when only one is needed grants unnecessary access.
- **Reference instruction files instead of duplicating guidelines** — if coding
  standards already exist in an instruction file, link to it. This keeps rules
  in one place.
- **Describe the expected output format** — tell the model what shape the result
  should take (e.g., "Return a markdown table", "Output a shell script"). This
  reduces ambiguity and retry loops.
- **Place files in `.github/prompts/`** with the `.prompt.md` extension — this
  is the standard location Copilot scans for prompt files.

## Complete Example

A prompt that generates a new API endpoint following project conventions:

```markdown
---
name: new-api-endpoint
description: Scaffold a new REST API endpoint with tests
argument-hint: "[resource name, e.g. 'users']"
agent: agent
tools: [terminal, codebase, git]
---

# Create API Endpoint

Scaffold a new REST API endpoint for the resource: ${input:resource:users}

## Steps

1. Use #tool:codebase to find an existing endpoint in `src/routes/` and use it
   as a structural reference.
2. Create the route file at `src/routes/${input:resource}.ts` following patterns
   in [existing route](../src/routes/health.ts).
3. Create the controller at `src/controllers/${input:resource}.ts`.
4. Add request/response types to `src/types/${input:resource}.ts`.
5. Register the route in [router config](../src/routes/index.ts).
6. Create a test file at `src/routes/${input:resource}.test.ts` following
   patterns in [existing test](../src/routes/health.test.ts).
7. Use #tool:terminal to run `npm test -- --filter ${input:resource}` and
   verify the tests pass.

## Standards

Apply the coding standards from
[TypeScript instructions](../instructions/typescript.instructions.md).
```

## Related Skills

See the **writing-instructions** skill for creating auto-applied coding
guidelines that prompt files can reference.
