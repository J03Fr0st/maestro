# Documentation Validation Checklist

Use this checklist to validate generated documentation quality and completeness.

## Project Detection and Classification

- [ ] Project type correctly identified (web, backend, mobile, cli, library, etc.)
- [ ] Multi-part vs single-part structure accurately detected
- [ ] All project parts identified (no missing client/server/packages)
- [ ] Repository type correct (monolith, monorepo, multi-part)
- [ ] Technology stack matches actual codebase

## Technology Stack Analysis

- [ ] All major technologies identified
  - [ ] Framework(s)
  - [ ] Language(s) and version(s)
  - [ ] Database(s)
  - [ ] Package manager
  - [ ] Build tools
- [ ] Versions captured where available
- [ ] Technology decision rationale documented (if discoverable)
- [ ] Key dependencies listed

## Codebase Scanning

- [ ] All critical directories scanned
- [ ] Entry points correctly identified
- [ ] Configuration files documented
- [ ] Environment variables listed

### API Documentation (if applicable)
- [ ] All endpoints documented
- [ ] HTTP methods specified
- [ ] Request/response schemas captured
- [ ] Authentication requirements noted
- [ ] Error responses documented

### Data Models (if applicable)
- [ ] All tables/collections documented
- [ ] Field types specified
- [ ] Relationships mapped
- [ ] Constraints noted
- [ ] Migrations documented

### UI Components (if applicable)
- [ ] Component inventory complete
- [ ] Props interfaces documented
- [ ] Component categorization sensible
- [ ] Design patterns identified

### State Management (if applicable)
- [ ] State management solution identified
- [ ] Store structure documented
- [ ] Data flow patterns captured

## Source Tree Analysis

- [ ] Complete directory tree generated
- [ ] Critical folders highlighted and described
- [ ] Entry points marked
- [ ] Generated/build folders noted
- [ ] File organization patterns explained

## Architecture Documentation

- [ ] System overview clear and accurate
- [ ] Architecture pattern identified
- [ ] Component relationships documented
- [ ] Data flow documented
- [ ] Security considerations noted
- [ ] Testing strategy captured

## Development Guide

- [ ] Prerequisites clearly listed
- [ ] Installation steps complete and correct
- [ ] Environment setup documented
- [ ] Run commands specified
- [ ] Build process documented
- [ ] Test commands included
- [ ] Common development tasks covered

## Multi-Part Projects (if applicable)

- [ ] Each part documented separately
- [ ] Integration architecture documented
- [ ] Communication patterns described
- [ ] Shared dependencies identified
- [ ] Data flow between parts explained
- [ ] Part-specific entry points listed

## Index and Navigation

- [ ] index.md serves as master entry point
- [ ] All generated docs linked
- [ ] Existing docs discovered and linked
- [ ] Quick reference section accurate
- [ ] Getting started section actionable
- [ ] AI-assisted development guidance included

## Content Quality

- [ ] No placeholder text remaining
- [ ] No "TODO" items in final docs
- [ ] Examples are realistic and working
- [ ] File paths are correct
- [ ] Technology names accurate
- [ ] Terminology consistent throughout
- [ ] Active voice used
- [ ] Present tense used
- [ ] Task-oriented (answers "how do I...")

## Markdown Quality

- [ ] CommonMark compliant
- [ ] Headers in proper hierarchy (no skipped levels)
- [ ] Code blocks have language identifiers
- [ ] Links work and have descriptive text
- [ ] Tables render correctly
- [ ] Mermaid diagrams valid (if used)

## Deep-Dive Validation (if applicable)

- [ ] Target area correctly scoped
- [ ] All files in scope analyzed
- [ ] Complete exports documented
- [ ] All dependencies mapped
- [ ] Dependents identified
- [ ] Key code snippets included
- [ ] Patterns documented
- [ ] Side effects captured
- [ ] Error handling documented
- [ ] Test coverage noted
- [ ] TODOs extracted
- [ ] Dependency graph created
- [ ] Data flow traced
- [ ] Modification guidance clear

## AI-Readiness

- [ ] Documentation provides sufficient context for AI to understand system
- [ ] Architecture constraints clear
- [ ] Code conventions captured
- [ ] Reusable components identified
- [ ] Integration points documented
- [ ] Enough detail for AI to plan new features

---

## Issue Tracking

### Critical Issues (must fix)
_List any blocking issues discovered during validation_

### Minor Issues (can address later)
_List non-blocking improvements_

### Missing Information (document gaps)
_Note what couldn't be determined from codebase_

---

## Completion Criteria

Documentation is complete when:

1. All applicable checklist items pass
2. No critical issues remain
3. Index provides clear navigation
4. Documentation enables brownfield feature planning
5. An AI agent could understand the codebase from docs alone
