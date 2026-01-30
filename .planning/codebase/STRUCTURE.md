# Codebase Structure

**Analysis Date:** 2026-01-30

## Directory Layout

```
maestro/
├── .github/
│   ├── agents/                      # Agent definitions (orchestration system)
│   ├── instructions/                # Language/context-specific coding standards
│   ├── prompts/                     # Reusable task templates
│   └── skills/                      # Domain-specific knowledge (Agent Skills spec)
├── .planning/
│   └── codebase/                    # Generated codebase analysis documents
├── docs/                            # Documentation about maestro toolkit
│   └── plans/                       # Implementation plans and examples
├── installer/                       # Installation scripts (PowerShell, bash)
├── plan/                            # Generated Tech Spec files (active plans)
├── vite-app/                        # Example Vite application (demo/sample)
├── LICENSE                          # MIT License
├── README.md                        # Project overview and quick start
└── .gitignore                       # Git ignore patterns
```

## Directory Purposes

**`.github/agents/`:**
- Purpose: Agent definitions for the maestro orchestration system
- Contains: 10 agent definitions (.agent.md files)
- Key files:
  - `maestro-conductor.agent.md` - Orchestrator
  - `maestro-planner.agent.md` - Context gathering and Tech Spec generation
  - `maestro-implementer.agent.md` - TDD execution
  - `maestro-reviewer.agent.md` - Code validation
  - `maestro-verifier.agent.md` - Goal verification
  - `maestro-mapper.agent.md` - Codebase analysis and documentation
  - `maestro-debugger.agent.md` - Systematic debugging
  - `alphabeast.agent.md` - Autonomous parallel agent
  - `betabeast.agent.md` - Extended autonomous agent
  - `research.agent.md` - Information gathering

**`.github/instructions/`:**
- Purpose: Language and context-specific coding standards
- Contains: 7 instruction files (.instructions.md)
- Key files:
  - `general.instructions.md` - Response style and code quality baseline
  - `typescript.instructions.md` - TypeScript patterns and conventions
  - `angular.instructions.md` - Angular framework patterns
  - `dotnet.instructions.md` - C# / .NET guidelines
  - `testing.instructions.md` - Testing standards
  - `security.instructions.md` - Security practices
  - `agents.instructions.md` - Agent file authoring guidelines

**`.github/prompts/`:**
- Purpose: Reusable task templates with variable substitution
- Contains: 7 prompt files (.prompt.md)
- Key files:
  - `commit.prompt.md` - Conventional commit generation
  - `review.prompt.md` - Code review checklist
  - `planning.prompt.md` - Technical planning
  - `prd.prompt.md` - Product requirements document
  - `adr.prompt.md` - Architecture decision records
  - `changelog.prompt.md` - Changelog entries
  - `project-docs.prompt.md` - Project documentation

**`.github/skills/`:**
- Purpose: Domain-specific knowledge following Agent Skills spec
- Contains: 18 skills in subdirectories
- Key directories:
  - `test-driven-development/` - TDD methodology
  - `code-review/` - Code review checklist
  - `writing-plans/` - Implementation plan guidance
  - `verification-before-completion/` - Verification discipline
  - `systematic-debugging/` - Debugging methodology
  - `receiving-code-review/` - Handling feedback
  - `brainstorming/` - Design exploration
  - `dispatching-parallel-agents/` - Parallel execution
  - `executing-plans/` - Batch execution
  - `using-git-worktrees/` - Isolated workspaces
  - `git-commit/` - Conventional commits
  - `pr-description/` - PR templates
  - `gh-cli/` - GitHub CLI operations
  - `azure-devops-cli/` - Azure DevOps operations
  - `project-documentation/` - Documentation guidelines
  - `skill-authoring/` - Creating skills
  - `using-superpowers/` - Mandatory skill checking
  - `subagent-driven-development/` - Two-stage review

**`.planning/codebase/`:**
- Purpose: Generated codebase analysis documents consumed by agents
- Contains: Analysis documents written by maestro-mapper
- Key files:
  - `STACK.md` - Technology stack analysis
  - `INTEGRATIONS.md` - External service integrations
  - `ARCHITECTURE.md` - Architecture patterns and layers
  - `STRUCTURE.md` - Directory layout and file organization
  - `CONVENTIONS.md` - Naming and coding conventions
  - `TESTING.md` - Test framework and patterns
  - `CONCERNS.md` - Technical debt and issues

**`docs/`:**
- Purpose: Documentation about maestro toolkit
- Contains: Markdown documentation files
- Key files:
  - `00-overview.md` - Overview of toolkit components
  - `30-copilot.md` - Copilot configuration
  - `35-copilot-chat.md` - Chat features
  - `40-agents.md` - Agent system and types
  - `45-instructions.md` - Custom instruction files
  - `50-prompts.md` - Prompt file format and usage
  - `55-tools.md` - Tool reference
  - `60-skills.md` - Skills library overview
  - `plans/` - Example implementation plans

**`installer/`:**
- Purpose: Installation scripts for adding maestro to projects
- Contains: PowerShell and shell scripts
- Key files: `install.ps1`, `install.sh`

**`plan/`:**
- Purpose: Directory for generated Tech Spec files (active implementation plans)
- Contains: `.md` files created by Conductor/Planner
- Pattern: `YYYY-MM-DD-<feature-name>.md`

## Key File Locations

**Entry Points:**
- `README.md` - Project entry point with overview and quick start
- `.github/agents/maestro-conductor.agent.md` - Workflow orchestrator entry point

**Agent Definitions:**
- `.github/agents/maestro-*.agent.md` - All specialized agents

**Configuration & Metadata:**
- `.github/copilot-instructions.md` - Repository-level Copilot instructions (if present)
- Each agent frontmatter - YAML metadata (name, description, tools, model)
- Each skill frontmatter - YAML metadata (name, description)

**Core Knowledge:**
- `.github/instructions/*.md` - Language standards
- `.github/prompts/*.md` - Task templates
- `.github/skills/*/SKILL.md` - Skill definitions

**Generated Context:**
- `.planning/codebase/*.md` - Analysis documents for target codebase

## Naming Conventions

**Files:**
- Agents: `{role}.agent.md` (e.g., `maestro-conductor.agent.md`)
- Instructions: `{language-or-context}.instructions.md` (e.g., `typescript.instructions.md`)
- Prompts: `{task-name}.prompt.md` (e.g., `commit.prompt.md`)
- Skills: `SKILL.md` in `{skill-name}/` directory (e.g., `.github/skills/code-review/SKILL.md`)
- Plans: `YYYY-MM-DD-{feature-name}.md` in `/plan/` directory
- Analysis: `UPPERCASE.md` in `.planning/codebase/` (e.g., `ARCHITECTURE.md`)
- Documentation: `{number}-{title}.md` in `docs/` (e.g., `40-agents.md`)

**Directories:**
- Agent roles: `maestro-{role}` (e.g., `maestro-conductor`, `maestro-implementer`)
- Skill names: lowercase with hyphens (e.g., `test-driven-development`, `code-review`)
- Special directories: `agents/`, `instructions/`, `prompts/`, `skills/`, `codebase/`, `plans/`

## Where to Add New Code

**New Agent:**
- Implementation: `.github/agents/{role}.agent.md`
- Format: YAML frontmatter + Markdown body (see agents.instructions.md)
- Pattern: Define identity, responsibilities, workflow, skill integration

**New Skill:**
- Implementation: `.github/skills/{skill-name}/SKILL.md`
- Optional: `.github/skills/{skill-name}/references/REFERENCE.md` for detailed docs
- Pattern: Follow Agent Skills specification (name, description, when to use, instructions)

**New Instruction:**
- Implementation: `.github/instructions/{context}.instructions.md`
- Pattern: Language/framework-specific coding standards
- Usage: Auto-applied based on file type or context

**New Prompt:**
- Implementation: `.github/prompts/{task}.prompt.md`
- Pattern: YAML frontmatter + Markdown with ${input:*} variables
- Usage: Invoked via `/` command in chat

**Codebase Analysis:**
- Implementation: `.planning/codebase/{DOC_NAME}.md`
- Pattern: Written by maestro-mapper, read by planner/implementer
- Focus areas: STACK, INTEGRATIONS, ARCHITECTURE, STRUCTURE, CONVENTIONS, TESTING, CONCERNS

## Special Directories

**`.planning/codebase/`:**
- Purpose: Context documents for client codebase
- Generated: Yes (by maestro-mapper)
- Committed: Yes (to version control for team reference)
- Usage: Loaded by Planner and Implementer agents

**`plan/`:**
- Purpose: Active implementation specifications
- Generated: Yes (by Conductor/Planner)
- Committed: Depends on workflow (can be committed for team visibility)
- Usage: Single source of truth during implementation cycle

**`.github/skills/*/references/`:**
- Purpose: Detailed reference material for large skills
- Generated: Typically hand-authored
- Committed: Yes
- Usage: Loaded on-demand when skill is activated

**`docs/plans/`:**
- Purpose: Example plans and plan templates
- Generated: Typically hand-authored
- Committed: Yes
- Usage: Reference for plan writers

---

*Structure analysis: 2026-01-30*
