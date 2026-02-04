# Architecture Review

Review guidance for large structural changes and architectural decisions.

---

## When This Guide Applies

Use this guide when reviewing:
- New services or modules
- Major refactoring
- Cross-cutting concerns
- API contract changes
- Database schema changes
- Infrastructure changes
- Technology additions

---

## Architecture Change Checklist

### Documentation

- [ ] ADR (Architecture Decision Record) exists
- [ ] Trade-offs documented
- [ ] Alternatives considered
- [ ] Migration path defined
- [ ] Rollback plan exists

### Impact Assessment

- [ ] All affected systems identified
- [ ] Breaking changes documented
- [ ] Performance impact analyzed
- [ ] Security impact analyzed
- [ ] Team knowledge/training needs identified

### Implementation Quality

- [ ] Follows existing patterns (or documented exception)
- [ ] Testable design
- [ ] Observable (logging, metrics, tracing)
- [ ] Handles failure gracefully
- [ ] Backwards compatible (or migration plan)

---

## Structural Change Patterns

### Adding a New Service

**Questions to Ask:**
- Why can't existing services handle this?
- What are the boundaries?
- How does it communicate with other services?
- What happens if it's unavailable?

**Checklist:**
- [ ] Clear responsibility/boundary
- [ ] API contract defined
- [ ] Error handling strategy
- [ ] Health check endpoint
- [ ] Deployment strategy
- [ ] Monitoring/alerting
- [ ] Data ownership clear

### Extracting a Module

**Questions to Ask:**
- Is this extraction necessary?
- Are the boundaries clean?
- What's the migration path?

**Checklist:**
- [ ] Clear interface vs implementation
- [ ] No circular dependencies
- [ ] Shared types in appropriate location
- [ ] Tests cover integration points

### API Contract Changes

**Breaking Changes Require:**
- [ ] Versioning strategy (URL, header)
- [ ] Migration timeline
- [ ] Consumer coordination
- [ ] Deprecation period

```csharp
// ✅ Good: Non-breaking addition
public class OrderResponse
{
    public int Id { get; set; }
    public string Status { get; set; }
    public string? TrackingNumber { get; set; } // New, optional
}

// ⚠️ Breaking: Requires version bump
// Removing field, changing type, renaming
```

---

## Database Schema Changes

### Safe Changes

- Adding nullable column
- Adding new table
- Adding index
- Adding non-unique constraint

### Dangerous Changes

| Change | Risk | Mitigation |
|--------|------|------------|
| Drop column | Data loss | Rename → remove after deployment |
| Change column type | Data loss/locks | Add new column → migrate → drop |
| Add NOT NULL | Deployment failure | Add nullable → backfill → add constraint |
| Rename table | Application errors | Alias → update apps → remove alias |

### Migration Review

```sql
-- ✅ Safe: Additive
ALTER TABLE orders ADD COLUMN tracking_url VARCHAR(500);

-- ⚠️ Unsafe: Needs phased approach
-- Phase 1: Add nullable
ALTER TABLE orders ADD COLUMN status_code INT;

-- Phase 2: Backfill (via app)
UPDATE orders SET status_code = /* mapping */;

-- Phase 3: Add constraint (separate deployment)
ALTER TABLE orders ALTER COLUMN status_code SET NOT NULL;
```

---

## Dependency Decisions

### Adding New Dependency

**Questions:**
- Is it actively maintained?
- What's the license?
- What's the security track record?
- Do we really need it?
- What happens if it's abandoned?

**Checklist:**
- [ ] License compatible with project
- [ ] No known security vulnerabilities
- [ ] Active maintenance (recent commits, issues addressed)
- [ ] Reasonable size (not adding MB for simple utility)
- [ ] Team can support/fork if needed

### Dependency Upgrade

**Checklist:**
- [ ] Changelog reviewed for breaking changes
- [ ] Security fixes included
- [ ] Tests pass
- [ ] No unexpected behavior changes

---

## Cross-Cutting Concerns

### Logging

- [ ] Structured logging (key-value, not string concatenation)
- [ ] Appropriate levels (Debug, Info, Warning, Error)
- [ ] No sensitive data logged
- [ ] Correlation IDs for request tracing
- [ ] Performance-critical paths have minimal logging

### Error Handling

- [ ] Consistent error response format
- [ ] Errors don't leak implementation details
- [ ] Retryable vs non-retryable distinguished
- [ ] Circuit breakers for external dependencies

```csharp
// ✅ Good: Consistent error format
public class ApiError
{
    public string Code { get; set; }      // Machine-readable
    public string Message { get; set; }   // Human-readable
    public string? TraceId { get; set; }  // For support
    public Dictionary<string, string[]>? Details { get; set; }
}
```

### Authentication/Authorization

- [ ] Follows zero-trust principles
- [ ] Token validation complete
- [ ] Permissions granular enough
- [ ] Audit trail for sensitive operations

---

## Design Principles Check

### SOLID

| Principle | Question |
|-----------|----------|
| Single Responsibility | Does this class/module do one thing? |
| Open/Closed | Can I extend without modifying? |
| Liskov Substitution | Can I substitute implementations? |
| Interface Segregation | Are interfaces focused? |
| Dependency Inversion | Do I depend on abstractions? |

### Clean Architecture

- [ ] Domain logic doesn't depend on infrastructure
- [ ] UI doesn't depend on data access
- [ ] Dependencies point inward
- [ ] Use cases are explicit

---

## Trade-off Analysis

### Document Trade-offs

Every architecture decision has trade-offs. Document them:

```markdown
## Decision: Use microservices for order processing

### Benefits
- Independent deployment
- Scale order processing independently
- Technology flexibility

### Costs
- Network complexity
- Distributed transactions harder
- More operational overhead

### Mitigations
- Start with 2-3 services, not 10
- Use saga pattern for transactions
- Invest in observability
```

### Common Trade-offs

| Decision | Gains | Loses |
|----------|-------|-------|
| Microservices | Scalability, autonomy | Simplicity, consistency |
| Event-driven | Decoupling, resilience | Debugging, ordering |
| Caching | Performance | Consistency, complexity |
| SQL | Consistency, querying | Scalability (vertical) |
| NoSQL | Scalability, flexibility | Consistency, joins |

---

## Migration Planning

### Phased Migration

```
Phase 1: Prepare
- Add feature flags
- Implement new path alongside old
- No traffic to new path

Phase 2: Test
- Internal traffic to new path
- Monitor for issues
- Quick rollback available

Phase 3: Gradual Rollout
- 1% → 10% → 50% → 100%
- Monitor metrics at each stage
- Rollback if degradation

Phase 4: Cleanup
- Remove old path
- Remove feature flags
- Update documentation
```

### Rollback Plan

Every architectural change needs a rollback plan:

```markdown
## Rollback Plan

### Trigger Conditions
- Error rate > 1%
- P95 latency > 2x baseline
- Critical bug discovered

### Rollback Steps
1. Disable feature flag
2. Scale down new service
3. Monitor for recovery
4. Notify stakeholders

### Data Considerations
- New data in separate tables (can be migrated later)
- No schema changes that break old code
```

---

## Architecture Review Questions

### For New Components

1. **Why?** What problem does this solve?
2. **Boundaries?** What's in scope, what's not?
3. **Integration?** How does it fit with existing systems?
4. **Failure?** What happens when it fails?
5. **Scale?** What happens at 10x load?

### For Refactoring

1. **Worth it?** Is the change justified?
2. **Safe?** Can we do this incrementally?
3. **Testable?** How do we verify correctness?
4. **Reversible?** Can we undo if needed?

### For Technology Choices

1. **Fit?** Does it solve our specific problem?
2. **Team?** Can the team support this?
3. **Future?** Will this choice age well?
4. **Alternatives?** What else did we consider?

---

## Documentation Requirements

### For Significant Changes

1. **ADR (Architecture Decision Record)**
   - Context and problem
   - Decision and rationale
   - Consequences and trade-offs

2. **System Documentation**
   - Updated diagrams
   - API documentation
   - Runbook updates

3. **Team Knowledge**
   - Tech talk or demo
   - Onboarding materials
   - Troubleshooting guide

---

## Red Flags

| Red Flag | Concern | Action |
|----------|---------|--------|
| No ADR for major change | Undocumented decisions | Require documentation |
| Breaking change without version | Consumer disruption | Add versioning |
| New service without monitoring | Blind spot | Add observability |
| No rollback plan | High risk | Define rollback |
| "Just this once" exception | Pattern erosion | Discuss with team |
| Single person understands system | Bus factor | Document + pair |
