# Architecture Decision Record Template

Use this template to document significant architectural decisions in the project.

## ADR Index Template

```markdown
# Architecture Decision Records

This directory contains Architecture Decision Records (ADRs) for {project_name}.

## What is an ADR?

An ADR captures a significant architectural decision along with its context and consequences. ADRs help teams understand why decisions were made and provide a historical record for future reference.

## ADR Status Legend

| Status | Meaning |
|--------|---------|
| **Proposed** | Under discussion, not yet accepted |
| **Accepted** | Decision has been made and is active |
| **Deprecated** | No longer applies, superseded by another ADR |
| **Superseded** | Replaced by a newer decision |

## Decision Log

| ID | Title | Status | Date |
|----|-------|--------|------|
| [ADR-001](./adr-001-{slug}.md) | {title} | {status} | {date} |
| [ADR-002](./adr-002-{slug}.md) | {title} | {status} | {date} |

## Creating a New ADR

1. Copy the template below
2. Number sequentially (ADR-XXX)
3. Use kebab-case for filename: `adr-001-use-typescript.md`
4. Fill in all sections
5. Submit for team review
```

---

## Individual ADR Template

```markdown
# ADR-{number}: {Title}

**Status:** {Proposed | Accepted | Deprecated | Superseded}
**Date:** {YYYY-MM-DD}
**Deciders:** {list of people involved}
**Supersedes:** {ADR-XXX if applicable}
**Superseded by:** {ADR-XXX if applicable}

## Context

{Describe the situation that requires a decision. Include:
- What problem are we trying to solve?
- What constraints exist?
- What forces are at play?
- Why is this decision needed now?}

## Decision

{State the decision clearly and concisely.}

**We will {action}.**

{Elaborate on what this means in practice.}

## Alternatives Considered

### Option 1: {Name}

{Description of the alternative}

**Pros:**
- {advantage}

**Cons:**
- {disadvantage}

### Option 2: {Name}

{Description of the alternative}

**Pros:**
- {advantage}

**Cons:**
- {disadvantage}

## Consequences

### Positive

- {benefit}
- {benefit}

### Negative

- {tradeoff}
- {tradeoff}

### Neutral

- {observation}

## Implementation Notes

{Optional: specific guidance for implementing this decision}

## References

- {link to relevant documentation}
- {link to discussion thread}
- {link to related ADRs}
```

---

## Example ADR

```markdown
# ADR-001: Use TypeScript for All New Code

**Status:** Accepted
**Date:** 2024-01-15
**Deciders:** Engineering Team

## Context

Our JavaScript codebase has grown significantly, and we're experiencing issues with:
- Runtime type errors in production
- Difficulty refactoring without breaking changes
- Inconsistent API contracts between modules
- Onboarding friction for new developers

The team has varying levels of TypeScript experience, but most are familiar with typed languages.

## Decision

**We will use TypeScript for all new code and gradually migrate existing JavaScript files.**

- New files must be `.ts` or `.tsx`
- Existing files converted during modification
- Strict mode enabled in tsconfig
- No `any` types without explicit justification

## Alternatives Considered

### Option 1: JSDoc Type Annotations

Use JSDoc comments with TypeScript checking in VS Code.

**Pros:**
- No build step changes
- Gradual adoption

**Cons:**
- Verbose syntax
- Less IDE support
- Harder to enforce

### Option 2: Flow

Use Facebook's Flow type checker.

**Pros:**
- Similar benefits to TypeScript
- Used by React team

**Cons:**
- Smaller ecosystem
- Declining community adoption
- Fewer type definitions available

## Consequences

### Positive

- Catch type errors at compile time
- Better IDE autocomplete and refactoring
- Self-documenting code through types
- Improved API contracts

### Negative

- Initial learning curve for team members
- Build step added to development workflow
- Migration effort for existing code

### Neutral

- Need to maintain tsconfig.json
- Type definitions required for third-party libraries

## Implementation Notes

1. Enable TypeScript in CI pipeline
2. Add `@types/*` packages as needed
3. Start with `strict: false`, tighten over time
4. Create shared type definitions in `src/types/`

## References

- [TypeScript Documentation](https://www.typescriptlang.org/docs/)
- [TypeScript Deep Dive](https://basarat.gitbook.io/typescript/)
```

---

## Common ADR Topics

Consider creating ADRs for decisions about:

| Category | Examples |
|----------|----------|
| **Language/Runtime** | TypeScript adoption, Node version, Python vs Go |
| **Frameworks** | React vs Vue, Express vs Fastify, ORM choice |
| **Architecture** | Monolith vs microservices, API design style |
| **Data** | Database selection, caching strategy, data modeling |
| **Infrastructure** | Cloud provider, container orchestration, CDN |
| **Security** | Authentication method, secrets management |
| **Testing** | Testing strategy, coverage requirements |
| **CI/CD** | Deployment strategy, branching model |
| **Code Quality** | Linting rules, formatting standards |

## Best Practices

1. **Write ADRs early** - Document decisions when context is fresh
2. **Keep them immutable** - Don't edit accepted ADRs; create new ones that supersede
3. **Be concise** - Focus on the decision, not exhaustive analysis
4. **Include context** - Future readers need to understand the "why"
5. **List alternatives** - Show that options were considered
6. **Accept consequences** - Be honest about tradeoffs
7. **Review as a team** - ADRs should reflect team consensus
