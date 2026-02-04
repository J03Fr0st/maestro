# Database Review

Database change review checklist for PostgreSQL and migrations.

---

## Migration Review Checklist

### Safety

- [ ] Migration is reversible (or has documented rollback plan)
- [ ] Safe for zero-downtime deployment
- [ ] No exclusive locks on hot tables during migration
- [ ] Large data operations chunked or run asynchronously

### Destructive Operations

| Operation | Risk | Mitigation |
|-----------|------|------------|
| DROP TABLE | Data loss | Backup first, soft delete period |
| DROP COLUMN | Data loss | Rename + monitor, then drop |
| TRUNCATE | Data loss | Never in migration |
| ALTER TYPE | Locks table | Add new column, migrate, drop old |

```sql
-- ❌ Dangerous: Instant data loss
ALTER TABLE users DROP COLUMN legacy_field;

-- ✅ Safe: Phased approach
-- Phase 1: Mark as deprecated (app code)
-- Phase 2: Rename column (monitors for usage)
ALTER TABLE users RENAME COLUMN legacy_field TO _deprecated_legacy_field;
-- Phase 3: Drop after confirmation period
ALTER TABLE users DROP COLUMN _deprecated_legacy_field;
```

### Column Modifications

```sql
-- ❌ Dangerous: Locks table for duration
ALTER TABLE large_table ADD COLUMN status VARCHAR(50) DEFAULT 'active';

-- ✅ Safe: Add nullable, then backfill
ALTER TABLE large_table ADD COLUMN status VARCHAR(50);
-- Backfill in chunks via application code
UPDATE large_table SET status = 'active' WHERE id BETWEEN 1 AND 10000;
-- Then add default
ALTER TABLE large_table ALTER COLUMN status SET DEFAULT 'active';
```

---

## Query Performance Checklist

### Index Review

- [ ] Indexes exist for WHERE clauses
- [ ] Indexes exist for JOIN columns
- [ ] Indexes exist for ORDER BY columns in large tables
- [ ] Composite indexes ordered correctly (high selectivity first)
- [ ] No over-indexing (slows writes)

```sql
-- Query that needs indexing
SELECT * FROM orders 
WHERE customer_id = 123 
  AND status = 'pending'
ORDER BY created_at DESC;

-- Appropriate index
CREATE INDEX idx_orders_customer_status_created 
ON orders (customer_id, status, created_at DESC);
```

### N+1 Query Detection

```csharp
// ❌ N+1 Query pattern
var orders = await _context.Orders.ToListAsync();
foreach (var order in orders)
{
    // This executes one query per order!
    order.Items = await _context.OrderItems
        .Where(i => i.OrderId == order.Id)
        .ToListAsync();
}

// ✅ Single query with Include
var orders = await _context.Orders
    .Include(o => o.Items)
    .ToListAsync();

// ✅ Alternative: Explicit join
var orders = await _context.Orders
    .Join(_context.OrderItems, 
        o => o.Id, i => i.OrderId, 
        (o, items) => new { Order = o, Items = items })
    .ToListAsync();
```

### Query Patterns to Watch

| Anti-pattern | Issue | Fix |
|--------------|-------|-----|
| `SELECT *` | Over-fetching | Select specific columns |
| `LIKE '%term%'` | Full scan, no index | Full-text search |
| Unbounded queries | Memory explosion | Add LIMIT/pagination |
| Nested subqueries | Poor optimization | JOINs or CTEs |
| Functions on indexed columns | Index not used | Functional index or restructure |

```sql
-- ❌ Bad: Function prevents index use
SELECT * FROM users WHERE LOWER(email) = 'test@example.com';

-- ✅ Option 1: Functional index
CREATE INDEX idx_users_email_lower ON users (LOWER(email));

-- ✅ Option 2: Store normalized data
SELECT * FROM users WHERE email_lower = 'test@example.com';
```

---

## PostgreSQL Specific

### Table Design

- [ ] Primary keys defined
- [ ] Foreign keys with appropriate ON DELETE behavior
- [ ] NOT NULL constraints where applicable
- [ ] CHECK constraints for data integrity
- [ ] Appropriate data types (not VARCHAR(255) for everything)

```sql
-- ✅ Good: Proper constraints
CREATE TABLE orders (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    customer_id UUID NOT NULL REFERENCES customers(id) ON DELETE RESTRICT,
    status VARCHAR(20) NOT NULL CHECK (status IN ('pending', 'processing', 'complete', 'cancelled')),
    total_amount DECIMAL(10,2) NOT NULL CHECK (total_amount >= 0),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
```

### Common Data Types

| Use Case | Type | Notes |
|----------|------|-------|
| Primary key | UUID or BIGSERIAL | UUID for distributed |
| Money | DECIMAL(p,s) | Never FLOAT |
| Timestamps | TIMESTAMPTZ | Always with timezone |
| JSON data | JSONB | Faster than JSON |
| Status/enum | VARCHAR + CHECK | Or native ENUM |
| Boolean | BOOLEAN | Not integer |

---

## Transaction Safety

### ACID Compliance

- [ ] Related operations in single transaction
- [ ] Transaction isolation level appropriate
- [ ] Deadlock potential considered
- [ ] Transaction kept short (no user input inside)

```csharp
// ✅ Good: Atomic operation
await using var transaction = await _context.Database
    .BeginTransactionAsync();

try
{
    var order = await _context.Orders.FindAsync(orderId);
    order.Status = "cancelled";
    
    var inventory = await _context.Inventory.FindAsync(order.ProductId);
    inventory.Quantity += order.Quantity;
    
    await _context.SaveChangesAsync();
    await transaction.CommitAsync();
}
catch
{
    await transaction.RollbackAsync();
    throw;
}
```

### Isolation Levels

| Level | Use When | Risk |
|-------|----------|------|
| Read Committed (default) | Most operations | Phantom reads possible |
| Repeatable Read | Reading data twice must be consistent | Higher contention |
| Serializable | Financial calculations | Deadlocks more likely |

---

## Connection Management

### Connection Pooling

- [ ] Connection pool configured appropriately
- [ ] Connections released promptly
- [ ] No connection leaks
- [ ] MaxPoolSize appropriate for workload

```csharp
// appsettings.json
"ConnectionStrings": {
    "Default": "Host=...;Database=...;Username=...;Password=...;" +
               "Maximum Pool Size=100;Connection Idle Lifetime=300"
}

// ✅ Good: Using statement ensures release
await using var connection = new NpgsqlConnection(connStr);
await connection.OpenAsync();
// Connection returned to pool on dispose
```

### EF Core Connection

```csharp
// ✅ Good: DbContext is scoped, handles connections
services.AddDbContext<AppDbContext>(options =>
    options.UseNpgsql(configuration.GetConnectionString("Default")));

// DbContext handles connection lifecycle
// Don't manually open/close
```

---

## Migration Safety Patterns

### Adding a Column

```sql
-- Phase 1: Add nullable column
ALTER TABLE users ADD COLUMN new_field VARCHAR(100);

-- Phase 2: Backfill data (in chunks via application)
-- UPDATE users SET new_field = computed_value WHERE id BETWEEN...

-- Phase 3: Add NOT NULL (if needed)
ALTER TABLE users ALTER COLUMN new_field SET NOT NULL;

-- Phase 4: Add default (if needed)
ALTER TABLE users ALTER COLUMN new_field SET DEFAULT 'value';
```

### Removing a Column

```sql
-- Phase 1: Stop writing to column (code change)
-- Phase 2: Stop reading from column (code change)
-- Phase 3: Rename column (monitor for errors)
ALTER TABLE users RENAME COLUMN old_field TO _deprecated_old_field;

-- Phase 4: Drop after observation period (1+ weeks)
ALTER TABLE users DROP COLUMN _deprecated_old_field;
```

### Renaming a Table

```sql
-- Phase 1: Create new table
-- Phase 2: Dual-write to both
-- Phase 3: Migrate data
-- Phase 4: Switch reads to new table
-- Phase 5: Drop old table
```

---

## Query Optimization Tips

### EXPLAIN ANALYZE

```sql
-- Always analyze expensive queries
EXPLAIN ANALYZE
SELECT o.*, c.name 
FROM orders o
JOIN customers c ON o.customer_id = c.id
WHERE o.status = 'pending'
ORDER BY o.created_at DESC
LIMIT 100;

-- Look for:
-- - Seq Scan on large tables (needs index)
-- - High cost numbers
-- - Appropriate use of indexes
```

### Common Optimizations

```sql
-- Pagination: Use keyset pagination for large offsets
-- ❌ Bad: OFFSET gets slower as it grows
SELECT * FROM items ORDER BY id LIMIT 10 OFFSET 10000;

-- ✅ Good: Keyset pagination
SELECT * FROM items WHERE id > 12345 ORDER BY id LIMIT 10;

-- ✅ Good: Date ranges use BETWEEN
SELECT * FROM orders 
WHERE created_at BETWEEN '2024-01-01' AND '2024-01-31';

-- ✅ Good: Use EXISTS instead of IN for large sets
SELECT * FROM customers c
WHERE EXISTS (
    SELECT 1 FROM orders o WHERE o.customer_id = c.id
);
```

---

## Red Flags

| Issue | Why It's Bad | Solution |
|-------|--------------|----------|
| No indexes on foreign keys | Slow JOINs | Add indexes |
| Missing NOT NULL on required fields | Data integrity issues | Add constraints |
| VARCHAR without length | Hidden limits | Specify length |
| FLOAT for money | Precision loss | Use DECIMAL |
| No EXPLAIN ANALYZE on new queries | Unknown performance | Always analyze |
| Direct DELETE/UPDATE without WHERE | Catastrophic loss | Require WHERE clause |
