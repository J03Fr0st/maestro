---
name: azure-devops-cli
description: >
  Use when working with Azure DevOps from the command line. Covers managing PRs,
  pipelines, work items, repos, and variable groups via `az devops` CLI.
  Make sure to use this skill whenever the user mentions "az devops", "Azure DevOps",
  "ADO pipeline", "create PR in DevOps", "work item", or "variable group",
  even if they don't explicitly ask for it.
---

# Azure DevOps CLI

Manage Azure DevOps resources via command line. For full command syntax and examples, see [REFERENCE.md](references/REFERENCE.md).

## Prerequisites

```bash
# Install Azure CLI
brew install azure-cli              # macOS
winget install Microsoft.AzureCLI   # Windows

# Install DevOps extension (auto-installs on first use)
az extension add --name azure-devops

# Login
az login
az devops login --organization https://dev.azure.com/{org}

# Configure defaults (avoids repeating --org/--project on every call)
az devops configure --defaults organization=https://dev.azure.com/{org} project={project}
```

## Key Concepts

- **`--detect`** — Auto-detects organization/project from the local git remote. Use this in repos already cloned from Azure DevOps to skip `--org` and `--project` flags.
- **`--output tsv`** — Outputs tab-separated values without headers, which makes it safe to pipe into `awk`, `cut`, or variable assignment in scripts. Prefer over `json` when extracting a single value.
- **PAT auth** — Store a Personal Access Token in `AZURE_DEVOPS_EXT_PAT` env var for non-interactive/CI use.
- **Cloud only** — The `az devops` extension works with Azure DevOps Services (cloud), not Azure DevOps Server (on-prem).

## Common Workflows

### Create PR from Current Branch

```bash
CURRENT_BRANCH=$(git branch --show-current)
az repos pr create \
  --source-branch "$CURRENT_BRANCH" \
  --target-branch main \
  --title "$(git log -1 --pretty=%B)" \
  --detect --open
```

### Approve and Complete a PR

```bash
az repos pr set-vote --id {pr-id} --vote approve
az repos pr update --id {pr-id} --status completed
```

### Run Pipeline and Check Status

```bash
az pipelines run --name {pipeline-name} --branch main
az pipelines runs list --pipeline-ids {pipeline-id} --top 1 --output table
```

### Query Work Items

```bash
az boards query \
  --wiql "SELECT [System.Id], [System.Title] FROM WorkItems WHERE [System.State] = 'Active'" \
  --output table
```

### Manage Variable Groups

```bash
# List
az pipelines variable-group list --output table

# Create
az pipelines variable-group create \
  --name {group-name} \
  --variables key1=value1 key2=value2

# Add a secret variable
az pipelines variable-group variable create \
  --group-id {group-id} \
  --name {var-name} \
  --secret true
```

## Output Formats

| Format | Flag | When to use |
|--------|------|-------------|
| Table | `--output table` | Human-readable display |
| JSON | `--output json` | Default; structured data |
| TSV | `--output tsv` | Scripting and piping (no headers, no quoting) |
| JMESPath | `--query "..."` | Filter/reshape any output format |

## Full Reference

See [references/REFERENCE.md](references/REFERENCE.md) for complete command documentation covering:
- Pull requests (create, list, show, update, vote, policies)
- Pipelines (list, run, show runs, variables)
- Work items (create, query, update, relations)
- Repositories (list, create, import, policies)
- Variable groups (create, list, update, secrets)
- Global arguments and advanced query patterns
