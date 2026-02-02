---
name: writing-plans
description: Write comprehensive implementation plans with bite-sized tasks. Use when you have requirements for a multi-step task, before touching code.
---

# Writing Plans

Write comprehensive implementation plans assuming the reader has zero context.

## When to Use

- Before implementing any multi-step feature
- When requirements are clear and you're ready to plan implementation
- Before touching code — plan first, execute second
- When handing off work to another agent or developer

## Plan Location

Save plans to: `docs/plans/YYYY-MM-DD-<feature-name>.md`

## Template

See: `templates/plan-template.md` for the full plan template.

## Bite-Sized Task Granularity

**Each step is one action:**
- "Write the failing test" - step
- "Run it to make sure it fails" - step
- "Implement minimal code" - step
- "Run tests to verify pass" - step
- "Commit" - step

## Plan Structure Summary

### Header (Required)
- **Goal:** One sentence
- **Architecture:** 2-3 sentences
- **Tech Stack:** Key technologies

### Each Task
- **Files:** Create/Modify/Test with exact paths
- **Step 1:** Write failing test (complete code)
- **Step 2:** Run test, verify fails
- **Step 3:** Write implementation (complete code)
- **Step 4:** Run test, verify passes
- **Step 5:** Commit with conventional message

## Remember

- Exact file paths always
- Complete code in plan (not "add validation")
- Exact commands with expected output
- DRY, YAGNI, TDD, frequent commits

## Example Mini-Plan

```markdown
# Add User Validation

**Goal:** Validate email format before user creation.
**Architecture:** Add validator function, integrate into create endpoint.
**Tech Stack:** Python, pytest

---

## Task 1: Email Validator

**Files:**
- Create: `src/validators/email.py`
- Test: `tests/validators/test_email.py`

**Step 1:** Write failing test
**Step 2:** Run `pytest tests/validators/test_email.py -v` → FAIL
**Step 3:** Implement `is_valid_email()` function
**Step 4:** Run test → PASS
**Step 5:** `git commit -m "feat: add email validator"`
```

## Execution Handoff

After saving the plan:

**"Plan complete and saved to `docs/plans/YYYY-MM-DD-<feature-name>.md`."**

→ Use skill: `executing-plans` to execute tasks in batches with review checkpoints.

## Related Skills

- `executing-plans` - Execute plans with batch processing and review checkpoints
