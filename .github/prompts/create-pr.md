# Create Pull Request Prompt

Use this prompt to create a pull request with a comprehensive description.

## Prompt

```
Create a pull request for my current changes:

1. Analyze all changes (staged and unstaged)
2. If there are uncommitted changes, create conventional commits first
3. Generate a comprehensive PR description with:
   - Summary of changes
   - Categorized changes (dependencies, code, tests, docs, etc.)
   - Change type checklist
   - Risks and considerations
4. Create the PR using GitHub CLI (gh) or Azure DevOps CLI (az repos)
5. Use conventional commit format for the PR title: `<type>: <description>`

Target branch: main
```

## Variations

### Quick PR (auto-detect everything)

```
/commit and create a PR
```

### PR with specific title

```
Create a PR titled "feat: add user authentication" for my current changes
```

### PR to specific branch

```
Create a PR to the develop branch with a comprehensive description
```

### Draft PR

```
Create a draft PR for my current work-in-progress changes
```

### PR with linked work items

```
Create a PR that links to issue #123 (GitHub) or work item AB#12345 (Azure DevOps)
```

## What the Agent Will Do

1. **Check for uncommitted changes**
   - If found, analyze diff and create conventional commits
   - Auto-detect commit type and scope from changes

2. **Generate PR description**
   - Analyze all commits on current branch vs base branch
   - Categorize changes (dependencies, code, tests, docs)
   - Include change type checklist
   - Highlight risks and breaking changes
   - Link related issues/work items

3. **Create the PR**
   - Detect platform (GitHub or Azure DevOps)
   - Use appropriate CLI (`gh` or `az repos`)
   - Apply conventional commit format to PR title
   - Set PR description from generated markdown

4. **Verify**
   - Provide PR URL
   - Confirm PR was created successfully

## Example Output

After running the prompt, you'll get:

```bash
✓ Committed 2 files with message: "feat(auth): add JWT authentication"
✓ PR description generated and saved to .github/.tmp/pr-description.md
✓ PR created: https://github.com/owner/repo/pull/123

Pull Request: feat(auth): add JWT authentication
Status: Open
URL: https://github.com/owner/repo/pull/123
```

## Prerequisites

- Git repository with remote configured
- **GitHub**: `gh` CLI installed and authenticated (`gh auth login`)
- **Azure DevOps**: `az` CLI with DevOps extension (`az extension add --name azure-devops`)
- Changes pushed to remote branch

## Tips

- The agent will handle both GitHub and Azure DevOps automatically
- Work items are auto-linked using `Fixes #123` (GitHub) or `AB#12345` (Azure DevOps)
- Breaking changes are highlighted in the description
- PR description is saved to `.github/.tmp/pr-description.md` for reference
