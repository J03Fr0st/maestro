---
name: dispatching-parallel-agents
description: >
  Use when facing 2+ independent tasks that can be worked on without shared state or sequential dependencies.
  Make sure to use this skill whenever the user mentions "multiple test failures", "fixing several bugs at once",
  "parallel investigations", "independent subtasks", "split this up", or "work on these simultaneously",
  even if they don't explicitly ask for it.
---

# Dispatching Parallel Agents

## Overview

When you have multiple unrelated failures (different test files, different subsystems, different bugs), investigating them sequentially wastes time. Each investigation is independent and can happen in parallel.

**Core principle:** Dispatch one agent per independent problem domain. Let them work concurrently.

## When to Use (and When Not To)

**Decision flow:**

1. Are there multiple failures or tasks? If no, use a single agent.
2. Are they independent (different root causes, different subsystems)? If no (they are related), use a single agent to investigate all -- fixing one may fix the others.
3. Can agents work without shared state? If no (they would edit the same files or use the same resources), use sequential agents.
4. If yes to all three: **dispatch in parallel.**

**Good fit:**
- 3+ test files failing with different root causes
- Multiple subsystems broken independently
- Each problem can be understood without context from others
- No shared state between investigations

**Poor fit:**
- Failures are related (fix one and others may resolve)
- Understanding requires seeing the entire system state
- Exploratory debugging where you do not yet know what is broken
- Agents would interfere (editing same files, using same resources)

## The Pattern

### 1. Identify Independent Domains

Group failures by what is broken:
- File A tests: Tool approval flow
- File B tests: Batch completion behavior
- File C tests: Abort functionality

Each domain is independent -- fixing tool approval does not affect abort tests.

### 2. Create Focused Agent Tasks

Each agent gets:
- **Specific scope:** One test file or subsystem
- **Clear goal:** Make these tests pass
- **Constraints:** Do not change other code
- **Expected output:** Summary of what you found and fixed

### 3. Dispatch in Parallel

```typescript
// Pseudocode -- Claude Code agent dispatch
Task("Fix agent-tool-abort.test.ts failures")
Task("Fix batch-completion-behavior.test.ts failures")
Task("Fix tool-approval-race-conditions.test.ts failures")
// All three run concurrently
```

### 4. Review and Integrate

When agents return:
- Read each summary
- Verify fixes do not conflict
- Run full test suite
- Integrate all changes

## Agent Prompt Structure

Good agent prompts are:
1. **Focused** - One clear problem domain
2. **Self-contained** - All context needed to understand the problem
3. **Specific about output** - What should the agent return?

```markdown
Fix the 3 failing tests in src/agents/agent-tool-abort.test.ts:

1. "should abort tool with partial output capture" - expects 'interrupted at' in message
2. "should handle mixed completed and aborted tools" - fast tool aborted instead of completed
3. "should properly track pendingToolCount" - expects 3 results but gets 0

These are timing/race condition issues. Your task:

1. Read the test file and understand what each test verifies
2. Identify root cause - timing issues or actual bugs?
3. Fix by:
   - Replacing arbitrary timeouts with event-based waiting
   - Fixing bugs in abort implementation if found
   - Adjusting test expectations if testing changed behavior

Do NOT just increase timeouts - find the real issue.

Return: Summary of what you found and what you fixed.
```

## Common Mistakes

| Mistake | Fix |
|---------|-----|
| Too broad: "Fix all the tests" | Scope to one file/subsystem: "Fix agent-tool-abort.test.ts" |
| No context: "Fix the race condition" | Paste the error messages and test names |
| No constraints: agent refactors everything | Add: "Do NOT change production code" or "Fix tests only" |
| Vague output: "Fix it" | Require: "Return summary of root cause and changes" |

## Real Example

**Scenario:** 6 test failures across 3 files after major refactoring

**Failures:**
- agent-tool-abort.test.ts: 3 failures (timing issues)
- batch-completion-behavior.test.ts: 2 failures (tools not executing)
- tool-approval-race-conditions.test.ts: 1 failure (execution count = 0)

**Decision:** Independent domains -- abort logic separate from batch completion separate from race conditions

**Dispatch:**
```
Agent 1 -> Fix agent-tool-abort.test.ts
Agent 2 -> Fix batch-completion-behavior.test.ts
Agent 3 -> Fix tool-approval-race-conditions.test.ts
```

**Results:**
- Agent 1: Replaced timeouts with event-based waiting
- Agent 2: Fixed event structure bug (threadId in wrong place)
- Agent 3: Added wait for async tool execution to complete

**Integration:** All fixes independent, no conflicts, full suite green

## Verification

After agents return:
1. **Review each summary** - Understand what changed
2. **Check for conflicts** - Did agents edit same code?
3. **Run full suite** - Verify all fixes work together
4. **Spot check** - Agents can make systematic errors
