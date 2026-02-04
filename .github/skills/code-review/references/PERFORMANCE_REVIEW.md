# Performance Review

Performance-focused code review for high-traffic areas and optimization work.

---

## Performance Impact Checklist

### Before Approving

- [ ] Performance impact considered for the change
- [ ] N+1 queries eliminated
- [ ] Unnecessary database calls removed
- [ ] Large data sets paginated
- [ ] Caching utilized where appropriate
- [ ] Async operations don't block

### For High-Traffic Areas

- [ ] Load testing performed
- [ ] Metrics/monitoring in place
- [ ] Graceful degradation considered
- [ ] Database indexes reviewed

---

## Database Performance

### Query Optimization

```csharp
// ❌ Bad: N+1 query (1 query + N queries)
var orders = await _context.Orders.ToListAsync();
foreach (var order in orders)
{
    order.Items = await _context.OrderItems
        .Where(i => i.OrderId == order.Id)
        .ToListAsync();
}

// ✅ Good: Eager loading (1 query)
var orders = await _context.Orders
    .Include(o => o.Items)
    .ToListAsync();

// ✅ Better: Projection for read-only (1 query, less data)
var orders = await _context.Orders
    .Select(o => new OrderDto
    {
        Id = o.Id,
        ItemCount = o.Items.Count,
        Total = o.Items.Sum(i => i.Price)
    })
    .ToListAsync();
```

### Pagination

```csharp
// ❌ Bad: Loading entire table
var all = await _context.Products.ToListAsync();
return all.Skip(page * size).Take(size);

// ✅ Good: Database-level pagination
var products = await _context.Products
    .OrderBy(p => p.Name)
    .Skip(page * size)
    .Take(size)
    .ToListAsync();

// ✅ Best: Keyset pagination (for large offsets)
var products = await _context.Products
    .Where(p => p.Id > lastId)
    .OrderBy(p => p.Id)
    .Take(size)
    .ToListAsync();
```

### Indexing

```sql
-- Common index patterns

-- For WHERE clauses
CREATE INDEX idx_orders_status ON orders(status);

-- For JOINs
CREATE INDEX idx_order_items_order_id ON order_items(order_id);

-- Composite for common queries
CREATE INDEX idx_orders_user_status_date 
ON orders(user_id, status, created_at DESC);

-- Covering index (includes all needed columns)
CREATE INDEX idx_orders_covering ON orders(user_id, status)
INCLUDE (id, total_amount);
```

---

## Memory Management

### C# Memory Patterns

```csharp
// ❌ Bad: Large object in memory
var allData = await _context.Records
    .Where(r => r.Date > startDate)
    .ToListAsync(); // Could be millions of rows!

// ✅ Good: Streaming for large data
await foreach (var record in _context.Records
    .Where(r => r.Date > startDate)
    .AsAsyncEnumerable())
{
    await ProcessRecord(record);
}

// ❌ Bad: String concatenation in loop
var result = "";
foreach (var item in items)
{
    result += item.Name + ","; // New string each time!
}

// ✅ Good: StringBuilder
var sb = new StringBuilder();
foreach (var item in items)
{
    sb.Append(item.Name).Append(',');
}
```

### Memory Leaks

```csharp
// ❌ Bad: Event handler not unsubscribed
public class MyService
{
    public MyService(IEventBus bus)
    {
        bus.OnEvent += HandleEvent; // Never unsubscribed!
    }
}

// ✅ Good: IDisposable pattern
public class MyService : IDisposable
{
    private readonly IEventBus _bus;
    
    public MyService(IEventBus bus)
    {
        _bus = bus;
        _bus.OnEvent += HandleEvent;
    }
    
    public void Dispose()
    {
        _bus.OnEvent -= HandleEvent;
    }
}

// ✅ Best: Weak event pattern or reactive extensions
```

---

## Async Performance

### Correct Async Usage

```csharp
// ❌ Bad: Blocking async call
var result = GetDataAsync().Result; // Blocks thread!

// ❌ Bad: Sync over async
Task.Run(() => GetDataAsync()).Wait(); // Still blocking!

// ✅ Good: Async all the way
var result = await GetDataAsync();

// ❌ Bad: Sequential when parallel is possible
var user = await GetUserAsync(id);
var orders = await GetOrdersAsync(id);
var reviews = await GetReviewsAsync(id);

// ✅ Good: Parallel when independent
var userTask = GetUserAsync(id);
var ordersTask = GetOrdersAsync(id);
var reviewsTask = GetReviewsAsync(id);

await Task.WhenAll(userTask, ordersTask, reviewsTask);

var user = await userTask;
var orders = await ordersTask;
var reviews = await reviewsTask;
```

### Async Streams

```csharp
// ✅ Good: Async enumerable for streaming
public async IAsyncEnumerable<LogEntry> StreamLogsAsync(
    [EnumeratorCancellation] CancellationToken ct = default)
{
    var reader = await _logSource.OpenReaderAsync(ct);
    
    while (await reader.MoveNextAsync(ct))
    {
        yield return reader.Current;
    }
}

// Consumer
await foreach (var log in StreamLogsAsync(cancellationToken))
{
    await ProcessLogAsync(log);
}
```

---

## Caching Strategies

### When to Cache

| Data Type | Cache Duration | Invalidation |
|-----------|----------------|--------------|
| Static config | Long (hours) | On deploy |
| Reference data | Medium (minutes) | TTL or event |
| User data | Short (seconds) | On update |
| Search results | Short (seconds) | TTL |

### Cache Implementation

```csharp
// ✅ Good: Cache-aside pattern
public async Task<Product?> GetProductAsync(int id)
{
    var cacheKey = $"product:{id}";
    
    // Try cache first
    if (_cache.TryGetValue(cacheKey, out Product? cached))
    {
        return cached;
    }
    
    // Get from database
    var product = await _context.Products.FindAsync(id);
    
    if (product != null)
    {
        // Cache with expiration
        _cache.Set(cacheKey, product, TimeSpan.FromMinutes(5));
    }
    
    return product;
}

// ✅ Good: Batch cache lookup
public async Task<List<Product>> GetProductsAsync(List<int> ids)
{
    var results = new List<Product>();
    var missingIds = new List<int>();
    
    // Check cache
    foreach (var id in ids)
    {
        if (_cache.TryGetValue($"product:{id}", out Product? cached))
            results.Add(cached);
        else
            missingIds.Add(id);
    }
    
    // Batch fetch missing
    if (missingIds.Any())
    {
        var fetched = await _context.Products
            .Where(p => missingIds.Contains(p.Id))
            .ToListAsync();
        
        foreach (var product in fetched)
        {
            _cache.Set($"product:{product.Id}", product, TimeSpan.FromMinutes(5));
            results.Add(product);
        }
    }
    
    return results;
}
```

### Cache Invalidation

```csharp
// ✅ Good: Explicit invalidation
public async Task UpdateProductAsync(int id, UpdateProductDto dto)
{
    var product = await _context.Products.FindAsync(id);
    if (product == null) throw new NotFoundException();
    
    // Update database
    product.Name = dto.Name;
    product.Price = dto.Price;
    await _context.SaveChangesAsync();
    
    // Invalidate cache
    _cache.Remove($"product:{id}");
    _cache.Remove($"products:list"); // Related caches too
}
```

---

## HTTP Performance

### Response Optimization

```csharp
// ✅ Good: Only return needed fields
[HttpGet]
public async Task<ActionResult<List<ProductListDto>>> GetProducts()
{
    return await _context.Products
        .Select(p => new ProductListDto
        {
            Id = p.Id,
            Name = p.Name,
            Price = p.Price
            // Don't include Description, Images, etc.
        })
        .ToListAsync();
}

// ✅ Good: Compression enabled
services.AddResponseCompression(options =>
{
    options.EnableForHttps = true;
    options.Providers.Add<GzipCompressionProvider>();
    options.Providers.Add<BrotliCompressionProvider>();
});
```

### Request Batching

```csharp
// ❌ Bad: Multiple network calls
var user = await httpClient.GetAsync("/api/users/1");
var orders = await httpClient.GetAsync("/api/users/1/orders");
var settings = await httpClient.GetAsync("/api/users/1/settings");

// ✅ Good: Batch endpoint
var userDetails = await httpClient.GetAsync("/api/users/1/full-profile");
// Returns user, orders, and settings in one call

// ✅ Alternative: GraphQL for flexible batching
var query = @"
    query {
        user(id: 1) {
            name
            orders { id, total }
            settings { theme }
        }
    }
";
```

---

## Angular Performance (Quick Reference)

See [ANGULAR_PERFORMANCE_REVIEW.md](ANGULAR_PERFORMANCE_REVIEW.md) for full details.

### Quick Wins

| Issue | Fix |
|-------|-----|
| Slow list rendering | Add trackBy |
| Excessive change detection | Use OnPush |
| Memory leaks | takeUntilDestroyed |
| Large initial bundle | Lazy loading |
| Template functions | Use computed signals |

---

## Performance Testing

### Load Testing Before Merge

For changes to:
- Database queries
- High-traffic API endpoints
- Caching logic
- Background processing

```bash
# k6 example
k6 run --vus 100 --duration 30s load-test.js
```

### Metrics to Track

| Metric | Target |
|--------|--------|
| P50 response time | <100ms |
| P95 response time | <500ms |
| P99 response time | <1s |
| Error rate | <0.1% |
| Throughput | Baseline + 20% |

---

## Red Flags

| Red Flag | Why It's Bad | Fix |
|----------|--------------|-----|
| `ToListAsync()` then LINQ | Processes in memory | Database query |
| `.Result` or `.Wait()` | Blocks thread | `await` |
| No pagination | Memory/timeout | Add Skip/Take |
| Missing indexes on JOIN columns | Slow queries | Add index |
| Cache without invalidation | Stale data | Add invalidation |
| `string +=` in loop | O(n²) allocations | StringBuilder |
| Sequential async when parallel possible | Slow | Task.WhenAll |

---

## Performance Review Questions

1. **Database impact?** How many queries, what size result sets?
2. **Memory impact?** Any large objects held in memory?
3. **Network impact?** How many external calls?
4. **Caching opportunity?** Is this data cacheable?
5. **Scaling concern?** What happens with 10x load?
6. **Degradation plan?** What fails gracefully?
