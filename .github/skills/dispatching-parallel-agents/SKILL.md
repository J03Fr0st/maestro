---
name: dispatching-parallel-agents
description: Dispatch multiple agents in parallel for independent tasks. Use when facing 2+ independent problems without shared state or sequential dependencies (e.g., multiple failing test files), and avoid when failures are related or shared state matters.
---

# Dispatching Parallel Agents

When you have multiple unrelated failures, investigating them sequentially wastes time.

## The Pattern

### 1. Identify Independent Domains

Group failures by what's broken:
- File A tests: Tool approval flow
- File B tests: Batch completion behavior
- File C tests: Abort functionality

### 2. Create Focused Agent Tasks

Each agent gets:
- **Specific scope:** One test file or subsystem
- **Clear goal:** Make these tests pass
- **Constraints:** Don't change other code
- **Expected output:** Summary of findings

### 3. Dispatch in Parallel

```
Task("Fix agent-abort.test.ts failures")
Task("Fix batch-completion.test.ts failures")
Task("Fix tool-approval.test.ts failures")
// All three run concurrently
```

### 4. Review and Integrate

When agents return:
- Read each summary
- Verify fixes don't conflict
- Run full test suite
- Integrate all changes

## Agent Prompt Structure

Good prompts are:
1. **Focused** - One clear problem domain
2. **Self-contained** - All context needed
3. **Specific about output** - What should agent return?

**Example:**
```
Fix the 3 failing tests in src/agents/agent-abort.test.ts:

1. "should abort with partial output" - expects 'interrupted' in message
2. "should handle mixed completed/aborted" - wrong status
3. "should track pendingCount" - expects 3 but gets 0

Your task:
1. Read the test file
2. Identify root cause
3. Fix (events, not timeouts)

Return: Summary of what you found and fixed.
```

## Common Mistakes

| Mistake | Fix |
|---------|-----|
| Too broad ("Fix all tests") | Specific ("Fix agent-abort.test.ts") |
| No context | Paste error messages |
| No constraints | "Do NOT change production code" |
| Vague output | "Return summary of root cause" |

## Verification

After agents return:
1. **Review each summary** - What changed
2. **Check for conflicts** - Same code edited?
3. **Run full suite** - All fixes work together
4. **Spot check** - Agents can make errors
