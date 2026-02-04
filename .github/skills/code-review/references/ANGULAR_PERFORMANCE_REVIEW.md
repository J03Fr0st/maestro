# Angular Performance Review

Performance-focused review checklist for Angular applications.

---

## Bundle Size Review

### Red Flags

- [ ] No unnecessary imports from large libraries
- [ ] Tree-shaking friendly imports (no barrel imports of entire libs)
- [ ] Images optimized and lazy loaded
- [ ] No duplicate dependencies

```typescript
// ❌ Bad: Imports entire library
import { _ } from 'lodash';

// ✅ Good: Import only what's needed
import { debounce } from 'lodash/debounce';

// ❌ Bad: Barrel import (may pull more than needed)
import { everything } from '@company/shared';

// ✅ Good: Direct import
import { SpecificUtility } from '@company/shared/utils/specific';
```

### Bundle Analysis

- [ ] Main bundle < 250KB gzipped ideal
- [ ] Lazy chunks appropriately sized
- [ ] No unexpected large dependencies
- [ ] Source maps not in production

```bash
# Analyze bundle
ng build --stats-json
npx webpack-bundle-analyzer dist/stats.json
```

---

## Change Detection Optimization

### OnPush Strategy

- [ ] All presentational components use OnPush
- [ ] Smart components consider OnPush with proper patterns
- [ ] No unnecessary detectChanges() calls

```typescript
// ✅ Required for OnPush to work:
// 1. Immutable inputs
// 2. Async pipe for observables
// 3. Explicit markForCheck() only when needed

@Component({
  changeDetection: ChangeDetectionStrategy.OnPush
})
export class OptimizedComponent {
  // Input changes trigger detection
  @Input() data!: Data;
  
  // Async pipe handles detection
  data$ = this.service.getData();
}
```

### When to Use Default vs OnPush

| Scenario | Strategy |
|----------|----------|
| Presentational/dumb component | OnPush |
| List item component | OnPush + trackBy |
| Forms with two-way binding | Default (or careful OnPush) |
| Components with observables | OnPush + async pipe |

---

## List Rendering Optimization

### Always Use trackBy

```typescript
// Template
<div *ngFor="let item of items; trackBy: trackById">

// Component
trackById(index: number, item: Item): string {
  return item.id;
}

// or for simple cases
trackByIndex(index: number): number {
  return index;
}
```

### Virtual Scrolling for Large Lists

```typescript
// For lists > 100 items, consider CDK virtual scrolling
<cdk-virtual-scroll-viewport itemSize="50" class="viewport">
  <div *cdkVirtualFor="let item of items; trackBy: trackById">
    {{ item.name }}
  </div>
</cdk-virtual-scroll-viewport>
```

### Pagination vs Infinite Scroll

| Scenario | Approach |
|----------|----------|
| Data needs random access | Pagination |
| Sequential browsing (feed) | Infinite scroll |
| Very large datasets | Server-side pagination + virtual scroll |

---

## Lazy Loading Review

### Feature Modules

- [ ] Features lazy loaded by route
- [ ] Preloading strategy appropriate
- [ ] No imports of lazy modules in main bundle

```typescript
// app-routing.module.ts
const routes: Routes = [
  {
    path: 'admin',
    loadChildren: () => import('./admin/admin.routes')
      .then(m => m.ADMIN_ROUTES)
  },
  {
    path: 'reports',
    loadChildren: () => import('./reports/reports.routes')
      .then(m => m.REPORTS_ROUTES)
  }
];

// With preloading strategy
RouterModule.forRoot(routes, {
  preloadingStrategy: PreloadAllModules // or custom
})
```

### Component-Level Lazy Loading

```typescript
// For heavy components, use dynamic imports
@Component({
  template: `
    <ng-container *ngIf="showChart">
      <ng-container *ngComponentOutlet="chartComponent" />
    </ng-container>
  `
})
export class DashboardComponent {
  chartComponent?: Type<any>;
  
  async loadChart() {
    const { ChartComponent } = await import('./chart.component');
    this.chartComponent = ChartComponent;
  }
}
```

---

## HTTP Performance

### Caching Strategies

```typescript
// Service with caching
private cache = new Map<string, Observable<Data>>();

getData(id: string): Observable<Data> {
  if (!this.cache.has(id)) {
    this.cache.set(id, this.http.get<Data>(`/api/data/${id}`).pipe(
      shareReplay(1)
    ));
  }
  return this.cache.get(id)!;
}
```

### Request Optimization

- [ ] Batch requests where possible
- [ ] Cancel unnecessary requests (switchMap for search)
- [ ] Debounce rapid requests
- [ ] Use appropriate HTTP caching headers

```typescript
// Search with debounce and cancellation
this.searchControl.valueChanges.pipe(
  debounceTime(300),
  distinctUntilChanged(),
  switchMap(term => this.searchService.search(term))
).subscribe(results => this.results = results);
```

---

## Memory Leak Prevention

### Common Leak Patterns

| Pattern | Detection | Fix |
|---------|-----------|-----|
| Unsubscribed observable | DevTools memory snapshot | takeUntilDestroyed |
| Event listener not removed | Growing listeners count | Use renderer or host bindings |
| setInterval/setTimeout | Timer still running | Clear on destroy |
| Closure over component | Component not GC'd | Avoid closures or null refs |

### Subscription Cleanup Patterns

```typescript
// ✅ Preferred: takeUntilDestroyed (Angular 16+)
export class MyComponent {
  private destroyRef = inject(DestroyRef);
  
  ngOnInit() {
    this.data$.pipe(
      takeUntilDestroyed(this.destroyRef)
    ).subscribe();
  }
}

// ✅ Alternative: async pipe (best when possible)
<div>{{ data$ | async }}</div>

// ✅ For multiple subscriptions
export class MyComponent implements OnDestroy {
  private subscriptions: Subscription[] = [];
  
  ngOnInit() {
    this.subscriptions.push(
      this.data$.subscribe(),
      this.events$.subscribe()
    );
  }
  
  ngOnDestroy() {
    this.subscriptions.forEach(s => s.unsubscribe());
  }
}
```

---

## Runtime Performance

### Avoid in Templates

```typescript
// ❌ Expensive: Runs every change detection cycle
<div>{{ calculateExpensiveValue() }}</div>
<div [style.color]="getColor()">

// ✅ Better: Use signals or computed properties
readonly expensiveValue = computed(() => this.calculate());
readonly color = computed(() => this.getColor());

// Template
<div>{{ expensiveValue() }}</div>
<div [style.color]="color()">
```

### Zone.js Optimization

```typescript
// Run heavy computations outside Angular zone
constructor(private ngZone: NgZone) {}

processLargeData(data: Data[]) {
  this.ngZone.runOutsideAngular(() => {
    const result = this.heavyComputation(data);
    this.ngZone.run(() => {
      this.result = result;
    });
  });
}
```

---

## Image Optimization

### NgOptimizedImage

```typescript
// Use Angular's built-in image optimization
import { NgOptimizedImage } from '@angular/common';

// Template
<img ngSrc="hero.jpg" width="400" height="300" priority />
<img ngSrc="thumbnail.jpg" width="100" height="100" loading="lazy" />
```

### Responsive Images

```html
<img ngSrc="image.jpg" 
     width="800" height="600"
     ngSrcset="320w, 640w, 1280w"
     sizes="(max-width: 320px) 280px, (max-width: 640px) 600px, 1200px" />
```

---

## Performance Testing

### Lighthouse Targets

| Metric | Target |
|--------|--------|
| First Contentful Paint | < 1.8s |
| Largest Contentful Paint | < 2.5s |
| Time to Interactive | < 3.8s |
| Total Blocking Time | < 200ms |
| Cumulative Layout Shift | < 0.1 |

### Dev Tools Profiling

1. **Performance tab**: Record and analyze runtime
2. **Memory tab**: Check for leaks
3. **Network tab**: Request timing and size
4. **Angular DevTools**: Component tree and change detection

---

## Quick Performance Wins

| Issue | Quick Fix |
|-------|-----------|
| Slow initial load | Lazy load routes |
| Slow list rendering | Add trackBy |
| Too many HTTP calls | Add caching/shareReplay |
| Memory leaks | Use takeUntilDestroyed |
| Large bundle | Analyze and remove unused deps |
| Layout shifts | Set explicit image dimensions |
