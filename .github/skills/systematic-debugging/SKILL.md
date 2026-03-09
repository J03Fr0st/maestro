---
name: systematic-debugging
description: >
  Use when encountering any bug, test failure, or unexpected behavior, before proposing fixes.
  Make sure to use this skill whenever the user mentions "bug", "broken", "not working", "tests failing",
  "debug this", "tried multiple fixes", "error", or "unexpected behavior", even if they don't explicitly ask for it.
---

# Systematic Debugging

## Overview

Random fixes waste time and create new bugs. Quick patches mask underlying issues.

**Core principle:** Find root cause before attempting fixes. Symptom fixes are failure.

## Why This Process Exists

Skipping straight to fixes feels fast but typically costs more time:

| Temptation | What actually happens |
|------------|----------------------|
| "Issue is simple, don't need process" | Simple issues have root causes too. The process is fast for simple bugs -- just follow the steps. |
| "Emergency, no time for process" | Systematic debugging is faster than guess-and-check thrashing. Rushing guarantees rework. |
| "Just try this first, then investigate" | The first fix sets the pattern. Once you start guessing, you keep guessing. |
| "I'll write a test after confirming fix works" | Untested fixes don't stick. Writing the test first proves you understand the problem. |
| "Multiple fixes at once saves time" | You can't isolate what worked, and bundled changes often introduce new bugs. |
| "Reference is too long, I'll adapt the pattern" | Partial understanding of a pattern typically leads to bugs. Read it completely. |
| "I see the problem, let me fix it" | Seeing symptoms is not the same as understanding root cause. |
| "One more fix attempt" (after 2+ failures) | Three or more failed fixes usually indicate an architectural problem. Stop fixing and question the design. |

Lead with this table when tempted to skip ahead. If you have already tried multiple fixes, that is a strong signal to slow down and follow Phase 1 from the top.

## The Iron Law

```
NO FIXES WITHOUT ROOT CAUSE INVESTIGATION FIRST
```

If you have not completed Phase 1, do not propose fixes.

## When to Use

Use for any technical issue:
- Test failures
- Bugs in production
- Unexpected behavior
- Performance problems
- Build failures
- Integration issues

**Use this especially when:**
- Under time pressure (emergencies make guessing tempting)
- "Just one quick fix" seems obvious
- You have already tried multiple fixes
- A previous fix did not work
- You do not fully understand the issue

**Do not skip when:**
- Issue seems simple (simple bugs have root causes too)
- You are in a hurry (rushing guarantees rework)
- The user wants it fixed quickly (systematic is faster than thrashing)

## The Four Phases

Complete each phase before proceeding to the next. Skipping phases leads to guess-and-check loops that waste more time than the process itself.

### Phase 1: Root Cause Investigation

**Before attempting any fix:**

1. **Read Error Messages Carefully**
   - Do not skip past errors or warnings
   - They often contain the exact solution
   - Read stack traces completely
   - Note line numbers, file paths, error codes

2. **Reproduce Consistently**
   - Can you trigger it reliably?
   - What are the exact steps?
   - Does it happen every time?
   - If not reproducible, gather more data instead of guessing

3. **Check Recent Changes**
   - What changed that could cause this?
   - Git diff, recent commits
   - New dependencies, config changes
   - Environmental differences

4. **Gather Evidence in Multi-Component Systems**

   When the system has multiple components (CI -> build -> signing, API -> service -> database):

   Before proposing fixes, add diagnostic instrumentation:
   ```
   For EACH component boundary:
     - Log what data enters component
     - Log what data exits component
     - Verify environment/config propagation
     - Check state at each layer

   Run once to gather evidence showing WHERE it breaks
   THEN analyze evidence to identify failing component
   THEN investigate that specific component
   ```

   **Example (multi-layer system):**
   ```bash
   # Layer 1: Workflow
   echo "=== Secrets available in workflow: ==="
   echo "IDENTITY: ${IDENTITY:+SET}${IDENTITY:-UNSET}"

   # Layer 2: Build script
   echo "=== Env vars in build script: ==="
   env | grep IDENTITY || echo "IDENTITY not in environment"

   # Layer 3: Signing script
   echo "=== Keychain state: ==="
   security list-keychains
   security find-identity -v

   # Layer 4: Actual signing
   codesign --sign "$IDENTITY" --verbose=4 "$APP"
   ```

   **This reveals:** Which layer fails (secrets -> workflow OK, workflow -> build FAIL)

5. **Trace Data Flow**

   When the error is deep in the call stack:

   See `root-cause-tracing.md` in this directory for the complete backward tracing technique.

   **Quick version:**
   - Where does the bad value originate?
   - What called this with the bad value?
   - Keep tracing up until you find the source
   - Fix at source, not at symptom

### Phase 2: Pattern Analysis

**Find the pattern before fixing:**

1. **Find Working Examples**
   - Locate similar working code in the same codebase
   - What works that is similar to what is broken?

2. **Compare Against References**
   - If implementing a pattern, read reference implementation completely
   - Do not skim -- read every line
   - Understand the pattern fully before applying

3. **Identify Differences**
   - What is different between working and broken?
   - List every difference, however small
   - Do not assume "that can't matter"

4. **Understand Dependencies**
   - What other components does this need?
   - What settings, config, environment?
   - What assumptions does it make?

### Phase 3: Hypothesis and Testing

**Scientific method:**

1. **Form Single Hypothesis**
   - State clearly: "I think X is the root cause because Y"
   - Write it down
   - Be specific, not vague

2. **Test Minimally**
   - Make the smallest possible change to test hypothesis
   - One variable at a time
   - Do not fix multiple things at once

3. **Verify Before Continuing**
   - Did it work? Yes -> Phase 4
   - Did not work? Form a new hypothesis
   - Do not add more fixes on top

4. **When You Do Not Know**
   - Say "I don't understand X"
   - Do not pretend to know
   - Ask for help
   - Research more

### Phase 4: Implementation

**Fix the root cause, not the symptom:**

1. **Create Failing Test Case**
   - Simplest possible reproduction
   - Automated test if possible
   - One-off test script if no framework
   - If the `test-driven-development` skill is available, use it for writing proper failing tests

2. **Implement Single Fix**
   - Address the root cause identified
   - One change at a time
   - No "while I'm here" improvements
   - No bundled refactoring

3. **Verify Fix**
   - Test passes now?
   - No other tests broken?
   - Issue actually resolved?

4. **If Fix Does Not Work**
   - Stop
   - Count: How many fixes have you tried?
   - If < 3: Return to Phase 1, re-analyze with new information
   - **If >= 3: Stop and question the architecture (step 5 below)**
   - Do not attempt fix #4 without an architectural discussion

5. **If 3+ Fixes Failed: Question Architecture**

   **Pattern indicating architectural problem:**
   - Each fix reveals new shared state/coupling/problem in different place
   - Fixes require large-scale refactoring to implement
   - Each fix creates new symptoms elsewhere

   **Stop and question fundamentals:**
   - Is this pattern fundamentally sound?
   - Are we sticking with it through sheer inertia?
   - Should we refactor architecture vs. continue fixing symptoms?

   **Discuss with the user or the code owner before attempting more fixes.**

   This is not a failed hypothesis -- this is a wrong architecture.

## Red Flags -- Stop and Follow Process

If you catch yourself thinking:
- "Quick fix for now, investigate later"
- "Just try changing X and see if it works"
- "Add multiple changes, run tests"
- "Skip the test, I'll manually verify"
- "It's probably X, let me fix that"
- "I don't fully understand but this might work"
- "Pattern says X but I'll adapt it differently"
- "Here are the main problems: [lists fixes without investigation]"
- Proposing solutions before tracing data flow
- **"One more fix attempt" (when already tried 2+)**
- **Each fix reveals new problem in different place**

**All of these mean: Stop. Return to Phase 1.**

**If 3+ fixes failed:** Question the architecture (see Phase 4, step 5).

## Signals You Are Off Track

**Watch for these redirections from the user:**
- "Is that not happening?" - You assumed without verifying
- "Will it show us...?" - You should have added evidence gathering
- "Stop guessing" - You are proposing fixes without understanding
- "Ultrathink this" - Question fundamentals, not just symptoms
- "We're stuck?" (frustrated) - Your approach is not working

**When you see these:** Stop. Return to Phase 1.

## Quick Reference

| Phase | Key Activities | Success Criteria |
|-------|---------------|------------------|
| **1. Root Cause** | Read errors, reproduce, check changes, gather evidence | Understand WHAT and WHY |
| **2. Pattern** | Find working examples, compare | Identify differences |
| **3. Hypothesis** | Form theory, test minimally | Confirmed or new hypothesis |
| **4. Implementation** | Create test, fix, verify | Bug resolved, tests pass |

## When Process Reveals "No Root Cause"

If systematic investigation reveals issue is truly environmental, timing-dependent, or external:

1. You have completed the process
2. Document what you investigated
3. Implement appropriate handling (retry, timeout, error message)
4. Add monitoring/logging for future investigation

In practice, most "no root cause" conclusions come from incomplete investigation.

## Supporting Techniques

These techniques are part of systematic debugging and available in this directory:

- **`root-cause-tracing.md`** - Trace bugs backward through call stack to find original trigger
- **`defense-in-depth.md`** - Add validation at multiple layers after finding root cause
- **`condition-based-waiting.md`** - Replace arbitrary timeouts with condition polling

**Related skills (use if available):**
- **test-driven-development** - For creating failing test case (Phase 4, Step 1)
- **verification-before-completion** - Verify fix worked before claiming success

## Real-World Impact

From debugging sessions:
- Systematic approach: typically 15-30 minutes to fix
- Random fixes approach: typically 2-3 hours of thrashing
- First-time fix rate improves dramatically with root cause analysis
- New bugs introduced: near zero with systematic approach vs. common with guess-and-check
