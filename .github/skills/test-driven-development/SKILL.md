---
name: test-driven-development
description: Strict Test-Driven Development with RED-GREEN-REFACTOR cycle. Use for new features, bug fixes, refactoring, or behavior changes; ask before skipping for throwaway prototypes, generated code, or configuration-only changes.
---

# Test-Driven Development (TDD)

Write the test first. Watch it fail. Write minimal code to pass.

## The Iron Law

```
NO PRODUCTION CODE WITHOUT A FAILING TEST FIRST
```

If you wrote code before the test, delete it. Start over. No exceptions.

## Red-Green-Refactor Cycle

### RED - Write Failing Test

Write ONE minimal test showing expected behavior.

**Requirements:**
- One behavior per test
- Clear descriptive name
- Real code (avoid mocks unless unavoidable)

**Good:**
```typescript
test('retries failed operations 3 times', async () => {
  let attempts = 0;
  const operation = () => {
    attempts++;
    if (attempts < 3) throw new Error('fail');
    return 'success';
  };

  const result = await retryOperation(operation);

  expect(result).toBe('success');
  expect(attempts).toBe(3);
});
```

**Bad:**
```typescript
test('retry works', () => { /* vague name, tests mock not code */ });
```

### Verify RED - Watch It Fail

**MANDATORY. Never skip.**

Run the test and confirm:
- Test fails (not errors)
- Failure message is expected
- Fails because feature missing (not typos)

**Test passes immediately?** You're testing existing behavior. Fix the test.

### GREEN - Minimal Code

Write the SIMPLEST code to pass the test.

**Good:** Just enough to pass
**Bad:** Over-engineered with options, callbacks, etc.

Don't add features beyond the test.

### Verify GREEN - Watch It Pass

**MANDATORY.**

Confirm:
- Test passes
- Other tests still pass
- No errors or warnings

**Test fails?** Fix code, not test.

### REFACTOR - Clean Up

After green only:
- Remove duplication
- Improve names
- Extract helpers

Keep tests green. Don't add behavior.

## Red Flags - STOP and Start Over

If you catch yourself:
- Writing code before test
- Test passing immediately
- Can't explain why test failed
- Saying "I'll test after"
- Thinking "too simple to test"
- Rationalizing "just this once"

**All mean: Delete code. Start over with TDD.**

## Common Rationalizations

| Excuse | Reality |
|--------|---------|
| "Too simple to test" | Simple code breaks. Test takes 30 seconds. |
| "I'll test after" | Tests passing immediately prove nothing. |
| "Need to explore first" | Fine. Throw away exploration, start with TDD. |
| "TDD will slow me down" | TDD faster than debugging. |
| "Already manually tested" | Manual doesn't prove edge cases. |

## Verification Checklist

Before marking work complete:

- [ ] Every new function has a test
- [ ] Watched each test fail before implementing
- [ ] Each test failed for expected reason
- [ ] Wrote minimal code to pass each test
- [ ] All tests pass
- [ ] No errors or warnings in output

Can't check all boxes? You skipped TDD. Start over.
