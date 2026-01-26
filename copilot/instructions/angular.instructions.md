---
applyTo: "**/*.component.ts,**/*.service.ts,**/*.directive.ts,**/*.pipe.ts"
---

# Angular Guidelines

## Components
- Use standalone components
- Use signals for state management
- Use the new control flow syntax (`@if`, `@for`, `@switch`)
- Inject dependencies using `inject()` function
- Keep components small and focused

## Structure
```
feature/
  feature.component.ts      # Main component
  feature.component.html    # Template (if separate)
  feature.component.spec.ts # Tests
  feature.service.ts        # Feature-specific service
  feature.model.ts          # Types and interfaces
```

## Signals
```typescript
// Prefer signals over BehaviorSubject for component state
data = signal<DataType[]>([]);
loading = signal(false);
error = signal<string | null>(null);

// Use computed for derived state
filteredData = computed(() => this.data().filter(x => x.active));
```
