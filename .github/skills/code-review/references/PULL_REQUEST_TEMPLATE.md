# Pull Request Template

Use this template for all PRs. Fill in all sections.

---

## PR Title Format

```
<type>(<scope>): <short description>
```

**Types:** `feat`, `fix`, `refactor`, `test`, `docs`, `chore`, `perf`

**Examples:**
- `feat(auth): add password reset functionality`
- `fix(orders): prevent duplicate submissions`
- `refactor(api): extract validation service`

---

## Description Template

```markdown
## Summary

[Brief description of what this PR does - 1-3 sentences]

## Related Items

- Ticket: [JIRA-123](link)
- Design: [Figma/Confluence link]
- Related PR: #456

## Changes

### Added
- [New feature or capability]

### Changed
- [What was modified and why]

### Fixed
- [Bug that was fixed]

### Removed
- [What was deleted and why]

## Testing

### Automated Tests
- [ ] Unit tests added/updated
- [ ] Integration tests added/updated
- [ ] E2E tests added/updated

### Manual Testing
1. [Step to reproduce/verify]
2. [Expected result]

## Screenshots/Videos

[If UI changes, include before/after screenshots]

## Checklist

- [ ] Self-reviewed my changes
- [ ] Code follows project conventions
- [ ] Tests pass locally
- [ ] Documentation updated (if needed)
- [ ] No secrets or sensitive data committed

## Deployment Notes

[Any special deployment considerations, feature flags, migrations, etc.]

## Reviewer Notes

[Anything specific you want reviewers to focus on or context they need]
```

---

## Minimum Requirements

Every PR MUST have:

1. **Clear summary** - What does this do?
2. **Ticket link** - Reference to requirements
3. **Change type** - feat/fix/refactor/etc.
4. **Testing evidence** - How was this verified?
5. **Self-review completed** - Author reviewed their own diff

---

## PR Size Guidelines

### Keep PRs Small

| Size | Lines | Review Quality |
|------|-------|----------------|
| Ideal | <200 | High |
| Acceptable | 200-400 | Medium |
| Too Large | >400 | Low |

### How to Split Large PRs

1. **By Layer:**
   - Database changes first
   - Backend API second
   - Frontend third

2. **By Feature Slice:**
   - Core functionality first
   - Edge cases second
   - Polish third

3. **By Refactor + Feature:**
   - Refactoring PR
   - Feature PR (builds on refactor)

---

## Good vs Bad PR Descriptions

### ❌ Bad

```
## Summary
Fixed the bug

## Changes
- Updated code
```

### ✅ Good

```
## Summary

Fixes race condition in order submission that caused duplicate orders
when users double-clicked the submit button.

## Related Items

- Ticket: [ORD-456](link)
- Bug report: Customer complaint #789

## Changes

### Fixed
- Added debounce (300ms) to submit button click handler
- Added server-side idempotency check using order reference ID
- Added loading state to prevent visual confusion

## Testing

### Automated Tests
- [x] Unit tests for debounce utility
- [x] Integration test for idempotency check

### Manual Testing
1. Click submit rapidly 5 times
2. Expected: Only one order created
3. Verified in staging environment

## Screenshots

[Before: Multiple orders | After: Single order with loading state]
```

---

## When to Request Review

### Ready for Review

- [ ] All work complete (no TODOs)
- [ ] CI passing
- [ ] Self-reviewed changes
- [ ] Description complete
- [ ] PR size is reasonable

### NOT Ready (Draft Instead)

- Work in progress
- Needs discussion on approach
- Waiting for dependencies
- Just want feedback on direction

---

## Responding to Review Comments

### For Each Comment:

1. **Acknowledge** - "Good catch" / "Thanks for the suggestion"
2. **Respond** - Fix it, explain why not, or ask for clarification
3. **Update** - Push the fix if making changes
4. **Resolve** - Only resolve threads you've addressed

### If You Disagree:

```
I see your point about X. However, I chose this approach because:
1. [Technical reason]
2. [Trade-off consideration]

Would you be okay with keeping it as-is, or do you feel strongly this should change?
```

---

## Merging

### Before Merging:

- [ ] All conversations resolved
- [ ] Required approvals obtained
- [ ] CI still passing
- [ ] Branch up to date with target

### Merge Strategy

| Situation | Strategy |
|-----------|----------|
| Single logical commit | Squash and merge |
| Multiple logical commits | Rebase and merge |
| Never | Create merge commit |

### After Merging:

- [ ] Delete source branch
- [ ] Verify deployment (if applicable)
- [ ] Update ticket status
- [ ] Notify relevant stakeholders
