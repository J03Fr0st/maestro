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

Custom agents for AI-assisted development (`copilot/agents/`):

| Agent | Purpose |
|-------|---------|
| **Beast Mode** | Autonomous problem-solving with research and testing |
| **Planner** | Generate executable implementation plans |
| **Implementer** | Execute implementation tasks from plans |
| **Reviewer** | Code review with security and performance focus |
| **Docs** | Documentation creation and updates |

### Instructions

Coding guidelines applied automatically based on file type (`copilot/instructions/`):

| Instruction | Scope |
|-------------|-------|
| **General** | All files - response style and code quality |
| **TypeScript** | `.ts` files - TypeScript patterns |
| **Angular** | Component files - Angular conventions |
| **DotNet** | `.cs` files - C# guidelines |
| **Testing** | Test files - testing standards |
| **Security** | All files - security practices |

### Prompts

Reusable task templates (`copilot/prompts/`):

**Development:**
- Commit messages, PRs, code review, performance optimization

**Documentation:**
- PRDs, technical planning, ADRs, changelogs

### Skills

Domain-specific knowledge documents (`copilot/skills/`):

| Skill | Description |
|-------|-------------|
| **azure-devops-cli** | Azure DevOps CLI commands and workflows |
| **code-review** | Code review checklist and guidelines |
| **gh-cli** | GitHub CLI reference |
| **project-documentation** | Brownfield project analysis |

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

1. Copy the `copilot/` folder to your project's `.github/` directory
2. Customize the instructions for your project
3. Start using agents, prompts, and skills in VS Code Copilot Chat

```bash
# Copy to your project
cp -r copilot/.github/* .github/
cp -r copilot/agents .github/
cp -r copilot/instructions .github/
cp -r copilot/prompts .github/
cp -r copilot/skills .github/
```
