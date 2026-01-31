---
name: sonarqube-review
description: Review code like SonarQube with comprehensive rules for bugs, vulnerabilities, code smells, and security hotspots. Use when reviewing code quality, performing static analysis, or ensuring code meets quality gates.
---

# SonarQube-Style Code Review

Perform comprehensive code analysis following SonarQube's rule categories: Bugs, Vulnerabilities, Code Smells, and Security Hotspots.

## When to Use

- Reviewing code for quality issues before merge
- Performing static analysis on code changes
- Ensuring code meets quality standards
- Identifying security vulnerabilities
- Finding maintainability issues

## Issue Severity Levels

| Severity | Description | Action Required |
|----------|-------------|-----------------|
| **Blocker** | Bug with high probability to impact production | Must fix immediately |
| **Critical** | Bug or security flaw with low probability to impact production | Must fix before release |
| **Major** | Quality flaw that can highly impact developer productivity | Should fix |
| **Minor** | Quality flaw that can slightly impact developer productivity | Consider fixing |
| **Info** | Neither a bug nor quality flaw, just a finding | Optional |

## Issue Types

| Type | Description |
|------|-------------|
| **Bug** | Something that is demonstrably wrong or highly likely to cause unexpected behavior |
| **Vulnerability** | Security issue that could be exploited by attackers |
| **Code Smell** | Maintainability issue that makes code harder to understand or modify |
| **Security Hotspot** | Security-sensitive code that requires manual review |

---

# Bug Rules (Reliability)

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

---

# Vulnerability Rules (Security)

## Injection Vulnerabilities

### S3649: SQL queries should not be vulnerable to injection
```typescript
// Non-compliant
const query = `SELECT * FROM users WHERE name = '${userInput}'`;

// Compliant
const query = 'SELECT * FROM users WHERE name = ?';
db.query(query, [userInput]);
```

### S2076: OS commands should not be vulnerable to injection
```typescript
// Non-compliant
exec(`ls ${userInput}`);

// Compliant
execFile('ls', [sanitizedInput]);
```

### S5334: XSS vulnerabilities should not exist
```typescript
// Non-compliant
element.innerHTML = userInput;

// Compliant
element.textContent = userInput;
// Or use proper sanitization
element.innerHTML = DOMPurify.sanitize(userInput);
```

### S5131: Server-side requests should not be vulnerable to SSRF
```typescript
// Non-compliant
fetch(userProvidedUrl);

// Compliant
if (isAllowedUrl(userProvidedUrl)) {
  fetch(userProvidedUrl);
}
```

## Authentication/Authorization

### S5122: CORS headers should not be permissive
```typescript
// Non-compliant
res.setHeader('Access-Control-Allow-Origin', '*');

// Compliant
res.setHeader('Access-Control-Allow-Origin', 'https://trusted-domain.com');
```

### S5659: JWT should be signed and verified
```typescript
// Non-compliant
jwt.decode(token); // Not verified!

// Compliant
jwt.verify(token, secret);
```

### S2068: Credentials should not be hardcoded
```typescript
// Non-compliant
const password = 'admin123';
const apiKey = 'sk-1234567890abcdef';

// Compliant
const password = process.env.PASSWORD;
const apiKey = process.env.API_KEY;
```

## Cryptography

### S4426: Cryptographic keys should be robust
```typescript
// Non-compliant
crypto.generateKeyPairSync('rsa', { modulusLength: 1024 }); // Too short

// Compliant
crypto.generateKeyPairSync('rsa', { modulusLength: 2048 });
```

### S5547: Cipher algorithms should be robust
```typescript
// Non-compliant
crypto.createCipher('des', key); // Weak algorithm

// Compliant
crypto.createCipheriv('aes-256-gcm', key, iv);
```

### S2245: Pseudorandom number generators should not be used for security
```typescript
// Non-compliant
const token = Math.random().toString(36); // Predictable!

// Compliant
const token = crypto.randomBytes(32).toString('hex');
```

## Data Exposure

### S5148: Response headers should prevent sensitive data exposure
```typescript
// Non-compliant - missing security headers
res.send(data);

// Compliant
res.setHeader('X-Content-Type-Options', 'nosniff');
res.setHeader('X-Frame-Options', 'DENY');
res.setHeader('Content-Security-Policy', "default-src 'self'");
res.send(data);
```

### S5693: Request body size should be limited
```typescript
// Non-compliant
app.use(express.json());

// Compliant
app.use(express.json({ limit: '100kb' }));
```

---

# Code Smell Rules (Maintainability)

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

---

# Security Hotspot Rules (Requires Review)

## Input Validation

### S5852: Regular expressions should not be vulnerable to ReDoS
```typescript
// Hotspot - review for catastrophic backtracking
const regex = /^(a+)+$/; // Vulnerable to ReDoS

// Safer alternative
const regex = /^a+$/;
```

### S2631: Regular expressions should be validated
```typescript
// Hotspot - user input in regex
const regex = new RegExp(userInput); // Could be malicious

// Review: ensure input is sanitized or escaped
const regex = new RegExp(escapeRegex(userInput));
```

## File Operations

### S2612: File permissions should be restricted
```typescript
// Hotspot
fs.writeFileSync(file, data, { mode: 0o777 }); // World-writable!

// Review: use restrictive permissions
fs.writeFileSync(file, data, { mode: 0o600 });
```

### S4797: Handling files should be done carefully
```typescript
// Hotspot - path traversal risk
const filePath = path.join(baseDir, userInput);

// Review: validate path is within allowed directory
const filePath = path.join(baseDir, path.basename(userInput));
```

## Logging

### S5757: Sensitive data should not be logged
```typescript
// Hotspot
console.log('User password:', password);
console.log('API Key:', apiKey);
console.log('Full request:', JSON.stringify(req.body));

// Review: ensure sensitive data is masked
console.log('User password: [REDACTED]');
```

## HTTP

### S5732: Cookies should be secure
```typescript
// Hotspot
res.cookie('session', token);

// Review: add security flags
res.cookie('session', token, {
  httpOnly: true,
  secure: true,
  sameSite: 'strict'
});
```

### S5739: HTTPS should be used
```typescript
// Hotspot
http.createServer(app); // Unencrypted

// Review: use HTTPS in production
https.createServer(options, app);
```

---

# Language-Specific Rules

## TypeScript/JavaScript

### S6754: React hooks should be called correctly
```typescript
// Non-compliant
function Component({ condition }) {
  if (condition) {
    const [state, setState] = useState(); // Conditional hook!
  }
}

// Compliant
function Component({ condition }) {
  const [state, setState] = useState();
}
```

### S6582: Optional chaining should be preferred
```typescript
// Non-compliant
const name = user && user.profile && user.profile.name;

// Compliant
const name = user?.profile?.name;
```

### S6598: Arrow functions should be preferred for callbacks
```typescript
// Non-compliant
items.map(function(item) { return item.name; });

// Compliant
items.map(item => item.name);
```

## Python

### S5806: Class methods should reference self
```python
# Non-compliant
class MyClass:
    def process(self):
        return compute()  # self not used

# Compliant - use @staticmethod
class MyClass:
    @staticmethod
    def process():
        return compute()
```

### S5719: Instance and class methods should have at least one positional parameter
```python
# Non-compliant
class MyClass:
    def process():  # Missing self!
        pass

# Compliant
class MyClass:
    def process(self):
        pass
```

## C# / .NET

### S2933: Fields that are only assigned in constructor should be readonly
```csharp
// Non-compliant
private string _name;

public MyClass(string name) {
    _name = name;
}

// Compliant
private readonly string _name;
```

### S3925: ISerializable should be implemented correctly
```csharp
// Non-compliant - missing protected constructor
[Serializable]
public class MyException : Exception, ISerializable { }

// Compliant
[Serializable]
public class MyException : Exception, ISerializable {
    protected MyException(SerializationInfo info, StreamingContext context)
        : base(info, context) { }
}
```

---

# Review Output Format

When reviewing code, report issues in this format:

```
## Code Review Summary

**Quality Gate**: PASSED / FAILED

| Type | Blocker | Critical | Major | Minor | Info |
|------|---------|----------|-------|-------|------|
| Bug | 0 | 0 | 0 | 0 | 0 |
| Vulnerability | 0 | 0 | 0 | 0 | 0 |
| Code Smell | 0 | 0 | 0 | 0 | 0 |
| Security Hotspot | 0 | 0 | 0 | 0 | 0 |

### Issues Found

#### [SEVERITY] [TYPE]: [Rule ID] - [Rule Name]
**File:** `path/to/file.ts:42`
**Description:** [What's wrong]
**Code:**
\`\`\`typescript
// Current code
\`\`\`
**Recommendation:**
\`\`\`typescript
// Fixed code
\`\`\`
```

## Quality Gate Criteria

A quality gate FAILS if any of these conditions are true:
- Any Blocker issues exist
- More than 0 Critical bugs
- More than 0 Critical vulnerabilities
- More than 3 Major issues
- Code coverage < 80% (if measurable)
- Duplicated lines > 3%

---

See [references/REFERENCE.md](references/REFERENCE.md) for the complete rule catalog organized by language.
