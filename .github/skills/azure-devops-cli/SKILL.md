---
name: azure-devops-cli
description: Azure DevOps CLI for projects, repos, pipelines, PRs, and work items. Use when working with Azure DevOps from the command line to manage PRs, pipelines, work items/boards, repos, and variable groups, or to automate DevOps workflows.
---

# Azure DevOps CLI

Manage Azure DevOps resources via command line. See [full reference](references/REFERENCE.md) for complete documentation.

## Prerequisites

```bash
# Install Azure CLI
brew install azure-cli              # macOS
winget install Microsoft.AzureCLI   # Windows

# Install DevOps extension (auto-installs on first use)
az extension add --name azure-devops
# Update extension
az extension update --name azure-devops

# Login (interactive or PAT)
az login
az devops login --organization https://dev.azure.com/{org}

# Configure defaults
az devops configure --defaults organization=https://dev.azure.com/{org} project={project}
```

## Quick Reference

### Pull Requests

```bash
# Create PR
az repos pr create \
  --repository {repo} \
  --source-branch feature/my-feature \
  --target-branch main \
  --title "Feature: description"

# List PRs
az repos pr list --repository {repo}
az repos pr list --status active

# View PR
az repos pr show --id {pr-id}
az repos pr show --id {pr-id} --open

# Complete PR
az repos pr update --id {pr-id} --status completed

# Vote on PR
az repos pr set-vote --id {pr-id} --vote approve
```

### Pipelines

```bash
# List pipelines
az pipelines list --output table

# Run pipeline
az pipelines run --name {pipeline-name} --branch main

# Run with parameters
az pipelines run --name {pipeline-name} --parameters version=1.0.0

# List runs
az pipelines runs list --pipeline {pipeline-id}

# View run
az pipelines runs show --run-id {run-id}
```

### Work Items

```bash
# Create work item
az boards work-item create \
  --title "Fix login bug" \
  --type Bug \
  --assigned-to user@example.com

# Query work items
az boards query --wiql "SELECT [System.Id], [System.Title] FROM WorkItems WHERE [System.State] = 'Active'"

# Update work item
az boards work-item update --id {id} --state "Active"
```

### Repositories

```bash
# List repos
az repos list --output table

# Create repo
az repos create --name {repo-name}

# Import from Git
az repos import create \
  --git-source-url https://github.com/user/repo \
  --repository {repo-name}
```

### Variable Groups

```bash
# List variable groups
az pipelines variable-group list

# Create variable group
az pipelines variable-group create \
  --name {group-name} \
  --variables key1=value1 key2=value2

# Add secret
az pipelines variable-group variable create \
  --group-id {group-id} \
  --name {var-name} \
  --secret true
```

## Common Patterns

### Create PR from Current Branch

```bash
CURRENT_BRANCH=$(git branch --show-current)
az repos pr create \
  --source-branch $CURRENT_BRANCH \
  --target-branch main \
  --title "$(git log -1 --pretty=%B)" \
  --open
```

### Approve and Complete PR

```bash
az repos pr set-vote --id {pr-id} --vote approve
az repos pr update --id {pr-id} --status completed
```

### Run Pipeline and Wait

```bash
az pipelines run --name {pipeline-name} --branch main
az pipelines runs list --pipeline {pipeline-id} --top 1
```

## Output Formats

```bash
# Table (human-readable)
az pipelines list --output table

# JSON (default)
az pipelines list --output json

# TSV (scripting)
az pipelines list --output tsv

# JMESPath queries
az pipelines list --query "[?name=='myPipeline']"
az pipelines list --query "[].{Name:name, ID:id}"
```

## Global Arguments

| Parameter | Description |
|-----------|-------------|
| `--org` | Azure DevOps organization URL |
| `--project` / `-p` | Project name or ID |
| `--output` / `-o` | Output format (json, table, tsv) |
| `--query` | JMESPath query string |
| `--yes` / `-y` | Skip confirmation prompts |
| `--open` | Open in web browser |

## Edge Cases

- Use `--detect` to auto-detect organization from git config
- Store PAT in `AZURE_DEVOPS_EXT_PAT` environment variable
- Use `--skip-run true` when creating pipelines to skip first run
- Azure DevOps CLI extension works with Azure DevOps Services (cloud) only, not Azure DevOps Server (on-prem)

## References

- [Full Command Reference](references/REFERENCE.md)
- [Azure DevOps CLI Docs](https://learn.microsoft.com/en-us/cli/azure/devops)
