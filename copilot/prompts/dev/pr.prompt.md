---
name: pr
description: Generate a comprehensive pull request description from git changes
agent: agent
---

Analyze the current git changes and generate a comprehensive pull request description.

## Format

### Title
Use conventional commit format: `<type>: <brief description>`
Types: feat, fix, refactor, chore, docs, test, build, ci

### Sections

**Summary**
2-3 sentences describing the overall purpose and impact of the changes.

**Changes**
Group changes into logical categories based on what was modified:
- Use bullet points for each specific change
- Include version numbers, package names, and file paths where relevant
- Categories might include: Dependencies, Build Configuration, Pipeline, Code, Tests, etc.

**Change Type**
Checkboxes for applicable categories:
- [ ] New Feature
- [ ] Bug Fix
- [ ] Dependency Updates
- [ ] Build Configuration
- [ ] Pipeline Configuration
- [ ] Code Refactoring
- [ ] Test Addition
- [ ] Documentation
- [ ] Breaking Change

**Risks & Considerations**
List any potential risks, breaking changes, or areas requiring extra review attention.

## Instructions
1. Run `git diff` or examine staged/unstaged changes
2. Identify all modified files and categorize them
3. Extract specific details: package versions, config changes, new dependencies
4. Summarize the "why" behind the changes
5. Note any migration steps or breaking changes

## Output
Generate the PR description in a temp file with markdown format, ready to paste into a PR. Then remove the temp file.
