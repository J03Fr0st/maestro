# Copilot Instructions

This file provides repository-level instructions for GitHub Copilot.

## Project Overview

This is a [describe your project type] project using:
- **Frontend**: [Angular/React/Vue] with TypeScript
- **Backend**: [.NET/Node.js] with [framework]
- **Database**: [SQL Server/PostgreSQL/MongoDB]

## Coding Standards

### General
- Use TypeScript strict mode
- Prefer `const` over `let`, never use `var`
- Use meaningful variable and function names
- Keep functions small and focused (single responsibility)
- Write self-documenting code; add comments only when necessary

### TypeScript/JavaScript
- Use ES6+ features (arrow functions, destructuring, template literals)
- Prefer `interface` over `type` for object shapes
- Use `unknown` instead of `any` when type is truly unknown
- Handle all promise rejections
- Use optional chaining (`?.`) and nullish coalescing (`??`)

### Angular (if applicable)
- Use standalone components
- Use signals for state management
- Use the new control flow syntax (`@if`, `@for`, `@switch`)
- Inject dependencies using `inject()` function
- Keep components small and focused

### C# (if applicable)
- Use file-scoped namespaces
- Use records for DTOs
- Use primary constructors where appropriate
- Follow async/await patterns consistently
- Use nullable reference types

## File Structure

```
src/
  app/           # Angular application code
    features/    # Feature modules
    shared/      # Shared components, services, utilities
    core/        # Core services, guards, interceptors
  api/           # Backend API code
    Controllers/ # API controllers
    Services/    # Business logic
    Models/      # Domain models and DTOs
```

## Testing Requirements

- Write unit tests for business logic
- Use descriptive test names: `MethodName_Scenario_ExpectedResult`
- Follow Arrange-Act-Assert pattern
- Mock external dependencies
- Aim for meaningful coverage, not 100%

## Git Conventions

### Commit Messages
Use conventional commits format:
- `feat:` New feature
- `fix:` Bug fix
- `refactor:` Code refactoring
- `test:` Adding tests
- `docs:` Documentation
- `chore:` Maintenance

Example: `feat: add user authentication endpoint`

### Pull Requests
- Keep PRs small and focused
- Include description of changes
- Link related issues
- Ensure all tests pass

## Do Not

- Never commit secrets, tokens, or credentials
- Don't use `console.log` in production code (use proper logging)
- Avoid `any` type in TypeScript
- Don't ignore linting errors
- Never commit code that doesn't compile
