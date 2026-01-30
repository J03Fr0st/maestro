# External Integrations

**Analysis Date:** 2026-01-30

## APIs & External Services

**GitHub:**
- GitHub Copilot API - Core AI foundation for all agents
  - SDK/Client: VS Code Copilot Extension
  - Auth: GitHub authentication via VS Code
  - Referenced in: All `.agent.md` files

- GitHub REST API - GitHub operations
  - SDK/Client: GitHub CLI (gh)
  - Auth: GitHub personal access token
  - Skill: `gh-cli` in `.github/skills/gh-cli/`

**Azure DevOps:**
- Azure DevOps REST API - Azure DevOps operations
  - SDK/Client: Azure DevOps CLI (az devops)
  - Auth: Azure DevOps PAT (personal access token)
  - Skill: `azure-devops-cli` in `.github/skills/azure-devops-cli/`

**AI Models:**
- Claude (Anthropic) - Default LLM for agents
  - Versions: Claude Opus 4.5, Claude Sonnet 4.5, Claude Haiku 4.5
  - Used by: maestro-conductor, maestro-planner, maestro-mapper, maestro-reviewer, maestro-verifier
  - Config: Specified in agent `model` field

- Gemini 3 Flash - Alternative model for implementation
  - Used by: maestro-implementer agent
  - Config: Specified in `.github/agents/maestro-implementer.agent.md`

**Web/Documentation:**
- Agent Skills Specification (agentskills.io) - External skill reference
  - Purpose: Skill authoring standard compliance
  - Referenced in: `.github/skills/skill-authoring/SKILL.md`

- VS Code Documentation - Extension API and tool references
  - Tools: #tool:VSCodeAPI for querying VS Code capabilities

## Data Storage

**Not Integrated:**
- No traditional databases (SQLite, PostgreSQL, etc.)
- No external storage services
- Toolkit operates entirely through VS Code workspace files

**File Storage:**
- Local filesystem only - Stores configuration files in `.github/` directory
- Git repository - Version control for toolkit and project configurations

**Caching:**
- VS Code Memory API - Persistent memory for agents (via `#tool:vscode/memory`)
- Agent state stored in memory during session
- Plans persisted in `/plan/` directory as Markdown files

## Authentication & Identity

**Auth Provider:**
- GitHub/GitHub Copilot - Primary authentication
  - Implementation: VS Code built-in OAuth flow
  - Scope: Copilot access and GitHub CLI operations
  - Fallback: Azure AD for enterprise deployments

- Azure DevOps - Optional auth for Azure operations
  - Implementation: Personal Access Token (PAT)
  - Scope: Azure DevOps project management operations

**Secrets Management:**
- Environment variables - For CLI tool authentication
  - `GITHUB_TOKEN` - GitHub CLI authentication
  - `AZURE_DEVOPS_EXT_PAT` - Azure DevOps CLI authentication
  - Not committed to repository

- VS Code Secrets Storage - For sensitive configuration
  - Method: VS Code handles OAuth token storage securely

## Monitoring & Observability

**Error Tracking:**
- None integrated directly in toolkit
- Relies on Copilot's internal logging
- Agent execution errors reported in VS Code chat interface

**Logs:**
- VS Code Debug Console - Execution logs visible to user
- Terminal output - From CLI commands (git, gh, az devops)
- Chat history - Persistent in VS Code Copilot chat view
- Plan files - Markdown documentation of execution in `/plan/` directory

## CI/CD & Deployment

**Hosting:**
- GitHub (primary) - Repository hosting for toolkit and configuration
- Azure DevOps (optional) - Alternative for enterprise environments
- VS Code Copilot Cloud - Execution environment for cloud agents

**CI Pipeline:**
- Not applicable - Toolkit is configuration, not code with CI/CD
- Installation via PowerShell or Bash scripts (manual or in CI)
- No automated testing pipeline

**Git Workflows:**
- Git Worktrees - Supported via `using-git-worktrees` skill in `.github/skills/using-git-worktrees/`
- Branch management via maestro agents (git operations through gh-cli)
- Commit generation via `git-commit` skill in `.github/skills/git-commit/`

## Environment Configuration

**Required env vars:**
- `GITHUB_TOKEN` (optional) - GitHub CLI operations (gh)
  - If not set: GitHub CLI will prompt for authentication
  - Format: GitHub personal access token with repo scope

- `AZURE_DEVOPS_EXT_PAT` (optional) - Azure DevOps CLI operations (az devops)
  - If not set: Azure CLI will prompt for authentication
  - Format: Azure DevOps personal access token

- `ANTHROPIC_API_KEY` (optional) - Direct Claude API usage (if not using Copilot)
  - Only needed if agents are configured to use direct API instead of Copilot

**Secrets location:**
- Stored in: VS Code Secrets Storage API (encrypted)
- Never committed: .gitignore excludes `.env` files
- Configuration template: `.env.example` (not present in repo)

**VS Code Settings:**
- User/Workspace settings control agent availability
- Setting: `vs.copilot.agents.enableCustomAgents` - Enable/disable custom agents
- Setting: `vs.copilot.chat.managedCopilot` - Select which Claude model version

## Webhooks & Callbacks

**Incoming:**
- Copilot Chat UI - Triggers agents when user invokes with `@agent-name`
- Terminal execution hooks - Triggered by `#tool:execute/runInTerminal`
- File system watchers - Triggered by changes to monitored files (via MCP)

**Outgoing:**
- Git push webhooks (optional) - If configured in GitHub repository
  - Can trigger GitHub Actions on commit
  - Integration point: `git-commit` skill for conventional commits

- Pull Request webhooks (optional) - If configured in GitHub repository
  - Can trigger code review workflows
  - Integration point: `code-review` skill in `.github/skills/code-review/`

- GitHub Actions - Can be triggered by maestro agents
  - Integration: Via GitHub CLI (`gh workflow run`)
  - Skill: `gh-cli` in `.github/skills/gh-cli/` includes workflow operations

## Tool Integration Points

**VS Code Built-in Tools:**
- Search tools: codebase, fileSearch, textSearch, usages
- Read tools: readFile, problems, selection
- Edit tools: editFiles, createFile, createDirectory
- Execute tools: runInTerminal, runTask, runTests, getTerminalOutput
- Context tools: changes, todos, VSCodeAPI

**MCP (Model Context Protocol) Servers:**
- Optional connection point in agent definition
- Specified in agent `mcp-servers` field
- Enables custom tool integrations beyond VS Code

**GitHub/Azure DevOps Integration:**
- `maestro-conductor` uses `runSubagent` to delegate to specialized agents
- Agents use CLI tools for git, GitHub, and Azure DevOps operations
- Skills reference specific CLI commands in documentation

---

*Integration audit: 2026-01-30*
