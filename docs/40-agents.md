# Agents

## Overview

Agents are AI-powered assistants that can autonomously plan and execute complex development tasks. VS Code Copilot supports several agent types, each optimized for different workflows.

Custom agents are located in `.github/agents/` and are auto-discovered by VS Code.

## Agent Types

VS Code supports four main agent categories:

| Type | Description | Best For |
|------|-------------|----------|
| **Local Agents** | Run directly within VS Code with full workspace access | Interactive tasks, real-time feedback, brainstorming |
| **Background Agents** | Run non-interactively using CLI tools | Autonomous, well-defined tasks without real-time interaction |
| **Cloud Agents** | Run on remote infrastructure (GitHub) | Team collaboration via branches and pull requests |
| **Third-Party Agents** | External providers integrated into VS Code | Unified session management across AI providers |

### Local Agents
- Full access to VS Code built-in tools, MCP servers, and extension tools
- Best for planning, brainstorming, and tasks requiring immediate developer context
- Support BYOK (Bring Your Own Key) models

### Background Agents
- Use Git worktrees for isolated operation
- Limited to CLI-provided models
- Cannot access MCP or extension tools

### Cloud Agents
- Integrate with GitHub for team collaboration
- Can access MCP servers in remote environments
- Ideal for implementations requiring multiple reviewers

## Available Agents

| Agent | Purpose |
|-------|---------|
| `maestro-conductor.agent.md` | Orchestrates multi-agent workflows |
| `maestro-planner.agent.md` | Generate executable implementation plans |
| `maestro-implementer.agent.md` | Execute implementation tasks from plans |
| `maestro-reviewer.agent.md` | Code review with security and performance focus |
| `alphabeast.agent.md` | Autonomous problem-solving agent |
| `betabeast.agent.md` | Extended autonomous agent capabilities |
| `research.agent.md` | Research and information gathering |

## Agent File Format

Custom agents use the `.agent.md` extension with YAML frontmatter and Markdown body:

```markdown
---
name: my-agent
description: Brief description shown in chat
tools:
  - search
  - read
  - edit
  - execute
model: gpt-4o
---

# Agent Name

## Primary Directive
Instructions for the agent's behavior...

## Workflow
1. Step one
2. Step two

## Rules
- Rule 1
- Rule 2
```

## Frontmatter Fields

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `name` | string | No | Agent identifier (defaults to filename) |
| `description` | string | Yes | Brief overview shown as placeholder text |
| `tools` | list | No | Available tools for the agent |
| `model` | string | No | Specific AI model to use |
| `infer` | boolean | No | Enable subagent functionality |
| `target` | string | No | Environment: `vscode` or `github-copilot` |
| `handoffs` | list | No | Sequential workflow transitions to other agents |
| `mcp-servers` | object | No | Optional MCP server configurations |

## Tool Syntax

Reference tools in the agent body using the `#tool:<tool-name>` syntax:

```markdown
Use #tool:search/codebase to find relevant code.
Use #tool:read/readFile to examine file contents.
Use #tool:edit/editFiles to make modifications.
```

## Tool Sets

Tools are organized into sets for easier management:

### `search` — Search files in your workspace
| Tool | Description |
|------|-------------|
| `#tool:search/codebase` | Semantic search across code |
| `#tool:search/usages` | Find symbol usages |
| `#tool:search/changes` | List git changes |
| `#tool:search/fileSearch` | Glob-based file search |
| `#tool:search/listDirectory` | List directory contents |
| `#tool:search/textSearch` | Text/regex search across files |

### `read` — Read files in your workspace
| Tool | Description |
|------|-------------|
| `#tool:read/readFile` | Read file contents (full or range) |
| `#tool:read/problems` | Get compile or lint errors |
| `#tool:read/terminalSelection` | Get selection from terminal |
| `#tool:read/terminalLastCommand` | Get last terminal command |

### `edit` — Edit files in your workspace
| Tool | Description |
|------|-------------|
| `#tool:edit/editFiles` | Apply precise file modifications |
| `#tool:edit/createFile` | Create a new file with content |
| `#tool:edit/createDirectory` | Create folders/directories |

### `execute` — Execute code and commands
| Tool | Description |
|------|-------------|
| `#tool:execute/runInTerminal` | Execute shell command in terminal |
| `#tool:execute/getTerminalOutput` | Read terminal command output |
| `#tool:execute/runTask` | Run an existing VS Code task |
| `#tool:execute/runTests` | Run unit tests |

### `web` — Fetch information from the web
| Tool | Description |
|------|-------------|
| `#tool:web/fetch` | Retrieve and read web pages |
| `#tool:web/githubRepo` | Search GitHub repositories |

### `vscode` — VS Code features
| Tool | Description |
|------|-------------|
| `#tool:vscode/vscodeAPI` | VS Code extension API docs |
| `#tool:vscode/extensions` | Search and manage extensions |
| `#tool:vscode/runCommand` | Execute a VS Code command |
| `#tool:vscode/memory` | Access persistent memory |

## Handoffs

Handoffs create guided workflows transitioning between agents:

```yaml
---
name: planner
description: Create implementation plans
tools: ['search', 'read', 'web']
handoffs:
  - agent: implementer
    prompt: "Implement the plan above"
    send: true  # Auto-submit the prompt
---
```

When users complete a task with the planner agent, a handoff button enables seamless transition to the implementer agent with pre-filled context.

## Tool Priority

Tools are resolved in this order:
1. Prompt file tools (if invoked via prompt)
2. Custom agent tools
3. Default agent tools

## Using Custom Agents

In VS Code Copilot Chat, type `@` followed by the agent name:

```
@alphabeast Fix the authentication bug in the login flow
@maestro-planner Create a plan for implementing user notifications
```

## Storage Locations

| Location | Scope | Discovery |
|----------|-------|-----------|
| `.github/agents/` | Workspace | Auto-discovered |
| User profile folder | All workspaces | Auto-discovered |
| Organization repository | Enterprise | Requires setting enabled |

## Creating New Agents

1. Create a file in `.github/agents/` with `.agent.md` extension
2. Add YAML frontmatter with `description` and `tools`
3. Write clear instructions in the Markdown body
4. Reference tools with `#tool:<tool-name>` syntax

### Best Practices

- **Be specific**: Clear, unambiguous instructions produce better results
- **Limit tools**: Only include tools the agent actually needs
- **Define workflows**: Step-by-step processes are easier to follow
- **Set boundaries**: Define what the agent should NOT do
- **Use handoffs**: Chain agents for complex multi-phase workflows
