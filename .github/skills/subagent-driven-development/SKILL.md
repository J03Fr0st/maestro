---
name: subagent-driven-development
description: Execute implementation plans with fresh subagent per task, two-stage review (spec compliance then code quality)
---

# Subagent-Driven Development

Execute plan by dispatching fresh subagent per task, with two-stage review after each.

**Core principle:** Fresh subagent per task + two-stage review (spec then quality) = high quality, fast iteration

## When to Use

- Have implementation plan with independent tasks
- Want to stay in current session
- Want automatic review checkpoints

## The Process

```
For each task:
1. Extract full task text from plan (don't make subagent read file)
2. Dispatch implementer subagent with full text + context
3. Answer any questions implementer asks
4. Implementer implements, tests, commits, self-reviews
5. Dispatch spec reviewer (verify: built exactly what was requested)
6. If spec issues → implementer fixes → re-review
7. Dispatch code quality reviewer (verify: well-built)
8. If quality issues → implementer fixes → re-review
9. Mark task complete

After all tasks:
- Dispatch final reviewer for entire implementation
- Use finishing-a-development-branch skill
```

## Prompt Templates

See:
- `./implementer-prompt.md`
- `./spec-reviewer-prompt.md`
- `./code-quality-reviewer-prompt.md`

## Red Flags

**Never:**
- Skip either review stage
- Proceed with unfixed issues
- Make subagent read plan file (provide full text)
- Start code quality review before spec compliance passes
- Accept "close enough" on spec compliance

**If reviewer finds issues:**
- Implementer fixes them
- Reviewer reviews again
- Repeat until approved
