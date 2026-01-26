---
name: commit
description: Smart git commit with conventional commit messages and pre-commit quality checks
agent: agent
---

Create a smart git commit by analyzing changes and generating a meaningful commit message.

## Pre-Commit Quality Checks

Before committing, verify:
1. **Build passes** (if build command exists)
2. **Tests pass** (if test command exists)
3. **Linter passes** (if lint command exists)
4. **No obvious errors** in changed files

## Process

1. Check git repository status
2. Detect staged and unstaged changes
3. If no files are staged, stage modified files with `git add -u`
4. Display what will be committed
5. Analyze change patterns to determine commit type
6. Generate conventional commit message
7. Create the commit

## Commit Message Format

Follow conventional commits:
```
<type>(<scope>): <subject>

<body>
```

**Type** (required):
- `feat` - New feature
- `fix` - Bug fix
- `docs` - Documentation only
- `style` - Formatting, no code change
- `refactor` - Code restructuring
- `test` - Adding/updating tests
- `chore` - Maintenance tasks

**Scope** (optional): Component or area affected

**Subject**: Clear description in present tense, lowercase, no period

**Body** (optional): Detailed explanation if needed

## Change Analysis

Determine from the diff:
- What files were modified
- Nature of changes (feature, fix, refactor, etc.)
- The scope/component affected
- Impact and purpose

## Restrictions

NEVER:
- Add "Co-authored-by" or any AI signatures
- Include "Generated with Claude Code" or similar messages
- Modify git configuration or credentials
- Use emojis in commit messages

The commit must use only existing git user configuration to maintain full authorship authenticity.
