---
applyTo: "**"
---

# Security Guidelines

## Input Validation
- Validate ALL user input (forms, query params, headers, file uploads)
- Use schema validation (Zod, class-validator, FluentValidation)
- Never trust input directly

## SQL Injection Prevention
Always use parameterized queries:
```csharp
// Safe
db.Query("SELECT * FROM Users WHERE Id = @Id", new { Id = id });

// NEVER do this
db.Query($"SELECT * FROM Users WHERE Id = {id}");
```

## XSS Prevention
- Use framework's built-in encoding
- Avoid `innerHTML`, `[innerHTML]`, `dangerouslySetInnerHTML` with user content
- Sanitize if raw HTML is required

## Authentication & Authorization
- Verify user owns the resource on every request
- Don't rely on UI hiding for security
- Use established auth libraries (don't roll your own)
- Implement rate limiting on auth endpoints

## Sensitive Data
Never log or commit:
- Passwords, API keys, secrets
- Credit card numbers, SSN
- Connection strings with credentials

## Error Handling
```csharp
// Return generic messages to users
return Problem("An error occurred");

// Log details internally
logger.LogError(ex, "Context info");
```

## Red Flags - Always Reject
- Hardcoded credentials
- Disabled security features (`ValidateIssuer = false`)
- User input in `Process.Start()` or `eval()`
- Weak crypto (MD5, SHA1, DES)
