---
name: using-git-worktrees
description: >
  Use when starting feature work that needs isolation from the current workspace,
  setting up parallel workspaces, or before executing implementation plans.
  Make sure to use this skill whenever the user mentions "git worktree",
  "parallel workspaces", "isolated branch work", "multi-branch development",
  or wants to work on a feature without disturbing their current checkout,
  even if they don't explicitly ask for it.
---

# Using Git Worktrees

Git worktrees create isolated workspaces sharing the same repository, allowing work on multiple branches simultaneously without switching.

**Core principle:** Systematic directory selection + safety verification = reliable isolation.

## Directory Selection Process

Follow this priority order:

### 1. Check Existing Directories

```bash
# Check in priority order
ls -d .worktrees 2>/dev/null     # Preferred (hidden)
ls -d worktrees 2>/dev/null      # Alternative
```

If found, use that directory. If both exist, `.worktrees` wins.

### 2. Check CLAUDE.md

```bash
grep -i "worktree.*director" CLAUDE.md 2>/dev/null
```

If a preference is specified, use it without asking.

### 3. Ask User

If no directory exists and no CLAUDE.md preference:

```
No worktree directory found. Where should I create worktrees?

1. .worktrees/ (project-local, hidden)
2. ~/.config/maestro/worktrees/<project-name>/ (global location)

Which would you prefer?
```

## Safety Verification

### For Project-Local Directories (.worktrees or worktrees)

Verify the directory is gitignored before creating a worktree — otherwise worktree contents get tracked and pollute git status.

```bash
# Check if directory is ignored (respects local, global, and system gitignore)
WORKTREE_DIR=".worktrees"  # or "worktrees", whichever was selected
git check-ignore -q "$WORKTREE_DIR" 2>/dev/null
```

If NOT ignored, fix it immediately:
1. Add the directory to `.gitignore`
2. Commit the change
3. Proceed with worktree creation

### For Global Directory (~/.config/maestro/worktrees)

No gitignore verification needed — it's outside the project entirely.

## Creation Steps

### 1. Detect Project Name

```bash
PROJECT_NAME=$(basename "$(git rev-parse --show-toplevel)")
```

### 2. Create Worktree

```bash
# Determine full path based on selected location
WORKTREE_DIR=".worktrees"  # or "worktrees" or "~/.config/maestro/worktrees/$PROJECT_NAME"
BRANCH_NAME="feature/my-feature"

WORKTREE_PATH="$WORKTREE_DIR/$BRANCH_NAME"

# Create worktree with new branch
git worktree add "$WORKTREE_PATH" -b "$BRANCH_NAME"
cd "$WORKTREE_PATH"
```

### 3. Run Project Setup

Auto-detect and run appropriate setup:

```bash
# Node.js
if [ -f package.json ]; then npm install; fi

# Rust
if [ -f Cargo.toml ]; then cargo build; fi

# Python
if [ -f requirements.txt ]; then pip install -r requirements.txt; fi
if [ -f pyproject.toml ]; then poetry install; fi

# Go
if [ -f go.mod ]; then go mod download; fi
```

### 4. Verify Clean Baseline

Run tests to confirm the worktree starts clean — this establishes a known-good state so new failures are clearly attributable to new changes.

```bash
# Use project-appropriate command
npm test        # Node.js
cargo test      # Rust
pytest          # Python
go test ./...   # Go
```

If tests fail, report failures and ask whether to proceed or investigate.

If tests pass, report ready.

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
| Both exist | Use `.worktrees/` |
| Neither exists | Check CLAUDE.md, then ask user |
| Directory not ignored | Add to .gitignore + commit |
| Tests fail during baseline | Report failures + ask |
| No package.json/Cargo.toml | Skip dependency install |

## Common Mistakes

- **Skipping ignore verification** — Worktree contents get tracked and pollute git status. Use `git check-ignore` before creating project-local worktrees.
- **Assuming directory location** — Creates inconsistency with project conventions. Follow priority: existing > CLAUDE.md > ask.
- **Proceeding with failing tests** — Cannot distinguish new bugs from pre-existing issues. Report failures and get explicit permission.
- **Hardcoding setup commands** — Breaks on projects using different tools. Auto-detect from project files.

## Integration

**Often called by:**
- **brainstorming** (Phase 4) — when design is approved and implementation follows
- **subagent-driven-development** — before executing tasks (if unavailable, manually create worktree using the steps above)
- **executing-plans** — before executing tasks
- Any workflow needing an isolated workspace

**Pairs with:**
- **finishing-a-development-branch** — for cleanup after work is complete (if unavailable, use `git worktree remove <path>` directly)
