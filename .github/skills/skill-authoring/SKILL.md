---
name: skill-authoring
description: Create agent skills following the Agent Skills specification. Use when building new skills, converting prompts to skills, or validating skill format.
---

# Skill Authoring Guide

Create reusable agent skills following the [Agent Skills specification](https://agentskills.io/specification).

## When to Use

- Creating a new skill for the team or project
- Converting prompts to reusable skills
- Validating skill format and structure
- Understanding skill best practices

## Directory Structure

A skill is a directory containing at minimum a `SKILL.md` file:

```
skill-name/
├── SKILL.md           # Required: skill definition
├── scripts/           # Optional: executable code
├── references/        # Optional: additional documentation
└── assets/            # Optional: static resources
```

### Optional Directories

| Directory | Purpose | Contents |
|-----------|---------|----------|
| `scripts/` | Executable code agents can run | Python, Bash, JavaScript |
| `references/` | Additional documentation loaded on demand | `REFERENCE.md`, domain-specific files |
| `assets/` | Static resources | Templates, images, data files, schemas |

## SKILL.md Format

The `SKILL.md` file must contain YAML frontmatter followed by Markdown content.

```markdown
---
name: skill-name
description: A description of what this skill does and when to use it.
---

# Skill Title

Your instructions and content...
```

## Frontmatter Fields

### Required Fields

| Field | Constraints |
|-------|-------------|
| `name` | Max 64 chars. Lowercase letters, numbers, hyphens only. Must not start/end with hyphen. Must match directory name. |
| `description` | Max 1024 chars. Describes what the skill does AND when to use it. |

### Optional Fields

| Field | Constraints |
|-------|-------------|
| `license` | License name or reference to bundled license file |
| `compatibility` | Max 500 chars. Environment requirements (product, packages, network) |
| `metadata` | Key-value mapping for additional properties |
| `allowed-tools` | Space-delimited list of pre-approved tools (experimental) |

### Full Example

```yaml
---
name: pdf-processing
description: Extract text and tables from PDF files, fill forms, merge documents. Use when working with PDF documents or when the user mentions PDFs, forms, or document extraction.
license: Apache-2.0
compatibility: Requires poppler-utils for PDF extraction
metadata:
  author: example-org
  version: "1.0"
allowed-tools: Bash(pdftotext:*) Read
---
```

## Name Field Rules

The `name` field:
- Must be 1-64 characters
- May only contain lowercase alphanumeric characters and hyphens (`a-z`, `0-9`, `-`)
- Must not start or end with `-`
- Must not contain consecutive hyphens (`--`)
- Must match the parent directory name

### Valid Names

```yaml
name: pdf-processing
name: data-analysis
name: code-review
name: api-testing
```

### Invalid Names

```yaml
name: PDF-Processing    # uppercase not allowed
name: -pdf              # cannot start with hyphen
name: pdf-              # cannot end with hyphen
name: pdf--processing   # consecutive hyphens not allowed
name: my_skill          # underscores not allowed
```

## Description Field Guidelines

The `description` field should:
- Describe both what the skill does AND when to use it
- Include specific keywords that help agents identify relevant tasks
- Be concise but informative

### Good Description

```yaml
description: Extract text and tables from PDF files, fill PDF forms, and merge multiple PDFs. Use when working with PDF documents or when the user mentions PDFs, forms, or document extraction.
```

### Poor Description

```yaml
description: Helps with PDFs.
```

### Description Pattern

```
[What it does]. Use when [trigger 1], [trigger 2], or [trigger 3].
```

## Body Content

The Markdown body after frontmatter contains skill instructions. Recommended sections:

- Step-by-step instructions
- Examples of inputs and outputs
- Common edge cases
- References to supporting files

## Progressive Disclosure

Skills are structured for efficient context usage:

| Layer | Token Budget | When Loaded |
|-------|--------------|-------------|
| Metadata | ~100 tokens | At startup for all skills |
| Instructions | <5000 tokens | When skill is activated |
| Resources | As needed | Only when required |

### Guidelines

- Keep main `SKILL.md` under 500 lines
- Move detailed reference material to `references/` directory
- Keep file references one level deep from `SKILL.md`

## File References

Reference other files using relative paths from skill root:

```
See [the reference guide](references/REFERENCE.md) for details.

Run the extraction script:
scripts/extract.py
```

## Skill Template

```markdown
---
name: my-skill
description: [What it does]. Use when [trigger 1], [trigger 2], or [trigger 3].
---

# [Skill Title]

[One-line summary of what this skill helps accomplish.]

## When to Use

- [Specific scenario 1]
- [Specific scenario 2]
- [Specific scenario 3]

## Instructions

### Step 1: [First Step]

[Instructions...]

### Step 2: [Second Step]

[Instructions...]

## Examples

### [Example Name]

**Input:**
\`\`\`
[sample input]
\`\`\`

**Output:**
\`\`\`
[expected output]
\`\`\`

## Edge Cases

- [Edge case 1 and how to handle it]
- [Edge case 2 and how to handle it]
```

## Converting Prompts to Skills

Prompts (`.prompt.md`) are lightweight triggers. Skills contain detailed instructions.

**Prompt** (trigger):
```markdown
---
name: my-prompt
description: Brief description
agent: agent
---

Use the `my-skill` skill to [accomplish task].
```

**Skill** (instructions):
```markdown
---
name: my-skill
description: Detailed description with use cases.
---

# Full instructions...
```

## Validation Checklist

Before deploying a skill:

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

## Skill Locations

| Type | Path | Purpose |
|------|------|---------|
| Project | `.github/skills/` | Shared with team via repo |
| Personal | `~/.copilot/skills/` | User-specific skills |

## References

- [Agent Skills Specification](https://agentskills.io/specification)
- [VS Code Copilot Skills](https://code.visualstudio.com/docs/copilot/customization/agent-skills)
