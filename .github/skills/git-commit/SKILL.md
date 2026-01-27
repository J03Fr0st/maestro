---
name: git-commit
description: Smart git commit with conventional commit messages and pre-commit quality checks. Use this when committing changes, creating meaningful commit messages, or ensuring commit quality.
---

# Smart Git Commit

Create meaningful git commits with conventional commit messages and quality checks.

## When to Use

- Committing staged or unstaged changes
- Generating conventional commit messages
- Running pre-commit quality checks
- Ensuring consistent commit message format

## Pre-Commit Quality Checks

Before committing, verify:

| Check | Command | Purpose |
|-------|---------|---------|
| Build | `npm run build` / `dotnet build` | Ensure code compiles |
| Tests | `npm test` / `dotnet test` | Verify functionality |
| Lint | `npm run lint` / `eslint .` | Check code style |
| Types | `tsc --noEmit` | Validate TypeScript |

## Workflow

### 1. Check Repository Status

```bash
# View current status
git status

# View staged changes
git diff --cached

# View unstaged changes
git diff

# View changed files summary
git diff --stat
```

### 2. Stage Changes

```bash
# Stage specific files
git add path/to/file.ts

# Stage all modified tracked files
git add -u

# Stage all changes (careful with new files)
git add -A

# Interactive staging
git add -p
```

### 3. Analyze Changes

Determine from the diff:
- What files were modified
- Nature of changes (feature, fix, refactor, etc.)
- The scope/component affected
- Impact and purpose

### 4. Create Commit

```bash
# Commit with message
git commit -m "type(scope): subject"

# Commit with body
git commit -m "type(scope): subject" -m "Detailed body explanation"

# Open editor for message
git commit
```

## Conventional Commit Format

```
<type>(<scope>): <subject>

<body>

<footer>
```

### Types

| Type | Use For | Example |
|------|---------|---------|
| `feat` | New feature | `feat(auth): add JWT token refresh` |
| `fix` | Bug fix | `fix(api): handle null response` |
| `docs` | Documentation | `docs(readme): update install steps` |
| `style` | Formatting only | `style: fix indentation` |
| `refactor` | Code restructure | `refactor(utils): extract helper` |
| `test` | Test changes | `test(auth): add login tests` |
| `chore` | Maintenance | `chore(deps): update packages` |
| `build` | Build system | `build: update webpack config` |
| `ci` | CI/CD changes | `ci: add deploy workflow` |
| `perf` | Performance | `perf(query): add index lookup` |

### Scope (Optional)

The component or area affected:
- `auth`, `api`, `ui`, `db`, `config`
- Feature names: `login`, `checkout`, `dashboard`
- Layer names: `service`, `controller`, `model`

### Subject Rules

- Use imperative mood: "add" not "added" or "adds"
- Lowercase first letter
- No period at end
- Max 50 characters
- Be specific and meaningful

### Body (Optional)

- Explain **why**, not what (the diff shows what)
- Wrap at 72 characters
- Separate from subject with blank line

### Footer (Optional)

- Breaking changes: `BREAKING CHANGE: description`
- Issue references: `Fixes #123`, `Closes #456`

## Examples

### Simple Feature

```bash
git commit -m "feat(cart): add quantity selector"
```

### Bug Fix with Context

```bash
git commit -m "fix(auth): prevent token expiry during refresh

The refresh token was being invalidated before the new token
was issued, causing a race condition on slow connections.

Fixes #234"
```

### Breaking Change

```bash
git commit -m "refactor(api)!: change response format to JSON:API

BREAKING CHANGE: API responses now follow JSON:API spec.
All clients must update their response parsing logic.

Migration guide: docs/migration-v2.md"
```

### Multiple Scopes

```bash
git commit -m "feat(auth,api): add role-based access control"
```

## Message Patterns by Change Type

### New Files Added

```bash
# New feature file
feat(module): add user preferences service

# New test file
test(auth): add unit tests for login flow

# New config file
chore(config): add production environment settings
```

### Files Modified

```bash
# Bug fix
fix(parser): handle empty input gracefully

# Enhancement
feat(search): add fuzzy matching support

# Refactor
refactor(utils): simplify date formatting logic
```

### Files Deleted

```bash
# Remove deprecated code
chore: remove legacy authentication module

# Clean up
refactor(api): remove unused endpoints
```

### Dependency Changes

```bash
# Update dependencies
chore(deps): update lodash to 4.17.21

# Add new dependency
chore(deps): add zod for schema validation

# Remove dependency
chore(deps): remove moment.js in favor of date-fns
```

## Quick Reference

```bash
# View what will be committed
git diff --cached --stat

# Amend last commit (unpushed only)
git commit --amend

# Amend without changing message
git commit --amend --no-edit

# View recent commits
git log --oneline -5
```

## Restrictions

- Do NOT add "Co-authored-by" or AI signatures
- Do NOT include "Generated with" messages
- Do NOT modify git configuration
- Do NOT use emojis in commit messages
- Use only existing git user configuration
