# Project Overview Template

Use this template for the executive summary document that provides a high-level view of the project.

```markdown
# {project_name} - Project Overview

**Generated:** {date}
**Scan Type:** Full Deep Scan
**Documentation Version:** 1.0

## Executive Summary

{2-3 paragraph executive summary covering:
- What the project does
- Who it's for
- Key capabilities}

## Project Classification

| Attribute | Value |
|-----------|-------|
| **Repository Type** | {monolith / monorepo / multi-part} |
| **Project Type(s)** | {web / mobile / backend / cli / library / desktop / data / infra} |
| **Primary Language(s)** | {TypeScript, Python, Go, etc.} |
| **Framework(s)** | {React, FastAPI, etc.} |
| **Architecture Pattern** | {MVC, Clean Architecture, Microservices, etc.} |

## Technology Stack

### Core Technologies

| Category | Technology | Version | Purpose |
|----------|------------|---------|---------|
| Runtime | {Node.js} | {20.x} | {JavaScript runtime} |
| Framework | {Next.js} | {14.x} | {Full-stack React framework} |
| Language | {TypeScript} | {5.x} | {Type-safe JavaScript} |
| Database | {PostgreSQL} | {15.x} | {Primary data store} |

### Development Tools

| Tool | Version | Purpose |
|------|---------|---------|
| {pnpm} | {8.x} | {Package management} |
| {ESLint} | {8.x} | {Code linting} |
| {Prettier} | {3.x} | {Code formatting} |
| {Vitest} | {1.x} | {Unit testing} |

### Infrastructure

| Component | Technology | Purpose |
|-----------|------------|---------|
| {Hosting} | {Vercel} | {Application hosting} |
| {Database} | {Supabase} | {Managed PostgreSQL} |
| {CDN} | {Cloudflare} | {Static asset delivery} |

## Key Features

### Core Functionality

1. **{Feature Name}**
   - {Brief description}
   - Located in: `{path/to/feature}`

2. **{Feature Name}**
   - {Brief description}
   - Located in: `{path/to/feature}`

3. **{Feature Name}**
   - {Brief description}
   - Located in: `{path/to/feature}`

### Integrations

| Integration | Type | Purpose |
|-------------|------|---------|
| {Stripe} | {Payment} | {Payment processing} |
| {Auth0} | {Authentication} | {User authentication} |
| {SendGrid} | {Email} | {Transactional emails} |

## Architecture Highlights

### System Design

{Brief description of overall architecture}

```
┌─────────────────────────────────────────────────────────┐
│                      {Diagram}                          │
│                                                         │
│   {High-level architecture visualization}               │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

### Key Architectural Decisions

1. **{Decision}**: {Rationale}
2. **{Decision}**: {Rationale}
3. **{Decision}**: {Rationale}

### Data Flow Summary

{Brief description of how data flows through the system}

## Codebase Statistics

| Metric | Value |
|--------|-------|
| Total Files | {count} |
| Lines of Code | {count} |
| Components | {count} |
| API Endpoints | {count} |
| Test Files | {count} |
| Test Coverage | {percentage} |

## Development Quick Start

### Prerequisites

- {Runtime} >= {version}
- {Package manager}
- {Other requirements}

### Setup Commands

```bash
# Clone and install
git clone {repository_url}
cd {project_name}
{install_command}

# Environment setup
cp .env.example .env
# Configure required environment variables

# Start development
{dev_command}
```

### Key Commands

| Command | Purpose |
|---------|---------|
| `{dev_command}` | Start development server |
| `{build_command}` | Create production build |
| `{test_command}` | Run test suite |
| `{lint_command}` | Run linter |

## Documentation Map

| Document | Purpose |
|----------|---------|
| [Source Tree Analysis](./source-tree-analysis.md) | Directory structure and file organization |
| [Architecture](./architecture.md) | Technical architecture deep dive |
| [Component Inventory](./component-inventory.md) | UI component library |
| [API Contracts](./api-contracts.md) | API endpoint documentation |
| [Data Models](./data-models.md) | Database schema and models |
| [State Management](./state-management.md) | Application state patterns |
| [Testing Guide](./testing-guide.md) | Test structure and patterns |
| [Configuration](./configuration.md) | Environment and settings |
| [Development Guide](./development-guide.md) | Developer workflow |
| [Deployment Guide](./deployment-guide.md) | Deployment process |

## Project Health

| Indicator | Status | Notes |
|-----------|--------|-------|
| Build | {passing/failing} | {notes} |
| Tests | {passing/failing} | {coverage}% coverage |
| Dependencies | {up-to-date/outdated} | {count} outdated |
| Security | {clean/issues} | {count} vulnerabilities |

## Contacts and Resources

| Resource | Link |
|----------|------|
| Repository | {repository_url} |
| Documentation | {docs_url} |
| Issue Tracker | {issues_url} |
| CI/CD | {ci_url} |
```

---

## Usage Notes

When generating this template:

1. **Fill every section** - No placeholders should remain
2. **Be specific** - Use actual values from the codebase
3. **Keep current** - Update statistics on each rescan
4. **Link documents** - Ensure all doc links are valid
