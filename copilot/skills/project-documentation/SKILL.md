---
name: project-documentation
description: Comprehensive brownfield project documentation and analysis. Use this skill when asked to document an existing codebase, analyze project architecture, create project documentation, understand a brownfield project, generate source tree analysis, or create technical documentation for AI-assisted development. This skill performs systematic codebase scanning, architecture detection, and generates structured documentation to help AI agents understand and extend existing projects.
---

# Project Documentation Skill

A comprehensive workflow for analyzing and documenting existing (brownfield) codebases to enable AI-assisted development. This skill systematically scans projects, detects architecture patterns, and generates structured documentation that helps both humans and AI agents understand how to extend the codebase.

## When to Use This Skill

Use this skill when you need to:

- Document an existing codebase for AI-assisted development
- Understand a brownfield project's architecture and patterns
- Create comprehensive technical documentation from source code
- Generate a project index for AI context and retrieval
- Analyze multi-part projects (monorepos, microservices)
- Perform deep-dive analysis of specific features or modules
- Prepare documentation before planning new features

## Workflow Overview

The documentation workflow has three modes:

1. **Initial Scan** - First-time documentation of a project
2. **Full Rescan** - Update existing documentation with latest changes
3. **Deep Dive** - Exhaustive analysis of a specific area

### Scan Levels

| Level | Description | File Reading | Use Case |
|-------|-------------|--------------|----------|
| **Quick** | Pattern-based analysis | Configs only | Fast overview |
| **Deep** | Critical directories | Selective | Standard documentation |
| **Exhaustive** | Complete codebase | All files | Deep analysis, audits |

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

### Step 3: Scan Based on Project Type Requirements

For each detected project type, perform conditional scans:

#### API Scan (if applicable)
- Find route definitions (controllers/, routes/, api/, handlers/)
- Extract HTTP methods, paths, and parameters
- Document request/response schemas
- Identify authentication requirements

#### Data Models Scan (if applicable)
- Locate schema definitions (models/, schemas/, prisma/, migrations/)
- Extract table/collection structures
- Document relationships and constraints
- Map data flow patterns

#### UI Components Scan (if applicable)
- Inventory component library (components/, ui/, widgets/)
- Categorize by type (Layout, Form, Display, Navigation)
- Identify design system patterns
- Document props interfaces

#### State Management Scan (if applicable)
- Identify state management solution (Redux, Context, Zustand, Pinia)
- Map store structure
- Document actions/reducers/selectors
- Track state flow

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

### Step 6: Generate Documentation Files

Create the following documentation structure:

```
docs/
├── index.md                    # Master navigation index
├── project-overview.md         # Executive summary
├── source-tree-analysis.md     # Directory structure
├── architecture.md             # Technical architecture
├── component-inventory.md      # UI components (if applicable)
├── development-guide.md        # Setup and workflow
├── api-contracts.md            # API documentation (if applicable)
├── data-models.md              # Database schemas (if applicable)
├── deployment-guide.md         # Deployment process (if found)
└── deep-dive-*.md              # Deep analysis (on demand)
```

## Documentation Templates

### Index Template (index.md)

```markdown
# {project_name} Documentation Index

**Type:** {repository_type}
**Primary Language:** {primary_language}
**Architecture:** {architecture_type}
**Last Updated:** {date}

## Project Overview
{brief_description}

## Quick Reference
- **Tech Stack:** {tech_stack_summary}
- **Entry Point:** {entry_point}
- **Architecture Pattern:** {architecture_pattern}

## Generated Documentation
- [Project Overview](./project-overview.md)
- [Source Tree Analysis](./source-tree-analysis.md)
- [Architecture](./architecture.md)
- [Development Guide](./development-guide.md)
{conditional_links}

## Existing Documentation
{existing_docs_list}

## Getting Started
{quick_start_commands}

## For AI-Assisted Development
When planning new features, reference:
- **UI features:** architecture.md, component-inventory.md
- **API features:** architecture.md, api-contracts.md, data-models.md
- **Full-stack:** All architecture docs
```

### Project Overview Template

```markdown
# {project_name} - Project Overview

**Date:** {date}
**Type:** {project_type}
**Architecture:** {architecture_type}

## Executive Summary
{executive_summary}

## Project Classification
- **Repository Type:** {repository_type}
- **Project Type(s):** {project_types}
- **Primary Language(s):** {languages}
- **Architecture Pattern:** {pattern}

## Technology Stack Summary
| Category | Technology | Version | Purpose |
|----------|------------|---------|---------|
| {category} | {tech} | {version} | {purpose} |

## Key Features
{feature_list}

## Architecture Highlights
{architecture_summary}

## Development Overview
### Prerequisites
{prerequisites}

### Key Commands
- **Install:** `{install_cmd}`
- **Dev:** `{dev_cmd}`
- **Build:** `{build_cmd}`
- **Test:** `{test_cmd}`
```

### Architecture Template

```markdown
# {project_name} - Architecture

## System Overview
{high_level_description}

## Architecture Diagram
```mermaid
{architecture_diagram}
```

## Technology Stack
{detailed_tech_table}

## Component Architecture
{component_breakdown}

## Data Flow
{data_flow_description}

## API Design
{api_overview}

## Security Architecture
{security_patterns}

## Testing Strategy
{testing_approach}
```

### Deep-Dive Template

```markdown
# {target_name} - Deep Dive Documentation

**Scope:** {target_path}
**Files Analyzed:** {file_count}
**Lines of Code:** {total_loc}

## Overview
{target_description}

## File Inventory
{for each file}
### {file_path}
- **Purpose:** {purpose}
- **LOC:** {lines}
- **Exports:** {export_list}
- **Dependencies:** {import_list}
- **Used By:** {dependents}
- **Key Implementation:** {implementation_notes}
- **Side Effects:** {side_effects}
- **Error Handling:** {error_approach}
{end for}

## Dependency Graph
{dependency_visualization}

## Data Flow
{data_flow_through_area}

## Integration Points
{api_connections}

## Testing Analysis
{test_coverage_and_gaps}

## Modification Guidance
- **To Add:** {add_guidance}
- **To Modify:** {modify_guidance}
- **To Remove:** {remove_guidance}
```

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

```markdown
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
  "mode": "initial_scan",
  "scan_level": "deep",
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

Before completing documentation:

- [ ] All critical directories documented
- [ ] Technology stack accurate and complete
- [ ] Entry points identified
- [ ] API endpoints documented (if applicable)
- [ ] Data models captured (if applicable)
- [ ] Development commands verified
- [ ] Index links all generated docs
- [ ] Markdown renders correctly
- [ ] No placeholder content remaining
- [ ] Examples are realistic and working

## Example Usage Prompts

**Initial Documentation:**
> "Document this project for AI-assisted development. Generate comprehensive documentation including architecture, source tree analysis, and development guides."

**Quick Overview:**
> "Do a quick scan of this codebase and create a project overview with the main architecture patterns and technology stack."

**Deep Dive:**
> "Perform an exhaustive deep-dive analysis of the `src/api/` directory. Document all files, their exports, dependencies, and how they integrate."

**Update Documentation:**
> "Rescan this project and update the existing documentation with any changes since the last scan."

**Specific Area:**
> "Document just the authentication system in this project, including all related files, data flow, and security patterns."

## Output Location

By default, generate documentation in:
- `docs/` - For project documentation
- Or user-specified location

Always create an `index.md` as the master entry point that AI agents can reference for context.

---

_This skill enables comprehensive brownfield project documentation for AI-assisted development workflows._
