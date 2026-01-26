---
name: code-review
description: Comprehensive code review checklist for PRs. Use this when reviewing pull requests, performing self-review before submitting PRs, training new reviewers, or establishing team review standards.
---

# Code Review Checklist

## When to Use
- Reviewing pull requests
- Self-review before submitting PR
- Training new reviewers
- Establishing review standards

## Quick Checklist

### Correctness
- [ ] Code does what it's supposed to do
- [ ] Edge cases are handled
- [ ] Error handling is appropriate
- [ ] No obvious bugs

### Security
- [ ] Input validation present
- [ ] No SQL injection vulnerabilities
- [ ] No XSS vulnerabilities
- [ ] Authorization checks in place
- [ ] No hardcoded secrets

### Performance
- [ ] No N+1 query problems
- [ ] No unnecessary loops or computations
- [ ] Appropriate caching considered
- [ ] Large data sets handled properly

### Maintainability
- [ ] Code is readable and understandable
- [ ] Functions are focused (single responsibility)
- [ ] No excessive complexity
- [ ] Consistent with codebase style

### Testing
- [ ] Unit tests for new functionality
- [ ] Edge cases tested
- [ ] Tests are meaningful (not just for coverage)

---

## Detailed Review Guide

### 1. Functionality

**Questions to Ask:**
- Does this solve the stated problem?
- Are all requirements addressed?
- Do the changes work as expected?

**Red Flags:**
```typescript
// Incomplete implementation
function processOrder(order: Order) {
  // TODO: implement validation
  saveOrder(order);
}

// Missing error handling
async function fetchUser(id: string) {
  const response = await fetch(`/api/users/${id}`);
  return response.json(); // What if it fails?
}
```

### 2. Logic & Correctness

**Questions to Ask:**
- Are there off-by-one errors?
- Are boundary conditions handled?
- Is null/undefined handled correctly?

**Common Issues:**
```typescript
// Off-by-one error
for (let i = 0; i <= items.length; i++) { // Should be <
  process(items[i]); // Accesses undefined!
}

// Missing null check
function getDisplayName(user: User | null) {
  return user.name; // Crashes if null!
}

// Correct: Should be
function getDisplayName(user: User | null) {
  return user?.name ?? 'Unknown';
}
```

### 3. Security

**Always Check For:**

| Vulnerability | What to Look For |
|---------------|------------------|
| SQL Injection | String concatenation in queries |
| XSS | User input rendered as HTML |
| CSRF | Missing anti-forgery tokens |
| Auth Bypass | Missing authentication checks |
| IDOR | Missing authorization checks |

**Example Issues:**
```csharp
// SQL Injection
var sql = $"SELECT * FROM Users WHERE Name = '{name}'"; // Bad!

// Correct
var sql = "SELECT * FROM Users WHERE Name = @Name";
connection.Query(sql, new { Name = name });
```

```typescript
// XSS
<div [innerHTML]="userInput"></div> // Bad if not sanitized!

// Correct
<div>{{ userInput }}</div>
```

### 4. Performance

**Questions to Ask:**
- Are there unnecessary database calls?
- Is data fetched efficiently?
- Are large lists paginated?

**Common Issues:**
```typescript
// N+1 query problem
const orders = await getOrders();
for (const order of orders) {
  order.items = await getOrderItems(order.id); // Query per order!
}

// Correct: Use join or batch query
const orders = await getOrdersWithItems();
```

```typescript
// Inefficient: Maps entire array twice
const filtered = items.map(x => transform(x)).filter(x => x.valid);

// Better: Single pass
const filtered = items.reduce((acc, x) => {
  const transformed = transform(x);
  if (transformed.valid) acc.push(transformed);
  return acc;
}, []);
```

### 5. Readability

**Good Code Is:**
- Easy to understand without comments
- Uses meaningful names
- Has consistent formatting
- Isn't overly clever

**Naming Examples:**
```typescript
// Bad names
const d = new Date();
const u = getUser();
function proc(x: any) { }

// Good names
const orderDate = new Date();
const currentUser = getUser();
function processPayment(payment: Payment) { }
```

### 6. Maintainability

**Questions to Ask:**
- Would a new team member understand this?
- Is this easy to modify?
- Is it DRY without being over-abstracted?

**Signs of Trouble:**
- Functions over 50 lines
- Deep nesting (> 3 levels)
- Copy-pasted code blocks
- Magic numbers without explanation

### 7. Testing

**Good Tests:**
- Test behavior, not implementation
- Cover happy path and edge cases
- Are independent and deterministic
- Have descriptive names

**Test Name Convention:**
```typescript
// Method_Scenario_ExpectedResult
describe('calculateTotal', () => {
  it('should return zero for empty cart', () => { });
  it('should sum all item prices', () => { });
  it('should apply discount when valid code', () => { });
});
```

---

## Review Feedback Guidelines

### Severity Levels

| Level | When to Use | Example |
|-------|-------------|---------|
| **Blocker** | Must fix, can't merge | Security vulnerability |
| **Major** | Should fix | Missing error handling |
| **Minor** | Consider fixing | Naming improvement |
| **Nitpick** | Optional | Style preference |

### Giving Good Feedback

**Do:**
- Be specific (file, line, code)
- Explain why it's an issue
- Suggest a fix
- Acknowledge good work

**Don't:**
- Be vague ("this is bad")
- Be harsh or personal
- Nitpick excessively
- Only point out negatives

### Examples

**Bad Feedback:**
> "This is wrong."

**Good Feedback:**
> "This could throw if `user` is null (line 42). Consider adding:
> ```typescript
> if (!user) return NotFound();
> ```"

**Bad Feedback:**
> "I would never write it this way."

**Good Feedback:**
> "This nested ternary is hard to follow. An if/else block or early return might be clearer."

---

## Review Workflow

### Before Review
1. Read the PR description
2. Understand the context/requirements
3. Check CI status

### During Review
1. First pass: Overall approach
2. Second pass: Details
3. Run locally if complex

### After Review
1. Summarize findings
2. Mark severity clearly
3. Approve or request changes
