---
name: test-driven-development
description: >
  Use when writing tests, doing test-first development, red-green-refactor
  cycles, TDD, unit testing, adding test coverage, or fixing bugs with
  regression tests.
  Trigger phrases: "write tests first", "TDD", "test-driven", "red-green-refactor",
  "add test coverage", "unit test this", "write a failing test",
  "test before implementing".
---

# Test-Driven Development (TDD)

## Overview

Write the test first. Watch it fail. Write minimal code to pass.

## Why Test-First Matters

Tests written after code pass immediately — and a test that has never failed proves nothing. You don't know if it's testing the right thing, testing implementation details instead of behavior, or missing edge cases you forgot about. Watching a test fail first proves it actually detects the absence of the feature.

Test-first also forces better design: if something is hard to test, it's usually hard to use. The test is your first consumer of the API, and awkwardness there signals a design problem worth fixing now rather than later.

## The Red-Green-Refactor Cycle

1. **RED** — Write one failing test that describes the behavior you want
2. **Verify RED** — Run the test, confirm it fails for the right reason (missing feature, not a typo)
3. **GREEN** — Write the simplest code that makes the test pass
4. **Verify GREEN** — Run the test, confirm it passes and no other tests broke
5. **REFACTOR** — Clean up (remove duplication, improve names, extract helpers) while keeping tests green
6. **Repeat** — Next failing test for the next behavior

The key discipline: if production code gets written before its test, delete it and start over. Code written without a failing test tends to get "adapted" rather than properly test-driven, which defeats the purpose. It feels wasteful, but keeping unverified code is more expensive than rewriting it.

## When to Use

- New features
- Bug fixes (write a test that reproduces the bug first)
- Refactoring (ensure tests exist before changing behavior)
- Behavior changes

**Reasonable exceptions (discuss with the user):**
- Throwaway prototypes (but throw them away — don't ship them)
- Generated code
- Configuration files

## RED — Write a Failing Test

Write one minimal test showing what should happen.

**Good test:**
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
Clear name, tests real behavior, one thing.

**Weaker test:**
```typescript
test('retry works', async () => {
  const mock = jest.fn()
    .mockRejectedValueOnce(new Error())
    .mockRejectedValueOnce(new Error())
    .mockResolvedValueOnce('success');
  await retryOperation(mock);
  expect(mock).toHaveBeenCalledTimes(3);
});
```
Vague name, tests mock behavior rather than real code.

**Requirements:**
- One behavior per test
- Clear name describing the behavior
- Real code paths (mocks only when unavoidable, e.g., external services)

## Verify RED — Watch It Fail

Run the test and confirm:
- Test fails (not errors from syntax/import issues)
- Failure message matches expectations
- Fails because the feature is missing, not because of typos

If the test passes immediately, you're testing existing behavior — fix the test.
If the test errors, fix the error and re-run until it fails correctly.

## GREEN — Minimal Code

Write the simplest code to pass the test.

**Good:**
```typescript
async function retryOperation<T>(fn: () => Promise<T>): Promise<T> {
  for (let i = 0; i < 3; i++) {
    try {
      return await fn();
    } catch (e) {
      if (i === 2) throw e;
    }
  }
  throw new Error('unreachable');
}
```
Just enough to pass.

**Over-engineered:**
```typescript
async function retryOperation<T>(
  fn: () => Promise<T>,
  options?: {
    maxRetries?: number;
    backoff?: 'linear' | 'exponential';
    onRetry?: (attempt: number) => void;
  }
): Promise<T> {
  // YAGNI — no test asked for these options
}
```

Don't add features, refactor other code, or "improve" beyond the test.

## Verify GREEN — Watch It Pass

Run the test and confirm:
- The new test passes
- All other tests still pass
- Output is clean (no errors, warnings)

If the test fails, fix the code, not the test.
If other tests broke, fix them now.

## REFACTOR — Clean Up

After green only:
- Remove duplication
- Improve names
- Extract helpers

Keep tests green throughout. Don't add new behavior during refactoring.

## Good Tests

| Quality | Good | Bad |
|---------|------|-----|
| **Minimal** | One thing. "and" in name? Split it. | `test('validates email and domain and whitespace')` |
| **Clear** | Name describes behavior | `test('test1')` |
| **Shows intent** | Demonstrates desired API | Obscures what code should do |

## Common Rationalizations and Why They're Wrong

| Excuse | Why it doesn't hold up |
|--------|----------------------|
| "Too simple to test" | Simple code breaks. The test takes 30 seconds to write. |
| "I'll test after" | Tests that pass immediately prove nothing — you never saw them catch the bug. |
| "Already manually tested" | Ad-hoc testing has no record, can't re-run, misses cases under pressure. |
| "Deleting X hours is wasteful" | Sunk cost. Keeping code you can't verify is technical debt. |
| "Keep as reference, write tests first" | You'll adapt it instead of writing fresh. That's testing-after in disguise. |
| "Need to explore first" | Fine — explore, then throw it away and start with TDD. |
| "Hard to test = design unclear" | Listen to the test. Hard to test = hard to use. Simplify the interface. |
| "TDD slows me down" | TDD is faster than debugging. Less rework, fewer production bugs. |
| "Existing code has no tests" | You're improving it. Add tests for what you're changing. |

## Red Flags — Stop and Reconsider

If you notice any of these, pause and return to the red-green-refactor cycle:

- Writing production code before its test
- A test passing immediately on first run
- Can't explain why a test failed
- Wanting to keep implementation code "as reference"
- Thinking "just this once" about skipping a step

## Example: Bug Fix with TDD

**Bug:** Empty email accepted by form submission

**RED:**
```typescript
test('rejects empty email', async () => {
  const result = await submitForm({ email: '' });
  expect(result.error).toBe('Email required');
});
```

**Verify RED:**
```
$ npm test
FAIL: expected 'Email required', got undefined
```

**GREEN:**
```typescript
function submitForm(data: FormData) {
  if (!data.email?.trim()) {
    return { error: 'Email required' };
  }
  // ...existing logic
}
```

**Verify GREEN:**
```
$ npm test
PASS (all tests)
```

**REFACTOR:** Extract validation for multiple fields if needed.

## Verification Checklist

Before marking work complete:

- [ ] Every new function/method has a test
- [ ] Watched each test fail before implementing
- [ ] Each test failed for the expected reason (feature missing, not typo)
- [ ] Wrote minimal code to pass each test
- [ ] All tests pass
- [ ] Output clean (no errors, warnings)
- [ ] Tests use real code (mocks only if unavoidable)
- [ ] Edge cases and errors covered

## When Stuck

| Problem | Solution |
|---------|----------|
| Don't know how to test | Write the API you wish existed. Write the assertion first. Ask the user. |
| Test too complicated | Design too complicated. Simplify the interface. |
| Must mock everything | Code too coupled. Use dependency injection. |
| Test setup huge | Extract helpers. Still complex? Simplify design. |

## Testing Anti-Patterns

When adding mocks or test utilities, read @testing-anti-patterns.md to avoid common pitfalls:
- Testing mock behavior instead of real behavior
- Adding test-only methods to production classes
- Mocking without understanding dependencies
