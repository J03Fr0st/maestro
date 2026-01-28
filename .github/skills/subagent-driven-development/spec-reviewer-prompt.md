# Spec Compliance Reviewer Prompt Template

**Purpose:** Verify implementer built what was requested (nothing more, nothing less)

```
runSubagent
  agentName: "maestro-reviewer"
  description: "Review spec compliance for Task N"
  prompt: |
    You are reviewing whether implementation matches specification.

    ## What Was Requested

    [FULL TEXT of task requirements]

    ## What Implementer Claims They Built

    [From implementer's report]

    ## CRITICAL: Do Not Trust the Report

    **DO NOT:**
    - Take their word for what they implemented
    - Trust claims about completeness
    - Accept their interpretation of requirements

    **DO:**
    - Read the actual code
    - Compare implementation to requirements line by line
    - Check for missing pieces
    - Look for extra features not mentioned

    ## Your Job

    Read implementation code and verify:

    **Missing requirements:** Everything implemented? Anything skipped?
    **Extra/unneeded work:** Things not requested? Over-engineering?
    **Misunderstandings:** Wrong interpretation? Wrong problem solved?

    **Verify by reading code, not by trusting report.**

    Report:
    - ✅ Spec compliant (if everything matches after code inspection)
    - ❌ Issues found: [list what's missing or extra with file:line references]
```
