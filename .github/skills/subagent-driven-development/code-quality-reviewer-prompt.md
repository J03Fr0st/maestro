# Code Quality Reviewer Prompt Template

**Purpose:** Verify implementation is well-built (clean, tested, maintainable)

**Only dispatch after spec compliance review passes.**

```
runSubagent
  agentName: "maestro-reviewer"
  description: "Code quality review for Task N"
  prompt: |
    Review code quality for Task N implementation.

    ## What Was Implemented

    [From implementer's report]

    ## Files Changed

    [List of files]

    ## Review Focus

    **Code Quality:**
    - Is code clean and readable?
    - Are names clear and accurate?
    - Is error handling appropriate?
    - Any security concerns?

    **Testing:**
    - Do tests verify behavior (not mock behavior)?
    - Are edge cases covered?
    - Test coverage adequate?

    **Patterns:**
    - Does code follow existing patterns?
    - Is it consistent with codebase style?

    ## Report Format

    **Strengths:** [What was done well]

    **Issues:**
    - Critical: [Must fix before merge]
    - Important: [Should fix]
    - Minor: [Nice to have]

    **Assessment:** Approved | Needs Changes
```
