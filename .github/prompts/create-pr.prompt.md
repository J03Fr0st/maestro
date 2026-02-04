---
name: create-pr
description: Create a pull request with comprehensive description, conventional commits, and proper categorization
argument-hint: "[optional: PR title or target branch]"
---

Create a pull request following these steps:

## 1. Handle Uncommitted Changes
- Check for uncommitted changes (staged and unstaged)
- If found, analyze the diff and create conventional commits
- Auto-detect commit type and scope from changes
- Follow conventional commit format: `<type>[scope]: <description>`

## 2. Generate PR Description
Analyze all commits on current branch vs base branch and generate a comprehensive description:

### Summary
- 2-3 sentences describing overall purpose and impact

### Categorized Changes
Group changes into categories:
- **Dependencies**: package.json, requirements.txt, *.csproj
- **Build Config**: webpack, tsconfig, Dockerfile
- **Pipeline**: GitHub Actions, Azure Pipelines
- **Code**: Source files (src/*, lib/*, app/*)
- **Tests**: Test files (*.spec.*, *.test.*, tests/*)
- **Documentation**: README, docs/, CHANGELOG

### Change Type Checklist
- [ ] New Feature
- [ ] Bug Fix
- [ ] Dependency Updates
- [ ] Build Configuration
- [ ] Pipeline Configuration
- [ ] Code Refactoring
- [ ] Test Addition
- [ ] Documentation
- [ ] Breaking Change

### Risks & Considerations
- Highlight any potential risks or breaking changes
- Note areas requiring extra review attention
- Include migration steps if applicable

## 3. Create the PR
- Detect platform (GitHub or Azure DevOps) from git remote
- **GitHub**: Use `gh pr create` with `--body-file .github/.tmp/pr-description.md`
- **Azure DevOps**: Use `az repos pr create` with description from file
- Apply conventional commit format to PR title
- Link work items: `Fixes #123` (GitHub) or `AB#12345` (Azure DevOps)
- Target branch: ${input:branch:main}

## 4. Verify Success
- Output PR URL
- Confirm PR was created successfully
- Show PR status

## Examples

**Quick PR:**
```
/create-pr
```

**PR with specific title:**
```
/create-pr feat: add user authentication
```

**PR to specific branch:**
```
/create-pr develop
```

**Draft PR:**
```
/create-pr --draft
```

**PR linking issue:**
```
/create-pr fixes #123
```

## Output Format

```
✓ Committed 2 files: "feat(auth): add JWT authentication"
✓ PR description saved: .github/.tmp/pr-description.md
✓ PR created: https://github.com/owner/repo/pull/123

Title: feat(auth): add JWT authentication
Status: Open
Branch: feature/auth → main
```

## Prerequisites
- Git repository with remote
- GitHub: `gh` CLI authenticated
- Azure DevOps: `az` CLI with DevOps extension
- Changes pushed to remote branch
