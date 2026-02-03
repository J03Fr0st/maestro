---
name: sonarqube-review
description: Review code like SonarQube with comprehensive rules for bugs, vulnerabilities, code smells, and security hotspots. Use when reviewing code quality, performing static analysis, or ensuring code meets quality gates.
---

# SonarQube-Style Code Review

Perform comprehensive code analysis following SonarQube's rule categories.

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

## Review Output Format

```markdown
## Code Review Summary

**Quality Gate**: PASSED / FAILED

| Type | Blocker | Critical | Major | Minor | Info |
|------|---------|----------|-------|-------|------|
| Bug | 0 | 0 | 0 | 0 | 0 |
| Vulnerability | 0 | 0 | 0 | 0 | 0 |
| Code Smell | 0 | 0 | 0 | 0 | 0 |
| Security Hotspot | 0 | 0 | 0 | 0 | 0 |

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

## Quality Gate Criteria

A quality gate **FAILS** if any of these conditions are true:
- Any Blocker issues exist
- More than 0 Critical bugs
- More than 0 Critical vulnerabilities
- More than 3 Major issues
- Code coverage < 80% (if measurable)
- Duplicated lines > 3%
