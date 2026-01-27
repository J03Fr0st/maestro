---
name: pr-description
description: Generate comprehensive pull request descriptions from git changes. Use this when creating PRs, preparing PR descriptions, or documenting changes before submission.
---

# PR Description Generator

Generate comprehensive pull request descriptions by analyzing git changes.

## When to Use

- Creating a new pull request
- Preparing PR descriptions before submission
- Documenting changes for team review
- Generating release notes from commits

## Workflow

### 1. Analyze Changes

```bash
# View all changes (staged and unstaged)
git diff

# View staged changes only
git diff --cached

# View changed files summary
git diff --stat

# View recent commits on current branch
git log --oneline -10

# Compare with base branch
git log main..HEAD --oneline
git diff main...HEAD --stat
```

### 2. Categorize Changes

Group changes into logical categories:

| Category | Examples |
|----------|----------|
| Dependencies | package.json, requirements.txt, *.csproj |
| Build Config | webpack.config.js, tsconfig.json, Dockerfile |
| Pipeline | .github/workflows/*, azure-pipelines.yml |
| Code | src/*, lib/*, app/* |
| Tests | *.spec.ts, *.test.js, tests/* |
| Documentation | README.md, docs/*, CHANGELOG.md |

### 3. Generate Description

Use this format:

```markdown
## Summary
2-3 sentences describing the overall purpose and impact of the changes.

## Changes

### [Category Name]
- Specific change with details (file paths, version numbers)
- Another change

### [Another Category]
- Change details

## Change Type
- [ ] New Feature
- [ ] Bug Fix
- [ ] Dependency Updates
- [ ] Build Configuration
- [ ] Pipeline Configuration
- [ ] Code Refactoring
- [ ] Test Addition
- [ ] Documentation
- [ ] Breaking Change

## Risks & Considerations
- Any potential risks or breaking changes
- Areas requiring extra review attention
- Migration steps if applicable
```

## Best Practices

### Title Format

Use conventional commit format: `<type>: <brief description>`

| Type | Use For |
|------|---------|
| `feat` | New features |
| `fix` | Bug fixes |
| `refactor` | Code restructuring |
| `chore` | Maintenance tasks |
| `docs` | Documentation only |
| `test` | Test additions/changes |
| `build` | Build system changes |
| `ci` | CI/CD changes |

### Description Guidelines

1. **Be Specific**: Include version numbers, package names, file paths
2. **Explain Why**: Focus on the purpose, not just what changed
3. **Highlight Risks**: Call out breaking changes or areas needing attention
4. **Link Issues**: Reference related issues with `Fixes #123` or `Relates to #456`

## Example Output

```markdown
## Summary
Updates authentication system to use JWT tokens instead of session cookies, improving scalability and enabling stateless API design. Also updates related dependencies and adds comprehensive test coverage.

## Changes

### Dependencies
- Updated `jsonwebtoken` from 8.5.1 to 9.0.0
- Added `@types/jsonwebtoken` 9.0.0
- Removed `express-session` (no longer needed)

### Code
- Replaced session-based auth in `src/auth/middleware.ts`
- Added JWT token generation in `src/auth/tokens.ts`
- Updated all protected routes to use new middleware

### Tests
- Added unit tests for token generation (`src/auth/tokens.spec.ts`)
- Added integration tests for auth flow (`tests/auth.integration.ts`)

## Change Type
- [x] New Feature
- [ ] Bug Fix
- [x] Dependency Updates
- [ ] Build Configuration
- [ ] Pipeline Configuration
- [x] Code Refactoring
- [x] Test Addition
- [ ] Documentation
- [x] Breaking Change

## Risks & Considerations
- **Breaking Change**: Existing sessions will be invalidated on deploy
- **Migration**: Users will need to re-authenticate after deployment
- **Security**: JWT secret must be configured in environment variables
```

## Quick Commands

```bash
# Create PR with generated description
gh pr create --title "feat: add JWT authentication" --body-file pr-description.md

# View current branch changes vs main
git diff main...HEAD

# List files changed
git diff main...HEAD --name-only

# Show commit messages for PR
git log main..HEAD --format="- %s"
```
