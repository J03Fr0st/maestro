# Code Review Checklist

Use this checklist for every PR. Mark items N/A if they don't apply.

---

## 🔴 Critical (Must Check)

### Correctness
- [ ] Code does what the PR description claims
- [ ] Edge cases are handled (null, empty, boundary values)
- [ ] Error paths are handled (try/catch, error responses)
- [ ] No obvious logic bugs (off-by-one, wrong operator, etc.)

### Security
- [ ] No SQL injection (parameterized queries used)
- [ ] No XSS (user input escaped/sanitized)
- [ ] Authorization checked (user owns/can access resource)
- [ ] No secrets in code (passwords, API keys, connection strings)
- [ ] Input validation present and correct

### Data Integrity
- [ ] Database operations are transactional where needed
- [ ] No race conditions in shared state
- [ ] Migrations are reversible or have rollback plan
- [ ] No data loss scenarios

---

## 🟠 Important (Should Check)

### Performance
- [ ] No N+1 query patterns
- [ ] Appropriate indexes exist for queries
- [ ] Large lists paginated
- [ ] No unnecessary loops or computations
- [ ] Async operations don't block

### Error Handling
- [ ] All async calls have error handling
- [ ] Errors logged with useful context
- [ ] User-facing errors are friendly (no stack traces)
- [ ] Errors don't leak sensitive information

### Testing
- [ ] New functionality has tests
- [ ] Edge cases are tested
- [ ] Tests are meaningful (not just for coverage)
- [ ] Tests are deterministic (no flaky tests)

---

## 🟡 Quality (Should Review)

### Readability
- [ ] Code is understandable without excessive comments
- [ ] Names are meaningful (variables, functions, classes)
- [ ] No excessive nesting (max 3 levels)
- [ ] Functions are focused (single responsibility)

### Maintainability
- [ ] No magic numbers/strings (use constants)
- [ ] No copy-paste code (DRY principle)
- [ ] Dependencies are appropriate
- [ ] No dead code

### Patterns
- [ ] Follows existing codebase patterns
- [ ] Uses appropriate design patterns
- [ ] Consistency with project conventions
- [ ] Types are properly defined (no `any` abuse)

---

## ⚪ Nice to Have (Optional)

### Documentation
- [ ] Complex logic has comments
- [ ] Public APIs have documentation
- [ ] README updated if needed
- [ ] Changelog updated if applicable

### Code Style
- [ ] Consistent formatting (defer to linter)
- [ ] Imports organized
- [ ] No TODO/FIXME without tickets
- [ ] No commented-out code

---

## Domain-Specific Checklists

### If Reviewing Angular Code
→ See [CODE_REVIEW_FRONTEND.md](CODE_REVIEW_FRONTEND.md)

- [ ] Components use OnPush change detection where appropriate
- [ ] Subscriptions properly unsubscribed
- [ ] trackBy used in *ngFor with lists
- [ ] No direct DOM manipulation

### If Reviewing C# API Code
→ See [CODE_REVIEW_BACKEND.md](CODE_REVIEW_BACKEND.md)

- [ ] Controller actions return appropriate status codes
- [ ] Async/await used correctly (no async void)
- [ ] DTOs used for API contracts
- [ ] Dependency injection used properly

### If Reviewing Database Changes
→ See [DATABASE_REVIEW.md](DATABASE_REVIEW.md)

- [ ] Migrations are safe for zero-downtime deploy
- [ ] Indexes added for new query patterns
- [ ] No delete/drop without backup plan
- [ ] Query performance verified

### If Security-Sensitive
→ See [SECURITY_REVIEW.md](SECURITY_REVIEW.md)

- [ ] Authentication required where needed
- [ ] Authorization granular enough
- [ ] Audit logging for sensitive operations
- [ ] OWASP Top 10 considered

---

## Quick Reference: Severity Levels

| Issue | Severity | Action |
|-------|----------|--------|
| Security vulnerability | 🔴 Blocker | Must fix |
| Data loss risk | 🔴 Blocker | Must fix |
| Logic bug | 🔴 Blocker | Must fix |
| Missing error handling | 🟠 Major | Should fix |
| Performance concern | 🟠 Major | Should fix |
| Missing tests | 🟠 Major | Should fix |
| Readability issue | 🟡 Minor | Consider |
| Naming improvement | 🟡 Minor | Consider |
| Style preference | ⚪ Nitpick | Optional |

---

## Review Summary Template

After completing review, summarize:

```
## Review Summary

**Status:** APPROVED / CHANGES REQUESTED / NEEDS DISCUSSION

### Blockers (must fix)
- [list or "None"]

### Important (should fix)
- [list or "None"]

### Suggestions (consider)
- [list or "None"]

### What I liked
- [acknowledge good work]
```
