# Overview

Maestro is a comprehensive toolkit for customizing GitHub Copilot with reusable agents, prompts, instructions, and skills.

## What's Included

### GitHub Copilot Configuration

| Component | Purpose | Documentation |
|-----------|---------|---------------|
| **Agents** | AI personas with specific tools and instructions | [Agents](40-agents.md) |
| **Instructions** | Coding guidelines applied automatically | [Instructions](45-instructions.md) |
| **Prompts** | Reusable task templates | [Prompts](50-prompts.md) |
| **Tools** | Built-in and MCP tool reference | [Tools](55-tools.md) |
| **Skills** | Domain-specific knowledge documents | [Skills](60-skills.md) |

### Agents

Custom agents for AI-assisted development (`.github/agents/`):

| Agent | Purpose |
|-------|---------|
| **Maestro Conductor** | Orchestrates multi-agent workflows |
| **Maestro Planner** | Generate executable implementation plans |
| **Maestro Implementer** | Execute implementation tasks from plans |
| **Maestro Reviewer** | Code review with security and performance focus |

### Instructions

Coding guidelines applied automatically based on file type (`.github/instructions/`):

| Instruction | Scope |
|-------------|-------|
| **General** | All files - response style and code quality |
| **TypeScript** | `.ts` files - TypeScript patterns |
| **Angular** | Component files - Angular conventions |
| **DotNet** | `.cs` files - C# guidelines |
| **Testing** | Test files - testing standards |
| **Security** | All files - security practices |
| **Agents** | Agent file guidelines |

### Prompts

Reusable task templates (`.github/prompts/`):

| Prompt | Purpose |
|--------|---------|
| `commit` | Smart git commit (triggers git-commit skill) |
| `project-docs` | Project documentation (triggers project-documentation skill) |
| `review` | Code review checklist |
| `adr` | Architecture decision records |
| `changelog` | Changelog entries |
| `planning` | Technical planning |
| `prd` | Product requirements document |

### Skills

Domain-specific knowledge following [Agent Skills spec](https://agentskills.io/specification) (`.github/skills/`):

| Skill | Description |
|-------|-------------|
| **azure-devops-cli** | Azure DevOps CLI for projects, repos, pipelines, PRs |
| **code-review** | Code review checklist covering correctness, security, performance |
| **gh-cli** | GitHub CLI for repositories, issues, PRs, and Actions |
| **git-commit** | Conventional commit messages with quality checks |
| **pr-description** | Generate PR descriptions from git changes |
| **project-documentation** | Brownfield project documentation and analysis |
| **skill-authoring** | Create agent skills following the spec |

## Documentation

| Topic | Description |
|-------|-------------|
| [Copilot Configuration](30-copilot.md) | Repository-level instructions |
| [Copilot Chat](35-copilot-chat.md) | Chat features and usage |
| [Agents](40-agents.md) | Custom agent creation |
| [Instructions](45-instructions.md) | Custom instruction files |
| [Prompts](50-prompts.md) | Reusable prompt templates |
| [Tools](55-tools.md) | Built-in and MCP tools reference |
| [Skills](60-skills.md) | Domain knowledge documents |

## Quick Start

1. Copy the `.github/` folder components to your project
2. Customize the instructions for your project
3. Start using agents, prompts, and skills in VS Code Copilot Chat

```bash
# Copy to your project
cp -r .github/agents your-project/.github/
cp -r .github/instructions your-project/.github/
cp -r .github/prompts your-project/.github/
cp -r .github/skills your-project/.github/
```
