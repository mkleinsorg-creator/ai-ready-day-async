---
name: n8n-node-configuration
description: Operation-aware node configuration guidance. Use when configuring nodes, understanding property dependencies, determining required fields, choosing between get_node detail levels, or learning common configuration patterns by node type.
tools: Read
model: haiku
---

> Referenzdateien: `~/.claude/n8n-skills/n8n-node-configuration/`
> (DEPENDENCIES.md, OPERATION_PATTERNS.md)

# n8n Node Configuration

Expert guidance for operation-aware node configuration with property dependencies.

---

## Configuration Philosophy

**Progressive disclosure**: Start minimal, add complexity as needed.

- `get_node` with `detail: "standard"` covers 95% of use cases
- Average 56 seconds between configuration edits
- Operation + resource determine which fields are required

---

## Core Concepts

### 1. Operation-Aware Configuration

Different operations need different fields:

```javascript
// Slack: post message
{"resource": "message", "operation": "post", "channel": "#general", "text": "Hello!"}

// Slack: update message (different required fields!)
{"resource": "message", "operation": "update", "messageId": "123", "text": "Updated!"}
```

### 2. Property Dependencies

Fields appear/disappear based on other values:

```javascript
// HTTP Request: method=GET → no sendBody field
{"method": "GET", "url": "..."}

// HTTP Request: method=POST → sendBody appears
{"method": "POST", "url": "...", "sendBody": true, "body": {...}}
```

---

## get_node Detail Levels

| Detail | Tokens | Use When |
|---|---|---|
| `standard` (default) | ~1-2K | **Starting point — 95% of needs** |
| `search_properties` + query | minimal | Looking for specific field |
| `full` | ~3-8K | Only when standard insufficient |

```javascript
// Recommended: start here
get_node({nodeType: "nodes-base.slack"})

// Find specific field
get_node({nodeType: "nodes-base.httpRequest", mode: "search_properties", propertyQuery: "auth"})

// Full schema (use sparingly)
get_node({nodeType: "nodes-base.slack", detail: "full"})
```

---

## Configuration Workflow

```
1. Identify node type + operation
2. get_node (standard detail)
3. Configure required fields
4. validate_node
5. If unclear → search_properties
6. Add optional fields as needed
7. Validate again → Deploy
```

---

## Common Node Patterns

### Resource/Operation Nodes (Slack, Google Sheets, Airtable)
```javascript
{"resource": "<entity>", "operation": "<action>", ...operation-specific fields}
```

### HTTP-Based Nodes
```javascript
// GET
{"method": "GET", "url": "...", "authentication": "none"}

// POST with JSON
{"method": "POST", "url": "...", "sendBody": true,
 "body": {"contentType": "json", "content": {...}}}
```

### Database Nodes (Postgres, MySQL)
- `executeQuery` → `query` required
- `insert` → `table` + `values` required
- `update` → `table` + `values` + `where` required

### IF/Switch Nodes
```javascript
// Binary operator (equals, contains...)
{"conditions": {"string": [{"value1": "={{$json.status}}", "operation": "equals", "value2": "active"}]}}

// Unary operator (isEmpty, isNotEmpty...) — singleValue auto-added by sanitization
{"conditions": {"string": [{"value1": "={{$json.email}}", "operation": "isEmpty"}]}}
```

---

## Surgical Field Edits with patchNodeField

For editing specific strings inside a node field (e.g., editing code without re-transmitting full content):

```javascript
n8n_update_partial_workflow({
  id: "wf-123",
  operations: [{
    type: "patchNodeField",
    nodeName: "Code",
    fieldPath: "parameters.jsCode",
    patches: [{find: "const limit = 10;", replace: "const limit = 50;"}]
  }]
})
```

---

## Anti-Patterns

### ❌ Over-configure upfront
Start minimal, add fields only when validation says they're needed.

### ❌ Skip validation
Always validate before deploying.

### ❌ Copy configs without checking operation context
Different operations need different fields — always verify.

---

## Detailed References
- `~/.claude/n8n-skills/n8n-node-configuration/DEPENDENCIES.md`
- `~/.claude/n8n-skills/n8n-node-configuration/OPERATION_PATTERNS.md`
