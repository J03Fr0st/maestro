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
