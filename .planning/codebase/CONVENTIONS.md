# Coding Conventions

**Analysis Date:** 2026-01-30

## Overview

The maestro codebase is a GitHub Copilot toolkit consisting primarily of YAML frontmatter-based markdown files (agents, prompts, skills, instructions). Conventions focus on consistent formatting, documentation structure, and adherence to specification standards.

## Naming Patterns

**Files:**
- Agent files: `{name}.agent.md` - kebab-case names (e.g., `maestro-mapper.agent.md`, `alphabeast.agent.md`)
- Prompt files: `{name}.prompt.md` - kebab-case names (e.g., `commit.prompt.md`, `review.prompt.md`)
- Skill directories: `{skill-name}/` with `SKILL.md` inside - kebab-case, single word or hyphenated
- Instructions: `{topic}.instructions.md` - kebab-case topics (e.g., `typescript.instructions.md`, `angular.instructions.md`)
- Documentation: `{number}-{title}.md` - numbered with kebab-case titles (e.g., `00-overview.md`, `40-agents.md`)

**Directories:**
- Plural for collections: `.github/agents/`, `.github/prompts/`, `.github/skills/`, `.github/instructions/`
- Skill subdirectories: `references/` for detailed REFERENCE.md files, `scripts/` for executable code, `assets/` for templates/data

## Frontmatter Format

**Agent files (`*.agent.md`):**
```yaml
---
description: 'Brief description of the agent's role'
model: 'Model name (copilot)'
tools: ['read', 'search', 'execute', 'edit']  # Optional
handoffs:                                      # Optional
  - label: 'Action label'
    agent: 'target-agent-name'
    prompt: 'Initial prompt message'
---
```

**Prompt files (`*.prompt.md`):**
```yaml
---
name: prompt-name
description: 'What it does'
agent: agent                    # Usually 'agent'
---
```

**Skill files (SKILL.md):**
```yaml
---
name: skill-name
description: 'What it does. Use when [trigger 1], [trigger 2], or [trigger 3].'
---
```

**Instruction files (`*.instructions.md`):**
```yaml
---
name: instruction-name
applies-to: '**'           # Glob pattern for where to apply
---
```

## Content Structure

**Agent Files:**
1. Front matter with metadata
2. `# Agent Title` - Level 1 heading (role name)
3. Brief introduction paragraph
4. `## Identity` - Role, scope, constraints
5. `## Required Skills` - Skills needed (with load instructions)
6. `## Core Responsibilities` - Numbered list of main duties
7. Additional sections as needed (`## Workflow`, `## Examples`, etc.)
8. No table of contents
9. Sections use `##` (level 2) for major sections, `###` (level 3) for subsections

**Skill Files:**
1. Front matter
2. `# Skill Title` - Level 1 heading
3. Brief one-line summary
4. `## When to Use` - Bulleted list of scenarios
5. `## Instructions` or `## Workflow` - Main content
6. `## Examples` - Code samples and usage patterns
7. Keep under 500 lines (move excess to `references/REFERENCE.md`)

**Prompt Files:**
Very brief format:
1. Front matter
2. Short instruction text
3. Optional: variables like `${input:context:prompt}` or `${selection}`

## Code Style

**Markdown formatting:**
- Max line length: No strict limit, but aim for readability (wrap long lines)
- Emphasis: Use `**bold**` for emphasis, `*italic*` for light emphasis, backticks for code
- Lists: Use `- ` (dash) for unordered lists, numbers `1. ` for ordered
- Code blocks: Use triple backticks with language identifier when applicable
  ```typescript
  // Example code block
  interface User {
    id: string;
    name: string;
  }
  ```
- Tables: Use markdown tables for structured data
  ```
  | Column 1 | Column 2 |
  |----------|----------|
  | Value 1  | Value 2  |
  ```

**Typography:**
- Use smart quotes where appropriate in prose
- Use em dashes (—) for clauses, not hyphens
- Use ellipsis (…) not three dots (...)
- Headers: Title Case for main headings, Sentence case for subheadings

## Writing Conventions

**Tone:**
- Prescriptive (tell what to do), not descriptive (tell what is)
- Direct and clear: "Use X pattern" not "X pattern can be used"
- Active voice: "Write failing tests first" not "Failing tests should be written first"
- Imperative for instructions: "Create", "Write", "Run", not "Creating", "Writing", "Running"

**Documentation:**
- Every agent/skill needs a `## When to Use` section with specific scenarios
- Every instruction needs clear triggering conditions
- Every example should be runnable or realistic
- Bad examples should show what NOT to do with explanation

**Comments and Examples:**
- Use comments in code examples to explain non-obvious decisions
- Mark bad examples with `// Bad:` and good with `// Good:` or similar
- Include both the wrong way and right way when teaching patterns

## Agent Structure Patterns

**Standard agent sections (in order):**
1. Identity (Role, Scope, Constraint)
2. Required Skills
3. Core Responsibilities
4. Constraints/Do NOT
5. Main workflow (Execution Steps, Workflow, etc.)
6. Quality standards or checklist
7. Error handling
8. Resume behavior (if applicable)

**Agent responsibilities should be:**
- Numbered list format for clarity
- Action-oriented verbs
- Specific outputs or deliverables

## Skill Structure Patterns

**Standard skill sections:**
1. When to Use (bulleted list of specific scenarios)
2. Workflow or Step-by-step process
3. Detailed explanations with examples
4. Common patterns or anti-patterns
5. Quick reference or cheat sheet (optional)

## Import and Reference Patterns

**Referencing skills:**
- Format: Use backticks for code/tool names: `` `skill-name` ``
- In prose: "Load the `writing-plans` skill" or "Use the `code-review` skill"
- Don't create circular dependencies between skills

**File path references:**
- Always use backticks: `` `src/path/file.ts` ``
- Use forward slashes even on Windows
- Relative to project root, not current directory
- Include full path for clarity

## Frontmatter Conventions

**Required fields:**
- `name`: Lowercase, hyphens only, max 64 chars, must match directory/filename
- `description`: Clear explanation of purpose and when to use

**Optional but recommended:**
- `model`: For agents, specify model preference
- `tools`: For agents, list required tools
- `applies-to`: For instructions, specify glob pattern
- `handoffs`: For agents, define hand-off points to other agents

**Field ordering (if using multiple):**
1. `description` or `name`
2. `model`
3. `tools`/`applies-to`
4. `handoffs`

## Version and Date Conventions

**Not used in files** - Instead track through git commits with conventional commit messages.

**Date references** in content: Use ISO format (YYYY-MM-DD) when needed.

## Examples and Code Samples

**Code example format:**
```typescript
// Good example label
test('retries failed operations 3 times', async () => {
  let attempts = 0;
  const operation = () => {
    attempts++;
    if (attempts < 3) throw new Error('fail');
    return 'success';
  };

  const result = await retryOperation(operation);

  expect(result).toBe('success');
  expect(attempts).toBe(3);
});

// Bad example label - explanation of why it's wrong
test('retry works', () => { /* too vague */ });
```

**Pattern conventions:**
- Compare good/bad side-by-side when teaching patterns
- Explain the trade-offs in comments
- Show the actual impact (performance, security, readability)

## No Technology Stack Constraints

The codebase is **technology-agnostic** markdown - no linting configurations, build tools, or programming language enforcement.

---

*Convention analysis: 2026-01-30*
