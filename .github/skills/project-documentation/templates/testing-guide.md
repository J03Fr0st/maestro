# Testing Guide Template

Use this template to document the project's testing strategy and patterns.

```markdown
# {project_name} - Testing Guide

**Generated:** {date}
**Test Runner:** {Vitest / Jest / Pytest / Go test}
**Coverage Tool:** {c8 / Istanbul / Coverage.py}

## Testing Overview

### Test Statistics

| Metric | Value |
|--------|-------|
| Total Test Files | {count} |
| Total Test Cases | {count} |
| Code Coverage | {percentage}% |
| Last Run | {date/time} |

### Test Categories

| Category | Count | Coverage | Location |
|----------|-------|----------|----------|
| Unit Tests | {count} | {%} | `{path}` |
| Integration Tests | {count} | {%} | `{path}` |
| E2E Tests | {count} | {%} | `{path}` |
| Component Tests | {count} | {%} | `{path}` |

---

## Running Tests

### Quick Commands

```bash
# Run all tests
{test_command}

# Run with coverage
{coverage_command}

# Run specific file
{test_file_command}

# Run in watch mode
{watch_command}

# Run specific category
{category_command}
```

### Test Configuration

**Config File:** `{path/to/config}`

```typescript
// vitest.config.ts / jest.config.js
export default {
  testEnvironment: '{environment}',
  setupFilesAfterEnv: ['{setup_file}'],
  testMatch: ['{pattern}'],
  collectCoverageFrom: ['{coverage_patterns}'],
  coverageThreshold: {
    global: {
      branches: {threshold},
      functions: {threshold},
      lines: {threshold},
      statements: {threshold},
    },
  },
};
```

---

## Test Structure

### Directory Layout

```
{project_root}/
├── src/
│   ├── {module}/
│   │   ├── {file}.ts
│   │   └── __tests__/
│   │       └── {file}.test.ts
├── tests/
│   ├── unit/
│   ├── integration/
│   └── e2e/
├── test-utils/
│   ├── setup.ts
│   ├── mocks/
│   └── fixtures/
└── {config_file}
```

### Naming Conventions

| Type | Pattern | Example |
|------|---------|---------|
| Unit test file | `{name}.test.ts` | `utils.test.ts` |
| Integration test | `{name}.integration.test.ts` | `api.integration.test.ts` |
| E2E test | `{name}.e2e.test.ts` | `checkout.e2e.test.ts` |
| Test utilities | `{name}.test-utils.ts` | `db.test-utils.ts` |

---

## Unit Testing

### Testing Patterns

#### Pure Functions

```typescript
// src/utils/math.ts
export function add(a: number, b: number): number {
  return a + b;
}

// src/utils/__tests__/math.test.ts
import { describe, it, expect } from 'vitest';
import { add } from '../math';

describe('add', () => {
  it('should add two positive numbers', () => {
    expect(add(1, 2)).toBe(3);
  });

  it('should handle negative numbers', () => {
    expect(add(-1, 1)).toBe(0);
  });

  it('should handle zero', () => {
    expect(add(0, 5)).toBe(5);
  });
});
```

#### Classes/Services

```typescript
// src/services/__tests__/{Service}.test.ts
import { describe, it, expect, beforeEach, vi } from 'vitest';
import { {Service} } from '../{Service}';

describe('{Service}', () => {
  let service: {Service};
  let mockDependency: MockType;

  beforeEach(() => {
    mockDependency = {
      method: vi.fn(),
    };
    service = new {Service}(mockDependency);
  });

  describe('methodName', () => {
    it('should do expected behavior', async () => {
      mockDependency.method.mockResolvedValue(expectedValue);

      const result = await service.methodName(input);

      expect(result).toEqual(expectedOutput);
      expect(mockDependency.method).toHaveBeenCalledWith(expectedArg);
    });

    it('should handle errors', async () => {
      mockDependency.method.mockRejectedValue(new Error('Failed'));

      await expect(service.methodName(input)).rejects.toThrow('Failed');
    });
  });
});
```

---

## Component Testing

### React Component Tests

```typescript
// components/__tests__/{Component}.test.tsx
import { render, screen, fireEvent } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import { {Component} } from '../{Component}';

describe('{Component}', () => {
  const defaultProps = {
    title: 'Test Title',
    onClick: vi.fn(),
  };

  it('should render with props', () => {
    render(<{Component} {...defaultProps} />);

    expect(screen.getByText('Test Title')).toBeInTheDocument();
  });

  it('should handle click events', async () => {
    const user = userEvent.setup();
    render(<{Component} {...defaultProps} />);

    await user.click(screen.getByRole('button'));

    expect(defaultProps.onClick).toHaveBeenCalledTimes(1);
  });

  it('should show loading state', () => {
    render(<{Component} {...defaultProps} isLoading />);

    expect(screen.getByRole('progressbar')).toBeInTheDocument();
  });

  it('should be accessible', async () => {
    const { container } = render(<{Component} {...defaultProps} />);

    const results = await axe(container);
    expect(results).toHaveNoViolations();
  });
});
```

### Testing with Providers

```typescript
// test-utils/render.tsx
import { render as rtlRender, RenderOptions } from '@testing-library/react';
import { QueryClient, QueryClientProvider } from '@tanstack/react-query';
import { ThemeProvider } from '../providers/ThemeProvider';

function AllProviders({ children }: { children: React.ReactNode }) {
  const queryClient = new QueryClient({
    defaultOptions: {
      queries: { retry: false },
    },
  });

  return (
    <QueryClientProvider client={queryClient}>
      <ThemeProvider>
        {children}
      </ThemeProvider>
    </QueryClientProvider>
  );
}

export function render(ui: React.ReactElement, options?: RenderOptions) {
  return rtlRender(ui, { wrapper: AllProviders, ...options });
}

export * from '@testing-library/react';
```

---

## Integration Testing

### API Integration Tests

```typescript
// tests/integration/api/{resource}.integration.test.ts
import { describe, it, expect, beforeAll, afterAll } from 'vitest';
import { setupServer } from 'msw/node';
import { handlers } from '../../mocks/handlers';

const server = setupServer(...handlers);

beforeAll(() => server.listen());
afterAll(() => server.close());

describe('{Resource} API Integration', () => {
  it('should fetch {resources}', async () => {
    const response = await fetch('/api/{resources}');
    const data = await response.json();

    expect(response.ok).toBe(true);
    expect(data).toHaveProperty('items');
  });

  it('should create {resource}', async () => {
    const response = await fetch('/api/{resources}', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ name: 'Test' }),
    });

    expect(response.status).toBe(201);
  });
});
```

### Database Integration Tests

```typescript
// tests/integration/db/{entity}.integration.test.ts
import { describe, it, expect, beforeEach, afterEach } from 'vitest';
import { prisma } from '../../test-utils/db';
import { {Entity}Repository } from '../../../src/repositories/{entity}';

describe('{Entity} Repository', () => {
  const repository = new {Entity}Repository(prisma);

  beforeEach(async () => {
    await prisma.$executeRaw`TRUNCATE TABLE {table} CASCADE`;
  });

  afterEach(async () => {
    await prisma.$disconnect();
  });

  it('should create and retrieve {entity}', async () => {
    const created = await repository.create({ name: 'Test' });
    const found = await repository.findById(created.id);

    expect(found).toEqual(created);
  });
});
```

---

## E2E Testing

### E2E Framework

**Framework:** {Playwright / Cypress / Puppeteer}
**Config:** `{path/to/config}`

### E2E Test Example

```typescript
// tests/e2e/{feature}.e2e.test.ts
import { test, expect } from '@playwright/test';

test.describe('{Feature} E2E', () => {
  test.beforeEach(async ({ page }) => {
    await page.goto('/');
  });

  test('should complete {flow}', async ({ page }) => {
    // Navigate to feature
    await page.click('[data-testid="nav-{feature}"]');

    // Fill form
    await page.fill('[data-testid="input-name"]', 'Test Name');
    await page.fill('[data-testid="input-email"]', 'test@example.com');

    // Submit
    await page.click('[data-testid="submit-button"]');

    // Verify result
    await expect(page.locator('[data-testid="success-message"]'))
      .toBeVisible();
  });

  test('should handle errors gracefully', async ({ page }) => {
    // Simulate error condition
    await page.route('/api/{resource}', (route) =>
      route.fulfill({ status: 500, body: 'Server Error' })
    );

    await page.click('[data-testid="submit-button"]');

    await expect(page.locator('[data-testid="error-message"]'))
      .toContainText('Something went wrong');
  });
});
```

---

## Mocking

### Mock Locations

```
test-utils/
├── mocks/
│   ├── handlers.ts      # MSW request handlers
│   ├── data/            # Mock data fixtures
│   ├── {service}.mock.ts
│   └── {module}.mock.ts
```

### MSW Handlers

```typescript
// test-utils/mocks/handlers.ts
import { http, HttpResponse } from 'msw';

export const handlers = [
  http.get('/api/{resources}', () => {
    return HttpResponse.json({
      items: [
        { id: '1', name: 'Item 1' },
        { id: '2', name: 'Item 2' },
      ],
    });
  }),

  http.post('/api/{resources}', async ({ request }) => {
    const body = await request.json();
    return HttpResponse.json(
      { id: 'new-id', ...body },
      { status: 201 }
    );
  }),
];
```

### Module Mocks

```typescript
// test-utils/mocks/{module}.mock.ts
export const mock{Module} = {
  method: vi.fn().mockResolvedValue(defaultValue),
  otherMethod: vi.fn(),
};

// In test file
vi.mock('{module}', () => ({
  {Module}: vi.fn(() => mock{Module}),
}));
```

---

## Fixtures and Factories

### Test Fixtures

```typescript
// test-utils/fixtures/{entity}.fixtures.ts
export const {entity}Fixtures = {
  valid: {
    id: 'test-id',
    name: 'Test Name',
    email: 'test@example.com',
    createdAt: new Date('2024-01-01'),
  },

  minimal: {
    name: 'Minimal',
  },

  invalid: {
    name: '', // Missing required field
  },
};
```

### Factory Functions

```typescript
// test-utils/factories/{entity}.factory.ts
import { faker } from '@faker-js/faker';

export function create{Entity}(overrides: Partial<{Entity}> = {}): {Entity} {
  return {
    id: faker.string.uuid(),
    name: faker.person.fullName(),
    email: faker.internet.email(),
    createdAt: faker.date.past(),
    ...overrides,
  };
}

export function create{Entity}List(count: number): {Entity}[] {
  return Array.from({ length: count }, () => create{Entity}());
}
```

---

## Coverage Requirements

### Thresholds

| Category | Minimum | Target |
|----------|---------|--------|
| Statements | {min}% | {target}% |
| Branches | {min}% | {target}% |
| Functions | {min}% | {target}% |
| Lines | {min}% | {target}% |

### Excluded from Coverage

```typescript
// Files/patterns excluded from coverage
[
  '**/*.d.ts',
  '**/types/**',
  '**/mocks/**',
  '**/test-utils/**',
  '{other_exclusions}',
]
```

### Viewing Coverage

```bash
# Generate coverage report
{coverage_command}

# Open HTML report
{open_report_command}
```

---

## CI/CD Integration

### Test Pipeline

```yaml
# .github/workflows/test.yml
test:
  runs-on: ubuntu-latest
  steps:
    - uses: actions/checkout@v4
    - uses: actions/setup-node@v4
    - run: {install_command}
    - run: {test_command}
    - run: {coverage_command}
    - uses: codecov/codecov-action@v3
```

### Pre-commit Hooks

```bash
# Run tests before commit
{pre_commit_test_command}
```
```

---

## Usage Notes

When generating this template:

1. **Document all test types** - Unit, integration, E2E
2. **Include real examples** - From actual codebase
3. **Show setup/teardown** - Database, mocks, providers
4. **Cover CI integration** - Pipeline configuration
5. **List coverage rules** - Thresholds and exclusions
