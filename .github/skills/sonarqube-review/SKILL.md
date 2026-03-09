---
name: sonarqube-review
description: >
  Use when reviewing code quality, performing static analysis, or ensuring code meets quality gates.
  Make sure to use this skill whenever the user mentions "code review", "quality check", "static analysis",
  "SonarQube", "code smells", "security review", "vulnerability scan", or "quality gate",
  even if they don't explicitly ask for it.
---

# SonarQube-Style Code Review

Perform comprehensive code analysis following SonarQube's rule categories.

## Quick Workflow

1. **Scan** -- Read the code and identify issues using the rule references below, categorized by type (Bug, Vulnerability, Code Smell, Security Hotspot) and severity.
2. **Judge** -- Apply the quality gate criteria to decide PASSED or FAILED. In an LLM review context, focus on the criteria you can evaluate by reading code (bugs, vulnerabilities, code smells, security hotspots). Coverage and duplication percentages require tooling and should be noted as "not measured" unless the user provides metrics.
3. **Report** -- Output findings in the standard format shown below.

## Issue Severity Levels

| Severity | Description | Action Required |
|----------|-------------|-----------------|
| **Blocker** | Bug with high probability to impact production | Must fix immediately |
| **Critical** | Bug or security flaw with low probability to impact production | Must fix before release |
| **Major** | Quality flaw that can highly impact developer productivity | Should fix |
| **Minor** | Quality flaw that can slightly impact developer productivity | Consider fixing |
| **Info** | Neither a bug nor quality flaw, just a finding | Optional |

## Issue Types

| Type | Description |
|------|-------------|
| **Bug** | Something demonstrably wrong or likely to cause unexpected behavior |
| **Vulnerability** | Security issue that could be exploited by attackers |
| **Code Smell** | Maintainability issue making code harder to understand or modify |
| **Security Hotspot** | Security-sensitive code requiring manual review |

---

## Rule References

Select rules based on issue category:
- **Bugs**: See [references/bugs.md](references/bugs.md) for reliability rules
- **Vulnerabilities**: See [references/vulnerabilities.md](references/vulnerabilities.md) for security rules
- **Code Smells**: See [references/code-smells.md](references/code-smells.md) for maintainability rules
- **Security Hotspots**: See [references/security-hotspots.md](references/security-hotspots.md) for review-required rules

Select rules based on language:
- **TypeScript/JavaScript**: See [references/typescript-rules.md](references/typescript-rules.md)
- **Python**: See [references/python-rules.md](references/python-rules.md)
- **C#/.NET**: See [references/csharp-rules.md](references/csharp-rules.md)

---

## Quality Gate Criteria

A quality gate **FAILS** if any of these conditions are true:
- Any Blocker issues exist
- More than 0 Critical bugs
- More than 0 Critical vulnerabilities
- More than 3 Major issues
- Code coverage < 80% (requires tooling -- mark "not measured" in LLM-only review)
- Duplicated lines > 3% (requires tooling -- mark "not measured" in LLM-only review)

## Review Output Format

Use this format when reporting findings:

```markdown
## Code Review Summary

**Quality Gate**: PASSED / FAILED

| Type | Blocker | Critical | Major | Minor | Info |
|------|---------|----------|-------|-------|------|
| Bug | 0 | 0 | 0 | 0 | 0 |
| Vulnerability | 0 | 0 | 0 | 0 | 0 |
| Code Smell | 0 | 0 | 0 | 0 | 0 |
| Security Hotspot | 0 | 0 | 0 | 0 | 0 |

**Coverage**: [measured value or "not measured"]
**Duplication**: [measured value or "not measured"]

### Issues Found

#### [SEVERITY] [TYPE]: [Rule ID] - [Rule Name]
**File:** `path/to/file.ts:42`
**Description:** [What's wrong]
**Code:**
\`\`\`typescript
// Current code
\`\`\`
**Recommendation:**
\`\`\`typescript
// Fixed code
\`\`\`
```

## Example: Completed Review

```markdown
## Code Review Summary

**Quality Gate**: FAILED

| Type | Blocker | Critical | Major | Minor | Info |
|------|---------|----------|-------|-------|------|
| Bug | 0 | 1 | 0 | 0 | 0 |
| Vulnerability | 0 | 0 | 1 | 0 | 0 |
| Code Smell | 0 | 0 | 2 | 1 | 0 |
| Security Hotspot | 0 | 0 | 0 | 1 | 0 |

**Coverage**: not measured
**Duplication**: not measured

### Issues Found

#### Critical Bug: S1764 - Identical expressions on both sides of operator
**File:** `src/utils/compare.ts:18`
**Description:** Both sides of `===` are the same variable, so the condition is always true.
**Code:**
\`\`\`typescript
if (user.id === user.id) { ... }
\`\`\`
**Recommendation:**
\`\`\`typescript
if (user.id === otherUser.id) { ... }
\`\`\`

#### Major Vulnerability: S5131 - User input in SQL query
**File:** `src/api/users.ts:55`
**Description:** Query string parameter inserted directly into SQL without parameterization.
**Recommendation:** Use parameterized queries to prevent SQL injection.
```
