# maestro

A comprehensive GitHub Copilot toolkit with reusable agents, prompts, instructions, and skills.

## Features

- **Agents**: AI role definitions for planning, implementing, reviewing, and documentation
- **Instructions**: Custom instructions for TypeScript, Angular, .NET, testing, and security
- **Prompts**: Reusable prompt templates for commits, PRs, reviews, ADRs, and more
- **Skills**: Domain-specific knowledge for Azure DevOps, GitHub CLI, code review, and project documentation

## Quick Installation

### Automated Installer

```powershell
# Windows (PowerShell)
.\installer\install.ps1

# macOS / Linux
./installer/install.sh
```

See [installer/README.md](installer/README.md) for advanced options.

### Manual Installation

Copy the `.github` folder to your project:

```bash
cp -r .github /path/to/your/project/
```

## Structure

```
maestro/
├── .github/
│   ├── copilot-instructions.md         # Repository-level instructions
│   ├── agents/                          # AI agent definitions
│   │   ├── maestro-conductor.agent.md   # Multi-agent orchestration
│   │   ├── maestro-planner.agent.md     # Implementation planning
│   │   ├── maestro-implementer.agent.md # Code execution
│   │   ├── maestro-reviewer.agent.md    # Code review
│   │   ├── alphabeast.agent.md          # Autonomous problem-solving
│   │   ├── betabeast.agent.md           # Extended autonomous agent
│   │   └── research.agent.md            # Research and information gathering
│   ├── instructions/                    # Custom instructions
│   │   ├── general.instructions.md
│   │   ├── typescript.instructions.md
│   │   ├── angular.instructions.md
│   │   ├── dotnet.instructions.md
│   │   ├── testing.instructions.md
│   │   ├── security.instructions.md
│   │   └── agents.instructions.md
│   ├── prompts/                         # Reusable prompts
│   │   ├── commit.prompt.md
│   │   ├── review.prompt.md
│   │   ├── project-docs.prompt.md
│   │   ├── prd.prompt.md
│   │   ├── planning.prompt.md
│   │   ├── adr.prompt.md
│   │   └── changelog.prompt.md
│   └── skills/                          # Domain knowledge
│       ├── azure-devops-cli/
│       ├── code-review/
│       ├── gh-cli/
│       ├── git-commit/
│       ├── pr-description/
│       ├── project-documentation/
│       └── skill-authoring/
├── installer/                           # Installation scripts
└── docs/                                # Documentation
```

## Agents

| Agent | Purpose |
|-------|---------|
| **maestro Conductor** | Orchestrates multi-agent workflows |
| **maestro Planner** | Generate structured implementation plans |
| **maestro Implementer** | Execute plans and make code changes |
| **maestro Reviewer** | Thorough code review with security checks |
| **alphabeast** | Autonomous problem-solving agent |
| **betabeast** | Extended autonomous agent capabilities |
| **research** | Research and information gathering |

## Documentation

- [Overview](docs/00-overview.md)
- [Copilot Configuration](docs/30-copilot.md)
- [Copilot Chat](docs/35-copilot-chat.md)
- [Agents](docs/40-agents.md)
- [Instructions](docs/45-instructions.md)
- [Prompts](docs/50-prompts.md)
- [Tools](docs/55-tools.md)
- [Skills](docs/60-skills.md)

## License

MIT
