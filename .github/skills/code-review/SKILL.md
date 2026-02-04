---
name: code-review
description: Code review checklist for pull requests covering correctness, security, performance, and maintainability. Use when reviewing PRs, doing self-review before submission, training new reviewers, or establishing review standards.
---

# Code Review Skill

Comprehensive code review guidance for Angular + C# + PostgreSQL projects.

## Quick Start

**Every review, open these three:**

1. [CODE_REVIEW_CHECKLIST.md](references/CODE_REVIEW_CHECKLIST.md) - High-signal checklist for every PR
2. [PULL_REQUEST_TEMPLATE.md](references/PULL_REQUEST_TEMPLATE.md) - What authors must provide
3. [CODE_REVIEW_OVERVIEW.md](references/CODE_REVIEW_OVERVIEW.md) - Goals, responsibilities, etiquette

## Reference Files

### Core Review Process
| File | Purpose |
|------|---------|
| [CODE_REVIEW_OVERVIEW.md](references/CODE_REVIEW_OVERVIEW.md) | Goals, expectations, workflow |
| [CODE_REVIEW_CHECKLIST.md](references/CODE_REVIEW_CHECKLIST.md) | Universal review checklist |
| [PULL_REQUEST_TEMPLATE.md](references/PULL_REQUEST_TEMPLATE.md) | PR submission template |

### Frontend (Angular)
| File | Purpose |
|------|---------|
| [CODE_REVIEW_FRONTEND.md](references/CODE_REVIEW_FRONTEND.md) | Angular-specific guidance |
| [ANGULAR_PERFORMANCE_REVIEW.md](references/ANGULAR_PERFORMANCE_REVIEW.md) | Performance regression prevention |

### Backend (C# / API)
| File | Purpose |
|------|---------|
| [CODE_REVIEW_BACKEND.md](references/CODE_REVIEW_BACKEND.md) | C# and API best practices |
| [DATABASE_REVIEW.md](references/DATABASE_REVIEW.md) | Query efficiency, migrations, N+1 |

### Quality & Safety
| File | Purpose |
|------|---------|
| [SECURITY_REVIEW.md](references/SECURITY_REVIEW.md) | Security awareness checklist |
| [TESTING_REVIEW.md](references/TESTING_REVIEW.md) | Test quality standards |

### Advanced (Large Changes)
| File | Purpose |
|------|---------|
| [PERFORMANCE_REVIEW.md](references/PERFORMANCE_REVIEW.md) | High-traffic change review |
| [ARCHITECTURE_REVIEW.md](references/ARCHITECTURE_REVIEW.md) | Structural change review |

## Review Workflow

### Before Review
1. Read the PR description (use [PULL_REQUEST_TEMPLATE.md](references/PULL_REQUEST_TEMPLATE.md))
2. Understand context and requirements
3. Check CI status

### During Review
1. Open [CODE_REVIEW_CHECKLIST.md](references/CODE_REVIEW_CHECKLIST.md)
2. **First pass:** Overall approach
3. **Second pass:** Details using domain-specific guides
4. Run locally if complex

### After Review
1. Summarize findings with severity levels
2. Approve or request changes
3. Follow up on fixes

## Severity Levels

| Level | When to Use | Action |
|-------|-------------|--------|
| **🔴 Blocker** | Security flaw, data loss risk | Must fix, cannot merge |
| **🟠 Major** | Missing error handling, logic bugs | Should fix before merge |
| **🟡 Minor** | Naming, minor readability | Consider fixing |
| **⚪ Nitpick** | Style preference | Optional |

## When to Use Each Guide

| Scenario | Files to Use |
|----------|-------------|
| Any PR | Checklist + Overview |
| Angular component | + Frontend + Angular Performance |
| C# API change | + Backend |
| Database migration | + Backend + Database |
| Security-sensitive | + Security |
| Adding tests | + Testing |
| High-traffic area | + Performance |
| Structural change | + Architecture |
