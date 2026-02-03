# Code Smell Rules (Maintainability)

Code smells are maintainability issues that make code harder to understand or modify.

## Complexity

### S3776: Cognitive complexity should not be too high
```typescript
// Non-compliant - cognitive complexity > 15
function processOrder(order) {
  if (order.status === 'pending') {
    if (order.items.length > 0) {
      for (const item of order.items) {
        if (item.stock > 0) {
          if (item.price > 100) {
            // More nested logic...
          }
        }
      }
    }
  }
}

// Compliant - extract methods, use early returns
function processOrder(order) {
  if (order.status !== 'pending') return;
  if (order.items.length === 0) return;

  for (const item of order.items) {
    processItem(item);
  }
}
```

### S134: Control flow statements should not be nested too deeply
```typescript
// Non-compliant - nesting > 3 levels
if (a) {
  if (b) {
    if (c) {
      if (d) { // Too deep!
      }
    }
  }
}

// Compliant - use early returns or extract functions
if (!a || !b || !c) return;
if (d) {
  // logic
}
```

### S1067: Expressions should not be too complex
```typescript
// Non-compliant
if (a && b || c && d || e && f || g && h) { }

// Compliant
const condition1 = a && b;
const condition2 = c && d;
const condition3 = e && f;
if (condition1 || condition2 || condition3) { }
```

## Function Design

### S107: Functions should not have too many parameters
```typescript
// Non-compliant
function createUser(name, email, age, address, phone, role, department, manager) { }

// Compliant
function createUser(options: CreateUserOptions) { }
```

### S138: Functions should not have too many lines
```typescript
// Non-compliant - function > 200 lines
function processEverything() {
  // 300 lines of code...
}

// Compliant - break into smaller functions
function processEverything() {
  validateInput();
  transformData();
  saveResults();
}
```

### S1448: Classes should not have too many methods
Threshold: Max 35 methods per class

### S1820: Classes should not have too many fields
Threshold: Max 20 fields per class

## Naming

### S100: Method/function names should comply with naming convention
```typescript
// Non-compliant
function GetUserData() { } // PascalCase for functions
function get_user_data() { } // snake_case in JS/TS

// Compliant
function getUserData() { } // camelCase
```

### S116: Variable names should comply with naming convention
```typescript
// Non-compliant
const USER_NAME = 'John'; // SCREAMING_CASE for mutable
let userName = 'John'; // But used as constant

// Compliant
const userName = 'John';
const MAX_RETRIES = 3; // SCREAMING_CASE for true constants
```

### S117: Local variable names should be descriptive
```typescript
// Non-compliant
const x = getUser();
const d = new Date();

// Compliant
const currentUser = getUser();
const orderDate = new Date();
```

## Duplication

### S1192: String literals should not be duplicated
```typescript
// Non-compliant
if (status === 'pending') { }
if (status === 'pending') { }
if (status === 'pending') { }

// Compliant
const STATUS_PENDING = 'pending';
if (status === STATUS_PENDING) { }
```

### S4144: Functions should not have identical implementations
```typescript
// Non-compliant
function processUserA(user) { return user.name.toUpperCase(); }
function processUserB(user) { return user.name.toUpperCase(); }

// Compliant
function formatUserName(user) { return user.name.toUpperCase(); }
```

## Dead Code

### S1172: Unused function parameters should be removed
```typescript
// Non-compliant
function greet(name: string, unused: number) {
  return `Hello ${name}`;
}

// Compliant
function greet(name: string) {
  return `Hello ${name}`;
}
```

### S1186: Methods should not be empty
```typescript
// Non-compliant
function handleError(error: Error) {
  // Empty!
}

// Compliant
function handleError(error: Error) {
  console.error('Error occurred:', error);
}
```

### S6133: Unused variables should be removed
```typescript
// Non-compliant
const unused = getValue();
return someOtherValue;

// Compliant
return someOtherValue;
```

## Comments

### S1135: Track uses of TODO/FIXME tags
```typescript
// Non-compliant (track these)
// TODO: implement validation
// FIXME: this is broken
// HACK: temporary workaround
```

### S125: Sections of code should not be commented out
```typescript
// Non-compliant
function process() {
  // const oldLogic = doOldThing();
  const newLogic = doNewThing();
}
```
