# Example Usage Prompts

This document provides example prompts for using the project-documentation skill effectively.

## Initial Project Documentation

### Full Documentation Request

> Document this entire project for AI-assisted development. I need comprehensive documentation including architecture, source tree analysis, API contracts, and development guides. Use a deep scan level to analyze critical directories.

### Quick Overview Request

> Do a quick scan of this codebase and give me a project overview. I just need to understand the basic structure, tech stack, and where things are located.

### Specific Output Location

> Document this project and output all documentation to the `docs/` folder. Create an index.md as the main entry point.

## Targeted Documentation

### API Documentation Only

> Document just the API layer of this project. Focus on all endpoints, their request/response schemas, authentication requirements, and error handling patterns.

### Frontend Components

> Create a component inventory for this React application. Document all UI components, their props, usage patterns, and how they're organized.

### Data Models

> Document all the data models in this project. Include database schemas, entity relationships, and how data flows through the system.

## Deep-Dive Analysis

### Specific Directory

> Perform an exhaustive deep-dive analysis of the `src/api/` directory. I need to understand every file, all exports, dependencies, and how they integrate with the rest of the system.

### Feature Analysis

> Deep-dive into the authentication system. Find all related files across the codebase and document how authentication works end-to-end.

### Module Understanding

> I need to understand the `utils/` module completely. Analyze all utility functions, their purposes, who uses them, and any patterns I should follow when adding new utilities.

## Update Existing Documentation

### Full Rescan

> The codebase has changed significantly. Rescan the entire project and update all documentation to reflect the current state.

### Incremental Update

> Update the documentation for just the `api/services/` directory. New services were added and I need the docs to reflect them.

### Validate Documentation

> Check if the existing documentation in `docs/` is still accurate. Identify any sections that are outdated and need updates.

## Multi-Part Projects

### Monorepo Documentation

> This is a monorepo with multiple packages. Document each package separately and create an integration document showing how they work together.

### Client-Server Project

> Document this full-stack project. There's a React frontend in `client/` and an Express backend in `server/`. Create separate architecture docs for each and an integration document.

### Microservices

> This project has multiple microservices. Document each service and create a service mesh diagram showing how they communicate.

## Specific Formats

### Mermaid Diagrams

> Create architecture documentation with Mermaid diagrams showing the system overview, data flow, and component relationships.

### API Reference Format

> Document the API following OpenAPI conventions. Include all endpoints, parameters, responses, and examples.

### Developer Onboarding

> Create documentation optimized for developer onboarding. Include everything a new developer needs to get started and understand the codebase.

## Combination Requests

### Pre-Feature Planning

> I'm about to add a new feature to the payment system. Document the existing payment-related code so I understand what's there before I start planning.

### Code Review Preparation

> Generate documentation that would help me review a PR touching the `auth/` and `user/` modules. I need to understand the existing patterns and integration points.

### Refactoring Analysis

> I want to refactor the state management. Deep-dive into all state-related code and document the current patterns, issues, and dependencies so I can plan the refactor.

## Output Customization

### Minimal Documentation

> Create minimal documentation - just an index, architecture overview, and development guide. Skip the detailed component inventories and API contracts.

### Maximum Detail

> I need exhaustive documentation. Use the exhaustive scan level and document everything including all file inventories, dependency graphs, and code patterns.

### Specific Templates

> Use the following structure for the documentation: [custom structure]. Ensure all docs follow this format.

---

## Response Expectations

When the skill is activated, expect:

1. **Project Analysis** - Initial scan and classification
2. **Confirmation** - Verification of detected structure
3. **Progress Updates** - Status as each document is generated
4. **Generated Files** - List of all documentation created
5. **Next Steps** - Guidance on using the documentation

## Tips for Best Results

1. **Be Specific** - The more specific your request, the more targeted the output
2. **Specify Scan Level** - Quick for overview, deep for comprehensive, exhaustive for complete
3. **Mention Output Location** - Specify where you want docs saved
4. **Request Validation** - Ask for validation against the checklist
5. **Iterative Refinement** - Start with an overview, then request deep-dives on specific areas

---

_Example prompts for the project-documentation skill_
