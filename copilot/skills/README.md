# Skills Library

Skills are stored in `copilot/skills/<skill-name>/SKILL.md` following the [Agent Skills standard](https://agentskills.io).

When using this devkit, copy the `copilot/skills/` folder to your project's `.github/skills/` for VS Code auto-discovery.

## Available Skills

| Skill | Description |
|-------|-------------|
| [azure-devops-cli](./azure-devops-cli/SKILL.md) | Azure DevOps CLI for projects, repos, pipelines, PRs, work items |
| [code-review](./code-review/SKILL.md) | Code review checklist for PRs |
| [gh-cli](./gh-cli/SKILL.md) | GitHub CLI comprehensive reference |
| [project-documentation](./project-documentation/SKILL.md) | Brownfield project documentation and analysis |

## How Skills Work

Skills use **progressive disclosure** to efficiently load content:

1. **Discovery** - Copilot reads `name` and `description` from YAML frontmatter
2. **Loading** - When your request matches, the full `SKILL.md` is loaded
3. **Resources** - Additional files in the skill directory load on-demand

Skills are automatically activated based on your prompt—no manual selection needed.

## Creating New Skills

1. Create a directory: `copilot/skills/<skill-name>/`
2. Add a `SKILL.md` file with this structure:

```markdown
---
name: skill-name
description: What it does AND when to use it. Be specific for better auto-activation.
---

# Skill Title

## When to Use
- Use case 1
- Use case 2

## Content
Your detailed instructions, patterns, and examples...
```

3. Optionally add scripts, templates, or examples to the skill directory

## Skill Format

Each `SKILL.md` has:

| Section | Purpose |
|---------|---------|
| **Frontmatter** | `name` (lowercase, hyphens) and `description` (max 1024 chars) |
| **When to Use** | Clear triggers for when the skill applies |
| **Decision Tree** | Help choose the right approach |
| **Recommended Approach** | Opinionated guidance with examples |
| **Pitfalls and Gotchas** | Common mistakes to avoid |
| **Code Examples** | Practical, copy-paste ready code |

## Deploying Skills

To use these skills in your project, copy to `.github/skills/` for VS Code auto-discovery:

```bash
cp -r copilot/skills/* .github/skills/
```

Skills in `.github/skills/` are automatically discovered by GitHub Copilot in VS Code.
