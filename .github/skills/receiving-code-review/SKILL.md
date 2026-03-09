---
name: receiving-code-review
description: >
  Use when handling code review feedback — PR comments, GitHub review suggestions,
  reviewer requests, inline comments, or any feedback on submitted code.
  Trigger phrases: "PR comments", "GitHub review", "reviewer suggested",
  "code review feedback", "inline comments", "address review", "review
  changes requested", "fix review comments".
---

# Code Review Reception

## Overview

Code review requires technical evaluation, not emotional performance. Verify before implementing. Ask before assuming. Technical correctness over social comfort.

## The Response Pattern

1. **Read** — Complete feedback without reacting
2. **Understand** — Restate the requirement in your own words (or ask if unclear)
3. **Verify** — Check against codebase reality
4. **Evaluate** — Is this technically sound for this codebase?
5. **Respond** — Technical acknowledgment or reasoned pushback
6. **Implement** — One item at a time, test each

## Handling Unclear Feedback

If any item is unclear, stop and ask before implementing anything. Items may be related, and partial understanding leads to wrong implementations.

**Example:**
```
User: "Fix items 1-6"
You understand 1,2,3,6. Unclear on 4,5.

Wrong: Implement 1,2,3,6 now, ask about 4,5 later
Right: "I understand items 1,2,3,6. Need clarification on 4 and 5 before proceeding."
```

## Source-Specific Handling

### From the Code Owner / User

- Trusted — implement after understanding
- Still ask if scope is unclear
- Skip to action or technical acknowledgment

### From External Reviewers

Before implementing, check:
1. Is this technically correct for this codebase?
2. Does it break existing functionality?
3. Is there a reason for the current implementation?
4. Does it work on all platforms/versions?
5. Does the reviewer have full context?

If a suggestion seems wrong, push back with technical reasoning.

If you can't easily verify, say so: "I can't verify this without [X]. Should I investigate, ask, or proceed?"

If a suggestion conflicts with the code owner's prior decisions, stop and discuss with the code owner first.

The code owner's standing guidance: external feedback should be taken seriously but evaluated skeptically.

## No Performative Agreement

Responding with "You're absolutely right!" or "Great point!" is noise. It doesn't advance the work and can mask a lack of understanding.

Instead, demonstrate understanding through action — restate the technical requirement, fix the issue, or push back with reasoning. The code itself shows you heard the feedback, which is more meaningful than words of agreement.

**When feedback is correct:**
```
"Fixed. [Brief description of what changed]"
"Good catch — [specific issue]. Fixed in [location]."
[Just fix it and show in the code]
```

**Avoid:**
- "You're absolutely right!"
- "Great point!" / "Excellent feedback!"
- "Thanks for catching that!"
- Any gratitude expression — just fix it

## YAGNI Check for "Professional" Features

When a reviewer suggests "implementing properly," grep the codebase for actual usage:
- If unused: "This endpoint isn't called. Remove it (YAGNI)?"
- If used: Then implement properly

The code owner's guidance: if a feature isn't needed, don't add it just because a reviewer suggests it.

## Implementation Order

For multi-item feedback:
1. Clarify anything unclear first
2. Then implement in this order:
   - Blocking issues (breaks, security)
   - Simple fixes (typos, imports)
   - Complex fixes (refactoring, logic)
3. Test each fix individually
4. Verify no regressions

## When to Push Back

Push back when:
- Suggestion breaks existing functionality
- Reviewer lacks full context
- Violates YAGNI (unused feature)
- Technically incorrect for this stack
- Legacy/compatibility reasons exist
- Conflicts with the code owner's architectural decisions

**How to push back:**
- Use technical reasoning, not defensiveness
- Ask specific questions
- Reference working tests/code
- Involve the code owner if it's an architectural question

## Gracefully Correcting Your Pushback

If you pushed back and were wrong:
```
"You were right — I checked [X] and it does [Y]. Implementing now."
"Verified this and you're correct. My initial understanding was wrong because [reason]. Fixing."
```

State the correction factually and move on. No long apologies or over-explaining.

## Common Mistakes

| Mistake | Fix |
|---------|-----|
| Performative agreement | State requirement or just act |
| Blind implementation | Verify against codebase first |
| Batch without testing | One at a time, test each |
| Assuming reviewer is right | Check if it breaks things |
| Avoiding pushback | Technical correctness matters more than comfort |
| Partial implementation | Clarify all items first |
| Can't verify, proceed anyway | State limitation, ask for direction |

## Real Examples

**Performative Agreement (avoid):**
```
Reviewer: "Remove legacy code"
"You're absolutely right! Let me remove that..."
```

**Technical Verification (better):**
```
Reviewer: "Remove legacy code"
"Checking... build target is 10.15+, this API needs 13+.
Need legacy for backward compat. Current impl has wrong
bundle ID — fix it or drop pre-13 support?"
```

**YAGNI:**
```
Reviewer: "Implement proper metrics tracking with database, date filters, CSV export"
"Grepped codebase — nothing calls this endpoint. Remove it (YAGNI)?
Or is there usage I'm missing?"
```

## GitHub Thread Replies

When replying to inline review comments on GitHub, reply in the comment thread (`gh api repos/{owner}/{repo}/pulls/{pr}/comments/{id}/replies`), not as a top-level PR comment.

## The Bottom Line

External feedback = suggestions to evaluate, not orders to follow. Verify. Question. Then implement.
