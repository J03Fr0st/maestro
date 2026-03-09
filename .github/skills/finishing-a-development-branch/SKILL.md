---
name: finishing-a-development-branch
description: >
  Guide completion and integration of development work on a branch. Use this skill whenever the
  user says "done coding", "finish up", "merge branch", "wrap up feature", "clean up worktree",
  "I'm done with this branch", "ready to merge", or "ship it". Make sure to use this skill whenever
  the user indicates they've finished implementation work and want to decide what to do next, even
  if they don't explicitly ask for it.
---

# Finishing a Development Branch

Guide completion of development work by verifying readiness, presenting integration options, and executing the chosen workflow.

## The Process

### Step 1: Verify Tests

Run the project's test suite before presenting options:

```bash
# Run project's test suite
npm test / cargo test / pytest / go test ./...
```

If tests fail, report the failures and work with the user to fix them before proceeding. Do not present integration options until tests pass -- merging or creating a PR with broken tests wastes reviewers' time and risks shipping bugs.

If tests pass, continue to Step 2.

### Step 2: Determine Base Branch

```bash
# Try common base branches
git merge-base HEAD main 2>/dev/null || git merge-base HEAD master 2>/dev/null
```

Or ask: "This branch split from main -- is that correct?"

### Step 3: Present Options

Present the relevant options from this list. Skip any that don't apply to the current situation (e.g., skip worktree cleanup if not in a worktree, skip "Create PR" if there's no remote):

```
Implementation complete. What would you like to do?

1. Merge back to <base-branch> locally
2. Push and create a Pull Request
3. Keep the branch as-is (I'll handle it later)
4. Discard this work
```

Keep options concise with no extra explanation.

### Step 4: Execute Choice

#### Option 1: Merge Locally

```bash
git checkout <base-branch>
git pull
git merge <feature-branch>
<test command>
# If tests pass
git branch -d <feature-branch>
```

Then: Cleanup worktree (Step 5).

#### Option 2: Push and Create PR

```bash
git push -u origin <feature-branch>
gh pr create --title "<title>" --body "$(cat <<'EOF'
## Summary
<2-3 bullets of what changed>

## Test Plan
- [ ] <verification steps>
EOF
)"
```

Then: Cleanup worktree (Step 5).

#### Option 3: Keep As-Is

Report: "Keeping branch `<name>`. Worktree preserved at `<path>`."

Do not clean up worktree.

#### Option 4: Discard

Confirm first to prevent accidental loss of work:

```
This will permanently delete:
- Branch <name>
- All commits: <commit-list>
- Worktree at <path>

Type 'discard' to confirm.
```

Wait for exact confirmation before proceeding.

If confirmed:
```bash
git checkout <base-branch>
git branch -D <feature-branch>
```

Then: Cleanup worktree (Step 5).

### Step 5: Cleanup Worktree

For Options 1, 2, and 4 (if currently in a worktree):

```bash
git worktree list | grep $(git branch --show-current)
# If in worktree:
git worktree remove <worktree-path>
```

For Option 3: Keep worktree.

## Quick Reference

| Option | Merge | Push | Keep Worktree | Cleanup Branch |
|--------|-------|------|---------------|----------------|
| 1. Merge locally | yes | - | - | yes |
| 2. Create PR | - | yes | yes | - |
| 3. Keep as-is | - | - | yes | - |
| 4. Discard | - | - | - | yes (force) |

## Red Flags

- Do not proceed with failing tests -- merging broken code creates more work for the team than fixing it now.
- Do not merge without verifying tests on the merge result -- the merge itself can introduce conflicts that break things even if both branches were green.
- Do not delete work without typed confirmation -- accidental branch deletion is unrecoverable if not pushed.
- Do not force-push without explicit request -- this rewrites shared history and can break collaborators' local branches.
- Verify tests before offering options so the user doesn't choose "merge" only to discover failures after the fact.
- Get typed confirmation for discarding (Option 4) because this is destructive and irreversible.

## Integration

**Called by:**
- **subagent-driven-development** (Step 7) - After all tasks complete
- **executing-plans** (Step 5) - After all batches complete

**Pairs with:**
- **using-git-worktrees** - Cleans up worktree created by that skill
