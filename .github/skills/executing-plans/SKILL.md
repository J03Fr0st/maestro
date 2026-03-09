---
name: executing-plans
description: >
  Use when users want to execute an implementation plan, follow a spec, work
  through a task list, or implement step-by-step instructions.
  Trigger phrases: "execute this plan", "implement these tasks", "follow this
  spec", "work through this list", "start implementing", "run the plan",
  "do these steps", "implement the design".
---

# Executing Plans

## Overview

Load a plan, review it critically, execute tasks in batches, and report for review between batches.

Batching with checkpoints matters because it lets the user course-correct early. Implementing an entire plan without feedback risks building the wrong thing — catching a misunderstanding after 3 tasks is much cheaper than catching it after 15.

## The Process

### Step 1: Load and Review Plan

1. Read the plan file
2. Review critically — identify any questions or concerns
3. If concerns exist, raise them with the user before starting
4. If everything is clear, proceed to execution

### Step 2: Execute a Batch

Execute the first 3 tasks (or a natural grouping if the plan has clear phases).

For each task:
1. Follow each step as specified in the plan
2. Run verifications as specified
3. Track what was completed

### Step 3: Report

When the batch is complete, report:
- What was implemented
- Verification output (test results, build status)
- Any issues encountered

Then wait for feedback before continuing.

### Step 4: Continue

Based on feedback:
- Apply changes if needed
- Execute next batch
- Repeat until complete

### Step 5: Wrap Up

After all tasks are complete and verified:
- If a finishing-a-development-branch skill is available, suggest using it
- Otherwise, run a final verification pass (tests, linting, build) and summarize the completed work

## When to Stop and Ask

Stop executing when you hit a blocker — guessing through ambiguity tends to compound errors:
- Missing dependency or unclear instruction
- Test fails unexpectedly
- Plan has gaps that prevent progress
- Verification fails repeatedly

Ask for clarification rather than guessing.

## Example: Plan File

A plan file typically looks like this:

```markdown
# Plan: Add user authentication

## Task 1: Set up auth middleware
- Create `src/middleware/auth.ts`
- Implement JWT token validation
- Add to Express app pipeline
- Verify: `npm test -- auth.test.ts` passes

## Task 2: Create login endpoint
- Add `POST /api/login` route
- Validate credentials against user store
- Return JWT on success
- Verify: `npm test -- login.test.ts` passes

## Task 3: Protect existing routes
- Add auth middleware to `/api/projects`
- Add auth middleware to `/api/settings`
- Verify: `npm test` — all tests pass
```

## Example: Batch Report

After completing tasks 1-3:

```
Completed batch 1 (tasks 1-3):

- Task 1: Created auth middleware in src/middleware/auth.ts
  with JWT validation. Tests pass (3/3).
- Task 2: Added POST /api/login endpoint with credential
  validation and JWT response. Tests pass (5/5).
- Task 3: Protected /api/projects and /api/settings with
  auth middleware. All tests pass (24/24).

No issues encountered. Ready for feedback before continuing
with tasks 4-6.
```

## Guidelines

- Review the plan critically before starting — raise concerns early
- Follow plan steps as specified
- Run verifications after each task, not just at the end
- Between batches: report and wait for feedback
- Stop when blocked rather than guessing
- Do not start implementation on main/master branch without explicit user consent

## Related Skills

These skills complement the execution workflow when available:
- **using-git-worktrees** — set up isolated workspace before starting
- **writing-plans** — creates the plans this skill executes
- **finishing-a-development-branch** — wrap up development after all tasks complete
