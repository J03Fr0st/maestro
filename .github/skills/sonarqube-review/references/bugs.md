# Bug Rules (Reliability)

Bugs are issues that are demonstrably wrong or highly likely to cause unexpected behavior.

## Null/Undefined Handling

### S2259: Null pointer should not be dereferenced
```typescript
// Non-compliant
function getName(user: User | null) {
  return user.name; // May crash!
}

// Compliant
function getName(user: User | null) {
  return user?.name ?? 'Unknown';
}
```

### S2583: Conditionally executed code should be reachable
```typescript
// Non-compliant - condition always false
const x = 5;
if (x > 10) {
  doSomething(); // Dead code
}
```

### S1854: Unused assignments should be removed
```typescript
// Non-compliant
let x = 10;
x = 20; // First assignment never used
return x;

// Compliant
const x = 20;
return x;
```

## Array/Collection Issues

### S2251: For loop increment should move towards stop condition
```typescript
// Non-compliant - infinite loop
for (let i = 10; i >= 0; i++) {
  process(i);
}

// Compliant
for (let i = 10; i >= 0; i--) {
  process(i);
}
```

### S2234: Parameters should be passed in correct order
```typescript
// Non-compliant
function createUser(firstName: string, lastName: string) { }
createUser(lastName, firstName); // Arguments swapped!
```

### S4143: Collection elements should not be overwritten unconditionally
```typescript
// Non-compliant
map.set('key', value1);
map.set('key', value2); // First value lost
```

## Equality Issues

### S1764: Identical expressions should not be used on both sides
```typescript
// Non-compliant
if (a === a) { } // Always true
const x = a - a; // Always 0
```

### S3981: Collection size should be compared correctly
```typescript
// Non-compliant
if (array.length >= 0) { } // Always true

// Compliant
if (array.length > 0) { }
```

## Async/Promise Issues

### S6544: Promises should be awaited or returned
```typescript
// Non-compliant
async function process() {
  saveData(); // Missing await - fire and forget!
}

// Compliant
async function process() {
  await saveData();
}
```

### S4327: 'await' should only be used with promises
```typescript
// Non-compliant
const value = await 42; // Not a promise

// Compliant
const value = await Promise.resolve(42);
```
