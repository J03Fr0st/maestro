# VS Code Automated Installer Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Create an automated installer that copies maestro configuration files to VS Code and VS Code Insiders installations on Windows, macOS, and Linux.

**Architecture:** PowerShell script for Windows (primary) with optional Node.js cross-platform alternative. The installer detects VS Code installations, prompts for installation scope (workspace vs user-global), and copies the `.github/` configuration files to the appropriate location.

**Tech Stack:** PowerShell (Windows), Bash (macOS/Linux), Node.js (cross-platform alternative)

---

## Task 1: Create Installer Directory Structure

**Files:**
- Create: `installer/install.ps1` (Windows PowerShell installer)
- Create: `installer/install.sh` (Unix shell installer)
- Create: `installer/README.md` (Usage documentation)

**Step 1: Create the installer directory**

```powershell
mkdir installer
```

**Step 2: Verify directory was created**

Run: `ls installer`
Expected: Empty directory exists

**Step 3: Commit**

```bash
git add installer
git commit -m "chore: create installer directory structure"
```

---

## Task 2: Write PowerShell Installer - Detection Functions

**Files:**
- Create: `installer/install.ps1`
- Test: Manual testing with `.\installer\install.ps1 -WhatIf`

**Step 1: Write the failing test scenario**

Create a minimal script that will fail if VS Code detection doesn't work:

```powershell
# installer/install.ps1
# Maestro Installer for VS Code and VS Code Insiders
# Usage: .\install.ps1 [-Scope <Workspace|User|Global>] [-VSCodeType <Both|Standard|Insiders>] [-WhatIf]

[CmdletBinding(SupportsShouldProcess)]
param(
    [ValidateSet('Workspace', 'User', 'Global')]
    [string]$Scope = 'Workspace',

    [ValidateSet('Both', 'Standard', 'Insiders')]
    [string]$VSCodeType = 'Both',

    [string]$WorkspacePath = (Get-Location).Path
)

$ErrorActionPreference = 'Stop'

# Colors for output
function Write-Success { param($Message) Write-Host $Message -ForegroundColor Green }
function Write-Info { param($Message) Write-Host $Message -ForegroundColor Cyan }
function Write-Warn { param($Message) Write-Host $Message -ForegroundColor Yellow }
function Write-Err { param($Message) Write-Host $Message -ForegroundColor Red }

Write-Info "Maestro Installer for VS Code"
Write-Info "=============================="
Write-Host ""

# Get script directory (where maestro files are located)
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$MaestroRoot = Split-Path -Parent $ScriptDir

# Verify maestro source files exist
$SourceGitHub = Join-Path $MaestroRoot ".github"
if (-not (Test-Path $SourceGitHub)) {
    Write-Err "Error: Cannot find maestro .github directory at: $SourceGitHub"
    Write-Err "Please run this installer from within the maestro repository."
    exit 1
}

Write-Success "Found maestro source at: $MaestroRoot"
```

**Step 2: Run script to verify it loads**

Run: `powershell -ExecutionPolicy Bypass -File .\installer\install.ps1 -WhatIf`
Expected: Shows "Found maestro source at: D:\Source\maestro" or similar

**Step 3: Commit**

```bash
git add installer/install.ps1
git commit -m "feat(installer): add PowerShell script skeleton with source detection"
```

---

## Task 3: Write PowerShell Installer - VS Code Path Detection

**Files:**
- Modify: `installer/install.ps1`

**Step 1: Add VS Code installation path detection functions**

Add after the source verification block:

```powershell
# Detect VS Code installations
function Get-VSCodePaths {
    $paths = @{
        Standard = @()
        Insiders = @()
    }

    # Windows default installation paths
    $standardPaths = @(
        "$env:LOCALAPPDATA\Programs\Microsoft VS Code",
        "$env:ProgramFiles\Microsoft VS Code",
        "${env:ProgramFiles(x86)}\Microsoft VS Code"
    )

    $insidersPaths = @(
        "$env:LOCALAPPDATA\Programs\Microsoft VS Code Insiders",
        "$env:ProgramFiles\Microsoft VS Code Insiders",
        "${env:ProgramFiles(x86)}\Microsoft VS Code Insiders"
    )

    foreach ($path in $standardPaths) {
        if (Test-Path (Join-Path $path "Code.exe")) {
            $paths.Standard += $path
        }
    }

    foreach ($path in $insidersPaths) {
        if (Test-Path (Join-Path $path "Code - Insiders.exe")) {
            $paths.Insiders += $path
        }
    }

    return $paths
}

# Detect VS Code user data directories
function Get-VSCodeUserDataPaths {
    $paths = @{
        Standard = $null
        Insiders = $null
    }

    $standardUserData = Join-Path $env:APPDATA "Code"
    $insidersUserData = Join-Path $env:APPDATA "Code - Insiders"

    if (Test-Path $standardUserData) {
        $paths.Standard = $standardUserData
    }

    if (Test-Path $insidersUserData) {
        $paths.Insiders = $insidersUserData
    }

    return $paths
}

# Detect installations
$vscodePaths = Get-VSCodePaths
$userDataPaths = Get-VSCodeUserDataPaths

$hasStandard = $vscodePaths.Standard.Count -gt 0 -or $userDataPaths.Standard
$hasInsiders = $vscodePaths.Insiders.Count -gt 0 -or $userDataPaths.Insiders

Write-Host ""
Write-Info "Detected VS Code Installations:"
if ($hasStandard) {
    Write-Success "  [OK] VS Code Standard"
    if ($userDataPaths.Standard) {
        Write-Host "       User Data: $($userDataPaths.Standard)"
    }
} else {
    Write-Warn "  [--] VS Code Standard (not found)"
}

if ($hasInsiders) {
    Write-Success "  [OK] VS Code Insiders"
    if ($userDataPaths.Insiders) {
        Write-Host "       User Data: $($userDataPaths.Insiders)"
    }
} else {
    Write-Warn "  [--] VS Code Insiders (not found)"
}

if (-not $hasStandard -and -not $hasInsiders) {
    Write-Err "Error: No VS Code installation detected."
    Write-Host "Please install VS Code or VS Code Insiders first."
    exit 1
}
```

**Step 2: Run to verify detection works**

Run: `powershell -ExecutionPolicy Bypass -File .\installer\install.ps1 -WhatIf`
Expected: Shows detected VS Code installations with paths

**Step 3: Commit**

```bash
git add installer/install.ps1
git commit -m "feat(installer): add VS Code installation detection"
```

---

## Task 4: Write PowerShell Installer - Copy Functions

**Files:**
- Modify: `installer/install.ps1`

**Step 1: Add file copy functions**

Add after the detection output:

```powershell
# Get target installation paths based on scope
function Get-TargetPaths {
    param(
        [string]$Scope,
        [string]$VSCodeType,
        [string]$WorkspacePath,
        [hashtable]$UserDataPaths
    )

    $targets = @()

    switch ($Scope) {
        'Workspace' {
            # Install to current workspace .github folder
            $targets += @{
                Type = 'Workspace'
                Path = Join-Path $WorkspacePath ".github"
                Description = "Workspace: $WorkspacePath"
            }
        }
        'User' {
            # Install to VS Code user snippets/settings area
            if (($VSCodeType -eq 'Both' -or $VSCodeType -eq 'Standard') -and $UserDataPaths.Standard) {
                $targets += @{
                    Type = 'User-Standard'
                    Path = Join-Path $UserDataPaths.Standard "User\.github"
                    Description = "VS Code User Profile"
                }
            }
            if (($VSCodeType -eq 'Both' -or $VSCodeType -eq 'Insiders') -and $UserDataPaths.Insiders) {
                $targets += @{
                    Type = 'User-Insiders'
                    Path = Join-Path $UserDataPaths.Insiders "User\.github"
                    Description = "VS Code Insiders User Profile"
                }
            }
        }
        'Global' {
            # Install to global copilot settings location
            $globalPath = Join-Path $env:USERPROFILE ".github"
            $targets += @{
                Type = 'Global'
                Path = $globalPath
                Description = "Global: $globalPath"
            }
        }
    }

    return $targets
}

# Copy maestro files to target
function Install-MaestroFiles {
    param(
        [string]$SourcePath,
        [string]$TargetPath,
        [string]$Description,
        [switch]$WhatIf
    )

    Write-Host ""
    Write-Info "Installing to: $Description"
    Write-Host "  Target: $TargetPath"

    # Folders to copy
    $folders = @('agents', 'instructions', 'prompts', 'skills')

    foreach ($folder in $folders) {
        $source = Join-Path $SourcePath $folder
        $target = Join-Path $TargetPath $folder

        if (Test-Path $source) {
            if ($WhatIf) {
                Write-Host "  [WhatIf] Would copy: $folder\"
            } else {
                if (Test-Path $target) {
                    Remove-Item -Path $target -Recurse -Force
                }
                Copy-Item -Path $source -Destination $target -Recurse -Force
                Write-Success "  [OK] Copied: $folder\"
            }
        } else {
            Write-Warn "  [Skip] Not found: $folder\"
        }
    }

    # Copy copilot-instructions.md if it exists
    $copilotInstructions = Join-Path $SourcePath "copilot-instructions.md"
    $targetInstructions = Join-Path $TargetPath "copilot-instructions.md"

    if (Test-Path $copilotInstructions) {
        if ($WhatIf) {
            Write-Host "  [WhatIf] Would copy: copilot-instructions.md"
        } else {
            Copy-Item -Path $copilotInstructions -Destination $targetInstructions -Force
            Write-Success "  [OK] Copied: copilot-instructions.md"
        }
    }

    return $true
}
```

**Step 2: Run to verify functions load**

Run: `powershell -ExecutionPolicy Bypass -File .\installer\install.ps1 -WhatIf`
Expected: Script loads without errors (functions are defined but not yet called)

**Step 3: Commit**

```bash
git add installer/install.ps1
git commit -m "feat(installer): add target path resolution and file copy functions"
```

---

## Task 5: Write PowerShell Installer - Main Execution Logic

**Files:**
- Modify: `installer/install.ps1`

**Step 1: Add main execution logic at the end of the script**

```powershell
# Main execution
Write-Host ""
Write-Info "Installation Configuration:"
Write-Host "  Scope: $Scope"
Write-Host "  VS Code Type: $VSCodeType"
if ($Scope -eq 'Workspace') {
    Write-Host "  Workspace: $WorkspacePath"
}

# Filter based on VSCodeType parameter
if ($VSCodeType -eq 'Standard' -and -not $hasStandard) {
    Write-Err "Error: VS Code Standard requested but not installed."
    exit 1
}
if ($VSCodeType -eq 'Insiders' -and -not $hasInsiders) {
    Write-Err "Error: VS Code Insiders requested but not installed."
    exit 1
}

# Get target paths
$targets = Get-TargetPaths -Scope $Scope -VSCodeType $VSCodeType -WorkspacePath $WorkspacePath -UserDataPaths $userDataPaths

if ($targets.Count -eq 0) {
    Write-Err "Error: No valid installation targets found for scope '$Scope'."
    exit 1
}

# Perform installation
$successCount = 0
foreach ($target in $targets) {
    if ($PSCmdlet.ShouldProcess($target.Path, "Install Maestro files")) {
        $result = Install-MaestroFiles -SourcePath $SourceGitHub -TargetPath $target.Path -Description $target.Description
        if ($result) {
            $successCount++
        }
    } else {
        # WhatIf mode
        Install-MaestroFiles -SourcePath $SourceGitHub -TargetPath $target.Path -Description $target.Description -WhatIf
        $successCount++
    }
}

Write-Host ""
if ($WhatIfPreference -or $PSBoundParameters.ContainsKey('WhatIf')) {
    Write-Info "WhatIf: Would have installed to $successCount location(s)."
} else {
    Write-Success "Installation complete! Installed to $successCount location(s)."
}

Write-Host ""
Write-Info "Next steps:"
Write-Host "  1. Open VS Code in your workspace"
Write-Host "  2. Open GitHub Copilot Chat"
Write-Host "  3. Type '@' to see available agents (e.g., @maestro-conductor)"
Write-Host "  4. Use '/prompts' to see available prompts"
Write-Host ""
```

**Step 2: Test full installer in WhatIf mode**

Run: `powershell -ExecutionPolicy Bypass -File .\installer\install.ps1 -WhatIf`
Expected: Shows complete installation preview without copying files

**Step 3: Commit**

```bash
git add installer/install.ps1
git commit -m "feat(installer): add main execution logic with WhatIf support"
```

---

## Task 6: Write Bash Installer for Unix Systems

**Files:**
- Create: `installer/install.sh`

**Step 1: Create the bash installer script**

```bash
#!/bin/bash
# Maestro Installer for VS Code and VS Code Insiders
# Usage: ./install.sh [-s scope] [-t type] [-w workspace] [-n]
# Options:
#   -s scope    : workspace, user, global (default: workspace)
#   -t type     : both, standard, insiders (default: both)
#   -w workspace: path to workspace (default: current directory)
#   -n          : dry-run mode (show what would be done)

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Defaults
SCOPE="workspace"
VSCODE_TYPE="both"
WORKSPACE_PATH="$(pwd)"
DRY_RUN=false

# Parse arguments
while getopts "s:t:w:nh" opt; do
    case $opt in
        s) SCOPE="$OPTARG" ;;
        t) VSCODE_TYPE="$OPTARG" ;;
        w) WORKSPACE_PATH="$OPTARG" ;;
        n) DRY_RUN=true ;;
        h)
            echo "Usage: $0 [-s scope] [-t type] [-w workspace] [-n]"
            echo "Options:"
            echo "  -s scope    : workspace, user, global (default: workspace)"
            echo "  -t type     : both, standard, insiders (default: both)"
            echo "  -w workspace: path to workspace (default: current directory)"
            echo "  -n          : dry-run mode (show what would be done)"
            exit 0
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            exit 1
            ;;
    esac
done

echo -e "${CYAN}Maestro Installer for VS Code${NC}"
echo -e "${CYAN}==============================${NC}"
echo ""

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MAESTRO_ROOT="$(dirname "$SCRIPT_DIR")"

# Verify maestro source
SOURCE_GITHUB="$MAESTRO_ROOT/.github"
if [[ ! -d "$SOURCE_GITHUB" ]]; then
    echo -e "${RED}Error: Cannot find maestro .github directory at: $SOURCE_GITHUB${NC}"
    echo "Please run this installer from within the maestro repository."
    exit 1
fi

echo -e "${GREEN}Found maestro source at: $MAESTRO_ROOT${NC}"

# Detect OS and set paths
detect_vscode_paths() {
    HAS_STANDARD=false
    HAS_INSIDERS=false
    STANDARD_USER_DATA=""
    INSIDERS_USER_DATA=""

    case "$(uname -s)" in
        Darwin)
            # macOS
            if [[ -d "/Applications/Visual Studio Code.app" ]]; then
                HAS_STANDARD=true
                STANDARD_USER_DATA="$HOME/Library/Application Support/Code"
            fi
            if [[ -d "/Applications/Visual Studio Code - Insiders.app" ]]; then
                HAS_INSIDERS=true
                INSIDERS_USER_DATA="$HOME/Library/Application Support/Code - Insiders"
            fi
            ;;
        Linux)
            # Linux
            if command -v code &> /dev/null; then
                HAS_STANDARD=true
                STANDARD_USER_DATA="$HOME/.config/Code"
            fi
            if command -v code-insiders &> /dev/null; then
                HAS_INSIDERS=true
                INSIDERS_USER_DATA="$HOME/.config/Code - Insiders"
            fi
            ;;
        *)
            echo -e "${RED}Unsupported operating system. Use install.ps1 for Windows.${NC}"
            exit 1
            ;;
    esac
}

detect_vscode_paths

echo ""
echo -e "${CYAN}Detected VS Code Installations:${NC}"
if $HAS_STANDARD; then
    echo -e "  ${GREEN}[OK]${NC} VS Code Standard"
    [[ -n "$STANDARD_USER_DATA" ]] && echo "       User Data: $STANDARD_USER_DATA"
else
    echo -e "  ${YELLOW}[--]${NC} VS Code Standard (not found)"
fi

if $HAS_INSIDERS; then
    echo -e "  ${GREEN}[OK]${NC} VS Code Insiders"
    [[ -n "$INSIDERS_USER_DATA" ]] && echo "       User Data: $INSIDERS_USER_DATA"
else
    echo -e "  ${YELLOW}[--]${NC} VS Code Insiders (not found)"
fi

if ! $HAS_STANDARD && ! $HAS_INSIDERS; then
    echo -e "${RED}Error: No VS Code installation detected.${NC}"
    echo "Please install VS Code or VS Code Insiders first."
    exit 1
fi

# Copy function
install_maestro_files() {
    local target_path="$1"
    local description="$2"

    echo ""
    echo -e "${CYAN}Installing to: $description${NC}"
    echo "  Target: $target_path"

    # Create target directory
    if $DRY_RUN; then
        echo "  [DryRun] Would create: $target_path"
    else
        mkdir -p "$target_path"
    fi

    # Folders to copy
    local folders=("agents" "instructions" "prompts" "skills")

    for folder in "${folders[@]}"; do
        local source="$SOURCE_GITHUB/$folder"
        local target="$target_path/$folder"

        if [[ -d "$source" ]]; then
            if $DRY_RUN; then
                echo "  [DryRun] Would copy: $folder/"
            else
                rm -rf "$target" 2>/dev/null || true
                cp -r "$source" "$target"
                echo -e "  ${GREEN}[OK]${NC} Copied: $folder/"
            fi
        else
            echo -e "  ${YELLOW}[Skip]${NC} Not found: $folder/"
        fi
    done

    # Copy copilot-instructions.md
    local copilot_instructions="$SOURCE_GITHUB/copilot-instructions.md"
    if [[ -f "$copilot_instructions" ]]; then
        if $DRY_RUN; then
            echo "  [DryRun] Would copy: copilot-instructions.md"
        else
            cp "$copilot_instructions" "$target_path/copilot-instructions.md"
            echo -e "  ${GREEN}[OK]${NC} Copied: copilot-instructions.md"
        fi
    fi
}

# Main execution
echo ""
echo -e "${CYAN}Installation Configuration:${NC}"
echo "  Scope: $SCOPE"
echo "  VS Code Type: $VSCODE_TYPE"
[[ "$SCOPE" == "workspace" ]] && echo "  Workspace: $WORKSPACE_PATH"

SUCCESS_COUNT=0

case "$SCOPE" in
    workspace)
        install_maestro_files "$WORKSPACE_PATH/.github" "Workspace: $WORKSPACE_PATH"
        SUCCESS_COUNT=$((SUCCESS_COUNT + 1))
        ;;
    user)
        if [[ "$VSCODE_TYPE" == "both" || "$VSCODE_TYPE" == "standard" ]] && [[ -n "$STANDARD_USER_DATA" ]]; then
            install_maestro_files "$STANDARD_USER_DATA/User/.github" "VS Code User Profile"
            SUCCESS_COUNT=$((SUCCESS_COUNT + 1))
        fi
        if [[ "$VSCODE_TYPE" == "both" || "$VSCODE_TYPE" == "insiders" ]] && [[ -n "$INSIDERS_USER_DATA" ]]; then
            install_maestro_files "$INSIDERS_USER_DATA/User/.github" "VS Code Insiders User Profile"
            SUCCESS_COUNT=$((SUCCESS_COUNT + 1))
        fi
        ;;
    global)
        install_maestro_files "$HOME/.github" "Global: $HOME/.github"
        SUCCESS_COUNT=$((SUCCESS_COUNT + 1))
        ;;
esac

echo ""
if $DRY_RUN; then
    echo -e "${CYAN}Dry-run: Would have installed to $SUCCESS_COUNT location(s).${NC}"
else
    echo -e "${GREEN}Installation complete! Installed to $SUCCESS_COUNT location(s).${NC}"
fi

echo ""
echo -e "${CYAN}Next steps:${NC}"
echo "  1. Open VS Code in your workspace"
echo "  2. Open GitHub Copilot Chat"
echo "  3. Type '@' to see available agents (e.g., @maestro-conductor)"
echo "  4. Use '/prompts' to see available prompts"
echo ""
```

**Step 2: Make the script executable and test**

Run: `chmod +x installer/install.sh && ./installer/install.sh -n` (on Unix) or verify syntax with `bash -n installer/install.sh`
Expected: Dry-run shows installation preview (or syntax check passes)

**Step 3: Commit**

```bash
git add installer/install.sh
git commit -m "feat(installer): add bash installer for macOS and Linux"
```

---

## Task 7: Create Installer Documentation

**Files:**
- Create: `installer/README.md`

**Step 1: Write the installer README**

```markdown
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
| `User` | VS Code user profile | `%APPDATA%/Code/User/.github/` (Win) or `~/.config/Code/User/.github/` (Unix) |
| `Global` | All projects | `~/.github/` |

## Options

### PowerShell (Windows)

| Parameter | Values | Default | Description |
|-----------|--------|---------|-------------|
| `-Scope` | Workspace, User, Global | Workspace | Where to install |
| `-VSCodeType` | Both, Standard, Insiders | Both | Which VS Code to target |
| `-WorkspacePath` | path | Current dir | Workspace location |
| `-WhatIf` | switch | - | Preview mode |

### Bash (macOS/Linux)

| Flag | Values | Default | Description |
|------|--------|---------|-------------|
| `-s` | workspace, user, global | workspace | Where to install |
| `-t` | both, standard, insiders | both | Which VS Code to target |
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

# User profile (macOS/Linux)
rm -rf ~/.config/Code/User/.github

# Global
rm -rf ~/.github
```
```

**Step 2: Verify README renders correctly**

Run: Review the file manually or use a markdown previewer
Expected: All sections render correctly with proper formatting

**Step 3: Commit**

```bash
git add installer/README.md
git commit -m "docs(installer): add comprehensive README with usage examples"
```

---

## Task 8: Update Main README with Installer Reference

**Files:**
- Modify: `README.md`

**Step 1: Read current README**

Read the existing README.md to understand its structure.

**Step 2: Add installer section**

Add a new "Quick Installation" section near the top of the README after the introduction:

```markdown
## Quick Installation

### Automated Installer

```powershell
# Windows (PowerShell)
.\installer\install.ps1

# macOS / Linux
./installer/install.sh
```

See [installer/README.md](installer/README.md) for advanced options.

### Manual Installation

Copy the `.github` folder to your project:

```bash
cp -r .github /path/to/your/project/
```
```

**Step 3: Run to verify README is valid markdown**

Run: Review with markdown previewer
Expected: New section renders correctly

**Step 4: Commit**

```bash
git add README.md
git commit -m "docs: add quick installation section to main README"
```

---

## Task 9: Test Full Installation Flow - Windows

**Files:**
- Test: `installer/install.ps1`

**Step 1: Test dry-run mode**

Run: `powershell -ExecutionPolicy Bypass -File .\installer\install.ps1 -WhatIf`
Expected: Shows all files that would be copied without making changes

**Step 2: Test actual workspace installation**

Run: `powershell -ExecutionPolicy Bypass -File .\installer\install.ps1 -WorkspacePath "$env:TEMP\test-workspace"`
Expected: Creates `.github` folder with all agents, instructions, prompts, skills

**Step 3: Verify installed files**

Run: `Get-ChildItem "$env:TEMP\test-workspace\.github" -Recurse | Select-Object FullName`
Expected: Lists all installed files matching source structure

**Step 4: Clean up test**

Run: `Remove-Item "$env:TEMP\test-workspace" -Recurse -Force`

**Step 5: Commit test verification**

No code changes needed - this is a verification step.

---

## Task 10: Add Interactive Mode to PowerShell Installer

**Files:**
- Modify: `installer/install.ps1`

**Step 1: Add interactive prompts when no parameters provided**

Add this block after the parameter validation, before detection:

```powershell
# Interactive mode if no parameters provided
$isInteractive = -not $PSBoundParameters.ContainsKey('Scope') -and
                 -not $PSBoundParameters.ContainsKey('VSCodeType') -and
                 -not $WhatIfPreference

if ($isInteractive -and $Host.UI.SupportsVirtualTerminal) {
    Write-Host ""
    Write-Info "Running in interactive mode. Use -Scope and -VSCodeType to skip prompts."
    Write-Host ""

    # Prompt for scope
    Write-Host "Where would you like to install Maestro?"
    Write-Host "  [1] Workspace - Current project only (recommended)"
    Write-Host "  [2] User - VS Code user profile"
    Write-Host "  [3] Global - All projects (~/.github)"
    Write-Host ""
    $scopeChoice = Read-Host "Enter choice (1-3, default=1)"

    switch ($scopeChoice) {
        '2' { $Scope = 'User' }
        '3' { $Scope = 'Global' }
        default { $Scope = 'Workspace' }
    }

    # Prompt for VS Code type
    Write-Host ""
    Write-Host "Which VS Code installation(s) to target?"
    Write-Host "  [1] Both Standard and Insiders"
    Write-Host "  [2] Standard only"
    Write-Host "  [3] Insiders only"
    Write-Host ""
    $typeChoice = Read-Host "Enter choice (1-3, default=1)"

    switch ($typeChoice) {
        '2' { $VSCodeType = 'Standard' }
        '3' { $VSCodeType = 'Insiders' }
        default { $VSCodeType = 'Both' }
    }

    Write-Host ""
}
```

**Step 2: Test interactive mode**

Run: `powershell -ExecutionPolicy Bypass -File .\installer\install.ps1`
Expected: Prompts for scope and VS Code type selections

**Step 3: Commit**

```bash
git add installer/install.ps1
git commit -m "feat(installer): add interactive mode for user-friendly installation"
```

---

## Task 11: Final Integration Test and Polish

**Files:**
- Review: All installer files

**Step 1: Run full test suite**

```powershell
# Test 1: Dry-run workspace
.\installer\install.ps1 -WhatIf

# Test 2: Dry-run global
.\installer\install.ps1 -Scope Global -WhatIf

# Test 3: Dry-run user (Insiders only)
.\installer\install.ps1 -Scope User -VSCodeType Insiders -WhatIf
```

Expected: All three tests complete without errors and show appropriate preview output

**Step 2: Verify no linting issues**

Run: Review code for any obvious issues or typos
Expected: Code is clean and follows PowerShell/Bash best practices

**Step 3: Final commit**

```bash
git add -A
git commit -m "feat(installer): complete automated installer for VS Code and VS Code Insiders

- PowerShell installer for Windows with interactive mode
- Bash installer for macOS and Linux
- Support for workspace, user, and global scopes
- Target Standard, Insiders, or both VS Code versions
- Dry-run/WhatIf mode for safe preview
- Comprehensive documentation

Closes #installer"
```

---

## Summary

This plan creates a complete automated installer with:

1. **PowerShell script** (`install.ps1`) for Windows
2. **Bash script** (`install.sh`) for macOS/Linux
3. **Three installation scopes**: Workspace, User profile, Global
4. **VS Code targeting**: Standard, Insiders, or both
5. **Safe preview mode**: -WhatIf (PowerShell) or -n (Bash)
6. **Interactive mode**: Prompts when run without parameters
7. **Comprehensive documentation**: README with examples

Total tasks: 11
Estimated commits: 11 (one per task)
