# Security Hotspot Rules (Requires Review)

Security hotspots are security-sensitive code that requires manual review to determine if it's safe.

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
