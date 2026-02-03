---
name: executing-plans
description: Execute implementation plans with batch execution and review checkpoints. Use when you have a written plan to implement task-by-task and want checkpoints between batches or single-agent execution.
---

# Executing Plans

Load plan, review critically, execute tasks in batches, report for review.

## Plan Location

Plans are typically saved at: `docs/plans/YYYY-MM-DD-<feature-name>.md`

Created by the `writing-plans` skill.

## The Process

### Step 1: Load and Review Plan

1. Read plan file
2. Review critically - identify questions or concerns
3. If concerns: Raise them before starting
4. If no concerns: Create todo list and proceed

### Step 2: Execute Batch

**Default: First 3 tasks**

For each task:
1. Mark as in_progress
2. Follow each step exactly
3. Run verifications as specified
4. Mark as completed

### Step 3: Report

When batch complete:
- Show what was implemented
- Show verification output
- Say: "Ready for feedback."

### Step 4: Continue

Based on feedback:
- Apply changes if needed
- Execute next batch
- Repeat until complete

### Step 5: Complete

After all tasks complete:
- Verify all tests pass
- Present completion options

## When to Stop and Ask

**STOP executing immediately when:**
- Hit a blocker mid-batch
- Plan has critical gaps
- You don't understand an instruction
- Verification fails repeatedly

**Ask for clarification rather than guessing.**

## Remember

- Review plan critically first
- Follow plan steps exactly
- Don't skip verifications
- Between batches: report and wait
- Stop when blocked, don't guess

## Example Batch Report

```
## Batch 1 Complete (Tasks 1-3)

**Task 1: Email Validator** ✅
- Created `src/validators/email.py`
- Test passes: `pytest tests/validators/test_email.py -v`

**Task 2: Integrate Validator** ✅
- Modified `src/api/users.py:45-52`
- Test passes: `pytest tests/api/test_users.py -v`

**Task 3: Error Response** ✅
- Added validation error handling
- All tests pass

**Ready for feedback before Tasks 4-6.**
```

## Related Skills

- `writing-plans` - Create implementation plans (use first)
