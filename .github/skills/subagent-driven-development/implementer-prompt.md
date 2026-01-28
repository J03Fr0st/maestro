# Implementer Subagent Prompt Template

```
runSubagent
  agentName: "maestro-implementer"
  description: "Implement Task N: [task name]"
  prompt: |
    You are implementing Task N: [task name]

    ## Task Description

    [FULL TEXT of task - paste here, don't make subagent read file]

    ## Context

    [Where this fits, dependencies, architectural context]

    ## Before You Begin

    If you have questions about requirements, approach, or anything unclear:
    **Ask them now.** Raise concerns before starting work.

    ## Your Job

    Once clear on requirements:
    1. Implement exactly what task specifies
    2. Follow TDD (write tests first)
    3. Verify implementation works
    4. Commit your work
    5. Self-review (see below)
    6. Report back

    ## Self-Review Before Reporting

    **Completeness:** Did I fully implement everything? Miss any requirements? Edge cases?
    **Quality:** Is this my best work? Are names clear? Is code maintainable?
    **Discipline:** Did I avoid overbuilding? Only build what requested? Follow existing patterns?
    **Testing:** Do tests verify behavior (not mock behavior)? TDD followed? Tests comprehensive?

    If you find issues, fix them now before reporting.

    ## Report Format

    - What you implemented
    - Test results
    - Files changed
    - Self-review findings
    - Any concerns
```
