---
name: systematic-debugging
description: Scientific method debugging with root cause investigation. Use when encountering bugs, test failures, or unexpected behavior. Prevents random fix attempts.
---

# Systematic Debugging

Random fixes waste time and create new bugs.

## The Iron Law

```
NO FIXES WITHOUT ROOT CAUSE INVESTIGATION FIRST
```

If you haven't completed Phase 1, you cannot propose fixes.

## When to Use

Use for ANY technical issue:
- Test failures
- Bugs in production
- Unexpected behavior
- Performance problems
- Build failures

**Use ESPECIALLY when:**
- Under time pressure
- "Just one quick fix" seems obvious
- You've tried multiple fixes already

## The Four Phases

### Phase 1: Root Cause Investigation

**BEFORE attempting ANY fix:**

1. **Read Error Messages Carefully**
   - Don't skip past errors
   - Read stack traces completely
   - Note line numbers, file paths

2. **Reproduce Consistently**
   - Can you trigger it reliably?
   - What are the exact steps?

3. **Check Recent Changes**
   - What changed that could cause this?
   - Git diff, recent commits

4. **Trace Data Flow**
   - Where does bad value originate?
   - Keep tracing up until you find source

### Phase 2: Pattern Analysis

1. **Find Working Examples** - Similar code that works
2. **Compare Against References** - Read completely
3. **Identify Differences** - List every difference
4. **Understand Dependencies** - What does this need?

### Phase 3: Hypothesis and Testing

1. **Form Single Hypothesis** - "I think X because Y"
2. **Test Minimally** - SMALLEST possible change
3. **Verify Before Continuing** - Didn't work? NEW hypothesis
4. **Don't stack fixes** - One at a time

### Phase 4: Implementation

1. **Create Failing Test Case** - Must have before fixing
2. **Implement Single Fix** - ONE change at a time
3. **Verify Fix** - Test passes? Other tests broken?
4. **If 3+ Fixes Failed** - Question the architecture

## Red Flags - STOP

If thinking:
- "Quick fix for now, investigate later"
- "Just try changing X"
- "I don't fully understand but might work"
- "One more fix attempt" (when already tried 2+)

**ALL mean: STOP. Return to Phase 1.**

## Common Rationalizations

| Excuse | Reality |
|--------|---------|
| "Issue is simple" | Simple issues have root causes too |
| "Emergency, no time" | Systematic is FASTER than thrashing |
| "Just try this first" | First fix sets the pattern |
| "I see the problem" | Seeing symptoms ≠ understanding root cause |

## Quick Reference

| Phase | Key Activities | Success Criteria |
|-------|---------------|------------------|
| 1. Root Cause | Read errors, reproduce, check changes | Understand WHAT and WHY |
| 2. Pattern | Find working examples, compare | Identify differences |
| 3. Hypothesis | Form theory, test minimally | Confirmed or new hypothesis |
| 4. Implementation | Create test, fix, verify | Bug resolved, tests pass |
