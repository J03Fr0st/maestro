# Configuration Template

Use this template to document all project configuration and environment setup.

```markdown
# {project_name} - Configuration

**Generated:** {date}
**Config Location:** `{path/to/config}`
**Env Example:** `{.env.example path}`

## Configuration Overview

### Configuration Sources

| Source | Priority | Purpose |
|--------|----------|---------|
| Environment Variables | 1 (Highest) | Runtime configuration |
| `.env.local` | 2 | Local overrides |
| `.env.{environment}` | 3 | Environment-specific |
| `.env` | 4 | Default values |
| Config files | 5 (Lowest) | Static configuration |

### Environment Types

| Environment | `.env` File | Purpose |
|-------------|-------------|---------|
| Development | `.env.development` | Local development |
| Test | `.env.test` | Test execution |
| Staging | `.env.staging` | Pre-production |
| Production | `.env.production` | Live environment |

---

## Environment Variables

### Required Variables

These MUST be set for the application to run:

| Variable | Type | Example | Description |
|----------|------|---------|-------------|
| `DATABASE_URL` | string | `postgresql://...` | Database connection string |
| `{VAR_NAME}` | {type} | `{example}` | {description} |
| `{VAR_NAME}` | {type} | `{example}` | {description} |

### Optional Variables

| Variable | Type | Default | Description |
|----------|------|---------|-------------|
| `PORT` | number | `3000` | Server port |
| `LOG_LEVEL` | string | `info` | Logging verbosity |
| `{VAR_NAME}` | {type} | `{default}` | {description} |

### Feature Flags

| Variable | Type | Default | Description |
|----------|------|---------|-------------|
| `FEATURE_{NAME}` | boolean | `false` | Enable {feature} |
| `{VAR_NAME}` | {type} | `{default}` | {description} |

### Third-Party Services

| Service | Variables | Required |
|---------|-----------|----------|
| {Service} | `{PREFIX}_API_KEY`, `{PREFIX}_SECRET` | Yes |
| {Service} | `{PREFIX}_URL` | Optional |

---

## Environment File Template

```bash
# .env.example
# Copy this file to .env and fill in the values

# ============================================
# Application
# ============================================
NODE_ENV=development
PORT=3000
APP_URL=http://localhost:3000
LOG_LEVEL=debug

# ============================================
# Database
# ============================================
DATABASE_URL=postgresql://user:password@localhost:5432/dbname

# ============================================
# Authentication
# ============================================
JWT_SECRET=your-secret-key-here
JWT_EXPIRES_IN=7d
SESSION_SECRET=your-session-secret

# ============================================
# External Services
# ============================================
# {Service Name}
{SERVICE}_API_KEY=
{SERVICE}_SECRET=

# {Service Name}
{SERVICE}_URL=
{SERVICE}_TOKEN=

# ============================================
# Feature Flags
# ============================================
FEATURE_NEW_UI=false
FEATURE_BETA_ACCESS=false

# ============================================
# Development Only
# ============================================
DEBUG=false
SEED_DATABASE=false
```

---

## Configuration Files

### Application Config

**File:** `{path/to/config.ts}`

```typescript
// config/index.ts
import { z } from 'zod';

const configSchema = z.object({
  env: z.enum(['development', 'test', 'staging', 'production']),
  port: z.number().default(3000),

  database: z.object({
    url: z.string().url(),
    poolSize: z.number().default(10),
  }),

  auth: z.object({
    jwtSecret: z.string().min(32),
    jwtExpiresIn: z.string().default('7d'),
  }),

  features: z.object({
    newUi: z.boolean().default(false),
  }),
});

export type Config = z.infer<typeof configSchema>;

export const config = configSchema.parse({
  env: process.env.NODE_ENV,
  port: Number(process.env.PORT),

  database: {
    url: process.env.DATABASE_URL,
    poolSize: Number(process.env.DB_POOL_SIZE),
  },

  auth: {
    jwtSecret: process.env.JWT_SECRET,
    jwtExpiresIn: process.env.JWT_EXPIRES_IN,
  },

  features: {
    newUi: process.env.FEATURE_NEW_UI === 'true',
  },
});
```

### Framework Configuration

#### {Framework} Config

**File:** `{config_file_path}`

```typescript
// {framework}.config.ts
export default {
  // Document key configuration options
  {option}: {value},
  {option}: {value},
};
```

---

## Build Configuration

### Build Tool

**Tool:** {Vite / Webpack / esbuild / Turbopack}
**Config:** `{path/to/build/config}`

```typescript
// vite.config.ts
import { defineConfig } from 'vite';

export default defineConfig({
  // Key build options
  build: {
    outDir: 'dist',
    sourcemap: true,
  },

  // Environment variable handling
  envPrefix: '{PREFIX}_',

  // Plugins
  plugins: [
    // ...
  ],
});
```

### Build Modes

| Mode | Command | Output | Source Maps |
|------|---------|--------|-------------|
| Development | `{dev_cmd}` | Memory | Yes |
| Production | `{build_cmd}` | `dist/` | Optional |
| Analyze | `{analyze_cmd}` | Report | No |

---

## TypeScript Configuration

**File:** `tsconfig.json`

```json
{
  "compilerOptions": {
    "target": "{target}",
    "module": "{module}",
    "strict": true,
    "baseUrl": ".",
    "paths": {
      "@/*": ["src/*"],
      "@components/*": ["src/components/*"]
    }
  },
  "include": ["src/**/*"],
  "exclude": ["node_modules", "dist"]
}
```

### Path Aliases

| Alias | Path | Usage |
|-------|------|-------|
| `@/*` | `src/*` | General imports |
| `@components/*` | `src/components/*` | Component imports |
| `{alias}` | `{path}` | {usage} |

---

## Linting and Formatting

### ESLint

**Config:** `.eslintrc.{ext}`

```json
{
  "extends": ["{preset}"],
  "rules": {
    "{rule}": "{setting}"
  }
}
```

### Prettier

**Config:** `.prettierrc`

```json
{
  "semi": {value},
  "singleQuote": {value},
  "tabWidth": {value},
  "trailingComma": "{value}"
}
```

---

## Secrets Management

### Secret Storage

| Environment | Method | Tool |
|-------------|--------|------|
| Development | `.env.local` | dotenv |
| CI/CD | Environment secrets | {CI tool} |
| Production | Secret manager | {AWS SSM / Vault / etc.} |

### Secret Rotation

| Secret | Rotation Period | Process |
|--------|-----------------|---------|
| JWT Secret | {period} | {process} |
| API Keys | {period} | {process} |
| Database Password | {period} | {process} |

### Never Commit

```gitignore
# .gitignore - secrets
.env
.env.local
.env.*.local
*.pem
*.key
credentials.json
```

---

## Runtime Configuration

### Dynamic Configuration

```typescript
// Runtime config that can be changed without rebuild
interface RuntimeConfig {
  apiUrl: string;
  featureFlags: Record<string, boolean>;
  analytics: {
    enabled: boolean;
    trackingId: string;
  };
}

// Loaded from: /api/config or window.__CONFIG__
```

### Configuration Validation

```typescript
// Validate configuration at startup
function validateConfig(config: unknown): Config {
  const result = configSchema.safeParse(config);

  if (!result.success) {
    console.error('Invalid configuration:', result.error.issues);
    process.exit(1);
  }

  return result.data;
}
```

---

## Deployment Configuration

### Environment-Specific Settings

| Setting | Development | Staging | Production |
|---------|-------------|---------|------------|
| Debug mode | true | true | false |
| Log level | debug | info | warn |
| SSL | false | true | true |
| Minification | false | true | true |
| Source maps | inline | hidden | none |

### Infrastructure Config

**Location:** `{infra_config_path}`

```yaml
# docker-compose.yml / kubernetes / terraform
{relevant_config_snippet}
```

---

## Troubleshooting

### Common Issues

| Issue | Cause | Solution |
|-------|-------|----------|
| Missing env var | Not set | Check `.env.example` |
| Type error in config | Wrong type | Validate with schema |
| {issue} | {cause} | {solution} |

### Debugging Configuration

```bash
# Print resolved config (development only)
{debug_config_command}

# Validate environment
{validate_env_command}
```
```

---

## Usage Notes

When generating this template:

1. **List all env vars** - Required and optional
2. **Show example values** - Safe, non-secret examples
3. **Document secrets handling** - Security practices
4. **Cover all config files** - Framework, build, lint
5. **Include validation** - Schema and startup checks
