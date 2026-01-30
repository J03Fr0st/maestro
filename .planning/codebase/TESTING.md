# Testing Patterns

**Analysis Date:** 2026-01-30

## Overview

The maestro codebase contains no traditional code unit tests. Instead, testing emphasis is placed on **skill-based testing methodology** through the `test-driven-development` skill, **quality assurance through code review**, and **verification workflows**. Testing patterns are documented as methodologies and best practices rather than executable test files.

## Testing Philosophy

The codebase enforces Test-Driven Development (TDD) at the methodology level through documented skills that agents must follow when implementing code:

**Core Principle:** "NO PRODUCTION CODE WITHOUT A FAILING TEST FIRST"

All implementation must follow the Red-Green-Refactor cycle documented in `test-driven-development` skill (`D:\Source\maestro\.github\skills\test-driven-development\SKILL.md`).

## Test-Driven Development Framework

**Location:** `.github/skills/test-driven-development/SKILL.md`

**Mandatory Workflow Stages:**

### RED - Write Failing Test First
- Write ONE minimal test showing expected behavior
- One behavior per test
- Clear, descriptive test names
- Use real code (avoid mocks unless unavoidable)
- Test must fail for expected reasons (not typos or missing implementation)

**Pattern:**
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

### GREEN - Write Minimum Code to Pass
- Simplest code that passes the test
- Just enough to pass, no more
- Don't add features beyond what test requires
- No over-engineering with options/callbacks

### VERIFY - Run Tests to Confirm
- **MANDATORY step** - Never skip
- Confirm test passes
- Verify other tests still pass
- No errors or warnings

### REFACTOR - Clean Up After GREEN
- Only after GREEN stage
- Remove duplication
- Improve names
- Extract helpers
- Keep tests green

## Quality Assurance Through Code Review

**Location:** `.github/skills/code-review/SKILL.md`

### Review Checklist Pattern

All implementations are validated against this checklist:

**Correctness:**
- Code does what it's supposed to do
- Edge cases are handled
- Error handling is appropriate
- No obvious bugs

**Security:**
- Input validation present
- No SQL injection vulnerabilities
- No XSS vulnerabilities (if applicable)
- Authorization checks in place
- No hardcoded secrets

**Performance:**
- No N+1 query problems
- No unnecessary loops or computations
- Appropriate caching considered
- Large data sets handled properly

**Maintainability:**
- Code is readable and understandable
- Functions are focused (single responsibility)
- No excessive complexity
- Consistent with codebase style

**Testing:**
- Unit tests for new functionality
- Edge cases tested
- Tests are meaningful (not just for coverage)

### Severity Levels for Issues

| Level | When to Use | Example |
|-------|-------------|---------|
| **Blocker/Critical** | Must fix, can't merge | Security vulnerability |
| **Major/Important** | Should fix | Missing error handling |
| **Minor** | Consider fixing | Naming improvement |
| **Nitpick** | Optional | Style preference |

## Verification Workflow

**Location:** Referenced in `maestro-reviewer.agent.md` and `maestro-implementer.agent.md`

### Two-Stage Review Protocol

**Stage 1: Spec Compliance Review**
1. Compare implementation against Tech Spec
2. Verify all requirements met
3. Check nothing extra was added (YAGNI principle)
4. Verify nothing is missing

Output format:
```markdown
## Spec Compliance

**Requirements:**
| Requirement | Status | Notes |
|-------------|--------|-------|
| [Req 1] | Met/Missing | [Details] |

**Extra Work (YAGNI violations):**
- [Feature not requested]

**Verdict:** Spec Compliant | Not Compliant
```

**Stage 2: Code Quality Review**
- Only after spec compliance passes
- Architecture and design patterns
- Error handling and edge cases
- Security considerations
- Performance concerns
- Test quality

## Implementation Testing Requirements

**Location:** `maestro-implementer.agent.md`

### Per-Task Testing Obligations

Each implementation task must have:

1. **Failing Test First** - RED stage shows test fails for right reasons
2. **Passing Tests** - GREEN stage verifies code works
3. **Full Suite Pass** - All existing tests still pass
4. **No Errors** - Compiler/linter has no issues
5. **Acceptance Criteria Met** - All requirements verified

**Required assertions:**
```markdown
## Acceptance Criteria Status

| Criteria | Status |
|----------|--------|
| [Criteria 1 from Tech Spec] | ✅ Met |
| [Criteria 2 from Tech Spec] | ✅ Met |
| All existing tests pass | ✅ Met |
| New tests cover changes | ✅ Met |
```

## Test Naming Conventions

**Pattern:** `Method_Scenario_ExpectedResult`

**Examples from code-review skill:**
```typescript
describe('calculateTotal', () => {
  it('should return zero for empty cart', () => { });
  it('should sum all item prices', () => { });
  it('should apply discount when valid code', () => { });
});
```

**Principles:**
- Descriptive names showing the behavior tested
- Use "should" for clarity: "should return", "should throw", "should validate"
- Test behavior, not implementation
- Make test name a sentence: "calculateTotal should return zero for empty cart"

## Test Structure Pattern

**Arrange-Act-Assert (AAA) pattern:**
```typescript
test('behavior being tested', () => {
  // Arrange - Set up test data and conditions
  const input = setupTestData();

  // Act - Perform the action being tested
  const result = performAction(input);

  // Assert - Verify the expected outcome
  expect(result).toMatch(expectedValue);
});
```

## Mocking Guidelines

**When to Mock:**
- External API calls (network dependencies)
- Database queries (isolation)
- Time-dependent operations (control time)
- Random values (determinism)

**When NOT to Mock:**
- Core business logic (test real behavior)
- Validation logic (test actual validation)
- Error conditions (test real error handling)
- Data transformations (test actual transformation)

**Principle:** Test behavior, not implementation. Mock external dependencies, not internal logic.

## Test Coverage Goals

**Not enforced with percentage targets** - Instead emphasis on:

- **Meaningful coverage** - Tests verify actual behavior, not just line coverage
- **Happy path coverage** - Normal operations work correctly
- **Edge case coverage** - Boundary conditions handled
- **Error case coverage** - Error conditions caught and handled appropriately

## Test Types

### Unit Tests
- **Scope:** Individual functions/methods
- **Approach:** Test in isolation from dependencies
- **Coverage:** Every unit with public interface
- **Location:** Co-located with implementation or in standard test directory

### Integration Tests
- **Scope:** Multiple components working together
- **Approach:** Test component interactions and data flow
- **Coverage:** Critical paths and failure scenarios
- **Location:** Separate from unit tests, organized by feature

### E2E Tests
- **Scope:** Complete user workflows
- **Approach:** End-to-end testing from UI to database
- **Coverage:** Critical user paths only
- **Status:** Not currently enforced in maestro

## Self-Review Before Submission

**From maestro-implementer.agent.md** - Before reporting completion:

### Completeness Check
- Did I fully implement everything in the spec?
- Did I miss any requirements?
- Are there edge cases I didn't handle?

### Quality Check
- Is this my best work?
- Are names clear and accurate (match what things do)?
- Is the code clean and maintainable?

### Discipline Check
- Did I avoid overbuilding (YAGNI)?
- Did I only build what was requested?
- Did I follow existing patterns?

### Testing Check
- Do tests actually verify behavior (not just mock behavior)?
- Did I follow TDD?
- Are tests comprehensive?

**If issues found during self-review, fix them before reporting.**

## Deviation Protocol During Implementation

**From maestro-implementer.agent.md** - Auto-fixes during implementation:

### RULE 1: Auto-fix Bugs
**Trigger:** Code doesn't work as intended
- Wrong logic, off-by-one errors
- Type errors, null references
- Security vulnerabilities
- Fix immediately, document in report

### RULE 2: Auto-add Missing Critical Functionality
**Trigger:** Essential features missing for correctness/security
- Missing input validation
- Missing error handling
- Missing auth checks
- Fix immediately, document in report

### RULE 3: Auto-fix Blocking Issues
**Trigger:** Something prevents task completion
- Missing dependency
- Wrong import paths
- Build config errors
- Fix to unblock, document in report

### RULE 4: Ask About Architectural Changes
**Trigger:** Fix requires significant structural modification
- Adding new database tables
- Changing auth approach
- Adding new services
- Stop, present options to user

## Test Verification Checklist

**Before marking work complete:**

- [ ] Every new function has a test
- [ ] Watched each test fail before implementing
- [ ] Each test failed for expected reason
- [ ] Wrote minimal code to pass each test
- [ ] All tests pass
- [ ] No errors or warnings in output
- [ ] Tests verify behavior, not implementation details
- [ ] Edge cases considered and tested
- [ ] Error conditions tested
- [ ] Self-review completed, no issues remain

**Cannot check all boxes?** TDD protocol wasn't followed - start over.

## Quality Standards Integration

**From code-review skill** - Applied to all testing:

- Tests should be independent and deterministic
- Test names should be descriptive
- One assertion focus per test (one reason to fail)
- Tests should verify behavior, not test mocks
- Meaningful assertions only (avoid "testing the tester")

## No Technology-Specific Test Frameworks

The maestro codebase doesn't mandate specific test frameworks. Agents implementing code must:

1. **Use project's existing test framework** (if present)
2. **Follow TDD principles** regardless of framework
3. **Apply code review checklist** to tests themselves
4. **Document test strategy in Tech Spec** before implementation

Implementation agents (`maestro-implementer`) have access to multiple frameworks (npm test, dotnet test, pytest, cargo test, etc.) and automatically run appropriate commands.

## Continuous Verification

**From maestro-verifier.agent.md concept** - Ongoing verification:

- Phase goals must be verified, not just tasks completed
- Evidence required before claiming success
- Verify artifacts exist and work as specified
- Run implementation through code review checklist
- Confirm acceptance criteria met

---

*Testing analysis: 2026-01-30*
