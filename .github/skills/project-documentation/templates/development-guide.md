# {PROJECT_NAME} - Development Guide

**Date:** {DATE}

## Prerequisites

### Required Software

| Software | Version | Purpose |
|----------|---------|---------|
| {RUNTIME} | {VERSION}+ | Runtime environment |
| {PACKAGE_MANAGER} | {VERSION}+ | Package management |
| {TOOL} | {VERSION}+ | {PURPOSE} |

### Recommended Tools

- **IDE:** VS Code with {EXTENSION_RECOMMENDATIONS}
- **Git:** Version 2.30+
- **Terminal:** Any modern terminal

### System Requirements

- OS: {SUPPORTED_OS}
- RAM: {MIN_RAM} minimum
- Disk: {DISK_SPACE} free space

---

## Getting Started

### 1. Clone Repository

```bash
git clone {REPO_URL}
cd {PROJECT_NAME}
```

### 2. Install Dependencies

```bash
{INSTALL_COMMAND}
```

### 3. Configure Environment

```bash
# Copy environment template
cp .env.example .env

# Edit with your values
{EDITOR} .env
```

**Required Environment Variables:**

| Variable | Description | Example |
|----------|-------------|---------|
| `{VAR_NAME}` | {DESCRIPTION} | `{EXAMPLE}` |

### 4. Run Development Server

```bash
{DEV_COMMAND}
```

Application available at: `http://localhost:{PORT}`

---

## Development Workflow

### Starting Development

```bash
# Start dev server with hot reload
{DEV_COMMAND}

# Or with specific options
{DEV_COMMAND_WITH_OPTIONS}
```

### Running Tests

```bash
# Run all tests
{TEST_COMMAND}

# Run specific test file
{TEST_SPECIFIC_COMMAND}

# Run with coverage
{TEST_COVERAGE_COMMAND}

# Run in watch mode
{TEST_WATCH_COMMAND}
```

### Building

```bash
# Development build
{BUILD_DEV_COMMAND}

# Production build
{BUILD_PROD_COMMAND}

# Type checking only
{TYPECHECK_COMMAND}
```

### Linting & Formatting

```bash
# Check lint issues
{LINT_COMMAND}

# Fix lint issues
{LINT_FIX_COMMAND}

# Format code
{FORMAT_COMMAND}
```

---

## Project Structure

```
{PROJECT_NAME}/
├── src/           # Source code
├── tests/         # Test files
├── dist/          # Build output
├── docs/          # Documentation
└── ...
```

See [Source Tree Analysis](./source-tree-analysis.md) for detailed structure.

---

## Key Commands Reference

| Command | Description |
|---------|-------------|
| `{CMD_1}` | {DESC_1} |
| `{CMD_2}` | {DESC_2} |
| `{CMD_3}` | {DESC_3} |
| `{CMD_4}` | {DESC_4} |
| `{CMD_5}` | {DESC_5} |

---

## Common Tasks

### Adding a New Feature

1. Create feature branch: `git checkout -b feature/{name}`
2. Add source files in appropriate directory
3. Add tests in `tests/`
4. Update types if needed
5. Run tests: `{TEST_COMMAND}`
6. Run linting: `{LINT_COMMAND}`
7. Commit and push

### Adding a New Dependency

```bash
# Production dependency
{ADD_DEP_COMMAND}

# Development dependency
{ADD_DEV_DEP_COMMAND}
```

### Updating Dependencies

```bash
# Check for updates
{CHECK_UPDATES_COMMAND}

# Update all
{UPDATE_COMMAND}
```

### Running Database Migrations (if applicable)

```bash
# Run migrations
{MIGRATE_COMMAND}

# Create new migration
{CREATE_MIGRATION_COMMAND}

# Rollback
{ROLLBACK_COMMAND}
```

---

## Testing Guide

### Test Structure

```
tests/
├── unit/           # Unit tests
├── integration/    # Integration tests
├── __mocks__/      # Mock implementations
└── setup.ts        # Test configuration
```

### Writing Tests

```typescript
// Example unit test
import { describe, it, expect } from '{TEST_FRAMEWORK}';
import { myFunction } from '../src/module';

describe('myFunction', () => {
  it('should return expected result', () => {
    const result = myFunction(input);
    expect(result).toEqual(expected);
  });
});
```

### Mocking

```typescript
// Mock external dependencies
import { mock } from '{MOCK_LIBRARY}';

const mockDependency = mock<DependencyType>();
mockDependency.method.mockReturnValue(value);
```

### Test Coverage

Target coverage levels:
- Statements: {STATEMENTS_TARGET}%
- Branches: {BRANCHES_TARGET}%
- Functions: {FUNCTIONS_TARGET}%
- Lines: {LINES_TARGET}%

---

## Debugging

### VS Code Launch Configurations

The project includes debug configurations in `.vscode/launch.json`:

- **Debug Application** - Start with debugger attached
- **Debug Tests** - Debug test files
- **Debug Current File** - Debug active file

### Debug Commands

```bash
# Run with debug logging
{DEBUG_COMMAND}

# Run with Node inspector
{INSPECT_COMMAND}
```

### Common Issues

| Issue | Solution |
|-------|----------|
| {ISSUE_1} | {SOLUTION_1} |
| {ISSUE_2} | {SOLUTION_2} |
| {ISSUE_3} | {SOLUTION_3} |

---

## Code Style

### Style Guide

This project follows {STYLE_GUIDE_NAME}.

Key conventions:
- {CONVENTION_1}
- {CONVENTION_2}
- {CONVENTION_3}

### Formatting

Code is formatted using {FORMATTER}. Format on save is recommended.

```json
// VS Code settings
{
  "editor.formatOnSave": true,
  "editor.defaultFormatter": "{FORMATTER_EXTENSION}"
}
```

### Commit Messages

Follow {COMMIT_CONVENTION}:

```
type(scope): description

[optional body]

[optional footer]
```

Types: `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`

---

## Deployment

### Build for Production

```bash
{BUILD_PROD_COMMAND}
```

### Environment-Specific Builds

```bash
# Staging
{BUILD_STAGING_COMMAND}

# Production
{BUILD_PRODUCTION_COMMAND}
```

### Pre-deployment Checklist

- [ ] All tests pass
- [ ] Linting passes
- [ ] Build succeeds
- [ ] Environment variables configured
- [ ] Database migrations ready (if applicable)

See [Deployment Guide](./deployment-guide.md) for full deployment instructions.

---

## Troubleshooting

### Installation Issues

**Problem:** Dependencies fail to install
```bash
# Clear cache and retry
{CLEAR_CACHE_COMMAND}
{INSTALL_COMMAND}
```

**Problem:** Version conflicts
```bash
# Check Node version
node --version

# Use correct version
{VERSION_MANAGER_COMMAND}
```

### Runtime Issues

**Problem:** Port already in use
```bash
# Find process using port
{FIND_PORT_COMMAND}

# Or use different port
{USE_DIFFERENT_PORT_COMMAND}
```

### Build Issues

**Problem:** TypeScript errors
```bash
# Check types
{TYPECHECK_COMMAND}

# Clear build cache
{CLEAR_BUILD_CACHE}
```

---

## Additional Resources

- [Architecture Documentation](./architecture.md)
- [API Contracts](./api-contracts.md)
- [Contributing Guide](./contribution-guide.md)

---

_Development guide for AI-assisted development_
