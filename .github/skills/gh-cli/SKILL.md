---
name: gh-cli
description: Use when working with GitHub from the command line to create PRs, manage issues or projects, monitor Actions, or automate GitHub workflows.
---

# GitHub CLI (gh)

Work with GitHub from the command line. See [full reference](references/REFERENCE.md) for complete documentation.

## Prerequisites

```bash
# Install
brew install gh              # macOS
winget install GitHub.cli    # Windows

# Authenticate
gh auth login

# Verify
gh auth status
```

## Quick Reference

### Pull Requests

```bash
# Create PR
gh pr create --title "feat: add feature" --body "Description"

# List PRs
gh pr list
gh pr list --author @me

# View/checkout PR
gh pr view 123
gh pr checkout 123

# Merge PR
gh pr merge 123 --squash --delete-branch

# Review PR
gh pr review 123 --approve
gh pr review 123 --request-changes --body "Please fix..."
```

### Issues

```bash
# Create issue
gh issue create --title "Bug: description" --label bug

# List issues
gh issue list
gh issue list --assignee @me

# View/close issue
gh issue view 123
gh issue close 123 --comment "Fixed in PR #456"
```

### Repositories

```bash
# Clone
gh repo clone owner/repo

# Create
gh repo create my-repo --public --description "My project"

# View
gh repo view
gh repo view --web
```

### GitHub Actions

```bash
# List workflow runs
gh run list

# View run
gh run view 123456789
gh run view 123456789 --log

# Watch run
gh run watch 123456789

# Trigger workflow
gh workflow run ci.yml --ref main
```

### Releases

```bash
# Create release
gh release create v1.0.0 --notes "Release notes"

# List releases
gh release list

# Download assets
gh release download v1.0.0
```

## Common Patterns

### Create PR from Current Branch

```bash
gh pr create --fill
gh pr create --title "feat: description" --body "Details"
```

### Check PR Status

```bash
gh pr checks 123 --watch
```

### API Requests

```bash
gh api /user
gh api /repos/owner/repo/issues --method POST --field title="Issue"
```

### JSON Output

```bash
gh pr list --json number,title,author
gh pr view 123 --json title,body,state --jq '.title'
```

## Global Flags

| Flag | Description |
|------|-------------|
| `--repo owner/repo` | Target repository |
| `--json FIELDS` | Output JSON |
| `--jq EXPRESSION` | Filter JSON |
| `--web` | Open in browser |

## Edge Cases

- Use `--repo` flag when not in a git repository
- Use `gh auth refresh --scopes` to add permissions
- Use `--paginate` for large result sets
- Draft PRs need `--draft` flag

## References

- [Full Command Reference](references/REFERENCE.md)
- [Official Manual](https://cli.github.com/manual/)
- [GitHub Docs](https://docs.github.com/en/github-cli)
