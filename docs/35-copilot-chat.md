# Copilot Chat Configuration

## Custom Instructions

VS Code Copilot supports [custom instructions](https://code.visualstudio.com/docs/copilot/copilot-customization) to define project-specific coding conventions and patterns.

### Instruction Files

The toolkit provides instruction files in `copilot/instructions/` that Copilot auto-discovers:
- `general.instructions.md` - General coding conventions
- `typescript.instructions.md` - TypeScript-specific guidance
- `angular.instructions.md` - Angular patterns
- `dotnet.instructions.md` - .NET conventions
- `testing.instructions.md` - Testing standards
- `security.instructions.md` - Security guidelines

### Using Instructions

Custom instructions are automatically applied when placed in:
- `.github/copilot-instructions.md` (project-wide)
- Individual instruction files with `applyTo` patterns

## Custom Agents

VS Code supports [custom agents](https://code.visualstudio.com/docs/copilot/copilot-customization#_custom-agents) for different workflows. See `copilot/agents/` for agent definitions that can be adapted for your team.

## Chat Best Practices

### Be Specific
```
Bad:  "Fix this code"
Good: "This function throws null reference exceptions. Add null checks and proper error handling."
```

### Provide Context
```
"I'm working on an Angular 17 application using signals for state management.
Help me refactor this component to use the new control flow syntax."
```

### Request Formats
```
"Provide your response as:
1. Summary of the issue
2. Proposed solution
3. Code changes with explanations"
```

## Integration with Prompt Library

Chat sessions can reference prompts from the library:
```
Use the bugfix prompt template to help me diagnose this issue.
```

See [Prompts Documentation](50-prompts.md) for available prompts.
