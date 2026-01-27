# Skills Library

Skills follow the [Agent Skills specification](https://agentskills.io/specification).

## Available Skills

| Skill | Description |
|-------|-------------|
| [azure-devops-cli](./azure-devops-cli/SKILL.md) | Azure DevOps CLI for projects, repos, pipelines, PRs, work items |
| [code-review](./code-review/SKILL.md) | Code review checklist for PRs |
| [gh-cli](./gh-cli/SKILL.md) | GitHub CLI for repositories, issues, PRs, and Actions |
| [git-commit](./git-commit/SKILL.md) | Conventional commit messages with quality checks |
| [pr-description](./pr-description/SKILL.md) | Generate PR descriptions from git changes |
| [project-documentation](./project-documentation/SKILL.md) | Brownfield project documentation and analysis |
| [skill-authoring](./skill-authoring/SKILL.md) | Create agent skills following the spec |

## Skill Structure

```
skill-name/
├── SKILL.md           # Required: skill definition (<500 lines)
├── references/        # Optional: detailed documentation
│   └── REFERENCE.md
├── scripts/           # Optional: executable code
└── assets/            # Optional: templates, data files
```

## Progressive Disclosure

Skills load content efficiently:

| Layer | Token Budget | When Loaded |
|-------|--------------|-------------|
| Metadata | ~100 tokens | At startup for all skills |
| Instructions | <5000 tokens | When skill is activated |
| Resources | As needed | Only when required |

## SKILL.md Format

```yaml
---
name: skill-name
description: What it does. Use when [trigger 1], [trigger 2], or [trigger 3].
---

# Skill Title

## When to Use
- Specific scenario 1
- Specific scenario 2

## Instructions
Step-by-step guidance...

## Examples
Input/output samples...
```

## Frontmatter Requirements

| Field | Constraints |
|-------|-------------|
| `name` | Lowercase, hyphens only, max 64 chars, must match directory |
| `description` | Max 1024 chars, includes what AND when to use |

Optional: `license`, `compatibility`, `metadata`, `allowed-tools`

## Creating Skills

1. Create directory: `.github/skills/<skill-name>/`
2. Add `SKILL.md` with frontmatter and content
3. Keep main file under 500 lines
4. Move detailed reference to `references/` directory

See [skill-authoring](./skill-authoring/SKILL.md) for complete guide.

## References

- [Agent Skills Specification](https://agentskills.io/specification)
- [VS Code Copilot Skills](https://code.visualstudio.com/docs/copilot/customization/agent-skills)

ALWAYS read and follow the relevant skill from `.github/skills/` 
before executing tasks matching these domains:
- GitHub CLI operations → gh-cli
- Git commits → git-commit
- Code reviews → code-review
