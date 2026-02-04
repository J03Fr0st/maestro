# Angular Frontend Code Review

Angular-specific review guidance for components, services, and state management.

---

## Component Review Checklist

### Change Detection

- [ ] Uses `OnPush` change detection where appropriate
- [ ] No unnecessary change detection cycles
- [ ] `markForCheck()` or `detectChanges()` used sparingly and correctly
- [ ] Async pipe used for observables (handles subscription/unsubscription)

```typescript
// ✅ Good: OnPush with async pipe
@Component({
  selector: 'app-user-list',
  template: `
    <div *ngFor="let user of users$ | async; trackBy: trackById">
      {{ user.name }}
    </div>
  `,
  changeDetection: ChangeDetectionStrategy.OnPush
})
export class UserListComponent {
  users$ = this.userService.getUsers();
  trackById = (index: number, user: User) => user.id;
}

// ❌ Bad: Default change detection, manual subscription
@Component({
  selector: 'app-user-list',
  template: `<div *ngFor="let user of users">{{ user.name }}</div>`
})
export class UserListComponent implements OnInit {
  users: User[] = [];
  ngOnInit() {
    this.userService.getUsers().subscribe(u => this.users = u);
    // Missing unsubscribe!
  }
}
```

### Subscription Management

- [ ] All subscriptions unsubscribed on destroy
- [ ] Using `takeUntilDestroyed()`, `DestroyRef`, or async pipe
- [ ] No subscription in subscription (nested subscribes)
- [ ] Subject/BehaviorSubject properly completed

```typescript
// ✅ Good: takeUntilDestroyed
export class MyComponent {
  private destroyRef = inject(DestroyRef);
  
  ngOnInit() {
    this.data$.pipe(
      takeUntilDestroyed(this.destroyRef)
    ).subscribe(data => this.process(data));
  }
}

// ❌ Bad: Manual subscription without cleanup
export class MyComponent implements OnInit {
  ngOnInit() {
    this.data$.subscribe(data => this.process(data));
    // Memory leak!
  }
}
```

### Template Best Practices

- [ ] `trackBy` used in `*ngFor` for lists
- [ ] No complex logic in templates (move to component/pipe)
- [ ] No direct function calls in templates for computed values
- [ ] Proper null handling with optional chaining or `*ngIf`

```typescript
// ✅ Good: trackBy function
<div *ngFor="let item of items; trackBy: trackById">

// ❌ Bad: No trackBy (causes full re-render)
<div *ngFor="let item of items">

// ✅ Good: Computed signal or getter
readonly displayName = computed(() => 
  `${this.user().firstName} ${this.user().lastName}`
);

// ❌ Bad: Function call in template (runs every cycle)
<span>{{ getDisplayName() }}</span>
```

### Input/Output

- [ ] Inputs immutable (don't mutate input objects)
- [ ] Required inputs marked appropriately
- [ ] Output events use EventEmitter correctly
- [ ] No two-way binding abuse

```typescript
// ✅ Good: Signal inputs (Angular 17+)
@Component({...})
export class UserCardComponent {
  user = input.required<User>();
  deleted = output<string>();
  
  onDelete() {
    this.deleted.emit(this.user().id);
  }
}

// ❌ Bad: Mutating input directly
@Component({...})
export class UserCardComponent {
  @Input() user!: User;
  
  updateName(name: string) {
    this.user.name = name; // Mutating parent's object!
  }
}
```

---

## Service Review Checklist

### Dependency Injection

- [ ] Services use `providedIn: 'root'` or appropriate scope
- [ ] No services provided in multiple modules (duplicates)
- [ ] Proper injection with `inject()` or constructor

```typescript
// ✅ Good: providedIn root for singletons
@Injectable({ providedIn: 'root' })
export class AuthService { }

// ✅ Good: Feature-scoped service
@Injectable()
export class FeatureService { }
// Provided in feature module's providers array
```

### HTTP Calls

- [ ] Error handling for all HTTP calls
- [ ] Loading states tracked
- [ ] Proper typing (not `any`)
- [ ] Operators used correctly (switchMap, exhaustMap, etc.)

```typescript
// ✅ Good: Proper error handling and typing
getUsers(): Observable<User[]> {
  return this.http.get<User[]>('/api/users').pipe(
    catchError(error => {
      this.logger.error('Failed to fetch users', error);
      return of([]); // or throwError
    })
  );
}

// ❌ Bad: No error handling, any type
getUsers() {
  return this.http.get('/api/users'); // Returns any
}
```

### State Management

- [ ] State clearly defined and typed
- [ ] State updates immutable
- [ ] Appropriate pattern for complexity (simple: service, complex: signals/NgRx)
- [ ] No duplicate state sources

---

## Forms Review Checklist

### Reactive Forms

- [ ] Form controls properly typed
- [ ] Validation appropriate and consistent
- [ ] Error messages user-friendly
- [ ] Form submission handles loading/error states

```typescript
// ✅ Good: Typed form with validation
this.form = this.fb.nonNullable.group({
  email: ['', [Validators.required, Validators.email]],
  password: ['', [Validators.required, Validators.minLength(8)]]
});

// With proper error display
<mat-error *ngIf="form.controls.email.hasError('email')">
  Please enter a valid email
</mat-error>
```

### Template-Driven Forms

- [ ] Properly bound with ngModel
- [ ] Validation attributes present
- [ ] Two-way binding used appropriately

---

## Routing Review Checklist

- [ ] Lazy loading used for feature modules
- [ ] Guards protect routes appropriately
- [ ] Resolvers fetch data before navigation
- [ ] Route params/query params typed
- [ ] Proper error handling for failed navigations

```typescript
// ✅ Good: Lazy loaded feature
{
  path: 'admin',
  loadChildren: () => import('./admin/admin.module')
    .then(m => m.AdminModule),
  canActivate: [AuthGuard, AdminGuard]
}
```

---

## Performance Red Flags

| Issue | Impact | Fix |
|-------|--------|-----|
| Missing `trackBy` | Full list re-render | Add trackBy function |
| Default change detection | Excessive checks | Use OnPush |
| Nested subscriptions | Memory leaks, race conditions | Use operators (switchMap) |
| Functions in templates | Runs every cycle | Use computed/signals/pipes |
| No lazy loading | Large initial bundle | Lazy load features |
| Unsubscribed subscriptions | Memory leaks | Use takeUntilDestroyed |

---

## Angular Signals Checklist (Angular 16+)

- [ ] Signals used for reactive state
- [ ] Computed signals for derived values
- [ ] Effects used sparingly and correctly
- [ ] Signal inputs/outputs in new components

```typescript
// ✅ Good: Signal-based state
@Component({...})
export class CounterComponent {
  count = signal(0);
  doubled = computed(() => this.count() * 2);
  
  increment() {
    this.count.update(c => c + 1);
  }
}
```

---

## Common Angular Issues

### Memory Leaks

```typescript
// ❌ Problem: Subscription not cleaned up
ngOnInit() {
  this.interval$ = interval(1000).subscribe(...)
}
// Component destroys but interval keeps running!

// ✅ Solution: Use takeUntilDestroyed
ngOnInit() {
  interval(1000).pipe(
    takeUntilDestroyed(this.destroyRef)
  ).subscribe(...)
}
```

### Change Detection Issues

```typescript
// ❌ Problem: ChangeDetectorRef.detectChanges() everywhere
this.data = newData;
this.cdr.detectChanges(); // Band-aid for OnPush issues

// ✅ Solution: Proper reactive approach
this.data$ = this.service.getData(); // Use async pipe
```

### Router Issues

```typescript
// ❌ Problem: Hard-coded routes
this.router.navigate(['/admin/users/' + id]);

// ✅ Solution: Typed route params
this.router.navigate(['/admin/users', id]);
// Or use route constants
this.router.navigate([ROUTES.ADMIN.USERS, id]);
```
