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

    # Ensure target directory exists
    if (-not $WhatIf) {
        if (-not (Test-Path $TargetPath)) {
            New-Item -ItemType Directory -Path $TargetPath -Force | Out-Null
        }
    }

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
        $null = Install-MaestroFiles -SourcePath $SourceGitHub -TargetPath $target.Path -Description $target.Description -WhatIf
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
