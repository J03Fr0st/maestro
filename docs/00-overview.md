# Overview

-maestro is a comprehensive toolkit for customizing GitHub Copilot with reusable agents, prompts, instructions, and skills.

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
| **maestro Conductor** | Orchestrates multi-agent workflows |
| **maestro Planner** | Generate executable implementation plans |
| **maestro Implementer** | Execute implementation tasks from plans |
| **maestro Reviewer** | Code review with security and performance focus |
| **alphabeast** | Autonomous problem-solving agent |
| **betabeast** | Extended autonomous agent capabilities |
| **research** | Research and information gathering |
| **maestro Verifier** | Verify phase goals achieved, not just tasks completed |
| **maestro Mapper** | Explore codebase and create structured analysis documents |
| **maestro Debugger** | Systematic debugging using scientific method |
| **Code Review** | Code review and static analysis reporting |

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
| **Instructions** | `*.instructions.md` files - instruction file guidelines |
| **Prompts** | `*.prompt.md` files - prompt file guidelines |

### Prompts

Reusable task templates (`.github/prompts/`):

| Prompt | Purpose |
|--------|---------|
| `commit` | Smart git commit (triggers git-commit skill) |
| `project-docs` | Project documentation (triggers project-documentation skill) |
| `create-pr` | Create pull request with comprehensive description |
| `review` | Code review checklist |
| `adr` | Architecture decision records |
| `changelog` | Changelog entries |
| `planning` | Technical planning |
| `prd` | Product requirements document |

### Skills

Domain-specific knowledge following [Agent Skills spec](https://agentskills.io/specification) (`.github/skills/`):

| Skill | Description |
|-------|-------------|
| **azure-devops-cli** | Azure DevOps CLI operations |
| **brainstorming** | Design exploration before implementation |
| **code-review** | Code review (giving and requesting) |
| **dispatching-parallel-agents** | Parallel agent workflows |
| **executing-plans** | Batch execution with checkpoints |
| **gh-cli** | GitHub CLI operations |
| **git-commit** | Conventional commit messages |
| **pr-description** | PR description templates |
| **project-documentation** | Documentation guidelines |
| **receiving-code-review** | Handling review feedback |
| **frontend-design** | Production-grade frontend interface design |
| **refactor** | Surgical code refactoring |
| **skill-creator** | Creating skills following spec |
| **sonarqube-review** | SonarQube-style code analysis |
| **systematic-debugging** | Root cause debugging |
| **test-driven-development** | TDD workflow enforcement |
| **using-git-worktrees** | Isolated workspaces |
| **using-skills** | Mandatory skill checking before responses |
| **verification-before-completion** | Evidence before claims |
| **writing-plans** | Comprehensive implementation plans |

## Skills Overview

Maestro includes 20 skills covering:

**Development Discipline:**
- test-driven-development - TDD with RED-GREEN-REFACTOR
- verification-before-completion - Evidence before claims
- systematic-debugging - Root cause investigation

**Collaboration:**
- code-review - Giving and requesting reviews
- receiving-code-review - Handling feedback
- brainstorming - Design exploration

**Workflow:**
- dispatching-parallel-agents - Parallel agent execution
- executing-plans - Batch execution with checkpoints
- writing-plans - Comprehensive implementation plans
- using-git-worktrees - Isolated workspaces
- git-commit - Conventional commits
- pr-description - PR templates

**Design & Quality:**
- frontend-design - Production-grade frontend interfaces
- refactor - Surgical code refactoring
- sonarqube-review - SonarQube-style code analysis

**Platform:**
- gh-cli - GitHub CLI
- azure-devops-cli - Azure DevOps CLI
- skill-creator - Creating skills
- using-skills - Skill checking and activation
- project-documentation - Documentation

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
