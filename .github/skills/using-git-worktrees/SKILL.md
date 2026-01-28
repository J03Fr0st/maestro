---
name: using-git-worktrees
description: Create isolated git worktrees for feature work. Use when starting work that needs isolation from current workspace or before executing implementation plans.
---

# Using Git Worktrees

Git worktrees create isolated workspaces sharing the same repository.

## Directory Selection Process

### 1. Check Existing Directories

```bash
ls -d .worktrees 2>/dev/null     # Preferred (hidden)
ls -d worktrees 2>/dev/null      # Alternative
```

**If found:** Use that directory.

### 2. Check Project Config

Look for worktree directory preference in project config.

### 3. Ask User

If no directory exists:
```
No worktree directory found. Where should I create worktrees?

1. .worktrees/ (project-local, hidden)
2. Global location

Which would you prefer?
```

## Safety Verification

**MUST verify directory is ignored before creating:**

```bash
git check-ignore -q .worktrees 2>/dev/null
```

**If NOT ignored:**
1. Add to .gitignore
2. Commit the change
3. Proceed

## Creation Steps

### 1. Detect Project Name

```bash
project=$(basename "$(git rev-parse --show-toplevel)")
```

### 2. Create Worktree

```bash
git worktree add "$path" -b "$BRANCH_NAME"
cd "$path"
```

### 3. Run Project Setup

Auto-detect and run:
```bash
# Node.js
if [ -f package.json ]; then npm install; fi

# Python
if [ -f requirements.txt ]; then pip install -r requirements.txt; fi
```

### 4. Verify Clean Baseline

Run tests to ensure worktree starts clean.

**If tests fail:** Report failures, ask whether to proceed.
**If tests pass:** Report ready.

### 5. Report Location

```
Worktree ready at <full-path>
Tests passing (<N> tests, 0 failures)
Ready to implement <feature-name>
```

## Quick Reference

| Situation | Action |
|-----------|--------|
| `.worktrees/` exists | Use it (verify ignored) |
| `worktrees/` exists | Use it (verify ignored) |
| Neither exists | Check config → Ask user |
| Directory not ignored | Add to .gitignore + commit |
| Tests fail during baseline | Report failures + ask |

## Red Flags

**Never:**
- Create worktree without verifying it's ignored
- Skip baseline test verification
- Proceed with failing tests without asking
- Assume directory location when ambiguous
