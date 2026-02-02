---
name: project-documentation
description: Deep scan and document brownfield codebases with full architecture analysis and source tree mapping. Always performs exhaustive analysis - no partial scans. Use when documenting existing projects, analyzing architecture, generating technical docs, or preparing codebases for AI-assisted development.
---

# Project Documentation Skill

A comprehensive workflow for analyzing and documenting existing (brownfield) codebases to enable AI-assisted development. This skill systematically scans projects, detects architecture patterns, and generates structured documentation that helps both humans and AI agents understand how to extend the codebase.

> **CRITICAL: This skill ALWAYS performs a FULL DEEP SCAN. There is no quick, partial, or surface-level mode. Every file is read, every pattern is analyzed, every component is documented. Do not skip steps or abbreviate the process.**

## When to Use This Skill

Use this skill when you need to:

- Document an existing codebase for AI-assisted development
- Understand a brownfield project's architecture and patterns
- Create comprehensive technical documentation from source code
- Generate a project index for AI context and retrieval
- Analyze multi-part projects (monorepos, microservices)
- Prepare documentation before planning new features

## Workflow Overview

This skill **ALWAYS performs a Full Deep Scan** - there is no partial or quick scan mode.

### Deep Scan Requirements

- **Read every source file** - No skipping or sampling
- **Analyze all code paths** - Entry points, modules, utilities, tests
- **Extract all patterns** - Architecture, conventions, dependencies
- **Document all components** - APIs, models, UI, state, infrastructure
- **Map all relationships** - File dependencies, data flow, integrations

The goal is exhaustive analysis that leaves no stone unturned. This enables AI agents to understand the complete codebase context for future development.

## Output Document Selection

By default, all 12 documentation files are generated. Users can optionally specify a subset.

### Default: Full Documentation Set

When no specific documents are requested, generate ALL documents:

```
index.md, project-overview.md, source-tree-analysis.md, architecture.md,
component-inventory.md, development-guide.md, api-contracts.md, data-models.md,
state-management.md, testing-guide.md, configuration.md, deployment-guide.md
```

### Presets

Users can request a preset to generate a focused subset:

| Preset | Documents Generated |
|--------|---------------------|
| `--preset=core` | index, project-overview, source-tree-analysis, architecture, development-guide |
| `--preset=api` | index, architecture, api-contracts, data-models, configuration |
| `--preset=frontend` | index, architecture, component-inventory, state-management, testing-guide |
| `--preset=devops` | index, configuration, deployment-guide, testing-guide |
| `--preset=minimal` | index, project-overview, architecture |

### Custom Selection

Users can specify individual documents:

```
"Generate documentation for this project, but only: architecture, api-contracts, data-models"
```

Or exclude specific documents:

```
"Generate full documentation except: component-inventory, state-management"
```

### Important Notes

- **Scanning is always full** - Even when generating fewer documents, the deep scan still analyzes the entire codebase
- **index.md is always included** - It serves as the navigation hub
- **Dependencies are respected** - If a document references another (e.g., architecture references data-models), consider including both

## Workflow Execution

### Step 1: Initialize and Detect Project Structure

First, analyze the project to understand its structure:

```
Project Root Analysis Checklist:
- [ ] Identify package managers (package.json, go.mod, requirements.txt, Cargo.toml)
- [ ] Detect framework markers (next.config.*, nuxt.config.*, angular.json)
- [ ] Analyze directory structure (src/, app/, lib/, components/)
- [ ] Determine repository type (monolith, monorepo, multi-part)
```

**Repository Types:**
- **Monolith**: Single cohesive codebase
- **Monorepo**: Multiple packages/apps in one repository (pnpm-workspace, lerna, nx, turborepo)
- **Multi-part**: Separate client/server or microservice architecture

### Step 2: Classify Project Type

Match the project against these type definitions:

| Type | Key Patterns | Critical Directories |
|------|-------------|---------------------|
| **web** | package.json, tsconfig.json, vite/webpack/next config | src/, app/, pages/, components/, api/ |
| **mobile** | app.json, capacitor.config, pubspec.yaml | screens/, components/, ios/, android/ |
| **backend** | Express/FastAPI/Go patterns, API routes | api/, services/, controllers/, models/ |
| **cli** | bin/, commands/, single entry point | src/, cmd/, cli/, bin/ |
| **library** | Index exports, dist output, no app entry | src/, lib/, dist/ |
| **desktop** | Electron, Tauri, Wails configs | main/, renderer/, src-tauri/ |
| **data** | Airflow, dbt, pipeline configs | dags/, pipelines/, models/ |
| **infra** | Terraform, Kubernetes, Pulumi | terraform/, k8s/, charts/ |

### Step 3: Execute Full Deep Scan

Perform ALL scans exhaustively. Do not skip any scan type - analyze everything present in the codebase.

#### API Scan (ALWAYS execute)
- Find ALL route definitions (controllers/, routes/, api/, handlers/)
- Extract EVERY HTTP method, path, and parameter
- Document ALL request/response schemas
- Identify ALL authentication requirements
- Map middleware chains and request lifecycle

#### Data Models Scan (ALWAYS execute)
- Locate ALL schema definitions (models/, schemas/, prisma/, migrations/)
- Extract EVERY table/collection structure
- Document ALL relationships and constraints
- Map complete data flow patterns
- Identify validation rules and defaults

#### UI Components Scan (ALWAYS execute)
- Inventory COMPLETE component library (components/, ui/, widgets/)
- Categorize ALL components by type (Layout, Form, Display, Navigation)
- Identify ALL design system patterns
- Document ALL props interfaces and their types
- Map component dependencies and composition patterns

#### State Management Scan (ALWAYS execute)
- Identify ALL state management solutions (Redux, Context, Zustand, Pinia, etc.)
- Map COMPLETE store structure
- Document ALL actions/reducers/selectors
- Track FULL state flow through application
- Identify side effects and async patterns

#### Configuration Scan (ALWAYS execute)
- Find ALL configuration files
- Document environment variables and their purposes
- Map build and bundler configurations
- Identify feature flags and runtime settings

#### Test Coverage Scan (ALWAYS execute)
- Inventory ALL test files and their locations
- Identify testing frameworks and patterns
- Document test utilities and fixtures
- Map coverage of critical paths

### Step 4: Generate Source Tree Analysis

Create an annotated directory tree highlighting:

```
project-root/
├── src/                    # Main source code
│   ├── api/               # API client and services
│   │   ├── client.ts      # Main API client [ENTRY]
│   │   └── services/      # Service modules
│   ├── components/        # Reusable UI components
│   ├── types/             # TypeScript type definitions
│   └── utils/             # Utility functions
├── tests/                  # Test files
│   ├── unit/              # Unit tests
│   └── integration/       # Integration tests
└── dist/                   # Build output [GENERATED]
```

### Step 5: Extract Development Information

Document setup and operations:

**Prerequisites:**
- Runtime versions (Node.js, Python, Go, etc.)
- Required global tools
- Environment variables needed

**Commands:**
- Installation steps
- Development server
- Build process
- Test execution
- Deployment process

### Step 6: Generate Complete Documentation Set

Generate ALL documentation files. Every file is required - populate with findings or note "Not applicable to this project type" if truly absent.

```
docs/
├── index.md                    # Master navigation index (REQUIRED)
├── project-overview.md         # Executive summary (REQUIRED)
├── source-tree-analysis.md     # Directory structure (REQUIRED)
├── architecture.md             # Technical architecture (REQUIRED)
├── component-inventory.md      # UI components (REQUIRED)
├── development-guide.md        # Setup and workflow (REQUIRED)
├── api-contracts.md            # API documentation (REQUIRED)
├── data-models.md              # Database schemas (REQUIRED)
├── state-management.md         # State patterns and flow (REQUIRED)
├── testing-guide.md            # Test structure and patterns (REQUIRED)
├── configuration.md            # Environment and config (REQUIRED)
└── deployment-guide.md         # Deployment process (REQUIRED)
```

## Documentation Templates

All templates are located in `templates/` directory. Use these templates when generating documentation:

| Document | Template File | Purpose |
|----------|---------------|---------|
| index.md | [templates/index.md](./templates/index.md) | Master navigation index |
| project-overview.md | [templates/project-overview.md](./templates/project-overview.md) | Executive summary |
| source-tree-analysis.md | [templates/source-tree-analysis.md](./templates/source-tree-analysis.md) | Directory structure |
| architecture.md | [templates/architecture.md](./templates/architecture.md) | Technical architecture |
| component-inventory.md | [templates/component-inventory.md](./templates/component-inventory.md) | UI components |
| development-guide.md | [templates/development-guide.md](./templates/development-guide.md) | Setup and workflow |
| api-contracts.md | [templates/api-contracts.md](./templates/api-contracts.md) | API documentation |
| data-models.md | [templates/data-models.md](./templates/data-models.md) | Database schemas |
| state-management.md | [templates/state-management.md](./templates/state-management.md) | State patterns |
| testing-guide.md | [templates/testing-guide.md](./templates/testing-guide.md) | Test structure |
| configuration.md | [templates/configuration.md](./templates/configuration.md) | Environment config |
| deployment-guide.md | [templates/deployment-guide.md](./templates/deployment-guide.md) | Deployment process |

### Template Usage

1. **Read the template** before generating each document
2. **Fill ALL placeholders** - no `{placeholder}` should remain
3. **Adapt to project** - use actual values from codebase analysis
4. **Mark N/A sections** - if truly not applicable, note "Not applicable to this project type"

### Bonus Template

| Document | Template File | Purpose |
|----------|---------------|---------|
| adr.md | [templates/adr.md](./templates/adr.md) | Architecture Decision Records (optional) |

## Best Practices

### Documentation Quality Rules

1. **CommonMark Compliance** - All markdown must follow CommonMark specification
2. **No Time Estimates** - Never include duration estimates (they vary too much)
3. **Task-Oriented** - Write for user goals, not feature lists
4. **Active Voice** - "Click the button" not "The button should be clicked"
5. **Present Tense** - "The function returns" not "The function will return"
6. **Working Examples** - Include realistic, tested code snippets

### Mermaid Diagram Guidelines

Use appropriate diagram types:
- **flowchart** - Process flows, decision trees
- **sequenceDiagram** - API interactions, message flows
- **classDiagram** - Object models, class relationships
- **erDiagram** - Database schemas
- **stateDiagram-v2** - State machines

Keep diagrams focused (5-10 nodes ideal, max 15).

### Write-As-You-Go Architecture

To manage context efficiently:

1. **Write immediately** - Save each document right after generation
2. **Validate sections** - Check completeness before moving on
3. **Purge details** - Keep only summaries in context
4. **Track state** - Record progress for resumability

## Multi-Part Project Handling

For projects with multiple parts (client/server, microservices):

1. **Detect all parts** - Scan for separate package.json, go.mod, etc.
2. **Document each part** - Generate part-specific docs (architecture-{part_id}.md)
3. **Map integration** - Document how parts communicate
4. **Create unified index** - Link all part documentation

### Integration Documentation

```
# Integration Architecture

## Communication Patterns
{how_parts_communicate}

## Integration Points
| From | To | Type | Details |
|------|-----|------|---------|
| {source} | {target} | {method} | {specifics} |

## Data Flow Between Parts
{cross_part_data_flow}

## Shared Dependencies
{common_libraries}
```

## State Management for Resumability

Track workflow progress in a state file:

```json
{
  "workflow_version": "1.0.0",
  "timestamps": {
    "started": "2024-01-15T10:00:00Z",
    "last_updated": "2024-01-15T10:30:00Z"
  },
  "completed_steps": [
    {"step": "step_1", "summary": "Project classified", "timestamp": "..."},
    {"step": "step_2", "summary": "Tech stack analyzed", "timestamp": "..."}
  ],
  "current_step": "step_3",
  "outputs_generated": ["index.md", "project-overview.md"],
  "findings": {
    "project_type": "web",
    "framework": "React + TypeScript",
    "parts_count": 1
  }
}
```

## Validation Checklist

Before completing documentation, verify FULL coverage:

### Scan Completeness
- [ ] Every source directory has been scanned
- [ ] All source files have been read (not sampled)
- [ ] All entry points identified and documented
- [ ] All dependencies analyzed and listed

### Documentation Completeness
- [ ] All requested documentation files generated (all 12 by default, or user-specified subset)
- [ ] index.md always included with links to generated docs only
- [ ] Technology stack accurate and complete
- [ ] API endpoints fully documented with schemas
- [ ] Data models captured with relationships
- [ ] UI components inventoried with props
- [ ] State management patterns mapped
- [ ] Test coverage documented
- [ ] Configuration fully documented
- [ ] Development commands verified and tested
- [ ] Deployment process documented

### Quality Checks
- [ ] Index links all generated docs
- [ ] Markdown renders correctly
- [ ] No placeholder content remaining
- [ ] No "TODO" or "TBD" markers left
- [ ] Examples are realistic and working
- [ ] Mermaid diagrams render correctly

## Example Usage Prompts

**Full Deep Scan (Default):**
> "Document this project for AI-assisted development."

This triggers a complete deep scan with all 12 documentation files generated.

**Using a Preset:**
> "Document this project using the API preset."

Generates: index, architecture, api-contracts, data-models, configuration.

**Custom Document Selection:**
> "Document this project, but only generate: architecture, component-inventory, and state-management."

Generates only the specified documents plus index.md.

**Excluding Documents:**
> "Generate full documentation for this project, except deployment-guide and testing-guide."

Generates all documents except the ones specified.

**Update Documentation:**
> "Rescan this project and update the existing documentation with any changes since the last scan."

This performs a full rescan - not incremental. All files are re-read and documentation regenerated.

**Specific Area (Still Deep):**
> "Document the authentication system in this project."

Even for specific areas, perform deep analysis: all related files, complete data flow, full security patterns, integration points, and test coverage.

## Output Location

By default, generate documentation in:
- `docs/` - For project documentation
- Or user-specified location

Always create an `index.md` as the master entry point that AI agents can reference for context.

---

_This skill enables comprehensive brownfield project documentation through exhaustive deep scanning. No shortcuts, no partial scans - full analysis every time._
