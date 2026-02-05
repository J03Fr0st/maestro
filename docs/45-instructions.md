# Custom Instructions

## Overview

Custom instructions define guidelines that automatically influence how GitHub Copilot generates code and handles development tasks. They ensure consistent AI responses aligned with your coding practices and project requirements.

Instructions are stored in `copilot/instructions/`. Copy them to `.github/instructions/` in your project for auto-discovery.

## File Types

VS Code supports three types of instruction files:

| Type | File | Purpose |
|------|------|---------|
| **Repository Instructions** | `.github/copilot-instructions.md` | Single file applying to all chat requests |
| **Conditional Instructions** | `*.instructions.md` | Multiple files with glob-based targeting |
| **Agent Instructions** | `AGENTS.md` | Multi-agent workspace configurations |

## Available Instructions

| File | Scope | Description |
|------|-------|-------------|
| `general.instructions.md` | `**` | General coding conventions and response style |
| `typescript.instructions.md` | `**/*.ts` | TypeScript patterns and best practices |
| `angular.instructions.md` | `**/*.component.ts` | Angular framework conventions |
| `dotnet.instructions.md` | `**/*.cs` | .NET and C# development guidelines |
| `testing.instructions.md` | `**/*.spec.ts` | Testing standards and patterns |
| `security.instructions.md` | `**` | Security-focused coding guidelines |
| `agents.instructions.md` | `**/*.agent.md` | Agent file creation guidelines |
| `instructions.instructions.md` | `**/*.instructions.md` | Instruction file creation guidelines |
| `prompts.instructions.md` | `**/*.prompt.md` | Prompt file creation guidelines |

## Instruction File Format

Instructions use Markdown with optional YAML frontmatter:

```markdown
---
applyTo: "**/*.ts"
---

# TypeScript Guidelines

## Code Style
- Use strict mode
- Prefer interfaces over types
- Use meaningful variable names

## Error Handling
- Always handle async errors
- Use custom error classes
- Log errors with context

## Avoid
- `any` type
- Implicit returns in multi-line functions
- Magic numbers
```

## Frontmatter Fields

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `name` | string | No | Display name in UI |
| `description` | string | No | Short summary |
| `applyTo` | string | No | Glob pattern for targeted application |

### Glob Pattern Examples

```yaml
# Apply to all files
applyTo: "**"

# Apply to TypeScript files only
applyTo: "**/*.ts"

# Apply to test files
applyTo: "**/*.{spec,test}.ts"

# Apply to specific directory
applyTo: "src/components/**/*.tsx"

# Multiple patterns (use separate files)
# Create typescript.instructions.md with applyTo: "**/*.ts"
# Create react.instructions.md with applyTo: "**/*.tsx"
```

## Creating Instructions

### Via Chat Interface

1. Select **Configure Chat** (gear icon) > **Chat Instructions**
2. Choose **New instruction file**
3. Pick location: Workspace (`.github/instructions`) or User profile
4. Enter file name and write instructions

### Via Command Palette

1. Open Command Palette (Ctrl+Shift+P / Cmd+Shift+P)
2. Run "Chat: New Instructions File" or "Chat: Configure Instructions"
3. Follow the prompts

### Via File Creation

1. Create a file with `.instructions.md` extension
2. Add YAML frontmatter with `applyTo` pattern
3. Write guidelines in Markdown

## Storage Locations

| Type | Location | Scope |
|------|----------|-------|
| Workspace instructions | `.github/instructions/` | Current workspace |
| User instructions | VS Code profile folder | All workspaces |
| Root instructions | `.github/copilot-instructions.md` | Entire workspace |

## How Instructions Apply

### Automatic Application

Instructions automatically apply based on:
- **File type matching**: Via `applyTo` glob patterns
- **File location**: Instructions in workspace root apply globally
- **Workspace root declarations**: `AGENTS.md` file scope

### Manual Application

Add instructions to specific prompts via:
1. Open Chat view
2. Click "Add Context"
3. Select "Instructions"
4. Choose the instruction file

## Configuration Settings

For specialized scenarios, use VS Code settings:

```json
{
  "github.copilot.chat.reviewSelection.instructions": {
    "text": "Focus on security and performance issues"
  },
  "github.copilot.chat.commitMessageGeneration.instructions": {
    "file": ".github/commit-instructions.md"
  },
  "github.copilot.chat.pullRequestDescriptionGeneration.instructions": {
    "text": "Include testing checklist and breaking changes"
  }
}
```

Settings accept:
- `text`: Inline instruction text
- `file`: Path to external instruction file

## Example Instructions

### General Coding Guidelines

```markdown
---
applyTo: "**"
---

# Code Generation Guidelines

## Response Style
- Be concise and provide focused responses
- Use code examples over lengthy descriptions
- If unsure, say so rather than guessing

## Code Quality
- Generate production-ready code with error handling
- Follow existing patterns in the codebase
- Include type annotations
- Use meaningful variable names

## Avoid
- Placeholder comments like `// TODO: implement`
- Incomplete implementations
- Hardcoded values that should be configurable
- Changes outside the scope of the request
```

### TypeScript Specific

```markdown
---
applyTo: "**/*.ts"
---

# TypeScript Standards

## Types
- Use explicit return types for public functions
- Prefer interfaces for object shapes
- Use generics for reusable components
- Avoid `any` - use `unknown` if type is uncertain

## Patterns
- Use async/await over raw promises
- Prefer immutable data structures
- Use destructuring for cleaner code

## Naming
- PascalCase for types and interfaces
- camelCase for variables and functions
- SCREAMING_SNAKE_CASE for constants
```

### Security Guidelines

```markdown
---
applyTo: "**"
---

# Security Requirements

## Input Validation
- Validate all external input
- Use parameterized queries for database operations
- Sanitize user input before rendering

## Authentication
- Never store passwords in plain text
- Use secure session management
- Implement proper token expiration

## Data Handling
- Encrypt sensitive data at rest
- Use HTTPS for all external communications
- Never log sensitive information
```

## Best Practices

### Keep Instructions Concise
- Focus on the most important guidelines
- Avoid overwhelming the AI with too many rules

### Use Multiple Files
- Create separate instruction files for different concerns
- Use glob patterns to target specific file types

### Share Project Instructions
- Store instructions in `.github/instructions/` for team sharing
- Use version control to track changes

### Reference in Prompts
- Link to instruction files from prompts to avoid duplication
- Use Markdown links: `[coding standards](../instructions/general.instructions.md)`

## Limitations

- Custom instructions do NOT apply to inline code suggestions
- Only apply to chat requests and AI-assisted operations
- Files without `applyTo` require manual attachment
- No guaranteed order when multiple files apply

## Troubleshooting

### Instructions Not Applying?

1. **Check file location**: Verify it's in `.github/instructions/`
2. **Check glob pattern**: Ensure `applyTo` matches your files
3. **Check settings**: Verify `useInstructionFiles` is enabled
4. **Check debug logs**: Open Chat Debug view for request logs

### Auto-Generate Instructions

Use the "Generate Chat Instructions" command to create `.github/copilot-instructions.md` based on existing code patterns in your workspace.
