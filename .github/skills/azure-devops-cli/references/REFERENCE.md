# Azure DevOps CLI Complete Reference

**CLI Version:** 2.81.0 (2025)

## CLI Structure

```
az devops              # Main DevOps commands
├── admin              # Administration (banner)
├── extension          # Extension management
├── project            # Team projects
├── security           # Security operations
├── service-endpoint   # Service connections
├── team               # Teams
├── user               # Users
├── wiki               # Wikis
├── configure          # Set defaults
├── invoke             # Invoke REST API
├── login              # Authenticate
└── logout             # Clear credentials

az pipelines           # Azure Pipelines
├── agent              # Agents
├── build              # Builds
├── folder             # Pipeline folders
├── pool               # Agent pools
├── queue              # Agent queues
├── release            # Releases
├── runs               # Pipeline runs
├── variable           # Pipeline variables
└── variable-group     # Variable groups

az boards              # Azure Boards
├── area               # Area paths
├── iteration          # Iterations
└── work-item          # Work items

az repos               # Azure Repos
├── import             # Git imports
├── policy             # Branch policies
├── pr                 # Pull requests
└── ref                # Git references

az artifacts           # Azure Artifacts
└── universal          # Universal Packages
```

## Authentication

```bash
# Interactive login (prompts for PAT)
az devops login --organization https://dev.azure.com/{org}

# Login with PAT token
az devops login --organization https://dev.azure.com/{org} --token YOUR_PAT_TOKEN

# Logout
az devops logout --organization https://dev.azure.com/{org}

# Configure defaults
az devops configure --defaults organization=https://dev.azure.com/{org} project={project}

# List current configuration
az devops configure --list

# Enable Git aliases
az devops configure --use-git-aliases true
```

## Projects

```bash
# List projects
az devops project list --organization https://dev.azure.com/{org}
az devops project list --top 10 --output table

# Create project
az devops project create \
  --name myNewProject \
  --organization https://dev.azure.com/{org} \
  --description "My new DevOps project" \
  --source-control git \
  --visibility private

# Show project
az devops project show --project {project-name} --org https://dev.azure.com/{org}

# Delete project
az devops project delete --id {project-id} --org https://dev.azure.com/{org} --yes
```

## Repositories

```bash
# List repositories
az repos list --org https://dev.azure.com/{org} --project {project}
az repos list --output table

# Create repository
az repos create --name {repo-name} --project {project}

# Delete repository
az repos delete --id {repo-id} --project {project} --yes

# Import from public Git repository
az repos import create \
  --git-source-url https://github.com/user/repo \
  --repository {repo-name}

# Import with authentication
az repos import create \
  --git-source-url https://github.com/user/private-repo \
  --repository {repo-name} \
  --user {username} \
  --password {password-or-pat}
```

## Pull Requests

### Create Pull Request

```bash
# Basic PR creation
az repos pr create \
  --repository {repo} \
  --source-branch {source-branch} \
  --target-branch {target-branch} \
  --title "PR Title" \
  --description "PR description" \
  --open

# PR with work items
az repos pr create \
  --repository {repo} \
  --source-branch {source-branch} \
  --work-items 63 64

# Draft PR with reviewers
az repos pr create \
  --repository {repo} \
  --source-branch feature/new-feature \
  --target-branch main \
  --title "Feature: New functionality" \
  --draft true \
  --reviewers user1@example.com user2@example.com \
  --required-reviewers lead@example.com \
  --labels "enhancement" "backlog"
```

### List/Show Pull Requests

```bash
# All PRs
az repos pr list --repository {repo}

# Filter by status
az repos pr list --repository {repo} --status active

# Show details
az repos pr show --id {pr-id}
az repos pr show --id {pr-id} --open
```

### Update PR

```bash
# Complete PR
az repos pr update --id {pr-id} --status completed

# Abandon PR
az repos pr update --id {pr-id} --status abandoned

# Set auto-complete when policies pass
az repos pr update --id {pr-id} --auto-complete true
```

### Vote on PR

```bash
az repos pr set-vote --id {pr-id} --vote approve
az repos pr set-vote --id {pr-id} --vote approve-with-suggestions
az repos pr set-vote --id {pr-id} --vote reject
az repos pr set-vote --id {pr-id} --vote wait-for-author
az repos pr set-vote --id {pr-id} --vote reset
```

### PR Reviewers/Work Items

```bash
# Add reviewers
az repos pr reviewer add --id {pr-id} --reviewers user1@example.com user2@example.com

# Add work items to PR
az repos pr work-item add --id {pr-id} --work-items {id1} {id2}
```

## Pipelines

### List/Create Pipelines

```bash
# List pipelines
az pipelines list --output table
az pipelines list --folder-path 'folder/subfolder'

# Create pipeline
az pipelines create \
  --name {pipeline-name} \
  --repository {repo} \
  --branch main \
  --yaml-path azure-pipelines.yml \
  --description "My CI/CD pipeline"

# Skip first run
az pipelines create --name 'MyPipeline' --skip-run true
```

### Run Pipeline

```bash
# Run by name
az pipelines run --name {pipeline-name} --branch main

# With parameters
az pipelines run --name {pipeline-name} --parameters version=1.0.0 environment=prod

# With variables
az pipelines run --name {pipeline-name} --variables buildId=123 configuration=release

# Open results in browser
az pipelines run --name {pipeline-name} --open
```

### Pipeline Runs

```bash
# List runs
az pipelines runs list --pipeline {pipeline-id}
az pipelines runs list --name {pipeline-name} --top 10

# Show run details
az pipelines runs show --run-id {run-id}

# Download artifact
az pipelines runs artifact download \
  --artifact-name '{artifact-name}' \
  --path {local-path} \
  --run-id {run-id}
```

## Builds

```bash
# List builds
az pipelines build list
az pipelines build list --status completed --result succeeded

# Queue build
az pipelines build queue --definition {build-definition-id} --branch main

# Show/Cancel build
az pipelines build show --id {build-id}
az pipelines build cancel --id {build-id}

# Add tag to build
az pipelines build tag add --build-id {build-id} --tags prod release
```

## Pipeline Variables

### Pipeline Variables

```bash
# List variables
az pipelines variable list --pipeline-id {pipeline-id}

# Create variable
az pipelines variable create \
  --name {var-name} \
  --value {var-value} \
  --pipeline-id {pipeline-id}

# Create secret variable
az pipelines variable create \
  --name {var-name} \
  --secret true \
  --pipeline-id {pipeline-id}

# Update/Delete variable
az pipelines variable update --name {var-name} --value {new-value} --pipeline-id {pipeline-id}
az pipelines variable delete --name {var-name} --pipeline-id {pipeline-id} --yes
```

### Variable Groups

```bash
# List/Show variable groups
az pipelines variable-group list
az pipelines variable-group show --id {group-id}

# Create variable group
az pipelines variable-group create \
  --name {group-name} \
  --variables key1=value1 key2=value2 \
  --authorize true

# Add variable to group
az pipelines variable-group variable create \
  --group-id {group-id} \
  --name {var-name} \
  --value {var-value}

# Add secret to group
az pipelines variable-group variable create \
  --group-id {group-id} \
  --name {var-name} \
  --secret true
```

## Work Items (Boards)

### Query Work Items

```bash
az boards query \
  --wiql "SELECT [System.Id], [System.Title], [System.State] FROM WorkItems WHERE [System.AssignedTo] = @Me AND [System.State] = 'Active'"
```

### Create Work Item

```bash
# Basic work item
az boards work-item create \
  --title "Fix login bug" \
  --type Bug \
  --assigned-to user@example.com \
  --description "Users cannot login with SSO"

# With area and iteration
az boards work-item create \
  --title "New feature" \
  --type "User Story" \
  --area "Project\\Area1" \
  --iteration "Project\\Sprint 1"
```

### Update Work Item

```bash
az boards work-item update \
  --id {work-item-id} \
  --state "Active" \
  --title "Updated title" \
  --assigned-to user@example.com

# Add comment
az boards work-item update --id {work-item-id} --discussion "Work in progress"
```

### Delete Work Item

```bash
# Soft delete (can be restored)
az boards work-item delete --id {work-item-id} --yes

# Permanent delete
az boards work-item delete --id {work-item-id} --destroy --yes
```

## Branch Policies

```bash
# Approver count policy
az repos policy approver-count create \
  --blocking true \
  --enabled true \
  --branch main \
  --repository-id {repo-id} \
  --minimum-approver-count 2 \
  --creator-vote-counts true

# Build policy
az repos policy build create \
  --blocking true \
  --enabled true \
  --branch main \
  --repository-id {repo-id} \
  --build-definition-id {definition-id} \
  --queue-on-source-update-only true

# Work item linking policy
az repos policy work-item-linking create \
  --blocking true \
  --branch main \
  --enabled true \
  --repository-id {repo-id}

# Required reviewer policy
az repos policy required-reviewer create \
  --blocking true \
  --enabled true \
  --branch main \
  --repository-id {repo-id} \
  --required-reviewers user@example.com
```

## Service Endpoints

```bash
# List service endpoints
az devops service-endpoint list --project {project}

# Show endpoint
az devops service-endpoint show --id {endpoint-id} --project {project}

# Delete endpoint
az devops service-endpoint delete --id {endpoint-id} --project {project} --yes
```

## Teams and Users

```bash
# List teams
az devops team list --project {project}

# Create team
az devops team create --name {team-name} --description "Team description" --project {project}

# List users
az devops user list --org https://dev.azure.com/{org}

# Add user
az devops user add --email user@example.com --license-type express --org https://dev.azure.com/{org}
```

## Universal Packages (Artifacts)

```bash
# Publish package
az artifacts universal publish \
  --feed {feed-name} \
  --name {package-name} \
  --version {version} \
  --path {package-path} \
  --project {project}

# Download package
az artifacts universal download \
  --feed {feed-name} \
  --name {package-name} \
  --version {version} \
  --path {download-path} \
  --project {project}
```

## Output Formats

```bash
# Table format (human-readable)
az pipelines list --output table

# JSON format (default)
az pipelines list --output json

# TSV format (for scripting)
az pipelines list --output tsv

# YAML format
az pipelines list --output yaml
```

## JMESPath Queries

```bash
# Filter by name
az pipelines list --query "[?name=='myPipeline']"

# Get specific fields
az pipelines list --query "[].{Name:name, ID:id}"

# Get first result
az pipelines list --query "[0]"
```

## Common Workflows

### Create PR from current branch

```bash
CURRENT_BRANCH=$(git branch --show-current)
az repos pr create \
  --source-branch $CURRENT_BRANCH \
  --target-branch main \
  --title "Feature: $(git log -1 --pretty=%B)" \
  --open
```

### Download latest pipeline artifact

```bash
RUN_ID=$(az pipelines runs list --pipeline {pipeline-id} --top 1 --query "[0].id" -o tsv)
az pipelines runs artifact download \
  --artifact-name 'webapp' \
  --path ./output \
  --run-id $RUN_ID
```

### Approve and complete PR

```bash
az repos pr set-vote --id {pr-id} --vote approve
az repos pr update --id {pr-id} --status completed
```

## Best Practices

### Authentication

```bash
# Use PAT from environment variable (most secure)
export AZURE_DEVOPS_EXT_PAT=$MY_PAT
az devops login --organization $ORG_URL

# Set defaults to avoid repetition
az devops configure --defaults organization=$ORG_URL project=$PROJECT
```

### Idempotent Operations

```bash
# Check existence before creation
if ! az pipelines show --id $PIPELINE_ID 2>/dev/null; then
  az pipelines create --name "$PIPELINE_NAME" --yaml-path azure-pipelines.yml
fi

# Use --output tsv for shell parsing
PIPELINE_ID=$(az pipelines list --query "[?name=='MyPipeline'].id" --output tsv)
```

## Global Arguments

| Parameter | Description |
|-----------|-------------|
| `--help` / `-h` | Show help |
| `--output` / `-o` | Output format (json, table, tsv, yaml) |
| `--query` | JMESPath query string |
| `--verbose` | Increase logging verbosity |
| `--debug` | Show all debug logs |
| `--only-show-errors` | Only show errors |
| `--yes` / `-y` | Skip confirmation prompts |

## Common Parameters

| Parameter | Description |
|-----------|-------------|
| `--org` / `--organization` | Azure DevOps organization URL |
| `--project` / `-p` | Project name or ID |
| `--detect` | Auto-detect organization from git config |
| `--open` | Open in web browser |
