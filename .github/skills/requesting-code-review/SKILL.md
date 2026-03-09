---
name: requesting-code-review
description: >
  Use when completing tasks, implementing features, or before merging to verify
  work meets requirements. Make sure to use this skill whenever the user says
  "review my code", "check my PR", "verify my changes", "before merging",
  or finishes a significant piece of work, even if they don't explicitly ask for it.
---

# Requesting Code Review

Dispatch a code-reviewer subagent to catch issues before they cascade.

**Core principle:** Review early, review often.

## When to Request Review

**Mandatory:**
- After each task in subagent-driven development
- After completing a major feature
- Before merge to main

**Optional but valuable:**
- When stuck (fresh perspective)
- Before refactoring (baseline check)
- After fixing a complex bug

## How to Request

### 1. Determine the git range

```bash
# For task-based reviews: compare against the commit before your task started
BASE_SHA=$(git log --oneline --all | head -20)  # find the right base commit
HEAD_SHA=$(git rev-parse HEAD)

# For branch-based reviews: compare against the target branch
BASE_SHA=$(git merge-base origin/main HEAD)
HEAD_SHA=$(git rev-parse HEAD)
```

Pick the approach that matches your situation. The goal is to capture exactly the changes under review.

### 2. Dispatch code-reviewer subagent

Use the Task tool with the template at `code-reviewer.md`. Fill these placeholders:

| Placeholder | Description |
|-------------|-------------|
| `{WHAT_WAS_IMPLEMENTED}` | What you just built |
| `{PLAN_REFERENCE}` | Requirements, plan section, or spec it should match |
| `{BASE_SHA}` | Starting commit |
| `{HEAD_SHA}` | Ending commit |
| `{DESCRIPTION}` | Brief summary of the changes |

**Note on Task tool:** This skill works best with the Task tool (subagent dispatch). If the Task tool is unavailable, you can still perform a self-review by following the checklist in `code-reviewer.md` directly, though a separate subagent provides a fresher perspective.

### 3. Act on feedback

- **Critical** issues: fix immediately
- **Important** issues: fix before proceeding
- **Minor** issues: note for later
- Push back if the reviewer is wrong, but provide technical reasoning

## Example

```
[Just completed Task 2: Add verification function]

Determine git range:
  BASE_SHA=$(git merge-base origin/main HEAD)
  HEAD_SHA=$(git rev-parse HEAD)

[Dispatch code-reviewer subagent with:]
  WHAT_WAS_IMPLEMENTED: Verification and repair functions for conversation index
  PLAN_REFERENCE: Task 2 from docs/plans/deployment-plan.md
  BASE_SHA: a7981ec
  HEAD_SHA: 3df7661
  DESCRIPTION: Added verifyIndex() and repairIndex() with 4 issue types

[Subagent returns:]
  Strengths: Clean architecture, real tests
  Issues:
    Important: Missing progress indicators
    Minor: Magic number (100) for reporting interval
  Assessment: Ready to proceed

[Fix progress indicators, then continue to Task 3]
```

## Integration with Workflows

**Subagent-Driven Development:**
- Review after each task
- Catch issues before they compound
- Fix before moving to next task

**Executing Plans:**
- Review after each batch (3 tasks)
- Get feedback, apply, continue

**Ad-Hoc Development:**
- Review before merge
- Review when stuck

## Red Flags

- **Skipping review because "it's simple"** — Simple changes still have edge cases and integration risks.
- **Ignoring Critical issues** — These are bugs, security holes, or data-loss risks. Fix them.
- **Proceeding with unfixed Important issues** — They compound across tasks and become harder to fix later.

If the reviewer is wrong, push back with technical reasoning, show code/tests that prove it works, or request clarification.

## Files

- Template: `code-reviewer.md`
