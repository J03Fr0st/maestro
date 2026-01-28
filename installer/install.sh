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

# Copy function for workspace/global scope (full folder structure)
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

# Copy function for user scope (flat agent and prompt files to prompts folder)
install_maestro_user_files() {
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

    local total_count=0

    # Copy agent files
    local agents_source="$SOURCE_GITHUB/agents"
    local agent_count=0
    if [[ -d "$agents_source" ]]; then
        for agent_file in "$agents_source"/*.agent.md; do
            if [[ -f "$agent_file" ]]; then
                local filename=$(basename "$agent_file")
                if $DRY_RUN; then
                    echo "  [DryRun] Would copy: $filename"
                else
                    cp "$agent_file" "$target_path/$filename"
                    echo -e "  ${GREEN}[OK]${NC} Copied: $filename"
                fi
                agent_count=$((agent_count + 1))
            fi
        done
        echo "  Found $agent_count agent(s)"
        total_count=$((total_count + agent_count))
    fi

    # Copy prompt files
    local prompts_source="$SOURCE_GITHUB/prompts"
    local prompt_count=0
    if [[ -d "$prompts_source" ]]; then
        for prompt_file in "$prompts_source"/*.prompt.md; do
            if [[ -f "$prompt_file" ]]; then
                local filename=$(basename "$prompt_file")
                if $DRY_RUN; then
                    echo "  [DryRun] Would copy: $filename"
                else
                    cp "$prompt_file" "$target_path/$filename"
                    echo -e "  ${GREEN}[OK]${NC} Copied: $filename"
                fi
                prompt_count=$((prompt_count + 1))
            fi
        done
        echo "  Found $prompt_count prompt(s)"
        total_count=$((total_count + prompt_count))
    fi

    # Copy instruction files
    local instructions_source="$SOURCE_GITHUB/instructions"
    local instruction_count=0
    if [[ -d "$instructions_source" ]]; then
        for instruction_file in "$instructions_source"/*.instructions.md; do
            if [[ -f "$instruction_file" ]]; then
                local filename=$(basename "$instruction_file")
                if $DRY_RUN; then
                    echo "  [DryRun] Would copy: $filename"
                else
                    cp "$instruction_file" "$target_path/$filename"
                    echo -e "  ${GREEN}[OK]${NC} Copied: $filename"
                fi
                instruction_count=$((instruction_count + 1))
            fi
        done
        echo "  Found $instruction_count instruction(s)"
        total_count=$((total_count + instruction_count))
    fi

    echo "  Total: $total_count file(s) copied to VS Code prompts folder"

    # Copy skills to ~/.copilot/skills/
    local skills_source="$SOURCE_GITHUB/skills"
    local skills_target="$HOME/.copilot/skills"
    if [[ -d "$skills_source" ]]; then
        echo ""
        echo -e "${CYAN}Installing skills to: $skills_target${NC}"

        if ! $DRY_RUN; then
            mkdir -p "$skills_target"
        fi

        local skill_count=0
        for skill_dir in "$skills_source"/*/; do
            if [[ -d "$skill_dir" ]]; then
                local skill_name=$(basename "$skill_dir")
                local target_skill="$skills_target/$skill_name"
                if $DRY_RUN; then
                    echo "  [DryRun] Would copy: $skill_name/"
                else
                    rm -rf "$target_skill" 2>/dev/null || true
                    cp -r "$skill_dir" "$target_skill"
                    echo -e "  ${GREEN}[OK]${NC} Copied: $skill_name/"
                fi
                skill_count=$((skill_count + 1))
            fi
        done
        echo "  Found $skill_count skill(s)"
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
            install_maestro_user_files "$STANDARD_USER_DATA/User/prompts" "VS Code User Profile"
            SUCCESS_COUNT=$((SUCCESS_COUNT + 1))
        fi
        if [[ "$VSCODE_TYPE" == "both" || "$VSCODE_TYPE" == "insiders" ]] && [[ -n "$INSIDERS_USER_DATA" ]]; then
            install_maestro_user_files "$INSIDERS_USER_DATA/User/prompts" "VS Code Insiders User Profile"
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
