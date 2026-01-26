---
name: changelog
description: Generate a changelog entry following Keep a Changelog format
agent: agent
---

Help me create a changelog entry.

**Version:** ${input:version:Version number (e.g., 2.1.0)}
**Release date:** ${input:date:Release date (YYYY-MM-DD)}

**Changes:**
${input:changes:List of changes, PRs, or commits}

**Breaking changes (if any):**
${input:breaking:List any breaking changes}

**Migration notes (if any):**
${input:migration:Steps users need to take}

Please create a changelog entry following Keep a Changelog format:
- Group by: Added, Changed, Deprecated, Removed, Fixed, Security
- Use past tense
- Include issue/PR references where available
- Highlight breaking changes with migration instructions
