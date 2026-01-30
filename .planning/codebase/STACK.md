# Technology Stack

**Analysis Date:** 2026-01-30

## Languages

**Primary:**
- Markdown - Documentation, agent definitions, skills, instructions, prompts
- Shell/Bash - Installation scripts for Unix-like systems (`installer/install.sh`)
- PowerShell - Installation scripts for Windows (`installer/install.ps1`)

**Secondary:**
- YAML - Configuration in agent frontmatter, instruction metadata

## Runtime

**Environment:**
- VS Code / VS Code Insiders - Primary execution environment
- GitHub Copilot - AI foundation (Claude models for agents)

**CLI Tools:**
- GitHub CLI (gh) - GitHub operations
- Azure DevOps CLI (az devops) - Azure DevOps operations
- Git - Version control

**Package Managers:**
- Not applicable - This is a configuration toolkit, not a code library

## Frameworks

**Core:**
- VS Code Copilot Agent SDK (`.agent.md` format with YAML frontmatter) - AI agent definitions
- Agent Skills Specification (https://agentskills.io/specification) - Skill authoring framework

**Copilot Integration:**
- Custom Instructions - File-type specific guidance system
- Custom Agents - Specialized AI personas for different workflows
- Prompt Files - Reusable task templates
- Skills - Domain-specific knowledge modules

**Architecture:**
- Model Context Protocol (MCP) - Optional support for rich tool integration

## Key Dependencies

**Critical:**
- GitHub Copilot Extension (VS Code) - Required for agent and instruction execution
- Claude models (Opus 4.5, Sonnet 4.5, Haiku 4.5) - LLM backbone for agents
- Gemini 3 Flash - Alternative model for maestro-implementer agent

**Infrastructure:**
- GitHub (or Azure DevOps) - Required for CLI-based operations and integration
- VS Code built-in tools - File operations, terminal execution, code search
- MCP servers (optional) - Extended tool capabilities

## Configuration

**Environment:**
- VS Code settings (workspace/user level) - Tool preferences and model selection
- .github/ directory - Configuration and customization location
- Installation scopes: Workspace (default), User (across workspaces), Global

**Build:**
- No build system required
- Installation via PowerShell (`install.ps1`) or Bash (`install.sh`) scripts
- Configuration files:
  - `installer/install.ps1` - Windows installer with scope selection
  - `installer/install.sh` - Unix installer with scope selection

**Structure:**
```
.github/
├── agents/               # Custom agent definitions (.agent.md files)
│   ├── maestro-conductor.agent.md
│   ├── maestro-planner.agent.md
│   ├── maestro-implementer.agent.md
│   ├── maestro-reviewer.agent.md
│   ├── maestro-mapper.agent.md
│   ├── maestro-debugger.agent.md
│   ├── maestro-verifier.agent.md
│   ├── alphabeast.agent.md
│   ├── betabeast.agent.md
│   └── research.agent.md
├── instructions/         # File-type specific guidelines
│   ├── general.instructions.md
│   ├── typescript.instructions.md
│   ├── angular.instructions.md
│   ├── dotnet.instructions.md
│   ├── testing.instructions.md
│   ├── security.instructions.md
│   └── agents.instructions.md
├── prompts/              # Reusable prompt templates
│   ├── commit.prompt.md
│   ├── review.prompt.md
│   ├── planning.prompt.md
│   ├── adr.prompt.md
│   ├── changelog.prompt.md
│   ├── prd.prompt.md
│   └── project-docs.prompt.md
└── skills/               # Domain-specific knowledge modules
    ├── azure-devops-cli/
    ├── brainstorming/
    ├── code-review/
    ├── dispatching-parallel-agents/
    ├── executing-plans/
    ├── gh-cli/
    ├── git-commit/
    ├── pr-description/
    ├── project-documentation/
    ├── receiving-code-review/
    ├── skill-authoring/
    ├── subagent-driven-development/
    ├── systematic-debugging/
    ├── test-driven-development/
    ├── using-git-worktrees/
    ├── using-superpowers/
    ├── verification-before-completion/
    └── writing-plans/
```

## Platform Requirements

**Development:**
- VS Code 1.85+ or VS Code Insiders
- GitHub Copilot extension installed and authenticated
- Git CLI installed (for version control integration)
- PowerShell 5.1+ (Windows) or Bash (macOS/Linux)
- Optional: Azure DevOps CLI (for Azure DevOps operations)
- Optional: GitHub CLI (for GitHub operations)

**Production (Usage):**
- VS Code with Copilot enabled
- Active GitHub Copilot subscription
- Agent files must be copied to target workspace `.github/agents/`
- Instructions, prompts, and skills must be in `.github/` directory

**Installation Targets:**
- Workspace-level: `.github/` directory in project root
- User-level: VS Code User profile directory for all workspaces
- Global: `~/.github/` directory (macOS/Linux) or equivalent

---

*Stack analysis: 2026-01-30*
