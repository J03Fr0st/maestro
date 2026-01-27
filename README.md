# maestro

A comprehensive GitHub Copilot toolkit with reusable agents, prompts, instructions, and skills.

## Features

- **Agents**: AI role definitions for planning, implementing, reviewing, and documentation
- **Instructions**: Custom instructions for TypeScript, Angular, .NET, testing, and security
- **Prompts**: Reusable prompt templates for commits, PRs, reviews, ADRs, and more
- **Skills**: Domain-specific knowledge for Azure DevOps, GitHub CLI, code review, and project documentation

## Structure

```
maestro/
├── copilot/
│   ├── .github/
│   │   └── copilot-instructions.md    # Repository-level instructions
│   ├── agents/                         # AI agent definitions
│   │   ├── planner.agent.md           # Implementation planning
│   │   ├── implementer.agent.md       # Code execution
│   │   ├── reviewer.agent.md          # Code review
│   │   ├── beastmode.agent.md         # Autonomous parallel tasks
│   │   └── docs.agent.md              # Documentation
│   ├── instructions/                   # Custom instructions
│   │   ├── general.instructions.md
│   │   ├── typescript.instructions.md
│   │   ├── angular.instructions.md
│   │   ├── dotnet.instructions.md
│   │   ├── testing.instructions.md
│   │   └── security.instructions.md
│   ├── prompts/                        # Reusable prompts
│   │   ├── dev/                        # Development prompts
│   │   │   ├── commit.prompt.md
│   │   │   ├── pr.prompt.md
│   │   │   ├── review.prompt.md
│   │   │   └── performance.prompt.md
│   │   └── docs/                       # Documentation prompts
│   │       ├── prd.prompt.md
│   │       ├── planning.prompt.md
│   │       ├── adr.prompt.md
│   │       └── changelog.prompt.md
│   └── skills/                         # Domain knowledge
│       ├── azure-devops-cli/
│       ├── code-review/
│       ├── gh-cli/
│       └── project-documentation/
└── docs/                               # Documentation
```

## Agents

| Agent | Purpose |
|-------|---------|
| **maestro Planner** | Generate structured implementation plans |
| **maestro Implementer** | Execute plans and make code changes |
| **maestro Reviewer** | Thorough code review with security checks |
| **Beast Mode** | Autonomous parallel task execution |
| **Docs** | Create and maintain documentation |

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
