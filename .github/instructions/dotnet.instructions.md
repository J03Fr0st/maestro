---
applyTo: "**/*.cs"
---

# .NET/C# Guidelines

## Modern C# Features
- Use file-scoped namespaces
- Use records for DTOs
- Use primary constructors where appropriate
- Follow async/await patterns consistently
- Use nullable reference types

## API Patterns
```csharp
// Minimal API style
app.MapGet("/api/items/{id}", async (int id, IItemService service) =>
    await service.GetById(id) is Item item
        ? Results.Ok(item)
        : Results.NotFound());

// Standard response format
public record ApiResponse<T>(T Data, ApiMeta? Meta = null, ApiError[]? Errors = null);
```

## Error Handling
- Use Result pattern for service methods
- Return appropriate HTTP status codes
- Include meaningful error messages
- Log errors with context

## Naming
- PascalCase for public members
- _camelCase for private fields
- Async suffix for async methods
