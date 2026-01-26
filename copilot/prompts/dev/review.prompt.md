---
name: review
description: Thorough code review for correctness, security, performance, and best practices
agent: agent
---

Please review this code.

**Context:**
${input:context:What does this code do and why?}

**Code:**
```
${selection}
```

Review for:
1. **Correctness** - Does it do what it should?
2. **Security** - Any vulnerabilities? (injection, XSS, auth issues)
3. **Performance** - Any inefficiencies? (N+1 queries, unnecessary work)
4. **Maintainability** - Is it easy to understand and modify?
5. **Testing** - Is it adequately tested?
6. **Best practices** - Does it follow conventions?

Format feedback as:
- **Critical**: Must fix before merge
- **Major**: Should fix
- **Minor**: Consider fixing
- **Positive**: What's done well
