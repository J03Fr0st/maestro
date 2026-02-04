# Testing Review

Test quality review checklist for unit, integration, and E2E tests.

---

## Test Quality Checklist

### Meaningful Tests

- [ ] Tests verify behavior, not implementation
- [ ] Tests have clear assertions (not just "runs without error")
- [ ] Edge cases covered
- [ ] Error conditions tested
- [ ] Tests act as documentation

```typescript
// ❌ Bad: Tests implementation detail
it('should call userRepository.findById', () => {
  service.getUser(1);
  expect(repository.findById).toHaveBeenCalledWith(1);
});

// ✅ Good: Tests behavior
it('should return user details when user exists', () => {
  const result = service.getUser(1);
  expect(result.name).toBe('John');
  expect(result.email).toBe('john@example.com');
});
```

### Test Independence

- [ ] Tests can run in any order
- [ ] No shared mutable state between tests
- [ ] Each test sets up its own data
- [ ] Tests clean up after themselves

```typescript
// ❌ Bad: Tests depend on order
let userId: number;

it('should create user', () => {
  userId = service.create({ name: 'John' }).id;
});

it('should get user', () => {
  const user = service.get(userId); // Depends on previous test!
});

// ✅ Good: Independent tests
it('should get user', () => {
  const created = service.create({ name: 'John' });
  const user = service.get(created.id);
  expect(user.name).toBe('John');
});
```

### Deterministic Tests

- [ ] No flaky tests (pass/fail randomly)
- [ ] No dependency on real time
- [ ] No dependency on network
- [ ] Random data is seeded or controlled

```typescript
// ❌ Bad: Flaky due to timing
it('should complete within timeout', async () => {
  const start = Date.now();
  await service.process();
  expect(Date.now() - start).toBeLessThan(100); // Flaky!
});

// ❌ Bad: Depends on current time
it('should format date', () => {
  const result = service.formatDate(new Date());
  expect(result).toBe('January 15, 2024'); // Fails tomorrow!
});

// ✅ Good: Controlled time
it('should format date', () => {
  const fixedDate = new Date('2024-01-15');
  const result = service.formatDate(fixedDate);
  expect(result).toBe('January 15, 2024');
});
```

---

## Test Types

### Unit Tests

**Purpose:** Test individual units in isolation

- [ ] Fast (milliseconds)
- [ ] No external dependencies (DB, network, filesystem)
- [ ] Dependencies mocked/stubbed
- [ ] Focus on single responsibility

```typescript
// Unit test example
describe('OrderCalculator', () => {
  let calculator: OrderCalculator;
  
  beforeEach(() => {
    calculator = new OrderCalculator();
  });
  
  it('should calculate total with tax', () => {
    const items = [
      { price: 10, quantity: 2 },
      { price: 5, quantity: 1 }
    ];
    
    const total = calculator.calculateTotal(items, 0.1);
    
    expect(total).toBe(27.5); // (20 + 5) * 1.1
  });
  
  it('should return 0 for empty cart', () => {
    const total = calculator.calculateTotal([], 0.1);
    expect(total).toBe(0);
  });
});
```

### Integration Tests

**Purpose:** Test components working together

- [ ] Uses real database (in-memory or test instance)
- [ ] Verifies data persistence
- [ ] Tests API contracts
- [ ] Slower than unit tests (seconds)

```csharp
// Integration test example (C#)
public class OrderServiceIntegrationTests : IClassFixture<TestDbFixture>
{
    private readonly AppDbContext _context;
    private readonly OrderService _service;
    
    public OrderServiceIntegrationTests(TestDbFixture fixture)
    {
        _context = fixture.CreateContext();
        _service = new OrderService(_context);
    }
    
    [Fact]
    public async Task CreateOrder_PersistsToDatabase()
    {
        // Arrange
        var dto = new CreateOrderDto { ProductId = "123", Quantity = 2 };
        
        // Act
        var order = await _service.CreateAsync(dto);
        
        // Assert
        var saved = await _context.Orders.FindAsync(order.Id);
        Assert.NotNull(saved);
        Assert.Equal("123", saved.ProductId);
    }
}
```

### E2E Tests

**Purpose:** Test full user flows

- [ ] Tests real user scenarios
- [ ] Includes UI interaction
- [ ] Slowest (minutes)
- [ ] Most valuable for critical paths

```typescript
// E2E test example (Playwright)
test('user can complete checkout', async ({ page }) => {
  await page.goto('/products');
  await page.click('[data-testid="add-to-cart-123"]');
  await page.click('[data-testid="cart-icon"]');
  await page.click('[data-testid="checkout-button"]');
  
  await page.fill('[name="email"]', 'test@example.com');
  await page.fill('[name="card"]', '4242424242424242');
  await page.click('[data-testid="pay-button"]');
  
  await expect(page.locator('.order-confirmation')).toBeVisible();
});
```

---

## Test Naming

### Convention: Should_ExpectedBehavior_WhenCondition

```typescript
// ✅ Good: Clear test names
describe('UserService', () => {
  it('should return user when user exists', () => {});
  it('should throw NotFoundError when user does not exist', () => {});
  it('should hash password when creating user', () => {});
});

// ❌ Bad: Vague test names
describe('UserService', () => {
  it('test1', () => {});
  it('works', () => {});
  it('getUser', () => {});
});
```

### Describe Blocks

```typescript
// ✅ Good: Organized by method/feature
describe('OrderService', () => {
  describe('createOrder', () => {
    it('should create order with valid data', () => {});
    it('should throw when product out of stock', () => {});
  });
  
  describe('cancelOrder', () => {
    it('should mark order as cancelled', () => {});
    it('should restore inventory', () => {});
    it('should throw when order already shipped', () => {});
  });
});
```

---

## Mocking Guidelines

### When to Mock

| Mock | Don't Mock |
|------|------------|
| External APIs | The unit under test |
| Database (in unit tests) | Pure functions |
| Time/Date | Simple value objects |
| File system | In-memory alternatives |
| Network calls | Business logic |

### Good Mocking

```typescript
// ✅ Good: Mock at boundaries
describe('NotificationService', () => {
  let emailClient: jest.Mocked<EmailClient>;
  let service: NotificationService;
  
  beforeEach(() => {
    emailClient = {
      send: jest.fn().mockResolvedValue({ success: true })
    };
    service = new NotificationService(emailClient);
  });
  
  it('should send email with correct content', async () => {
    await service.notifyUser('user@example.com', 'Welcome!');
    
    expect(emailClient.send).toHaveBeenCalledWith({
      to: 'user@example.com',
      subject: expect.stringContaining('Welcome'),
      body: expect.stringContaining('Welcome!')
    });
  });
});

// ❌ Bad: Mocking the unit under test
it('should call private method', () => {
  jest.spyOn(service as any, 'privateMethod');
  service.publicMethod();
  expect((service as any).privateMethod).toHaveBeenCalled();
});
```

---

## Coverage Guidelines

### Coverage ≠ Quality

```typescript
// ❌ Bad: 100% coverage, no value
it('should have coverage', () => {
  const result = complexFunction(null, undefined, '', 0);
  // No assertions! Just runs the code
});

// ✅ Good: Meaningful coverage
it('should handle complex calculation correctly', () => {
  const result = complexFunction(10, 5, 'multiply', 2);
  expect(result).toBe(100); // 10 * 5 * 2
});

it('should throw for invalid operation', () => {
  expect(() => complexFunction(10, 5, 'invalid', 2))
    .toThrow('Unknown operation');
});
```

### Coverage Targets

| Area | Minimum | Ideal |
|------|---------|-------|
| Business logic | 80% | 95% |
| Utility functions | 90% | 100% |
| UI components | 60% | 80% |
| E2E flows | Critical paths | Happy + error paths |

### What to Cover

- [ ] Happy path
- [ ] Error conditions
- [ ] Edge cases (null, empty, boundary)
- [ ] Business rules

---

## Angular Testing

### Component Tests

```typescript
describe('UserCardComponent', () => {
  let component: UserCardComponent;
  let fixture: ComponentFixture<UserCardComponent>;
  
  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [UserCardComponent],
      providers: [
        { provide: UserService, useValue: mockUserService }
      ]
    }).compileComponents();
    
    fixture = TestBed.createComponent(UserCardComponent);
    component = fixture.componentInstance;
  });
  
  it('should display user name', () => {
    component.user = { id: 1, name: 'John', email: 'john@test.com' };
    fixture.detectChanges();
    
    const element = fixture.nativeElement.querySelector('.user-name');
    expect(element.textContent).toContain('John');
  });
});
```

### Service Tests

```typescript
describe('ApiService', () => {
  let service: ApiService;
  let httpMock: HttpTestingController;
  
  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [HttpClientTestingModule],
      providers: [ApiService]
    });
    
    service = TestBed.inject(ApiService);
    httpMock = TestBed.inject(HttpTestingController);
  });
  
  afterEach(() => {
    httpMock.verify();
  });
  
  it('should fetch users', () => {
    const mockUsers = [{ id: 1, name: 'John' }];
    
    service.getUsers().subscribe(users => {
      expect(users).toEqual(mockUsers);
    });
    
    const req = httpMock.expectOne('/api/users');
    expect(req.request.method).toBe('GET');
    req.flush(mockUsers);
  });
});
```

---

## C# Testing

### xUnit Patterns

```csharp
public class OrderServiceTests
{
    private readonly Mock<IOrderRepository> _repositoryMock;
    private readonly OrderService _service;
    
    public OrderServiceTests()
    {
        _repositoryMock = new Mock<IOrderRepository>();
        _service = new OrderService(_repositoryMock.Object);
    }
    
    [Fact]
    public async Task CreateOrder_WithValidData_ReturnsOrder()
    {
        // Arrange
        var dto = new CreateOrderDto { ProductId = "123", Quantity = 2 };
        _repositoryMock.Setup(r => r.CreateAsync(It.IsAny<Order>()))
            .ReturnsAsync((Order o) => o);
        
        // Act
        var result = await _service.CreateAsync(dto);
        
        // Assert
        Assert.NotNull(result);
        Assert.Equal("123", result.ProductId);
        Assert.Equal(2, result.Quantity);
    }
    
    [Theory]
    [InlineData(0)]
    [InlineData(-1)]
    public async Task CreateOrder_WithInvalidQuantity_ThrowsValidationException(int quantity)
    {
        // Arrange
        var dto = new CreateOrderDto { ProductId = "123", Quantity = quantity };
        
        // Act & Assert
        await Assert.ThrowsAsync<ValidationException>(
            () => _service.CreateAsync(dto));
    }
}
```

---

## Test Smells (Red Flags)

| Smell | Problem | Fix |
|-------|---------|-----|
| No assertions | Test doesn't verify anything | Add meaningful assertions |
| Multiple assertions on different things | Testing multiple units | Split into separate tests |
| Test depends on test order | Shared state | Make tests independent |
| Commented out tests | Dead code | Delete or fix |
| Sleep/delays | Flaky, slow | Use async waits or mocks |
| Testing private methods | Over-coupling | Test through public API |
| Identical test data everywhere | Maintainability | Use test data builders |

---

## Test Review Questions

1. **Does this test fail for the right reasons?** (If code breaks, does test catch it?)
2. **Is this test readable?** (Can I understand what's being tested?)
3. **Is this test maintainable?** (Will small changes break it unnecessarily?)
4. **Does this test add confidence?** (Am I more confident deploying with this test?)
5. **Is this the right type of test?** (Unit vs integration vs E2E)
