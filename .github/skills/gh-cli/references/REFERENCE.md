# GitHub CLI Complete Reference

**Version:** 2.85.0 (January 2026)

## Table of Contents

- [CLI Structure](#cli-structure)
- [Authentication (gh auth)](#authentication-gh-auth)
- [Repositories (gh repo)](#repositories-gh-repo)
- [Issues (gh issue)](#issues-gh-issue)
- [Pull Requests (gh pr)](#pull-requests-gh-pr)
- [GitHub Actions](#github-actions)
- [Releases (gh release)](#releases-gh-release)
- [Gists (gh gist)](#gists-gh-gist)
- [Projects (gh project)](#projects-gh-project)
- [Search (gh search)](#search-gh-search)
- [API Requests (gh api)](#api-requests-gh-api)
- [Configuration (gh config)](#configuration-gh-config)
- [Environment Variables](#environment-variables)
- [Global Flags](#global-flags)
- [Output Formatting](#output-formatting)
- [Common Workflows](#common-workflows)
- [Extensions](#extensions)
- [Aliases](#aliases)
- [References](#references)

## CLI Structure

```
gh                          # Root command
├── auth                    # Authentication
├── browse                  # Open in browser
├── codespace               # GitHub Codespaces
├── gist                    # Gists
├── issue                   # Issues
├── org                     # Organizations
├── pr                      # Pull Requests
├── project                 # Projects
├── release                 # Releases
├── repo                    # Repositories
├── cache                   # Actions caches
├── run                     # Workflow runs
├── workflow                # Workflows
├── alias                   # Command aliases
├── api                     # API requests
├── config                  # Configuration
├── extension               # Extensions
├── label                   # Labels
├── search                  # Search
├── secret                  # Secrets
├── ssh-key                 # SSH keys
├── status                  # Status overview
└── variable                # Variables
```

## Authentication (gh auth)

```bash
# Interactive login
gh auth login

# Web-based authentication
gh auth login --web

# With specific git protocol
gh auth login --git-protocol ssh

# With custom hostname (GitHub Enterprise)
gh auth login --hostname enterprise.internal

# Login with token from stdin
gh auth login --with-token < token.txt

# Show authentication status
gh auth status
gh auth status --show-token

# Switch accounts
gh auth switch
gh auth switch --hostname github.com --user monalisa

# Print authentication token
gh auth token

# Refresh credentials / add scopes
gh auth refresh
gh auth refresh --scopes write:org,read:public_key

# Setup git credential helper
gh auth setup-git

# Logout
gh auth logout
```

## Repositories (gh repo)

### Create Repository

```bash
gh repo create my-repo
gh repo create my-repo --description "My awesome project"
gh repo create my-repo --public
gh repo create my-repo --private
gh repo create my-repo --homepage https://example.com
gh repo create my-repo --license mit
gh repo create my-repo --gitignore python
gh repo create org/my-repo
gh repo create my-repo --source=.
gh repo create my-repo --disable-issues
gh repo create my-repo --disable-wiki
```

### Clone Repository

```bash
gh repo clone owner/repo
gh repo clone owner/repo my-directory
gh repo clone owner/repo --branch develop
```

### List Repositories

```bash
gh repo list
gh repo list owner
gh repo list --limit 50
gh repo list --public
gh repo list --source
gh repo list --json name,visibility,owner
gh repo list --json name --jq '.[].name'
```

### View Repository

```bash
gh repo view
gh repo view owner/repo
gh repo view --json name,description,defaultBranchRef
gh repo view --web
```

### Edit Repository

```bash
gh repo edit --description "New description"
gh repo edit --homepage https://example.com
gh repo edit --visibility private
gh repo edit --visibility public
gh repo edit --enable-issues
gh repo edit --disable-issues
gh repo edit --default-branch main
gh repo rename new-name
gh repo archive
gh repo unarchive
```

### Delete Repository

```bash
gh repo delete owner/repo
gh repo delete owner/repo --yes
```

### Fork Repository

```bash
gh repo fork owner/repo
gh repo fork owner/repo --org org-name
gh repo fork owner/repo --clone
gh repo fork owner/repo --remote-name upstream
```

### Sync Fork

```bash
gh repo sync
gh repo sync --branch feature
gh repo sync --force
```

### Set Default Repository

```bash
gh repo set-default
gh repo set-default owner/repo
gh repo set-default --unset
```

## Issues (gh issue)

### Create Issue

```bash
gh issue create
gh issue create --title "Bug: Login not working"
gh issue create --title "Bug" --body "Steps to reproduce..."
gh issue create --body-file issue.md
gh issue create --title "Fix bug" --labels bug,high-priority
gh issue create --title "Fix bug" --assignee user1,user2
gh issue create --repo owner/repo --title "Issue title"
gh issue create --web
```

### List Issues

```bash
gh issue list
gh issue list --state all
gh issue list --state closed
gh issue list --limit 50
gh issue list --assignee username
gh issue list --assignee @me
gh issue list --labels bug,enhancement
gh issue list --milestone "v1.0"
gh issue list --search "is:open is:issue label:bug"
gh issue list --json number,title,state,author
gh issue list --sort created --order desc
```

### View Issue

```bash
gh issue view 123
gh issue view 123 --comments
gh issue view 123 --web
gh issue view 123 --json title,body,state,labels,comments
gh issue view 123 --json title --jq '.title'
```

### Edit Issue

```bash
gh issue edit 123
gh issue edit 123 --title "New title"
gh issue edit 123 --body "New description"
gh issue edit 123 --add-label bug,high-priority
gh issue edit 123 --remove-label stale
gh issue edit 123 --add-assignee user1,user2
gh issue edit 123 --remove-assignee user1
gh issue edit 123 --milestone "v1.0"
```

### Close/Reopen Issue

```bash
gh issue close 123
gh issue close 123 --comment "Fixed in PR #456"
gh issue reopen 123
```

### Comment on Issue

```bash
gh issue comment 123 --body "This looks good!"
gh issue comment 123 --edit 456789 --body "Updated comment"
gh issue comment 123 --delete 456789
```

### Other Issue Operations

```bash
gh issue status
gh issue pin 123
gh issue unpin 123
gh issue lock 123
gh issue lock 123 --reason off-topic
gh issue unlock 123
gh issue transfer 123 --repo owner/new-repo
gh issue delete 123
gh issue delete 123 --yes
gh issue develop 123
gh issue develop 123 --branch fix/issue-123
```

## Pull Requests (gh pr)

### Create Pull Request

```bash
gh pr create
gh pr create --title "Feature: Add new functionality"
gh pr create --title "Feature" --body "This PR adds..."
gh pr create --body-file .github/PULL_REQUEST_TEMPLATE.md
gh pr create --base main
gh pr create --head feature-branch
gh pr create --draft
gh pr create --assignee user1,user2
gh pr create --reviewer user1,user2
gh pr create --labels enhancement,feature
gh pr create --repo owner/repo
gh pr create --web
gh pr create --fill
```

### List Pull Requests

```bash
gh pr list
gh pr list --state all
gh pr list --state merged
gh pr list --state closed
gh pr list --head feature-branch
gh pr list --base main
gh pr list --author username
gh pr list --author @me
gh pr list --assignee username
gh pr list --labels bug,enhancement
gh pr list --limit 50
gh pr list --search "is:open is:pr label:review-required"
gh pr list --json number,title,state,author,headRefName
gh pr list --sort created --order desc
```

### View Pull Request

```bash
gh pr view 123
gh pr view 123 --comments
gh pr view 123 --web
gh pr view 123 --json title,body,state,author,commits,files
gh pr view 123 --json files --jq '.files[].path'
```

### Checkout Pull Request

```bash
gh pr checkout 123
gh pr checkout 123 --branch name-123
gh pr checkout 123 --force
```

### Diff Pull Request

```bash
gh pr diff 123
gh pr diff 123 --color always
gh pr diff 123 > pr-123.patch
gh pr diff 123 --name-only
```

### Merge Pull Request

```bash
gh pr merge 123
gh pr merge 123 --merge
gh pr merge 123 --squash
gh pr merge 123 --rebase
gh pr merge 123 --delete-branch
gh pr merge 123 --subject "Merge PR #123" --body "Merging feature"
gh pr merge 123 --admin
```

### Close/Reopen Pull Request

```bash
gh pr close 123
gh pr close 123 --comment "Closing due to..."
gh pr reopen 123
```

### Edit Pull Request

```bash
gh pr edit 123
gh pr edit 123 --title "New title"
gh pr edit 123 --body "New description"
gh pr edit 123 --add-label bug,enhancement
gh pr edit 123 --remove-label stale
gh pr edit 123 --add-assignee user1,user2
gh pr edit 123 --add-reviewer user1,user2
gh pr edit 123 --ready
```

### Review Pull Request

```bash
gh pr review 123
gh pr review 123 --approve
gh pr review 123 --approve --body "LGTM!"
gh pr review 123 --request-changes --body "Please fix these issues"
gh pr review 123 --comment --body "Some thoughts..."
```

### Other PR Operations

```bash
gh pr ready 123
gh pr checks 123
gh pr checks 123 --watch
gh pr checks 123 --watch --interval 5
gh pr comment 123 --body "Looks good!"
gh pr update-branch 123
gh pr lock 123
gh pr unlock 123
gh pr revert 123
gh pr status
```

## GitHub Actions

### Workflow Runs (gh run)

```bash
gh run list
gh run list --workflow "ci.yml"
gh run list --branch main
gh run list --limit 20
gh run list --json databaseId,status,conclusion,headBranch
gh run view 123456789
gh run view 123456789 --log
gh run view 123456789 --job 987654321
gh run view 123456789 --web
gh run watch 123456789
gh run watch 123456789 --interval 5
gh run rerun 123456789
gh run rerun 123456789 --job 987654321
gh run cancel 123456789
gh run delete 123456789
gh run download 123456789
gh run download 123456789 --name build
gh run download 123456789 --dir ./artifacts
```

### Workflows (gh workflow)

```bash
gh workflow list
gh workflow view ci.yml
gh workflow view ci.yml --yaml
gh workflow view ci.yml --web
gh workflow enable ci.yml
gh workflow disable ci.yml
gh workflow run ci.yml
gh workflow run ci.yml --raw-field version="1.0.0" environment="production"
gh workflow run ci.yml --ref develop
```

### Caches (gh cache)

```bash
gh cache list
gh cache list --branch main
gh cache list --limit 50
gh cache delete 123456789
gh cache delete --all
```

### Secrets (gh secret)

```bash
gh secret list
gh secret set MY_SECRET
echo "$MY_SECRET" | gh secret set MY_SECRET
gh secret set MY_SECRET --env production
gh secret set MY_SECRET --org orgname
gh secret delete MY_SECRET
```

### Variables (gh variable)

```bash
gh variable list
gh variable set MY_VAR "some-value"
gh variable set MY_VAR "value" --env production
gh variable get MY_VAR
gh variable delete MY_VAR
```

## Releases (gh release)

```bash
gh release list
gh release view
gh release view v1.0.0
gh release view v1.0.0 --web
gh release create v1.0.0 --notes "Release notes here"
gh release create v1.0.0 --notes-file notes.md
gh release create v1.0.0 --target main
gh release create v1.0.0 --draft
gh release create v1.0.0 --prerelease
gh release create v1.0.0 --title "Version 1.0.0"
gh release upload v1.0.0 ./file.tar.gz
gh release delete v1.0.0
gh release delete v1.0.0 --yes
gh release download v1.0.0
gh release download v1.0.0 --pattern "*.tar.gz"
gh release download v1.0.0 --dir ./downloads
gh release edit v1.0.0 --notes "Updated notes"
```

## Gists (gh gist)

```bash
gh gist list
gh gist list --public
gh gist view abc123
gh gist view abc123 --files
gh gist create script.py
gh gist create script.py --desc "My script"
gh gist create script.py --public
gh gist create file1.py file2.py
gh gist edit abc123
gh gist delete abc123
gh gist clone abc123
```

## Projects (gh project)

```bash
gh project list
gh project list --owner owner
gh project view 123
gh project create --title "My Project"
gh project edit 123 --title "New Title"
gh project delete 123
gh project close 123
gh project field-list 123
gh project item-list 123
gh project item-create 123 --title "New item"
gh project view 123 --web
```

## Search (gh search)

```bash
gh search code "TODO"
gh search code "TODO" --repo owner/repo
gh search commits "fix bug"
gh search issues "label:bug state:open"
gh search prs "is:open is:pr review:required"
gh search repos "stars:>1000 language:python"
gh search repos "topic:api" --limit 50
gh search repos "stars:>100" --json name,description,stargazers
gh search repos "language:rust" --order desc --sort stars
```

## API Requests (gh api)

```bash
gh api /user
gh api --method POST /repos/owner/repo/issues --field title="Issue title" --field body="Issue body"
gh api /user --header "Accept: application/vnd.github.v3+json"
gh api /user/repos --paginate
gh api /user --jq '.login'
gh api /repos/owner/repo --jq '.stargazers_count'
gh api graphql -f query='{ viewer { login } }'
```

## Configuration (gh config)

```bash
gh config list
gh config get editor
gh config set editor vim
gh config set git_protocol ssh
gh config set prompt disabled
gh config clear-cache
```

## Environment Variables

```bash
export GH_TOKEN=ghp_xxxxxxxxxxxx
export GH_HOST=github.com
export GH_PROMPT_DISABLED=true
export GH_EDITOR=vim
export GH_REPO=owner/repo
```

## Global Flags

| Flag | Description |
|------|-------------|
| `--help` / `-h` | Show help for command |
| `--version` | Show gh version |
| `--repo [HOST/]OWNER/REPO` | Select another repository |
| `--hostname HOST` | GitHub hostname |
| `--jq EXPRESSION` | Filter JSON output |
| `--json FIELDS` | Output JSON with specified fields |
| `--template STRING` | Format JSON using Go template |
| `--web` | Open in browser |
| `--paginate` | Make additional API calls |
| `--verbose` | Show verbose output |
| `--debug` | Show debug output |

## Output Formatting

### JSON Output

```bash
gh repo view --json name,description
gh repo view --json owner,name --jq '.owner.login + "/" + .name'
gh pr list --json number,title --jq '.[] | select(.number > 100)'
```

### Template Output

```bash
gh repo view --template '{{.name}}: {{.description}}'
gh pr view 123 --template 'Title: {{.title}}\nAuthor: {{.author.login}}'
```

## Common Workflows

### Create PR from Issue

```bash
gh issue develop 123 --branch feature/issue-123
git add .
git commit -m "Fix issue #123"
git push
gh pr create --title "Fix #123" --body "Closes #123"
```

### Bulk Operations

```bash
# Close multiple issues
gh issue list --search "label:stale" --json number --jq '.[].number' | \
  xargs -I {} gh issue close {} --comment "Closing as stale"

# Add label to multiple PRs
gh pr list --search "review:required" --json number --jq '.[].number' | \
  xargs -I {} gh pr edit {} --add-label needs-review
```

### CI/CD Workflow

```bash
RUN_ID=$(gh workflow run ci.yml --ref main --jq '.databaseId')
gh run watch "$RUN_ID"
gh run download "$RUN_ID" --dir ./artifacts
```

## Extensions

```bash
gh extension list
gh extension search github
gh extension install owner/extension-repo
gh extension upgrade extension-name
gh extension remove extension-name
gh extension create my-extension
```

## Aliases

```bash
gh alias list
gh alias set prview 'pr view --web'
gh alias set co 'pr checkout' --shell
gh alias delete prview
```

## References

- Official Manual: https://cli.github.com/manual/
- GitHub Docs: https://docs.github.com/en/github-cli
- REST API: https://docs.github.com/en/rest
- GraphQL API: https://docs.github.com/en/graphql
