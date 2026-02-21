---
name: skill-creator
description: Use when creating a new skill, editing an existing skill, or packaging a skill for distribution
---

# Skill Creator

## Overview

Skills are modular, self-contained packages that extend an AI agent's capabilities by providing specialized knowledge, workflows, and tools. Think of them as "onboarding guides" for specific domains — they transform a general-purpose agent into a specialized one equipped with procedural knowledge that no model can fully possess.

**Official spec:** Skills follow the [Agent Skills Specification](https://agentskills.io/specification).

## When to Create a Skill

**Create when:**
- Technique wasn't intuitively obvious to you
- You'd reference this again across projects
- Pattern applies broadly (not project-specific)
- Others would benefit

**Don't create for:**
- One-off solutions
- Standard practices well-documented elsewhere
- Project-specific conventions (put in repository docs)
- Mechanical constraints (if it's enforceable with lint/validation, automate it — save documentation for judgment calls)

## Skill Types

### Technique
Concrete method with steps to follow (condition-based-waiting, root-cause-tracing)

### Pattern
Way of thinking about problems (flatten-with-flags, test-invariants)

### Reference
API docs, syntax guides, tool documentation (azure-devops-cli, gh-cli)

## Core Principles

### Concise is Key

The context window is a public good. Skills share it with everything else the agent needs: system prompt, conversation history, other skills' metadata, and the actual user request.

**Default assumption: The agent is already very smart.** Only add context the agent doesn't already have. Challenge each piece of information: "Does the agent really need this explanation?" and "Does this justify its token cost?"

### Set Appropriate Degrees of Freedom

Match specificity to the task's fragility and variability:

- **High freedom** (text instructions): Multiple approaches valid, decisions depend on context, heuristics guide the approach
- **Medium freedom** (pseudocode/parameterized scripts): Preferred pattern exists, some variation acceptable
- **Low freedom** (specific scripts, few parameters): Fragile operations where consistency is critical

Think of the agent as exploring a path: a narrow bridge with cliffs needs specific guardrails (low freedom), while an open field allows many routes (high freedom).

### Progressive Disclosure

Skills use a three-level loading system:

1. **Metadata** (name + description) — Always in context (~100 tokens)
2. **SKILL.md body** — When skill triggers (< 500 lines recommended)
3. **Bundled resources** — Loaded only as needed by the agent

## Directory Structure

```
skills/
  skill-name/
    SKILL.md              # Main reference (required)
    references/           # Heavy reference material, loaded as needed
    scripts/              # Executable tools
    assets/               # Output resources (templates, icons, boilerplate)
```

**Keep inline:** Principles, concepts, code patterns (< 50 lines)

**Move to `references/`:** Heavy reference material (100+ lines), API docs, comprehensive syntax, schemas

**Move to `scripts/`:** Reusable executable code — when the same code is rewritten repeatedly or deterministic reliability is needed

**Move to `assets/`:** Templates, boilerplate, icons, fonts — files used in output, not loaded into context

**Do NOT include:** README.md, INSTALLATION_GUIDE.md, CHANGELOG.md, or any auxiliary documentation about the process of creating the skill. Only include what an agent needs to do the job.

## SKILL.md Structure

**Frontmatter (YAML) — required fields:**
- `name`: Lowercase letters, numbers, and hyphens only (`a-z`, `0-9`, `-`). Max 64 chars. Must match directory name. No consecutive hyphens. No leading/trailing hyphens.
- `description`: Max 1024 chars. Primary triggering mechanism — see CSO section below.

**Optional frontmatter fields:**
- `license`: License name (e.g., `MIT`, `Apache-2.0`)
- `compatibility`: Environment requirements (e.g., `Requires git, docker, jq`)
- `metadata`: Arbitrary key-value pairs (author, version, etc.)
- `allowed-tools`: Space-delimited pre-approved tools (experimental)

**Body template:**
```markdown
## Overview
What is this? Core principle in 1-2 sentences.

## When to Use
[Small inline flowchart IF decision non-obvious]
Bullet list with SYMPTOMS and use cases
When NOT to use

## Core Pattern (for techniques/patterns)
Before/after comparison

## Quick Reference
Table or bullets for scanning common operations

## Implementation
Inline code for simple patterns
Link to file for heavy reference or reusable tools

## Common Mistakes
What goes wrong + fixes
```

## Search Optimization (CSO)

**Critical: Future agents must FIND your skill before they can use it.**

### Description Field

**Description = When to Use, NOT What the Skill Does.**

The description is loaded to decide IF the skill applies. Do NOT summarize the skill's process or workflow — this causes agents to follow the description instead of reading the full skill content.

**Why this matters:** When a description summarizes workflow, agents may follow the description as a shortcut and skip reading the skill body. A description saying "code review between tasks" caused an agent to do ONE review, even though the skill clearly showed TWO. Changing it to just "Use when executing implementation plans with independent tasks" fixed the problem.

```yaml
# ❌ BAD: Summarizes workflow — agent may follow this and skip reading the skill
description: Use when executing plans - dispatches subagent per task with code review between tasks

# ❌ BAD: Too much process detail
description: Use for TDD - write test first, watch it fail, write minimal code, refactor

# ✅ GOOD: Just triggering conditions, no workflow summary
description: Use when executing implementation plans with independent tasks

# ✅ GOOD: Triggering conditions only
description: Use when implementing any feature or bugfix, before writing implementation code
```

**Format rules:**
- Start with "Use when..." to focus on triggering conditions
- Write in third person (injected into system prompt)
- Keep under 500 characters if possible
- Include specific symptoms, situations, and contexts that signal this skill applies
- NEVER summarize the skill's process or workflow

### Keyword Coverage

Use words agents would search for:
- Error messages: "Hook timed out", "ENOTEMPTY", "race condition"
- Symptoms: "flaky", "hanging", "zombie", "pollution"
- Synonyms: "timeout/hang/freeze", "cleanup/teardown/afterEach"
- Tools: Actual commands, library names, file types

### Naming

Use active voice, verb-first:
- ✅ `systematic-debugging` not `debugging-techniques`
- ✅ `condition-based-waiting` not `async-test-helpers`
- ✅ `using-git-worktrees` not `git-worktree-usage`

Gerunds (-ing) work well for processes: `writing-plans`, `using-skills`, `requesting-code-review`

### Token Efficiency

**Target word counts:**
- Frequently-loaded skills: < 200 words total
- Other skills: < 500 words (still be concise)

**Techniques:**
- Move details to tool `--help` rather than documenting all flags
- Cross-reference other skills rather than repeating their content
- One excellent example beats many mediocre ones
- Keep only essential procedural instructions in SKILL.md; move detailed reference to `references/`

## Skill Creation Process

### Step 1: Understand with Concrete Examples

Clarify how the skill will be used before writing anything. Ask:
- What functionality should this skill support?
- What would trigger this skill? What would a user say?
- Can you give examples of how this skill would be used?

Conclude when you have a clear sense of the functionality the skill should support.

### Step 2: Plan Reusable Contents

For each concrete example, analyze how to execute it from scratch and identify what scripts, references, or assets would help execute it repeatedly:

**Examples:**
- Rotating PDFs → `scripts/rotate_pdf.py` (same code rewritten each time)
- Building frontend apps → `assets/hello-world/` (same boilerplate each time)
- Querying a database → `references/schema.md` (same schemas re-discovered each time)
- Cloud deployments → `references/aws.md`, `references/gcp.md` (provider-specific patterns)

Note: This step may require user input. For example, a `brand-guidelines` skill may need the user to provide brand assets or templates.

### Step 3: Initialize the Skill

For new skills, run the initialization script:

```bash
scripts/init_skill.py <skill-name> --path <output-directory>
```

This generates a SKILL.md template with proper frontmatter and example resource directories. Remove any generated files not needed for your skill.

Skip this step only if the skill already exists and you're iterating on it.

### Step 4: Implement Resources

Start with the reusable resources identified in Step 2: `scripts/`, `references/`, and `assets/` files.

**Test scripts** by actually running them to ensure there are no bugs and that output matches expectations. If there are many similar scripts, test a representative sample.

**Remove example files** generated by the initialization script that aren't needed for your skill.

### Step 5: Write SKILL.md

When editing the skill, include information that would be beneficial and non-obvious to the agent. Consider what procedural knowledge, domain-specific details, or reusable assets would help the agent execute tasks more effectively.

**Writing guidelines:**
- Use imperative/infinitive form
- For multi-step processes: see `references/workflows.md`
- For specific output formats: see `references/output-patterns.md`

**Writing guidelines for discipline-enforcing skills:**
See `references/persuasion-principles.md` for research on language patterns that increase agent compliance (load when writing skills that enforce mandatory workflows or rules).

### Step 6: Package the Skill

```bash
scripts/package_skill.py <path/to/skill-folder>
```

The packaging script validates then packages to a `.skill` file. Validation checks:
- YAML frontmatter format and required fields per spec
- Naming conventions (lowercase, hyphens, max 64 chars, matches directory)
- Description completeness (max 1024 chars)
- File organization and resource references

Fix any validation errors and run again.

```bash
# Optional: validate without packaging
scripts/quick_validate.py <path/to/skill-folder>
```

You can also use the official reference library:
```bash
skills-ref validate ./my-skill
```

### Step 7: Iterate

After real usage, notice struggles or inefficiencies. Update SKILL.md or bundled resources and re-package.

## Progressive Disclosure Patterns

Keep SKILL.md to essentials and under 500 lines. Split content into separate files when approaching this limit. When splitting, always reference the files from SKILL.md and describe when to load them.

**Pattern 1: High-level guide with references**
```markdown
# PDF Processing

## Quick start
Extract text with pdfplumber: [code example]

## Advanced features
- **Form filling**: See references/forms.md for complete guide
- **API reference**: See references/api.md for all methods
```

**Pattern 2: Domain-specific organization**
```
bigquery-skill/
├── SKILL.md (overview and navigation)
└── references/
    ├── finance.md (revenue, billing metrics)
    ├── sales.md (opportunities, pipeline)
    └── product.md (API usage, features)
```
When a user asks about sales metrics, the agent only reads `sales.md`.

**Pattern 3: Framework variants**
```
cloud-deploy/
├── SKILL.md (workflow + provider selection)
└── references/
    ├── aws.md
    ├── gcp.md
    └── azure.md
```

**Pattern 4: Conditional details**
```markdown
## Editing documents

For simple edits, modify directly.

**For tracked changes**: See references/redlining.md
**For OOXML details**: See references/ooxml.md
```

**Important guidelines:**
- Use relative paths from the skill root (e.g., `references/api.md`, `scripts/extract.py`)
- Keep references one level deep from SKILL.md
- For reference files longer than 100 lines, include a table of contents at the top

## Anti-Patterns

### ❌ Narrative Example
"In session 2025-10-03, we found empty projectDir caused..."
**Why bad:** Too specific, not reusable

### ❌ Multi-Language Dilution
example-js.js, example-py.py, example-go.go
**Why bad:** Mediocre quality, maintenance burden. Pick the most relevant language — one excellent example is enough.

### ❌ Generic Labels
helper1, helper2, step3, pattern4
**Why bad:** Labels should have semantic meaning

### ❌ Duplication Between Files
The same information in both SKILL.md and a references file.
**Why bad:** Creates maintenance burden and inconsistency. Information lives in one place only.

### ❌ Auxiliary Documentation
Adding README.md, CHANGELOG.md, INSTALLATION_GUIDE.md to the skill directory.
**Why bad:** Adds clutter. The skill should only contain what an agent needs to do the job.

### ❌ Deeply Nested References
References that link to other references.
**Why bad:** Makes discovery unreliable. All reference files link directly from SKILL.md.
