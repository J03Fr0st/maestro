# Code Review Overview

## Purpose of Code Review

Code review exists to:
1. **Catch bugs** before they reach production
2. **Share knowledge** across the team
3. **Maintain consistency** in codebase patterns
4. **Improve code quality** over time

## Goals

| Goal | Description |
|------|-------------|
| **Correctness** | Code works as intended, handles edge cases |
| **Security** | No vulnerabilities introduced |
| **Performance** | No regressions, efficient algorithms |
| **Maintainability** | Easy to understand and modify |
| **Consistency** | Follows team patterns and standards |

## What Code Review Is NOT

- A place to debate style preferences (use linters)
- An opportunity to rewrite someone's code your way
- A gatekeeping mechanism
- A blame assignment process

---

## Responsibilities

### Author Responsibilities

**Before Requesting Review:**
- [ ] Self-review your own changes first
- [ ] Ensure CI passes (tests, lint, build)
- [ ] Write a clear PR description
- [ ] Keep PRs focused and reasonably sized (<400 lines)
- [ ] Link to relevant requirements/tickets

**During Review:**
- [ ] Respond to all comments
- [ ] Be open to feedback
- [ ] Ask clarifying questions
- [ ] Push back with reasoning if you disagree

**After Review:**
- [ ] Address all blockers and majors
- [ ] Update PR description if scope changed
- [ ] Request re-review after significant changes

### Reviewer Responsibilities

**During Review:**
- [ ] Review within agreed SLA (ideally <24 hours)
- [ ] Focus on what matters (correctness, security, performance)
- [ ] Explain WHY something is an issue
- [ ] Suggest fixes, not just problems
- [ ] Acknowledge good work

**Communication:**
- [ ] Be respectful and constructive
- [ ] Use severity levels consistently
- [ ] Distinguish between blocking issues and suggestions
- [ ] Prefer questions over commands when possible

---

## Review Etiquette

### For Reviewers

**DO:**
- Ask questions: "What happens if X is null here?"
- Suggest alternatives: "Consider using Y for better Z"
- Praise good work: "Nice refactor of this logic!"
- Be specific: Reference file, line, code snippet

**DON'T:**
- Use dismissive language: "This is wrong"
- Make it personal: "You always do this"
- Nitpick excessively on style
- Demand changes without explanation

### For Authors

**DO:**
- Thank reviewers for their time
- Explain context when needed
- Ask for clarification if feedback is unclear
- Push back respectfully with evidence

**DON'T:**
- Take feedback personally
- Dismiss concerns without consideration
- Make changes just to "make them happy"
- Ignore comments you disagree with

---

## Review Workflow

### 1. Preparation (Author)

```
1. Complete implementation
2. Run tests locally
3. Self-review diff
4. Write PR description using template
5. Request review
```

### 2. First Pass (Reviewer)

```
1. Read PR description
2. Understand the goal
3. Check overall approach
4. Note structural concerns
```

### 3. Detailed Review (Reviewer)

```
1. Open CODE_REVIEW_CHECKLIST.md
2. Review file by file
3. Use domain-specific guides as needed
4. Comment with severity levels
```

### 4. Response (Author)

```
1. Address all comments
2. Reply to each thread
3. Push fixes
4. Request re-review if needed
```

### 5. Resolution (Both)

```
1. Reviewer verifies fixes
2. Approve or request another round
3. Merge when approved
```

---

## Communication Patterns

### Asking Questions

**Good:**
> "I'm not sure I understand the edge case where `user` is null. Could you explain what should happen?"

**Better:**
> "What happens if `user` is null on line 42? Might throw NullReferenceException?"

### Suggesting Changes

**Good:**
> "Consider adding null check here."

**Better:**
> "This could throw if user is null. Consider:
> ```csharp
> if (user is null) return NotFound();
> ```"

### Praising Good Work

> "Nice catch on the race condition here! The lock is perfect."

> "This refactor significantly improves readability. Well done."

---

## When to Block vs. Suggest

### 🔴 BLOCK (Must Fix)

- Security vulnerabilities
- Data loss or corruption risks
- Breaking changes without migration
- Missing required tests for critical paths
- Obvious bugs

### 🟠 STRONG SUGGESTION (Should Fix)

- Missing error handling
- Performance issues with clear impact
- Missing edge case handling
- Significant readability issues

### 🟡 SUGGESTION (Consider Fixing)

- Minor naming improvements
- Alternative approaches worth discussing
- Documentation improvements

### ⚪ NITPICK (Optional)

- Formatting preferences beyond linter
- Stylistic preferences
- "I would have done it differently"

---

## PR Size Guidelines

| Size | Lines Changed | Review Time | Risk |
|------|---------------|-------------|------|
| **XS** | 1-50 | 5-10 min | Low |
| **S** | 51-100 | 10-20 min | Low |
| **M** | 101-200 | 20-40 min | Medium |
| **L** | 201-400 | 40-60 min | Medium |
| **XL** | 400+ | 1+ hour | High |

**For Large PRs:**
- Consider splitting into logical chunks
- Provide extra context in description
- Offer to walk through changes
- Accept that review quality may decrease

---

## Review SLAs

| Priority | Initial Response | Complete Review |
|----------|------------------|-----------------|
| **Critical** (prod issue) | 1 hour | 4 hours |
| **High** (blocking work) | 4 hours | 1 day |
| **Normal** | 1 day | 2 days |
| **Low** (refactoring) | 2 days | 4 days |

**If you can't meet SLA:**
- Communicate early
- Suggest alternative reviewer
- Don't leave PR in limbo
