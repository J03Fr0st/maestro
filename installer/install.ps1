# installer/install.ps1
# Maestro Installer for VS Code and VS Code Insiders
# Usage: .\install.ps1 [-Scope <Workspace|User|Global>] [-VSCodeType <Both|Standard|Insiders>] [-WhatIf]

[CmdletBinding(SupportsShouldProcess)]
param(
    [ValidateSet('Workspace', 'User', 'Global')]
    [string]$Scope = 'Workspace',

    [ValidateSet('Both', 'Standard', 'Insiders')]
    [string]$VSCodeType = 'Both',

    [string]$WorkspacePath = (Get-Location).Path,

    [string]$ProfileId = ''
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

    # If User scope, prompt for profile selection
    if ($Scope -eq 'User') {
        $allProfiles = @()

        if (($VSCodeType -eq 'Both' -or $VSCodeType -eq 'Standard') -and $userDataPaths.Standard) {
            $standardProfiles = Get-VSCodeProfiles -UserDataPath $userDataPaths.Standard
            foreach ($p in $standardProfiles) {
                $p.VSCodeType = 'Standard'
                $allProfiles += $p
            }
        }

        if (($VSCodeType -eq 'Both' -or $VSCodeType -eq 'Insiders') -and $userDataPaths.Insiders) {
            $insidersProfiles = Get-VSCodeProfiles -UserDataPath $userDataPaths.Insiders
            foreach ($p in $insidersProfiles) {
                $p.VSCodeType = 'Insiders'
                $p.Name = "$($p.Name) (Insiders)"
                $allProfiles += $p
            }
        }

        if ($allProfiles.Count -gt 1) {
            Write-Host ""
            Write-Host "Available VS Code profiles:"
            for ($i = 0; $i -lt $allProfiles.Count; $i++) {
                $profile = $allProfiles[$i]
                $marker = if ($profile.Id -eq 'default') { ' (default)' } else { '' }
                Write-Host "  [$($i + 1)] $($profile.Name)$marker"
                Write-Host "       ID: $($profile.Id)"
            }
            Write-Host "  [A] All profiles"
            Write-Host ""
            $profileChoice = Read-Host "Enter choice (1-$($allProfiles.Count) or A, default=1)"

            if ($profileChoice -eq 'A' -or $profileChoice -eq 'a') {
                $ProfileId = 'all'
            } elseif ($profileChoice -match '^\d+$' -and [int]$profileChoice -ge 1 -and [int]$profileChoice -le $allProfiles.Count) {
                $selectedProfile = $allProfiles[[int]$profileChoice - 1]
                $ProfileId = $selectedProfile.Id
                $VSCodeType = $selectedProfile.VSCodeType
            } else {
                $ProfileId = 'default'
            }
        }
    }

    Write-Host ""
}

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

# Detect VS Code profiles
function Get-VSCodeProfiles {
    param(
        [string]$UserDataPath
    )

    $profiles = @()

    # Default profile (User folder directly)
    $defaultPromptsPath = Join-Path $UserDataPath "User\prompts"
    $profiles += @{
        Id = 'default'
        Name = 'Default Profile'
        PromptsPath = $defaultPromptsPath
        InstructionsPath = Join-Path $UserDataPath "User\instructions"
    }

    # Check for additional profiles
    $profilesDir = Join-Path $UserDataPath "User\profiles"
    if (Test-Path $profilesDir) {
        $profileFolders = Get-ChildItem -Path $profilesDir -Directory
        foreach ($folder in $profileFolders) {
            # Try to get profile name from profile.json if it exists
            $profileName = $folder.Name
            $profileJson = Join-Path $folder.FullName "profile.json"
            if (Test-Path $profileJson) {
                try {
                    $profileData = Get-Content $profileJson -Raw | ConvertFrom-Json
                    if ($profileData.name) {
                        $profileName = $profileData.name
                    }
                } catch {
                    # Ignore JSON parsing errors
                }
            }

            $profiles += @{
                Id = $folder.Name
                Name = $profileName
                PromptsPath = Join-Path $folder.FullName "prompts"
                InstructionsPath = Join-Path $folder.FullName "instructions"
            }
        }
    }

    return $profiles
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
        [hashtable]$UserDataPaths,
        [string]$ProfileId
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
            # Install to VS Code user prompts folder (where VS Code stores user-level agents)
            # Handle profile selection
            if (($VSCodeType -eq 'Both' -or $VSCodeType -eq 'Standard') -and $UserDataPaths.Standard) {
                $profiles = Get-VSCodeProfiles -UserDataPath $UserDataPaths.Standard
                foreach ($profile in $profiles) {
                    if ($ProfileId -eq 'all' -or $ProfileId -eq '' -or $ProfileId -eq $profile.Id) {
                        $targets += @{
                            Type = 'User-Standard'
                            Path = $profile.PromptsPath
                            InstructionsPath = $profile.InstructionsPath
                            Description = "VS Code Profile: $($profile.Name)"
                            ProfileId = $profile.Id
                            IsUserScope = $true
                        }
                        # If specific profile selected (not 'all'), only add that one
                        if ($ProfileId -ne 'all' -and $ProfileId -ne '') {
                            break
                        }
                    }
                }
            }
            if (($VSCodeType -eq 'Both' -or $VSCodeType -eq 'Insiders') -and $UserDataPaths.Insiders) {
                $profiles = Get-VSCodeProfiles -UserDataPath $UserDataPaths.Insiders
                foreach ($profile in $profiles) {
                    if ($ProfileId -eq 'all' -or $ProfileId -eq '' -or $ProfileId -eq $profile.Id) {
                        $targets += @{
                            Type = 'User-Insiders'
                            Path = $profile.PromptsPath
                            InstructionsPath = $profile.InstructionsPath
                            Description = "VS Code Insiders Profile: $($profile.Name)"
                            ProfileId = $profile.Id
                            IsUserScope = $true
                        }
                        # If specific profile selected (not 'all'), only add that one
                        if ($ProfileId -ne 'all' -and $ProfileId -ne '') {
                            break
                        }
                    }
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
        [switch]$IsUserScope,
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

    if ($IsUserScope) {
        # For User scope: copy agent and prompt files directly to prompts folder (flat structure)
        $totalCount = 0

        # Copy agents
        $agentsSource = Join-Path $SourcePath "agents"
        if (Test-Path $agentsSource) {
            $agentFiles = Get-ChildItem -Path $agentsSource -Filter "*.agent.md"
            foreach ($file in $agentFiles) {
                $targetFile = Join-Path $TargetPath $file.Name
                if ($WhatIf) {
                    Write-Host "  [WhatIf] Would copy: $($file.Name)"
                } else {
                    Copy-Item -Path $file.FullName -Destination $targetFile -Force
                    Write-Success "  [OK] Copied: $($file.Name)"
                }
            }
            $totalCount += $agentFiles.Count
            Write-Host "  Found $($agentFiles.Count) agent(s)"
        }

        # Copy prompts
        $promptsSource = Join-Path $SourcePath "prompts"
        if (Test-Path $promptsSource) {
            $promptFiles = Get-ChildItem -Path $promptsSource -Filter "*.prompt.md"
            foreach ($file in $promptFiles) {
                $targetFile = Join-Path $TargetPath $file.Name
                if ($WhatIf) {
                    Write-Host "  [WhatIf] Would copy: $($file.Name)"
                } else {
                    Copy-Item -Path $file.FullName -Destination $targetFile -Force
                    Write-Success "  [OK] Copied: $($file.Name)"
                }
            }
            $totalCount += $promptFiles.Count
            Write-Host "  Found $($promptFiles.Count) prompt(s)"
        }

        # Copy instructions
        $instructionsSource = Join-Path $SourcePath "instructions"
        if (Test-Path $instructionsSource) {
            $instructionFiles = Get-ChildItem -Path $instructionsSource -Filter "*.instructions.md"
            foreach ($file in $instructionFiles) {
                $targetFile = Join-Path $TargetPath $file.Name
                if ($WhatIf) {
                    Write-Host "  [WhatIf] Would copy: $($file.Name)"
                } else {
                    Copy-Item -Path $file.FullName -Destination $targetFile -Force
                    Write-Success "  [OK] Copied: $($file.Name)"
                }
            }
            $totalCount += $instructionFiles.Count
            Write-Host "  Found $($instructionFiles.Count) instruction(s)"
        }

        Write-Host "  Total: $totalCount file(s) copied to VS Code prompts folder"

        # Copy skills to ~/.copilot/skills/
        $skillsSource = Join-Path $SourcePath "skills"
        $skillsTarget = Join-Path $env:USERPROFILE ".copilot\skills"
        if (Test-Path $skillsSource) {
            Write-Host ""
            Write-Info "Installing skills to: $skillsTarget"

            if (-not $WhatIf) {
                if (-not (Test-Path $skillsTarget)) {
                    New-Item -ItemType Directory -Path $skillsTarget -Force | Out-Null
                }
            }

            $skillFolders = Get-ChildItem -Path $skillsSource -Directory
            foreach ($skill in $skillFolders) {
                $targetSkill = Join-Path $skillsTarget $skill.Name
                if ($WhatIf) {
                    Write-Host "  [WhatIf] Would copy: $($skill.Name)\"
                } else {
                    if (Test-Path $targetSkill) {
                        Remove-Item -Path $targetSkill -Recurse -Force
                    }
                    Copy-Item -Path $skill.FullName -Destination $targetSkill -Recurse -Force
                    Write-Success "  [OK] Copied: $($skill.Name)\"
                }
            }
            Write-Host "  Found $($skillFolders.Count) skill(s)"
        }
    } else {
        # For Workspace/Global scope: copy full folder structure
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
$targets = Get-TargetPaths -Scope $Scope -VSCodeType $VSCodeType -WorkspacePath $WorkspacePath -UserDataPaths $userDataPaths -ProfileId $ProfileId

if ($targets.Count -eq 0) {
    Write-Err "Error: No valid installation targets found for scope '$Scope'."
    exit 1
}

# Perform installation
$successCount = 0
foreach ($target in $targets) {
    $isUserScope = $target.IsUserScope -eq $true
    if ($PSCmdlet.ShouldProcess($target.Path, "Install Maestro files")) {
        $result = Install-MaestroFiles -SourcePath $SourceGitHub -TargetPath $target.Path -Description $target.Description -IsUserScope:$isUserScope
        if ($result) {
            $successCount++
        }
    } else {
        # WhatIf mode
        $null = Install-MaestroFiles -SourcePath $SourceGitHub -TargetPath $target.Path -Description $target.Description -IsUserScope:$isUserScope -WhatIf
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
