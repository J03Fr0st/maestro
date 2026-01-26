# GitHub Copilot Configuration

## Overview

This toolkit provides structured guidance for GitHub Copilot through multiple customization layers:

| Layer | Purpose | Scope |
|-------|---------|-------|
| [Repository Instructions](#repository-instructions) | Project-wide coding conventions | All chat requests |
| [Custom Instructions](45-instructions.md) | File-type specific guidelines | Matching files |
| [Custom Agents](40-agents.md) | Task-specific AI personas | Selected agent |
| [Prompt Files](50-prompts.md) | Reusable task templates | Per prompt |
| [Skills](60-skills.md) | Domain knowledge documents | Auto-activated |

## Repository Instructions

GitHub Copilot supports repository-level instructions via `.github/copilot-instructions.md`. This file applies to all chat requests in the workspace.

### Location

The template is at `copilot/.github/copilot-instructions.md`. Copy it to your project:

```bash
cp copilot/.github/copilot-instructions.md .github/
```

### Contents

The instructions file defines:
- Project tech stack and frameworks
- Coding conventions and style guides
- File structure expectations
- Testing requirements
- PR/commit conventions

### Example

```markdown
# Project Instructions

## Tech Stack
- TypeScript 5.x with strict mode
- Angular 17 with standalone components
- Jest for unit testing
- Playwright for E2E testing

## Conventions
- Use barrel exports (index.ts)
- Prefer composition over inheritance
- All public APIs must have JSDoc comments

## File Structure
- Components in `src/app/components/`
- Services in `src/app/services/`
- Models in `src/app/models/`

## Testing
- Unit tests required for all services
- Component tests for user interactions
- Minimum 80% code coverage
```

## Instruction Files

Located in `copilot/instructions/`, these files are auto-discovered and apply based on glob patterns:

| File | Scope | Description |
|------|-------|-------------|
| `general.instructions.md` | `**` | Response style and code quality |
| `typescript.instructions.md` | `**/*.ts` | TypeScript patterns |
| `angular.instructions.md` | `**/*.component.ts` | Angular conventions |
| `dotnet.instructions.md` | `**/*.cs` | C# guidelines |
| `testing.instructions.md` | `**/*.spec.ts` | Testing standards |
| `security.instructions.md` | `**` | Security practices |

See [Custom Instructions](45-instructions.md) for detailed documentation.

## Custom Agents

Located in `copilot/agents/`, custom agents are AI personas with specific tools and instructions:

| Agent | Purpose |
|-------|---------|
| `beastmode.agent.md` | Autonomous problem-solving |
| `planner.agent.md` | Implementation planning |
| `implementer.agent.md` | Code implementation |
| `reviewer.agent.md` | Code review |
| `docs.agent.md` | Documentation |

See [Agents](40-agents.md) for detailed documentation.

## Prompt Files

Located in `copilot/prompts/`, prompts are reusable templates for common tasks:

**Development (`dev/`):**
- `commit.prompt.md` - Smart git commit
- `pr.prompt.md` - PR description generation
- `review.prompt.md` - Code review
- `performance.prompt.md` - Performance optimization

**Documentation (`docs/`):**
- `prd.prompt.md` - Product requirements
- `planning.prompt.md` - Technical planning
- `adr.prompt.md` - Architecture decisions
- `changelog.prompt.md` - Changelog entries

See [Prompts](50-prompts.md) for detailed documentation.

## Skills

Located in `copilot/skills/`, skills are domain knowledge documents:

| Skill | Description |
|-------|-------------|
| `azure-devops-cli` | Azure DevOps CLI reference |
| `code-review` | Review checklist |
| `gh-cli` | GitHub CLI commands |
| `project-documentation` | Project analysis |

See [Skills](60-skills.md) for detailed documentation.

## Project Setup

Copy files to your project's `.github/` directory:

```bash
# Repository instructions
cp copilot/.github/copilot-instructions.md .github/

# Agents
cp -r copilot/agents .github/

# Instructions
cp -r copilot/instructions .github/

# Prompts
cp -r copilot/prompts .github/

# Skills
cp -r copilot/skills .github/
```

Then customize for your project specifics and commit to version control.

### Verification

1. Open VS Code in your project
2. Open Copilot Chat (Ctrl+Alt+I / Cmd+Ctrl+I)
3. Type `@` to see available agents
4. Type `/` to see available prompts
5. Ask a question to verify instructions are applied

## Configuration Settings

VS Code settings for Copilot customization:

```json
{
  // Enable instruction files
  "github.copilot.chat.useInstructionFiles": true,

  // Enable AGENTS.md file
  "github.copilot.chat.useAgentsMdFile": true,

  // Custom instructions for specific actions
  "github.copilot.chat.reviewSelection.instructions": {
    "text": "Focus on security and performance"
  },
  "github.copilot.chat.commitMessageGeneration.instructions": {
    "file": ".github/commit-instructions.md"
  }
}
```

## Customization

### Extending Instructions

1. Keep the base structure from templates
2. Add team-specific conventions
3. Include project-specific patterns
4. Document tech stack choices

### Creating Custom Agents

1. Identify repetitive workflows
2. Define clear agent purpose
3. Select appropriate tools
4. Write specific instructions
5. Test with real scenarios

### Building Prompt Library

1. Start with common tasks
2. Use variables for flexibility
3. Include expected output format
4. Test iteratively

## Best Practices

1. **Version Control**: Commit all customizations
2. **Team Review**: Discuss changes with team
3. **Iterate**: Improve based on usage
4. **Document**: Explain non-obvious guidelines
5. **Stay Current**: Update as project evolves
