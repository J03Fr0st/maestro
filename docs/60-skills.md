# Skills Library

## Overview

Skills are domain-specific knowledge documents following the [Agent Skills specification](https://agentskills.io/specification). They provide specialized guidance for common tasks using progressive disclosure for efficient context loading.

Skills are stored in `.github/skills/<skill-name>/SKILL.md`.

## Available Skills

| Skill | Description |
|-------|-------------|
| [`azure-devops-cli`](../.github/skills/azure-devops-cli/SKILL.md) | Azure DevOps CLI for projects, repos, pipelines, PRs |
| [`code-review`](../.github/skills/code-review/SKILL.md) | Code review checklist covering correctness, security, performance |
| [`gh-cli`](../.github/skills/gh-cli/SKILL.md) | GitHub CLI for repositories, issues, PRs, and Actions |
| [`git-commit`](../.github/skills/git-commit/SKILL.md) | Conventional commit messages with quality checks |
| [`pr-description`](../.github/skills/pr-description/SKILL.md) | Generate PR descriptions from git changes |
| [`project-documentation`](../.github/skills/project-documentation/SKILL.md) | Brownfield project documentation and analysis |
| [`skill-authoring`](../.github/skills/skill-authoring/SKILL.md) | Create agent skills following the spec |

## Skill Structure

Skills follow the Agent Skills specification structure:

```
skill-name/
├── SKILL.md           # Required: skill definition (<500 lines)
├── references/        # Optional: detailed documentation
│   └── REFERENCE.md
├── scripts/           # Optional: executable code
└── assets/            # Optional: templates, data files
```

## SKILL.md Format

Each skill has a `SKILL.md` file with YAML frontmatter:

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

## Frontmatter Fields

### Required Fields

| Field | Constraints |
|-------|-------------|
| `name` | Max 64 chars, lowercase, hyphens only, must match directory |
| `description` | Max 1024 chars, includes what AND when to use |

### Optional Fields

| Field | Purpose |
|-------|---------|
| `license` | License name or reference |
| `compatibility` | Environment requirements |
| `metadata` | Key-value mapping for additional properties |
| `allowed-tools` | Space-delimited list of pre-approved tools |

## Progressive Disclosure

Skills load content efficiently in layers:

| Layer | Token Budget | When Loaded |
|-------|--------------|-------------|
| Metadata | ~100 tokens | At startup for all skills |
| Instructions | <5000 tokens | When skill is activated |
| Resources | As needed | Only when required |

### Guidelines

- Keep main `SKILL.md` under 500 lines
- Move detailed reference material to `references/` directory
- Keep file references one level deep from `SKILL.md`

## How Skills Work

1. **Discovery** - Copilot reads `name` and `description` from frontmatter
2. **Matching** - Your prompt is compared against skill descriptions
3. **Loading** - When a match is found, the full skill content loads
4. **Resources** - Additional files in the skill directory load on-demand

### Auto-Activation

Skills activate automatically based on prompt matching. Write specific descriptions:

```yaml
# Less effective - too generic
description: "Help with GitHub"

# More effective - specific triggers
description: "GitHub CLI for repositories, issues, PRs, and Actions. Use when working with GitHub from command line."
```

## Using Skills

### Automatic (Recommended)

Simply describe your task - skills activate when relevant:

```
Help me create a pull request for this feature
→ gh-cli skill activates automatically
```

### Via Prompts

Prompts can trigger skills:

```markdown
---
name: commit
description: Smart git commit
agent: agent
---

Use the `git-commit` skill to create a commit.
```

### Explicit Reference

Reference a skill directly in your prompt:

```
Use the azure-devops-cli skill to help me create a pipeline.
```

## Creating New Skills

See the [skill-authoring](../.github/skills/skill-authoring/SKILL.md) skill for complete guidance.

### Quick Start

1. Create directory: `.github/skills/<skill-name>/`
2. Add `SKILL.md` with frontmatter and content
3. Keep main file under 500 lines
4. Move detailed reference to `references/` directory

### Validation Checklist

- [ ] `name` is lowercase with hyphens only
- [ ] `name` matches parent directory name
- [ ] `name` has no consecutive hyphens
- [ ] `name` does not start or end with hyphen
- [ ] `name` is under 64 characters
- [ ] `description` is under 1024 characters
- [ ] `description` includes what AND when
- [ ] `SKILL.md` is under 500 lines
- [ ] File references use relative paths
- [ ] Referenced files exist

## Skill vs Instructions vs Prompts

| Feature | Skills | Instructions | Prompts |
|---------|--------|--------------|---------|
| **Purpose** | Domain knowledge | Coding guidelines | Task templates |
| **Activation** | Auto (by topic) | Auto (by file type) | Manual (by command) |
| **Scope** | Specific domain | All code generation | Single task |
| **Size** | Comprehensive | Concise | Variable |
| **Structure** | Decision trees, examples | Rules, guidelines | Input/output format |

### When to Use Each

- **Skills**: Deep expertise on a topic (CLI tools, frameworks, patterns)
- **Instructions**: Coding style and conventions (formatting, naming, practices)
- **Prompts**: Repeatable workflows that may trigger skills

## References

- [Agent Skills Specification](https://agentskills.io/specification)
- [VS Code Copilot Skills](https://code.visualstudio.com/docs/copilot/customization/agent-skills)
