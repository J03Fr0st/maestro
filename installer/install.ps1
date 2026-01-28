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
