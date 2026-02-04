# C# Backend Code Review

C# and .NET API-specific review guidance.

---

## Controller Review Checklist

### Route and Action Design

- [ ] RESTful conventions followed (GET, POST, PUT, DELETE)
- [ ] Routes are logical and consistent
- [ ] Action names describe the operation
- [ ] API versioning used if needed

```csharp
// ✅ Good: RESTful controller
[ApiController]
[Route("api/v1/[controller]")]
public class UsersController : ControllerBase
{
    [HttpGet]              // GET /api/v1/users
    [HttpGet("{id}")]      // GET /api/v1/users/123
    [HttpPost]             // POST /api/v1/users
    [HttpPut("{id}")]      // PUT /api/v1/users/123
    [HttpDelete("{id}")]   // DELETE /api/v1/users/123
}
```

### HTTP Status Codes

- [ ] Returns appropriate status codes
- [ ] 200 for successful GET
- [ ] 201 for successful POST (with Location header)
- [ ] 204 for successful DELETE
- [ ] 400 for bad request (validation errors)
- [ ] 401 for authentication required
- [ ] 403 for authorization denied
- [ ] 404 for not found
- [ ] 500 only for unexpected errors

```csharp
// ✅ Good: Appropriate status codes
[HttpGet("{id}")]
public async Task<ActionResult<UserDto>> GetUser(int id)
{
    var user = await _userService.GetByIdAsync(id);
    
    if (user is null)
        return NotFound();
    
    return Ok(_mapper.Map<UserDto>(user));
}

[HttpPost]
public async Task<ActionResult<UserDto>> CreateUser(CreateUserDto dto)
{
    if (!ModelState.IsValid)
        return BadRequest(ModelState);
    
    var user = await _userService.CreateAsync(dto);
    return CreatedAtAction(nameof(GetUser), new { id = user.Id }, user);
}
```

### Input Validation

- [ ] Model validation attributes used
- [ ] FluentValidation for complex rules
- [ ] Validation errors returned clearly
- [ ] No trust of client input

```csharp
// ✅ Good: DTO with validation
public class CreateUserDto
{
    [Required]
    [StringLength(100, MinimumLength = 2)]
    public string Name { get; set; } = string.Empty;
    
    [Required]
    [EmailAddress]
    public string Email { get; set; } = string.Empty;
    
    [Required]
    [MinLength(8)]
    public string Password { get; set; } = string.Empty;
}

// With FluentValidation for complex rules
public class CreateUserValidator : AbstractValidator<CreateUserDto>
{
    public CreateUserValidator()
    {
        RuleFor(x => x.Email)
            .NotEmpty()
            .EmailAddress()
            .MustAsync(BeUniqueEmail)
            .WithMessage("Email already exists");
    }
}
```

---

## Async/Await Review

### Critical Rules

- [ ] **No async void** (except event handlers)
- [ ] **Always await or return task**
- [ ] **Use ConfigureAwait where appropriate**
- [ ] **Don't block with .Result or .Wait()**

```csharp
// ❌ Bad: async void (fire and forget, exceptions lost)
public async void ProcessDataAsync() { }

// ✅ Good: async Task
public async Task ProcessDataAsync() { }

// ❌ Bad: Blocking
var result = GetDataAsync().Result; // Deadlock risk!
var result = GetDataAsync().GetAwaiter().GetResult(); // Still blocking

// ✅ Good: Async all the way
var result = await GetDataAsync();

// ❌ Bad: Forgetting to await
public async Task ProcessAsync()
{
    SaveAsync(); // Not awaited! Runs in background
}

// ✅ Good: Properly awaited
public async Task ProcessAsync()
{
    await SaveAsync();
}
```

### Async Patterns

```csharp
// ✅ Good: Parallel async operations
var task1 = GetUserAsync(id);
var task2 = GetOrdersAsync(id);
await Task.WhenAll(task1, task2);
var user = await task1;
var orders = await task2;

// ✅ Good: Async enumerable for streaming
public async IAsyncEnumerable<Item> GetItemsAsync(
    [EnumeratorCancellation] CancellationToken ct = default)
{
    await foreach (var item in _repository.StreamItemsAsync(ct))
    {
        yield return item;
    }
}
```

---

## Dependency Injection

### Registration

- [ ] Appropriate lifetime (Singleton, Scoped, Transient)
- [ ] Interfaces used for testability
- [ ] No service locator pattern
- [ ] Factory pattern for complex creation

```csharp
// ✅ Good: Proper DI registration
services.AddScoped<IUserService, UserService>();
services.AddSingleton<ICacheService, RedisCacheService>();
services.AddTransient<IEmailSender, SmtpEmailSender>();

// Service lifetimes:
// Singleton: Same instance forever (config, cache)
// Scoped: Same instance per request (DbContext, services with request state)
// Transient: New instance each time (lightweight, stateless)
```

### Constructor Injection

```csharp
// ✅ Good: Constructor injection
public class UserService : IUserService
{
    private readonly IUserRepository _repository;
    private readonly ILogger<UserService> _logger;
    
    public UserService(IUserRepository repository, ILogger<UserService> logger)
    {
        _repository = repository;
        _logger = logger;
    }
}

// ❌ Bad: Service locator
public class UserService
{
    public void DoSomething()
    {
        var repo = ServiceLocator.Get<IUserRepository>(); // Anti-pattern!
    }
}
```

---

## Error Handling

### Controller Level

```csharp
// ✅ Good: Specific exception handling
[HttpGet("{id}")]
public async Task<ActionResult<UserDto>> GetUser(int id)
{
    try
    {
        var user = await _userService.GetByIdAsync(id);
        return Ok(user);
    }
    catch (NotFoundException)
    {
        return NotFound();
    }
    catch (UnauthorizedException)
    {
        return Forbid();
    }
    // Let global handler catch unexpected exceptions
}
```

### Global Exception Handling

```csharp
// ✅ Good: Exception middleware
public class ExceptionMiddleware
{
    public async Task InvokeAsync(HttpContext context, RequestDelegate next)
    {
        try
        {
            await next(context);
        }
        catch (ValidationException ex)
        {
            context.Response.StatusCode = 400;
            await context.Response.WriteAsJsonAsync(new { errors = ex.Errors });
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Unhandled exception");
            context.Response.StatusCode = 500;
            await context.Response.WriteAsJsonAsync(new { error = "Internal error" });
        }
    }
}
```

### Logging

- [ ] Structured logging used
- [ ] Appropriate log levels
- [ ] No sensitive data logged
- [ ] Correlation IDs included

```csharp
// ✅ Good: Structured logging
_logger.LogInformation("Processing order {OrderId} for user {UserId}", 
    order.Id, user.Id);

// ❌ Bad: String interpolation loses structure
_logger.LogInformation($"Processing order {order.Id} for user {user.Id}");

// ❌ Bad: Logging sensitive data
_logger.LogInformation("User login: {Email}, Password: {Password}", 
    email, password); // NEVER!
```

---

## Entity Framework / Database

### Query Optimization

- [ ] No N+1 queries (use Include/ThenInclude)
- [ ] Projections used when full entity not needed
- [ ] AsNoTracking for read-only queries
- [ ] Pagination for large result sets

```csharp
// ❌ Bad: N+1 query
var users = await _context.Users.ToListAsync();
foreach (var user in users)
{
    var orders = await _context.Orders
        .Where(o => o.UserId == user.Id)
        .ToListAsync(); // Query per user!
}

// ✅ Good: Eager loading
var users = await _context.Users
    .Include(u => u.Orders)
    .ToListAsync();

// ✅ Good: Projection for read-only
var userDtos = await _context.Users
    .AsNoTracking()
    .Select(u => new UserDto
    {
        Id = u.Id,
        Name = u.Name,
        OrderCount = u.Orders.Count
    })
    .ToListAsync();
```

### Transaction Handling

```csharp
// ✅ Good: Explicit transaction
await using var transaction = await _context.Database
    .BeginTransactionAsync(cancellationToken);
try
{
    await _context.Users.AddAsync(user);
    await _context.Audit.AddAsync(auditEntry);
    await _context.SaveChangesAsync(cancellationToken);
    await transaction.CommitAsync(cancellationToken);
}
catch
{
    await transaction.RollbackAsync(cancellationToken);
    throw;
}
```

---

## API Design Patterns

### DTOs

- [ ] DTOs used for API contracts (not entities)
- [ ] Separate DTOs for input vs output
- [ ] Immutable DTOs where possible

```csharp
// ✅ Good: Separate input/output DTOs
public record CreateUserRequest(string Name, string Email, string Password);
public record UserResponse(int Id, string Name, string Email, DateTime CreatedAt);

// Mapping
var user = new User { Name = request.Name, Email = request.Email };
return new UserResponse(user.Id, user.Name, user.Email, user.CreatedAt);
```

### Result Pattern

```csharp
// ✅ Good: Result pattern for service layer
public class Result<T>
{
    public bool IsSuccess { get; }
    public T? Value { get; }
    public string? Error { get; }
    
    public static Result<T> Success(T value) => new(true, value, null);
    public static Result<T> Failure(string error) => new(false, default, error);
}

// Usage
public async Task<Result<User>> CreateUserAsync(CreateUserDto dto)
{
    if (await _repository.EmailExistsAsync(dto.Email))
        return Result<User>.Failure("Email already exists");
    
    var user = new User { /* ... */ };
    await _repository.AddAsync(user);
    return Result<User>.Success(user);
}
```

---

## Common C# Issues

### Null Reference

```csharp
// ❌ Bad: No null check
var user = await GetUserAsync(id);
return user.Name; // Throws if null

// ✅ Good: Null handling
var user = await GetUserAsync(id);
if (user is null)
    throw new NotFoundException($"User {id} not found");
return user.Name;

// ✅ Better: Nullable reference types enabled
public async Task<User?> GetUserAsync(int id)
// Compiler warns about possible null
```

### Disposable Resources

```csharp
// ❌ Bad: Not disposing
var connection = new SqlConnection(connStr);
// ...
// Connection leaked!

// ✅ Good: Using statement
await using var connection = new SqlConnection(connStr);
// Automatically disposed

// ✅ Good: IDisposable pattern for classes
public class ResourceConsumer : IDisposable, IAsyncDisposable
{
    public void Dispose() { /* ... */ }
    public async ValueTask DisposeAsync() { /* ... */ }
}
```

### String Operations

```csharp
// ❌ Bad: String concatenation in loop
var result = "";
foreach (var item in items)
    result += item.Name + ", "; // Creates new string each time

// ✅ Good: StringBuilder or LINQ
var result = string.Join(", ", items.Select(i => i.Name));
// or
var sb = new StringBuilder();
foreach (var item in items)
    sb.Append(item.Name).Append(", ");
```
