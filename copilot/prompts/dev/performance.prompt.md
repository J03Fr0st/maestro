---
name: performance
description: Identify and fix performance bottlenecks with optimization recommendations
agent: agent
---

I need help optimizing this code for performance.

**Code:**
```
${selection}
```

**Context:**
- Purpose: ${input:purpose:What does this code do?}
- Data volume: ${input:volume:Typical data sizes}
- Current performance: ${input:current:How long does it take now?}
- Target performance: ${input:target:Desired performance}

Please:
1. Identify performance bottlenecks
2. Explain why each is a problem
3. Suggest optimizations with trade-offs
4. Provide optimized code
5. Estimate improvement impact

Look for common issues:
- N+1 queries
- Unnecessary loops or allocations
- Missing caching
- Synchronous blocking
- Over-fetching data
