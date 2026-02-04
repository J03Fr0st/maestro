# Maestro Installer

Automated installer for Maestro GitHub Copilot configuration files.

## Quick Start

### Windows (PowerShell)

```powershell
# Install to current workspace (most common)
.\installer\install.ps1

# Preview what will be installed (no changes made)
.\installer\install.ps1 -WhatIf

# Install globally for all workspaces
.\installer\install.ps1 -Scope Global
```

### macOS / Linux (Bash)

```bash
# Install to current workspace (most common)
./installer/install.sh

# Preview what will be installed (no changes made)
./installer/install.sh -n

# Install globally for all workspaces
./installer/install.sh -s global
```

## Installation Scopes

| Scope | Description | Path |
|-------|-------------|------|
| `Workspace` (default) | Current project only | `./.github/` |
| `User` | VS Code user prompts | Agent files to `User/prompts/` (all workspaces) |
| `Global` | All projects | `~/.github/` |

## Options

### PowerShell (Windows)

| Parameter | Values | Default | Description |
|-----------|--------|---------|-------------|
| `-Scope` | Workspace, User, Global | Workspace | Where to install |
| `-VSCodeType` | Both, Standard, Insiders | Both | Which VS Code to target |
| `-ProfileId` | profile ID, 'all' | (default) | VS Code profile to install to |
| `-WorkspacePath` | path | Current dir | Workspace location |
| `-WhatIf` | switch | - | Preview mode |

### Bash (macOS/Linux)

| Flag | Values | Default | Description |
|------|--------|---------|-------------|
| `-s` | workspace, user, global | workspace | Where to install |
| `-t` | both, standard, insiders | both | Which VS Code to target |
| `-p` | profile ID, 'all' | (default) | VS Code profile to install to |
| `-w` | path | Current dir | Workspace location |
| `-n` | - | - | Dry-run mode |
| `-h` | - | - | Show help |

## Examples

### Install to VS Code Insiders Only

```powershell
# Windows
.\installer\install.ps1 -VSCodeType Insiders

# macOS/Linux
./installer/install.sh -t insiders
```

### Install to a Different Workspace

```powershell
# Windows
.\installer\install.ps1 -WorkspacePath "C:\Projects\my-app"

# macOS/Linux
./installer/install.sh -w ~/projects/my-app
```

### Install to Both VS Code Versions Globally

```powershell
# Windows
.\installer\install.ps1 -Scope Global -VSCodeType Both

# macOS/Linux
./installer/install.sh -s global -t both
```

### Install to a Specific VS Code Profile

VS Code profiles have their own prompts folders. The installer auto-detects profiles and lets you choose interactively, or you can specify directly:

```powershell
# Windows - Install to specific profile by ID
.\installer\install.ps1 -Scope User -ProfileId "5ec026e8"

# Windows - Install to all profiles
.\installer\install.ps1 -Scope User -ProfileId all

# macOS/Linux - Install to specific profile
./installer/install.sh -s user -p "5ec026e8"

# macOS/Linux - Install to all profiles
./installer/install.sh -s user -p all
```

Profile paths:
- **Default**: `Code/User/prompts/` or `Code - Insiders/User/prompts/`
- **Named profile**: `Code/User/profiles/<profile-id>/prompts/`

## What Gets Installed

The installer copies these directories to your target location:

```
.github/
├── agents/           # AI agent definitions
│   ├── maestro-conductor.agent.md
│   ├── maestro-planner.agent.md
│   ├── maestro-implementer.agent.md
│   ├── maestro-reviewer.agent.md
│   └── ...
├── instructions/     # File-type specific guidelines
│   ├── general.instructions.md
│   ├── typescript.instructions.md
│   └── ...
├── prompts/          # Reusable prompt templates
│   ├── commit.prompt.md
│   ├── review.prompt.md
│   └── ...
├── skills/           # Domain-specific knowledge
│   ├── git-commit/
│   ├── code-review/
│   └── ...
└── copilot-instructions.md  # Repository-level instructions
```

## Troubleshooting

### "Execution Policy" Error (Windows)

Run PowerShell as Administrator and execute:

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

Or run with bypass:

```powershell
powershell -ExecutionPolicy Bypass -File .\installer\install.ps1
```

### "Permission Denied" (macOS/Linux)

Make the script executable:

```bash
chmod +x installer/install.sh
```

### "VS Code Not Detected"

Ensure VS Code is installed in the default location. The installer checks:

**Windows:**
- `%LOCALAPPDATA%\Programs\Microsoft VS Code`
- `%ProgramFiles%\Microsoft VS Code`

**macOS:**
- `/Applications/Visual Studio Code.app`

**Linux:**
- `code` command in PATH

## Uninstalling

To remove Maestro configuration, simply delete the `.github` folder from your installation location:

```bash
# Workspace
rm -rf .github

# User profile - default (macOS/Linux)
rm -rf ~/.config/Code/User/prompts/*.agent.md
rm -rf ~/.config/Code/User/prompts/*.prompt.md
rm -rf ~/.config/Code/User/prompts/*.instructions.md

# User profile - named profile (macOS/Linux)
rm -rf ~/.config/Code/User/profiles/<profile-id>/prompts/*.agent.md
rm -rf ~/.config/Code/User/profiles/<profile-id>/prompts/*.prompt.md
rm -rf ~/.config/Code/User/profiles/<profile-id>/prompts/*.instructions.md

# User profile - default (Windows)
# %APPDATA%\Code\User\prompts\*.agent.md
# %APPDATA%\Code\User\prompts\*.prompt.md
# %APPDATA%\Code\User\prompts\*.instructions.md

# User profile - named profile (Windows)
# %APPDATA%\Code\User\profiles\<profile-id>\prompts\*.agent.md
# %APPDATA%\Code\User\profiles\<profile-id>\prompts\*.prompt.md
# %APPDATA%\Code\User\profiles\<profile-id>\prompts\*.instructions.md

# Global
rm -rf ~/.github
```
