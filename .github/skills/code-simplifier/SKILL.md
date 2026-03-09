---
name: code-simplifier
description: >
  Refine code for clarity, consistency, and maintainability without changing behavior. Use this
  skill whenever the user says "simplify", "clean up this code", "reduce complexity", "code smell",
  "make this more readable", "refactor for clarity", "tidy up", or "this code is messy". Also
  activate after completing a coding task, fixing a bug, or finishing an implementation when the
  resulting code could be clearer. Make sure to use this skill whenever the user mentions
  simplifying, cleaning up, or improving code readability, even if they don't explicitly ask for it.
---

# Code Simplifier

Refine recently modified code for clarity, consistency, and maintainability. Preserve exact functionality while improving how code is written.

## Simplification Process

1. **Identify** recently modified code sections (git diff, implementation report, or session context)
2. **Analyze** for clarity, consistency, and standards compliance opportunities
3. **Apply** refinements preserving all observable behavior
4. **Verify** functionality is unchanged and code is genuinely simpler

## Rules

### Preserve Functionality

Do not change what the code does. All original features, outputs, and behaviors must remain intact. Only change how the code expresses its logic.

### Enhance Clarity

- **Reduce nesting** -- deeply nested code forces readers to track multiple conditions mentally; flatten with early returns or guard clauses.
- **Eliminate redundant code** -- dead code and unnecessary abstractions add cognitive load for future readers.
- **Improve names** -- good variable and function names eliminate the need for comments explaining what things are.
- **Consolidate related logic** -- scattered related code forces readers to jump around the file to understand a single concept.
- **Remove obvious comments** -- comments like `// increment counter` on `count++` add noise without value.
- **Avoid nested ternaries** -- prefer `if/else` or `switch` because nested ternaries are notoriously hard to read and debug; even experienced developers have to slow down to parse them.
- **Choose clarity over brevity** -- a 3-line `if/else` is easier to understand than a compact one-liner with multiple operators.

### Apply Project Standards

Follow established coding conventions found in project config and instructions:

- Import ordering and module style
- Function declaration style (e.g., `function` keyword over arrow functions)
- Explicit return type annotations for top-level functions
- Consistent naming conventions
- Error handling patterns
- Component patterns (e.g., explicit Props types for React)

### Maintain Balance

Avoid over-simplifying:

- Do not create overly clever solutions that trade readability for conciseness.
- Do not combine too many concerns into single functions -- separation of concerns aids testing and debugging.
- Do not remove helpful abstractions that improve organization.
- Do not prioritize "fewer lines" over readability -- sometimes more lines are clearer.

### Scope

Only refine recently modified code unless explicitly asked to review broader scope.

## Examples

### Example 1: Flatten nested conditionals

Before:
```typescript
function getDiscount(user: User): number {
  if (user.isActive) {
    if (user.tier === 'premium') {
      if (user.yearsActive > 2) {
        return 0.20;
      } else {
        return 0.10;
      }
    } else {
      return 0.05;
    }
  } else {
    return 0;
  }
}
```

After:
```typescript
function getDiscount(user: User): number {
  if (!user.isActive) return 0;
  if (user.tier !== 'premium') return 0.05;
  return user.yearsActive > 2 ? 0.20 : 0.10;
}
```

### Example 2: Replace nested ternary with explicit logic

Before:
```typescript
const label = status === 'active' ? 'Active' : status === 'pending' ? 'Pending Review' : status === 'archived' ? 'Archived' : 'Unknown';
```

After:
```typescript
function getStatusLabel(status: string): string {
  switch (status) {
    case 'active': return 'Active';
    case 'pending': return 'Pending Review';
    case 'archived': return 'Archived';
    default: return 'Unknown';
  }
}

const label = getStatusLabel(status);
```

## Output

After simplification, report:

```markdown
## Simplification Report

### Changes Applied
- **[file:line]**: [What changed] - [Why it improves the code]

### Standards Compliance
- [x] Naming conventions followed
- [x] Import ordering correct
- [x] No nested ternaries
- [x] Error handling patterns applied

### Verification
- [x] All original behavior preserved
- [x] No logic changes introduced
```
