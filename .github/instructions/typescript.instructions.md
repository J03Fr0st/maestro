---
applyTo: "**/*.ts,**/*.tsx,**/*.js,**/*.jsx"
---

# TypeScript/JavaScript Guidelines

## Type Safety
- Use TypeScript strict mode
- Prefer `const` over `let`, never use `var`
- Use `unknown` instead of `any` when type is truly unknown
- Prefer `interface` over `type` for object shapes

## Modern Syntax
- Use ES6+ features (arrow functions, destructuring, template literals)
- Use optional chaining (`?.`) and nullish coalescing (`??`)
- Handle all promise rejections

## Error Handling
```typescript
// Use Result pattern for operations that can fail
type Result<T, E = Error> = { ok: true; value: T } | { ok: false; error: E };
```

## Imports
- Use named imports over default imports where possible
- Group imports: external, internal, relative
- Use type-only imports when importing just types
