---
name: pr-description
description: Use when creating PRs, preparing pull request descriptions, documenting changes, or generating release notes. Works with GitHub and Azure DevOps.
---

# PR Description Generator

Generate comprehensive pull request descriptions by analyzing git changes. Works with both **GitHub** and **Azure DevOps**.

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

## Related Work Items
- GitHub: Fixes #123, Relates to #456
- Azure DevOps: AB#12345, AB#67890

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

> **Work Item Linking:**
> - **GitHub**: Use `Fixes #123` or `Closes #123` to auto-close issues
> - **Azure DevOps**: Use `AB#12345` syntax to link work items in the description

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
4. **Link Work Items**:
   - GitHub: `Fixes #123` or `Closes #456`
   - Azure DevOps: `AB#12345` (auto-links to work item)

## Example Output

```markdown
## Summary
Updates authentication system to use JWT tokens instead of session cookies, improving scalability and enabling stateless API design. Also updates related dependencies and adds comprehensive test coverage.

## Related Work Items
AB#4521, AB#4522

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

## Creating the PR

### Step 1: Detect Platform

Determine which platform the repository uses:

```bash
# Check for GitHub remote
git remote -v | grep -i github

# Check for Azure DevOps remote
git remote -v | grep -i "dev.azure.com\|visualstudio.com"
```

### Step 2: Write Description to Temp File

Always write the PR description to a temporary markdown file first:

```bash
# Create temp file for PR description
# Location: .github/.tmp/pr-description.md
```

Write the generated description to `.github/.tmp/pr-description.md` using the Write tool.

### Step 3: Create PR Using the File

#### GitHub

```bash
# Create PR with description from file
gh pr create --title "<type>: <description>" --body-file .github/.tmp/pr-description.md

# Or update existing PR description
gh pr edit <PR_NUMBER> --body-file .github/.tmp/pr-description.md

# Create PR with specific base branch
gh pr create --base main --title "<type>: <description>" --body-file .github/.tmp/pr-description.md
```

#### Azure DevOps

```bash
# Create PR with description from file
az repos pr create \
  --title "<type>: <description>" \
  --description "$(cat .github/.tmp/pr-description.md)" \
  --source-branch "$(git branch --show-current)" \
  --target-branch main

# Or update existing PR description
az repos pr update \
  --id <PR_ID> \
  --description "$(cat .github/.tmp/pr-description.md)"

# Create PR with auto-complete enabled
az repos pr create \
  --title "<type>: <description>" \
  --description "$(cat .github/.tmp/pr-description.md)" \
  --source-branch "$(git branch --show-current)" \
  --target-branch main \
  --auto-complete true
```

### Step 4: Clean Up (Optional)

The temp file can be kept for reference or deleted:

```bash
# Delete temp file after PR creation
rm .github/.tmp/pr-description.md
```

> **Note**: The `.github/.tmp/` directory should be in `.gitignore` to prevent committing temp files.

## Platform-Specific Notes

### GitHub

- Uses `gh` CLI (GitHub CLI)
- Supports `--body-file` for reading description from file
- Work items: Reference with `Fixes #123` or `Closes #123`
- Install: `winget install GitHub.cli` or `brew install gh`

### Azure DevOps

- Uses `az repos` CLI (Azure CLI with DevOps extension)
- Requires reading file content with `$(cat file)` for `--description`
- Work items: Link with `--work-items <ID>` flag
- Install: `az extension add --name azure-devops`
- Auth: `az login` then `az devops configure --defaults organization=<ORG_URL> project=<PROJECT>`

```bash
# ADO: Create PR with linked work items
az repos pr create \
  --title "<type>: <description>" \
  --description "$(cat .github/.tmp/pr-description.md)" \
  --source-branch "$(git branch --show-current)" \
  --target-branch main \
  --work-items 12345 67890

# ADO: Set required reviewers
az repos pr create \
  --title "<type>: <description>" \
  --description "$(cat .github/.tmp/pr-description.md)" \
  --source-branch "$(git branch --show-current)" \
  --target-branch main \
  --reviewers "user@example.com"
```

## Quick Reference Commands

```bash
# View current branch changes vs main
git diff main...HEAD

# List files changed
git diff main...HEAD --name-only

# Show commit messages for PR
git log main..HEAD --format="- %s"

# View diff stats
git diff main...HEAD --stat

# Get current branch name
git branch --show-current
```
