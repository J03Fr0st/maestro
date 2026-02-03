# Project Type Detection Reference

This document provides detailed patterns for detecting and classifying project types during documentation workflows.

## Detection Matrix

### Web Applications

**Key File Patterns:**
- `package.json` with React, Vue, Angular, Svelte, or similar
- `tsconfig.json`, `jsconfig.json`
- Config files: `vite.config.*`, `webpack.config.*`, `next.config.*`, `nuxt.config.*`

**Critical Directories:**
- `src/`, `app/`, `pages/`
- `components/`, `views/`
- `api/`, `lib/`, `utils/`
- `styles/`, `public/`, `static/`

**Documentation Requirements:**
| Requirement | Required |
|-------------|----------|
| API Scan | Yes |
| Data Models | Yes |
| State Management | Yes |
| UI Components | Yes |
| Deployment Config | Yes |

**Common Patterns:**
- Entry: `index.ts`, `main.ts`, `app.ts`, `_app.tsx`
- Tests: `*.test.ts`, `*.spec.ts`, `__tests__/`
- Config: `.env*`, `config/`

---

### Mobile Applications

**Key File Patterns:**
- React Native: `app.json`, `metro.config.js`
- Flutter: `pubspec.yaml`
- Capacitor/Ionic: `capacitor.config.*`, `ionic.config.json`
- Native: `Podfile`, `build.gradle`

**Critical Directories:**
- `src/`, `app/`, `screens/`
- `components/`, `services/`, `models/`
- `assets/`, `ios/`, `android/`

**Documentation Requirements:**
| Requirement | Required |
|-------------|----------|
| API Scan | Yes |
| Data Models | Yes |
| State Management | Yes |
| UI Components | Yes |
| Asset Inventory | Yes |

---

### Backend/API Services

**Key File Patterns:**
- Node.js: `package.json` with Express, Fastify, NestJS, Hono
- Python: `requirements.txt`, `pyproject.toml` with FastAPI, Django, Flask
- Go: `go.mod`, `go.sum`
- Rust: `Cargo.toml` with Actix, Axum
- Java: `pom.xml`, `build.gradle`

**Critical Directories:**
- `src/`, `api/`, `services/`
- `models/`, `routes/`, `controllers/`
- `middleware/`, `handlers/`, `repositories/`

**Documentation Requirements:**
| Requirement | Required |
|-------------|----------|
| API Scan | Yes |
| Data Models | Yes |
| State Management | No |
| UI Components | No |
| Deployment Config | Yes |

**Common Patterns:**
- Entry: `main.ts`, `index.ts`, `server.ts`, `app.ts`, `main.go`, `main.py`
- Auth: `*auth*`, `*session*`, `middleware/auth*`, `guards/`
- Migrations: `migrations/`, `prisma/`, `alembic/`

---

### CLI Tools

**Key File Patterns:**
- Node.js: `package.json` with `bin` field
- Go: `go.mod` with `cmd/` directory
- Python: `setup.py`, `pyproject.toml` with console_scripts
- Rust: `Cargo.toml` with `[[bin]]`

**Critical Directories:**
- `src/`, `cmd/`, `cli/`, `bin/`
- `lib/`, `commands/`

**Documentation Requirements:**
| Requirement | Required |
|-------------|----------|
| API Scan | No |
| Data Models | No |
| State Management | No |
| UI Components | No |
| Deployment Config | No |

---

### Libraries/Packages

**Key File Patterns:**
- `package.json` with `main`, `module`, `exports` fields
- Rollup/Vite library mode configs
- `tsconfig.json` with `declaration: true`

**Critical Directories:**
- `src/`, `lib/`
- `dist/`, `build/` (output)

**Documentation Requirements:**
| Requirement | Required |
|-------------|----------|
| API Scan | No |
| Data Models | No |
| State Management | No |
| UI Components | No |
| Deployment Config | No |

**Focus Areas:**
- Public API surface
- Type definitions
- Usage examples
- Changelog and versioning

---

### Desktop Applications

**Key File Patterns:**
- Electron: `electron-builder.yml`, `forge.config.*`
- Tauri: `tauri.conf.json`, `src-tauri/`
- Wails: `wails.json`

**Critical Directories:**
- `src/`, `app/`, `main/`, `renderer/`
- `components/`, `resources/`, `assets/`

**Documentation Requirements:**
| Requirement | Required |
|-------------|----------|
| API Scan | No |
| Data Models | No |
| State Management | Yes |
| UI Components | Yes |
| Asset Inventory | Yes |

---

### Data/Pipeline Projects

**Key File Patterns:**
- Airflow: `airflow.cfg`, `dags/`
- dbt: `dbt_project.yml`, `profiles.yml`
- Generic: `pipeline.py`, `etl/`

**Critical Directories:**
- `dags/`, `pipelines/`, `models/`
- `transformations/`, `sql/`, `etl/`, `jobs/`

**Documentation Requirements:**
| Requirement | Required |
|-------------|----------|
| API Scan | No |
| Data Models | Yes |
| State Management | No |
| UI Components | No |
| Deployment Config | Yes |

---

### Infrastructure/DevOps

**Key File Patterns:**
- Terraform: `*.tf`, `*.tfvars`
- Pulumi: `pulumi.yaml`, `Pulumi.*.yaml`
- Kubernetes: `*.yaml` with apiVersion/kind
- Docker: `Dockerfile`, `docker-compose*.yml`

**Critical Directories:**
- `terraform/`, `modules/`
- `k8s/`, `charts/`, `helm/`
- `playbooks/`, `roles/`

**Documentation Requirements:**
| Requirement | Required |
|-------------|----------|
| API Scan | No |
| Data Models | No |
| State Management | No |
| UI Components | No |
| Deployment Config | Yes |

---

## Multi-Part Detection

A project is multi-part when:

1. **Separate package manifests** - Multiple `package.json`, `go.mod`, etc. in subdirectories
2. **Distinct entry points** - Separate runnable applications
3. **Clear boundaries** - Folders like `client/`, `server/`, `api/`, `web/`, `mobile/`
4. **Monorepo markers** - `pnpm-workspace.yaml`, `lerna.json`, `nx.json`, `turbo.json`

### Common Multi-Part Patterns

| Structure | Parts | Detection |
|-----------|-------|-----------|
| Client/Server | 2 | `client/` + `server/` or `frontend/` + `backend/` |
| Monorepo | N | Workspace config + `packages/` or `apps/` |
| Microservices | N | Multiple service directories with own manifests |
| Full-stack | 3+ | `web/` + `api/` + `shared/` or similar |

### Integration Detection Patterns

Look for integration points:
- REST clients: `*client.ts`, `*api.ts`, `fetch*`, `axios*`
- GraphQL: `*.graphql`, `graphql/`, `apollo*`
- gRPC: `*.proto`, `grpc*`
- Events: `*event*`, `*queue*`, `*subscriber*`, `*consumer*`
- Shared: `shared/`, `common/`, `packages/shared`

---

## Exclusion Patterns

Always exclude from scanning:
- `node_modules/`
- `.git/`
- `dist/`, `build/`, `out/`
- `coverage/`
- `*.min.js`, `*.map`
- `__pycache__/`, `.pytest_cache/`
- `target/` (Rust/Java)
- `.next/`, `.nuxt/`, `.svelte-kit/`
