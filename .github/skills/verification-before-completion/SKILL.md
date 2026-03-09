---
name: verification-before-completion
description: >
  Use when about to claim work is done, finished, fixed, ready to merge,
  passing, or complete — before committing or creating PRs.
  Trigger phrases: "done", "finished", "ready to merge", "all tests pass",
  "works now", "ship it", "that should fix it", "looks good", "completed",
  "fixed the bug", "ready for review".
---

# Verification Before Completion

## Overview

Run the verification command. Read the output. Then — and only then — claim the result.

## Why This Matters

Without fresh verification, completion claims are guesses. Here's what actually happens when verification is skipped:

- **Undefined functions ship** — code compiles in your head but crashes at runtime
- **Missing requirements slip through** — "tests pass" doesn't mean requirements are met
- **Trust erodes** — once the user has to re-check your claims, every future claim gets scrutinized
- **Rework multiplies** — false completion leads to redirect, context-switching, and rework that costs more than the original verification would have

The pattern is consistent: unverified claims waste more time than they save.

## The Verification Gate

Before claiming any status:

1. **Identify** — What command proves this claim? (test suite, build, linter, etc.)
2. **Run** — Execute the full command fresh (not from memory, not from a previous run)
3. **Read** — Full output, check exit code, count failures
4. **Confirm** — Does the output actually support the claim?
   - If no: state the actual status with evidence
   - If yes: state the claim with evidence

## What Counts as Verification

| Claim | Requires | Not Sufficient |
|-------|----------|----------------|
| Tests pass | Test command output: 0 failures | Previous run, "should pass" |
| Linter clean | Linter output: 0 errors | Partial check, extrapolation |
| Build succeeds | Build command: exit 0 | Linter passing, "logs look good" |
| Bug fixed | Reproduce original symptom: passes | Code changed, assumed fixed |
| Regression test works | Red-green cycle verified | Test passes once |
| Agent completed | VCS diff shows changes | Agent reports "success" |
| Requirements met | Line-by-line checklist | Tests passing alone |

## When to Apply

**Before any completion-adjacent claim:**
- Saying work is done, fixed, passing, or ready
- Committing, creating a PR, or marking a task complete
- Moving to the next task (verify the current one is actually finished)
- Reporting on delegated work (verify the agent's output independently)

**This does not apply to:**
- In-progress observations like "this approach looks promising"
- Describing what you're about to do
- Sharing intermediate results you haven't claimed are final

The distinction: if you're asserting a state of completion or correctness, verify it first. If you're sharing work-in-progress, just be clear that it's in progress.

## Red Flags — Pause and Verify

Watch for these patterns in your own output — they usually signal an unverified claim:

- Words like "should", "probably", "seems to" before a status claim
- Satisfaction phrases ("Great!", "Perfect!", "Done!") before running verification
- About to commit/push/PR without a fresh test run
- Trusting an agent's success report without checking the diff
- Thinking "the change is small enough that it obviously works"

## Common Excuses and What to Do Instead

| Temptation | What to do instead |
|------------|-------------------|
| "Should work now" | Run the verification and find out |
| "I'm confident" | Confidence isn't evidence — run the command |
| "Linter passed" | Linter checks style, not correctness — run the tests too |
| "Agent said success" | Check the VCS diff and run verification independently |
| "Partial check is enough" | Partial verification misses partial failures — run the full suite |

## Key Patterns

**Tests:**
```
Run test command -> See "34/34 pass" -> "All tests pass"
NOT: "Should pass now" / "Looks correct"
```

**Build:**
```
Run build -> See exit 0 -> "Build succeeds"
NOT: "Linter passed" (linter doesn't check compilation)
```

**Requirements:**
```
Re-read plan -> Create checklist -> Verify each item -> Report gaps or completion
NOT: "Tests pass, phase complete" (tests don't prove requirements)
```

**Agent delegation:**
```
Agent reports success -> Check VCS diff -> Run verification -> Report actual state
NOT: Trust the agent report at face value
```

## The Bottom Line

Run the command. Read the output. Then claim the result.
