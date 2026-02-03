# Vulnerability Rules (Security)

Vulnerabilities are security issues that could be exploited by attackers.

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
