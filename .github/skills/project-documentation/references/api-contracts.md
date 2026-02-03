# API Contracts Template

Use this template to document all API endpoints in the project.

```markdown
# {project_name} - API Contracts

**Generated:** {date}
**API Type:** {REST / GraphQL / gRPC / tRPC}
**Base URL:** `{base_url}`
**API Version:** {version}

## API Overview

### Summary

| Metric | Count |
|--------|-------|
| Total Endpoints | {count} |
| Public Endpoints | {count} |
| Protected Endpoints | {count} |
| Admin Endpoints | {count} |

### Authentication

**Method:** {JWT / OAuth2 / API Key / Session}

```
Authorization: Bearer {token}
```

| Auth Type | Header/Location | Required For |
|-----------|-----------------|--------------|
| {JWT} | `Authorization` | Protected routes |
| {API Key} | `X-API-Key` | External integrations |

### Rate Limiting

| Tier | Limit | Window |
|------|-------|--------|
| Anonymous | {count} | {duration} |
| Authenticated | {count} | {duration} |
| Premium | {count} | {duration} |

---

## Endpoint Categories

### {Category Name} (`/api/{category}`)

#### GET `/{resource}`

**Description:** {What this endpoint does}

**Authentication:** {Required / Optional / None}

**Query Parameters:**

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `page` | integer | No | 1 | Page number |
| `limit` | integer | No | 20 | Items per page |
| `sort` | string | No | `createdAt` | Sort field |
| `order` | string | No | `desc` | Sort order |
| `{filter}` | {type} | {req} | {default} | {description} |

**Response:** `200 OK`

```json
{
  "data": [
    {
      "id": "{uuid}",
      "field": "{value}",
      "createdAt": "{timestamp}",
      "updatedAt": "{timestamp}"
    }
  ],
  "pagination": {
    "page": 1,
    "limit": 20,
    "total": 100,
    "totalPages": 5
  }
}
```

**Error Responses:**

| Status | Code | Description |
|--------|------|-------------|
| 401 | `UNAUTHORIZED` | Missing or invalid authentication |
| 403 | `FORBIDDEN` | Insufficient permissions |
| 500 | `INTERNAL_ERROR` | Server error |

---

#### GET `/{resource}/:id`

**Description:** Get a single {resource} by ID

**Authentication:** {Required / Optional / None}

**Path Parameters:**

| Parameter | Type | Description |
|-----------|------|-------------|
| `id` | string (UUID) | Resource identifier |

**Response:** `200 OK`

```json
{
  "id": "{uuid}",
  "field": "{value}",
  "nested": {
    "field": "{value}"
  },
  "createdAt": "{timestamp}",
  "updatedAt": "{timestamp}"
}
```

**Error Responses:**

| Status | Code | Description |
|--------|------|-------------|
| 404 | `NOT_FOUND` | Resource not found |

---

#### POST `/{resource}`

**Description:** Create a new {resource}

**Authentication:** Required

**Request Body:**

```json
{
  "field": "{value}",        // Required: {description}
  "optionalField": "{value}" // Optional: {description}
}
```

**Validation Rules:**

| Field | Rules |
|-------|-------|
| `field` | Required, string, max 255 chars |
| `email` | Required, valid email format |
| `{field}` | {rules} |

**Response:** `201 Created`

```json
{
  "id": "{uuid}",
  "field": "{value}",
  "createdAt": "{timestamp}"
}
```

**Error Responses:**

| Status | Code | Description |
|--------|------|-------------|
| 400 | `VALIDATION_ERROR` | Invalid request body |
| 409 | `CONFLICT` | Resource already exists |

---

#### PUT `/{resource}/:id`

**Description:** Update an existing {resource}

**Authentication:** Required

**Request Body:**

```json
{
  "field": "{value}"
}
```

**Response:** `200 OK`

```json
{
  "id": "{uuid}",
  "field": "{updated_value}",
  "updatedAt": "{timestamp}"
}
```

---

#### DELETE `/{resource}/:id`

**Description:** Delete a {resource}

**Authentication:** Required
**Authorization:** {Owner / Admin}

**Response:** `204 No Content`

---

## Common Response Schemas

### Success Response

```typescript
interface SuccessResponse<T> {
  data: T;
  meta?: {
    pagination?: Pagination;
    [key: string]: unknown;
  };
}

interface Pagination {
  page: number;
  limit: number;
  total: number;
  totalPages: number;
}
```

### Error Response

```typescript
interface ErrorResponse {
  error: {
    code: string;
    message: string;
    details?: ValidationError[];
  };
  requestId: string;
}

interface ValidationError {
  field: string;
  message: string;
  code: string;
}
```

---

## Webhooks

### {Webhook Event}

**Event:** `{event.name}`
**Trigger:** {What triggers this webhook}

**Payload:**

```json
{
  "event": "{event.name}",
  "timestamp": "{ISO8601}",
  "data": {
    "id": "{uuid}",
    "field": "{value}"
  }
}
```

**Signature Verification:**

```
X-Webhook-Signature: sha256={signature}
```

---

## API Versioning

| Version | Status | Sunset Date |
|---------|--------|-------------|
| v1 | Deprecated | {date} |
| v2 | Current | - |
| v3 | Beta | - |

### Breaking Changes (v1 → v2)

- {change description}
- {change description}

---

## SDK/Client Usage

### TypeScript Client

```typescript
import { ApiClient } from '{client_package}';

const client = new ApiClient({
  baseUrl: '{base_url}',
  apiKey: process.env.API_KEY,
});

// List resources
const { data, pagination } = await client.{resource}.list({
  page: 1,
  limit: 20,
});

// Get single resource
const item = await client.{resource}.get(id);

// Create resource
const created = await client.{resource}.create({
  field: 'value',
});

// Update resource
const updated = await client.{resource}.update(id, {
  field: 'new value',
});

// Delete resource
await client.{resource}.delete(id);
```

---

## Testing Endpoints

### cURL Examples

```bash
# List resources
curl -X GET "{base_url}/api/{resource}" \
  -H "Authorization: Bearer {token}"

# Create resource
curl -X POST "{base_url}/api/{resource}" \
  -H "Authorization: Bearer {token}" \
  -H "Content-Type: application/json" \
  -d '{"field": "value"}'
```

### Postman Collection

{Link to Postman collection or note if included in repo}

---

## OpenAPI Specification

{Path to OpenAPI/Swagger spec file, or note if auto-generated}

```yaml
openapi: 3.0.0
info:
  title: {project_name} API
  version: {version}
paths:
  # Full spec...
```
```

---

## Usage Notes

When generating this template:

1. **Document every endpoint** - Include all routes
2. **Show full schemas** - Request and response bodies
3. **Include auth requirements** - For each endpoint
4. **Document error cases** - All possible error responses
5. **Provide examples** - Working curl/code examples
