# Security Review

Security-focused code review checklist based on OWASP Top 10 and common vulnerabilities.

---

## Critical Security Checklist

### Authentication

- [ ] Passwords hashed with strong algorithm (bcrypt, Argon2)
- [ ] No plain-text password storage or logging
- [ ] Session tokens are cryptographically random
- [ ] Session invalidated on logout
- [ ] Account lockout after failed attempts
- [ ] MFA available for sensitive operations

```csharp
// ❌ Bad: MD5/SHA1 password hash
var hash = SHA1.ComputeHash(Encoding.UTF8.GetBytes(password));

// ✅ Good: bcrypt
var hash = BCrypt.Net.BCrypt.HashPassword(password);
var valid = BCrypt.Net.BCrypt.Verify(password, hash);

// ❌ Bad: Logging password
_logger.LogInformation("User login: {Email}, Password: {Password}", email, password);

// ✅ Good: Never log credentials
_logger.LogInformation("User login attempt: {Email}", email);
```

### Authorization

- [ ] Authorization checked on every endpoint
- [ ] User can only access their own resources (no IDOR)
- [ ] Role/permission checks at service layer
- [ ] Principle of least privilege

```csharp
// ❌ Bad: No authorization check (IDOR vulnerability)
[HttpGet("orders/{orderId}")]
public async Task<Order> GetOrder(int orderId)
{
    return await _context.Orders.FindAsync(orderId);
    // Any user can access any order!
}

// ✅ Good: Verify ownership
[HttpGet("orders/{orderId}")]
public async Task<ActionResult<Order>> GetOrder(int orderId)
{
    var userId = User.GetUserId();
    var order = await _context.Orders
        .FirstOrDefaultAsync(o => o.Id == orderId && o.UserId == userId);
    
    if (order is null)
        return NotFound(); // Don't reveal existence
    
    return order;
}
```

---

## OWASP Top 10 Review

### 1. Injection (SQL, NoSQL, OS, LDAP)

- [ ] Parameterized queries used
- [ ] ORM used correctly (no raw SQL with string concat)
- [ ] Input validated before use in queries

```csharp
// ❌ SQL Injection vulnerability
var sql = $"SELECT * FROM Users WHERE Name = '{name}'";

// ✅ Parameterized query
var sql = "SELECT * FROM Users WHERE Name = @Name";
var user = await connection.QueryAsync(sql, new { Name = name });

// ✅ EF Core (automatic parameterization)
var user = await _context.Users
    .Where(u => u.Name == name)
    .FirstOrDefaultAsync();
```

### 2. Broken Authentication

- [ ] Strong password policy enforced
- [ ] Secure session management
- [ ] No credentials in URL
- [ ] Proper JWT validation

```csharp
// ❌ Bad: Weak JWT validation
services.AddAuthentication().AddJwtBearer(options =>
{
    options.TokenValidationParameters = new TokenValidationParameters
    {
        ValidateIssuer = false, // Vulnerable!
        ValidateAudience = false, // Vulnerable!
        ValidateLifetime = false // Expired tokens accepted!
    };
});

// ✅ Good: Complete validation
services.AddAuthentication().AddJwtBearer(options =>
{
    options.TokenValidationParameters = new TokenValidationParameters
    {
        ValidateIssuer = true,
        ValidIssuer = configuration["Jwt:Issuer"],
        ValidateAudience = true,
        ValidAudience = configuration["Jwt:Audience"],
        ValidateLifetime = true,
        ValidateIssuerSigningKey = true,
        IssuerSigningKey = new SymmetricSecurityKey(key)
    };
});
```

### 3. Sensitive Data Exposure

- [ ] Sensitive data encrypted at rest
- [ ] HTTPS enforced
- [ ] Sensitive data not in logs
- [ ] PII minimized in responses

```csharp
// ❌ Bad: Sensitive data in response
return Ok(new { user.Email, user.Password, user.SSN });

// ✅ Good: DTO with only necessary fields
return Ok(new UserResponse { Email = user.Email, Name = user.Name });

// ❌ Bad: Sensitive data in URL (appears in logs)
GET /api/users?ssn=123-45-6789

// ✅ Good: POST with body
POST /api/users/verify
{ "ssn": "123-45-6789" }
```

### 4. XML External Entities (XXE)

- [ ] XML parsing configured to disable external entities
- [ ] Consider using JSON instead of XML

```csharp
// ❌ Vulnerable to XXE
var doc = new XmlDocument();
doc.Load(xmlInput);

// ✅ Safe: Disable DTD processing
var settings = new XmlReaderSettings
{
    DtdProcessing = DtdProcessing.Prohibit,
    XmlResolver = null
};
using var reader = XmlReader.Create(xmlInput, settings);
```

### 5. Broken Access Control

- [ ] Role-based access enforced
- [ ] Admin functions protected
- [ ] Direct object references validated

```csharp
// ❌ Bad: No role check
[HttpPost("admin/users")]
public async Task<IActionResult> CreateAdmin(AdminUserDto dto)
{
    // Any authenticated user can create admin!
}

// ✅ Good: Role authorization
[HttpPost("admin/users")]
[Authorize(Roles = "Admin")]
public async Task<IActionResult> CreateAdmin(AdminUserDto dto)
{
    // Only users with Admin role
}

// ✅ Better: Policy-based authorization
[HttpPost("admin/users")]
[Authorize(Policy = "RequireAdminRole")]
public async Task<IActionResult> CreateAdmin(AdminUserDto dto)
```

### 6. Security Misconfiguration

- [ ] Debug mode disabled in production
- [ ] Default credentials changed
- [ ] Error messages don't expose stack traces
- [ ] Unnecessary features disabled

```csharp
// ❌ Bad: Stack trace to user
catch (Exception ex)
{
    return StatusCode(500, ex.ToString());
}

// ✅ Good: Generic message, log internally
catch (Exception ex)
{
    _logger.LogError(ex, "Error processing request");
    return StatusCode(500, new { error = "An error occurred" });
}
```

### 7. Cross-Site Scripting (XSS)

- [ ] User input escaped before rendering
- [ ] Content-Security-Policy header set
- [ ] No innerHTML with user data

```typescript
// ❌ XSS vulnerability (Angular)
<div [innerHTML]="userInput"></div>

// ✅ Safe: Text interpolation (escaped)
<div>{{ userInput }}</div>

// ✅ If HTML needed: Sanitize
import { DomSanitizer } from '@angular/platform-browser';
safeHtml = this.sanitizer.bypassSecurityTrustHtml(cleaned);
```

```csharp
// ❌ XSS vulnerability (C#/Razor)
@Html.Raw(userInput)

// ✅ Safe: Automatic encoding
@userInput
```

### 8. Insecure Deserialization

- [ ] No deserialization of untrusted data
- [ ] Type validation on deserialization
- [ ] Avoid BinaryFormatter, use JSON

```csharp
// ❌ Dangerous: BinaryFormatter (RCE vulnerability)
var formatter = new BinaryFormatter();
var obj = formatter.Deserialize(stream);

// ✅ Safe: JSON with type restrictions
var options = new JsonSerializerOptions { /* ... */ };
var obj = JsonSerializer.Deserialize<ExpectedType>(json, options);
```

### 9. Using Components with Known Vulnerabilities

- [ ] Dependencies up to date
- [ ] No known CVEs in dependencies
- [ ] Regular dependency audits

```bash
# Check for vulnerabilities
dotnet list package --vulnerable
npm audit
```

### 10. Insufficient Logging & Monitoring

- [ ] Security events logged
- [ ] Logs don't contain sensitive data
- [ ] Alerts configured for suspicious activity

```csharp
// ✅ Good: Security event logging
_logger.LogWarning("Failed login attempt for user {Email} from IP {IP}",
    email, HttpContext.Connection.RemoteIpAddress);

_logger.LogWarning("Authorization denied for user {UserId} on resource {Resource}",
    userId, resourceId);
```

---

## Input Validation

### Always Validate

- [ ] Type validation (expected type?)
- [ ] Range validation (within bounds?)
- [ ] Format validation (email, phone, etc.)
- [ ] Length validation (not too long?)
- [ ] Business rule validation

```csharp
// ✅ Good: Comprehensive validation
public class CreateOrderDto
{
    [Required]
    [Range(1, 10000)]
    public int Quantity { get; set; }
    
    [Required]
    [StringLength(100, MinimumLength = 1)]
    public string ProductId { get; set; } = string.Empty;
    
    [EmailAddress]
    public string? NotificationEmail { get; set; }
}
```

### Sanitization vs Validation

| Approach | When to Use |
|----------|-------------|
| **Validation** | Reject invalid input (preferred) |
| **Sanitization** | Clean input before use (use carefully) |

```csharp
// ✅ Validation: Reject bad input
if (!Uri.IsWellFormedUriString(url, UriKind.Absolute))
    throw new ValidationException("Invalid URL");

// ⚠️ Sanitization: Only when HTML is truly needed
var clean = HtmlSanitizer.Sanitize(userInput);
```

---

## API Security

### CORS

```csharp
// ❌ Bad: Allow all origins
services.AddCors(options =>
{
    options.AddPolicy("AllowAll", builder =>
        builder.AllowAnyOrigin().AllowAnyMethod().AllowAnyHeader());
});

// ✅ Good: Specific origins
services.AddCors(options =>
{
    options.AddPolicy("Production", builder =>
        builder.WithOrigins("https://myapp.com", "https://admin.myapp.com")
               .AllowAnyMethod()
               .AllowAnyHeader()
               .AllowCredentials());
});
```

### Rate Limiting

```csharp
// ✅ Good: Rate limiting on sensitive endpoints
[HttpPost("login")]
[EnableRateLimiting("login")]
public async Task<IActionResult> Login(LoginDto dto)

// Configuration
services.AddRateLimiter(options =>
{
    options.AddFixedWindowLimiter("login", opt =>
    {
        opt.Window = TimeSpan.FromMinutes(1);
        opt.PermitLimit = 5;
        opt.QueueLimit = 0;
    });
});
```

---

## Secrets Management

### Never In Code

```csharp
// ❌ Bad: Hardcoded secrets
var apiKey = "sk-1234567890abcdef";
var connectionString = "Server=prod;Password=admin123";

// ✅ Good: Environment/configuration
var apiKey = configuration["ExternalApi:Key"];
var connectionString = configuration.GetConnectionString("Default");

// ✅ Better: Secret manager in development
// dotnet user-secrets set "ExternalApi:Key" "sk-..."
```

### Environment Separation

- [ ] Different credentials per environment
- [ ] Secrets not in source control
- [ ] Secrets rotated regularly
- [ ] Least privilege for service accounts

---

## Security Headers

```csharp
// Recommended headers
app.Use(async (context, next) =>
{
    context.Response.Headers["X-Content-Type-Options"] = "nosniff";
    context.Response.Headers["X-Frame-Options"] = "DENY";
    context.Response.Headers["X-XSS-Protection"] = "1; mode=block";
    context.Response.Headers["Referrer-Policy"] = "strict-origin-when-cross-origin";
    context.Response.Headers["Content-Security-Policy"] = 
        "default-src 'self'; script-src 'self'; style-src 'self' 'unsafe-inline'";
    await next();
});
```

---

## Quick Reference: Security Red Flags

| Red Flag | Why It's Bad | Fix |
|----------|--------------|-----|
| String concatenation in SQL | SQL injection | Parameterized queries |
| `innerHTML` with user input | XSS | Text interpolation + sanitize |
| `ValidateIssuer = false` | JWT bypass | Enable all validations |
| Hardcoded credentials | Credential theft | Configuration/secrets manager |
| `catch { return ex.ToString() }` | Information disclosure | Generic error + log |
| `AllowAnyOrigin()` | CSRF/data theft | Specific origins |
| No rate limiting on login | Brute force | Rate limiting |
| `BinaryFormatter` | RCE vulnerability | JSON serialization |
