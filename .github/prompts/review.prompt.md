---
name: review
description: Run the code-review agent and return the structured report
argument-hint: "<feature name>"
agent: Code Review
---

Use the **code-review** agent to produce the structured report.

**Feature (optional):**
${input:feature:Short feature or ticket name}

**Context:**
${input:context:What does this code do, and why is it changing?}

**Code:**
```
${selection}
```
