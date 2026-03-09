---
name: writing-plans
description: >
  Use when you need to create an implementation plan for a multi-step task before
  touching code. Make sure to use this skill whenever the user says "plan",
  "implementation plan", "task breakdown", "break this down",
  "how should I build this", or discusses requirements for a feature that needs
  structured implementation, even if they don't explicitly ask for it.
---

# Writing Plans

Write comprehensive implementation plans that assume the implementing engineer has zero context for the codebase and limited familiarity with the problem domain. Document everything they need: which files to touch, complete code, testing steps, relevant docs, and how to verify. Deliver the plan as bite-sized tasks. DRY. YAGNI. Frequent commits.

Assume the implementer is a skilled developer, but knows almost nothing about the project's toolset or domain.

**Context:** Ideally run in a dedicated worktree (e.g., created by the brainstorming skill), but works from any branch.

**Save plans to:** `docs/plans/YYYY-MM-DD-<feature-name>.md`

## Plan Structure

Use the template at [references/plan-template.md](references/plan-template.md) as the base structure.

Every plan starts with:
- **Goal** — One sentence describing what this builds
- **Architecture** — 2-3 sentences about approach
- **Tech Stack** — Key technologies/libraries

### Choosing TDD vs Direct Implementation

**Use TDD tasks** (test-first steps) when the work involves testable logic: business rules, data transformations, APIs, algorithms. Most implementation plans should use TDD.

**Use direct implementation tasks** when the work is not meaningfully testable with unit tests: configuration files, CI/CD pipelines, infrastructure-as-code, UI layout/styling, documentation, or migration scripts. In these cases, structure each task as:

1. Implement the change
2. Verify it works (manual check, build succeeds, deploy succeeds, etc.)
3. Commit

## Bite-Sized Task Granularity

Each step should be one action (2-5 minutes):
- "Write the failing test" — one step
- "Run it to verify it fails" — one step
- "Implement the minimal code to pass" — one step
- "Run tests to verify they pass" — one step
- "Commit" — one step

## Key Rules

- Provide exact file paths, not approximate ones
- Include complete code in the plan (not "add validation here")
- Specify exact commands with expected output
- One action per step — never combine actions
- Commit after each task with a conventional commit message

## Execution Handoff

After saving the plan, offer execution choice:

**"Plan complete and saved to `docs/plans/<filename>.md`. Two execution options:**

**1. Subagent-Driven (this session)** — Dispatch a fresh subagent per task, review between tasks, fast iteration. Uses the subagent-driven-development skill if available; otherwise, manually dispatch subagents using the Task tool.

**2. Parallel Session (separate)** — Open a new session in the worktree. Use the executing-plans skill if available; otherwise, follow the plan task-by-task manually.

**Which approach?"**
