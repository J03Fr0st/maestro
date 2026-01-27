---
applyTo: "**/*.spec.ts,**/*.test.ts,**/*Tests.cs,**/*Test.cs"
---

# Testing Guidelines

## Test Naming
Use descriptive names: `MethodName_Scenario_ExpectedResult`

Examples:
- `CreateUser_ValidInput_ReturnsCreatedUser`
- `CreateUser_DuplicateEmail_ThrowsConflictException`
- `CalculateTotal_EmptyCart_ReturnsZero`

## Structure
Follow Arrange-Act-Assert pattern:
```typescript
it('should return user when valid id provided', () => {
  // Arrange
  const userId = '123';
  const expectedUser = { id: userId, name: 'Test' };
  mockService.getUser.mockReturnValue(expectedUser);

  // Act
  const result = component.getUser(userId);

  // Assert
  expect(result).toEqual(expectedUser);
});
```

## Best Practices
- Mock external dependencies
- Test edge cases and error conditions
- Aim for meaningful coverage, not 100%
- Write tests that actually test behavior
- One assertion concept per test
