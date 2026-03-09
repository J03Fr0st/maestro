---
name: subagent-driven-development
description: >
  Use when executing implementation plans by dispatching fresh subagents per task
  in the current session. Make sure to use this skill whenever the user mentions
  "subagent", "parallel tasks", "dispatch workers", "multi-task development",
  "execute plan with subagents", or wants to run through a plan task-by-task
  with automated review, even if they don't explicitly ask for it.
---

# Subagent-Driven Development

Execute a plan by dispatching a fresh subagent per task, with two-stage review after each: spec compliance first, then code quality.

**Core principle:** Fresh subagent per task + two-stage review = high quality, fast iteration.

## When to Use

1. Do you have an implementation plan? If no, create one first (the writing-plans skill can help, or write one manually).
2. Are the tasks mostly independent? If no (tightly coupled), execute manually instead.
3. Do you want to stay in this session? If yes, use this skill. If no, use executing-plans for a parallel session.

**vs. executing-plans (parallel session):**
- Same session (no context switch)
- Fresh subagent per task (no accumulated context pollution)
- Two-stage review after each task
- Faster iteration (no human-in-loop between tasks)

## The Process

### Setup
1. Read the plan file once, extract all tasks with their full text and context
2. Create a TodoWrite list tracking all tasks

### Per Task
1. **Dispatch implementer subagent** using `./implementer-prompt.md` — provide the full task text and context (the subagent should not need to read the plan file)
2. **Handle questions** — if the implementer asks questions, answer clearly and completely before letting them proceed
3. **Implementer executes** — implements, tests, commits, and self-reviews
4. **Dispatch spec reviewer** using `./spec-reviewer-prompt.md` — confirms code matches the spec
   - If issues found: implementer fixes them, spec reviewer re-reviews, repeat until approved
5. **Dispatch code quality reviewer** using `./code-quality-reviewer-prompt.md` — reviews architecture, style, and correctness
   - If issues found: implementer fixes them, quality reviewer re-reviews, repeat until approved
   - Run quality review only after spec compliance passes (spec gaps are more expensive to fix later, so catch them first)
6. **Mark task complete** in TodoWrite

### After All Tasks
1. Dispatch a final code reviewer subagent for the entire implementation
2. Use the finishing-a-development-branch skill to wrap up (if unavailable, manually create PR, clean up worktree, etc.)

## Prompt Templates

- `./implementer-prompt.md` — Dispatch implementer subagent
- `./spec-reviewer-prompt.md` — Dispatch spec compliance reviewer subagent
- `./code-quality-reviewer-prompt.md` — Dispatch code quality reviewer subagent

## Example Workflow

```
[Read plan file once: docs/plans/feature-plan.md]
[Extract all 5 tasks with full text and context]
[Create TodoWrite with all tasks]

Task 1: Hook installation script

[Dispatch implementation subagent with full task text + context]

Implementer: "Before I begin - should the hook be installed at user or system level?"

Answer: "User level (~/.config/maestro/hooks/)"

Implementer: [Implements, tests, commits, self-reviews]

[Dispatch spec compliance reviewer]
Spec reviewer: Spec compliant - all requirements met, nothing extra

[Dispatch code quality reviewer]
Code reviewer: Strengths: Good test coverage, clean. Issues: None. Approved.

[Mark Task 1 complete]

Task 2: Recovery modes

[Dispatch implementation subagent]
Implementer: [No questions, implements, tests, commits]

[Dispatch spec compliance reviewer]
Spec reviewer: Issues:
  - Missing: Progress reporting (spec says "report every 100 items")
  - Extra: Added --json flag (not requested)

[Implementer fixes issues]
[Spec reviewer re-reviews — now compliant]

[Dispatch code quality reviewer]
Code reviewer: Issues (Important): Magic number (100) should be a constant

[Implementer fixes]
[Code reviewer re-reviews — Approved]

[Mark Task 2 complete]
...

[After all tasks]
[Dispatch final code reviewer for entire implementation]
Final reviewer: All requirements met, ready to merge

Done!
```

## Red Flags

- **Starting on main/master without consent** — Risk of polluting the main branch. Set up a worktree or feature branch first.
- **Skipping either review stage** — Spec compliance catches requirement gaps; quality review catches design issues. Both are needed because the implementer's self-review has blind spots.
- **Proceeding with unfixed issues** — Unresolved issues compound across tasks. Fix before moving on.
- **Parallel implementation subagents** — Multiple subagents editing the same codebase cause merge conflicts. Run one at a time.
- **Making subagent read the plan file** — Wastes context window. Provide full task text inline.
- **Skipping scene-setting context** — Subagents need to understand where their task fits in the bigger picture.
- **Running quality review before spec compliance passes** — Fixing spec gaps often requires rewriting code, which invalidates quality feedback.
- **Accepting "close enough" on spec compliance** — Spec gaps discovered later are more expensive to fix.

## Integration

**Workflow skills (use if available, otherwise proceed manually):**
- **using-git-worktrees** — Set up an isolated workspace before starting
- **writing-plans** — Creates the plan this skill executes
- **requesting-code-review** — Code review template for reviewer subagents
- **finishing-a-development-branch** — Wrap up after all tasks complete

**Subagents should follow:**
- **test-driven-development** — TDD for each task (if available)

**Alternative workflow:**
- **executing-plans** — Use for parallel session instead of same-session execution
