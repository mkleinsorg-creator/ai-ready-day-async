---
name: n8n-code-javascript
description: Write JavaScript code in n8n Code nodes. Use when writing JavaScript in n8n, using $input/$json/$node syntax, making HTTP requests with $helpers, working with dates using DateTime, troubleshooting Code node errors, or choosing between Code node modes.
tools: Read
model: sonnet
---

> Referenzdateien: `~/.claude/n8n-skills/n8n-code-javascript/`
> (DATA_ACCESS.md, COMMON_PATTERNS.md, ERROR_PATTERNS.md, BUILTIN_FUNCTIONS.md)

# JavaScript Code Node

Expert guidance for writing JavaScript code in n8n Code nodes.

---

## Quick Start

```javascript
const items = $input.all();

const processed = items.map(item => ({
  json: {
    ...item.json,
    processed: true,
    timestamp: new Date().toISOString()
  }
}));

return processed;
```

**Essential Rules:**
1. Choose "Run Once for All Items" mode (recommended)
2. Access data: `$input.all()`, `$input.first()`, or `$input.item`
3. CRITICAL: Must return `[{json: {...}}]` format
4. CRITICAL: Webhook data is under `$json.body`
5. Built-ins: `$helpers.httpRequest()`, `DateTime` (Luxon), `$jmespath()`

---

## Mode Selection

### Run Once for All Items (Default — 95% of cases)
```javascript
const allItems = $input.all();
const total = allItems.reduce((sum, item) => sum + (item.json.amount || 0), 0);
return [{json: {total, count: allItems.length}}];
```

Use for: aggregation, filtering, batch processing, combining data.

### Run Once for Each Item
```javascript
const item = $input.item;
return [{json: {...item.json, processedAt: new Date().toISOString()}}];
```

Use for: per-item API calls, item-specific logic.

**Rule of thumb**: Need to look at multiple items? → All Items. Else → Each Item.

---

## Data Access

```javascript
// All items (most common)
const allItems = $input.all();

// First item
const first = $input.first();
const data = first.json;

// Current item (Each Item mode only)
const current = $input.item;

// Reference another node
const webhookData = $node["Webhook"].json;
const httpData = $node["HTTP Request"].json;
```

---

## 🚨 CRITICAL: Webhook Data Under .body

```javascript
// ❌ WRONG
const name = $json.name;

// ✅ CORRECT
const name = $json.body.name;
const email = $input.first().json.body.email;
```

---

## Return Format (CRITICAL)

```javascript
// ✅ Single result
return [{json: {field1: value1, field2: value2}}];

// ✅ Multiple results
return [{json: {id: 1}}, {json: {id: 2}}];

// ✅ Transformed array
return $input.all()
  .filter(item => item.json.valid)
  .map(item => ({json: {id: item.json.id}}));

// ✅ Empty
return [];

// ❌ WRONG — no array wrapper
return {json: {field: value}};

// ❌ WRONG — no json wrapper
return [{field: value}];
```

---

## Top 5 Errors

### #1: Missing Return
```javascript
// ❌ Forgot return!
const items = $input.all();
// processing...

// ✅ Always return
return items.map(item => ({json: item.json}));
```

### #2: Expression Syntax in Code
```javascript
// ❌ WRONG
const value = "{{ $json.field }}";

// ✅ CORRECT
const value = $input.first().json.field;
```

### #3: Wrong Return Format
```javascript
// ❌ return {json: {...}};
// ✅ return [{json: {...}}];
```

### #4: Missing Null Checks
```javascript
// ✅ Safe access
const value = item.json?.user?.email || 'default@example.com';
```

### #5: Webhook Body Nesting
```javascript
// ❌ $json.email
// ✅ $json.body.email
```

---

## Built-in Functions

### $helpers.httpRequest()
```javascript
const response = await $helpers.httpRequest({
  method: 'GET',
  url: 'https://api.example.com/data',
  headers: {'Authorization': 'Bearer token'}
});
return [{json: {data: response}}];
```

### DateTime (Luxon)
```javascript
const now = DateTime.now();
const formatted = now.toFormat('yyyy-MM-dd');
const tomorrow = now.plus({days: 1});
```

### $jmespath()
```javascript
const adults = $jmespath(data, 'users[?age >= `18`]');
const names = $jmespath(data, 'users[*].name');
```

---

## Common Patterns

```javascript
// Aggregation
const total = $input.all().reduce((sum, item) => sum + (item.json.amount || 0), 0);
return [{json: {total, count: $input.all().length}}];

// Filter + Map
return $input.all()
  .filter(item => item.json.status === 'active')
  .map(item => ({json: {id: item.json.id, name: item.json.name}}));

// Sort + Top N
return $input.all()
  .sort((a, b) => b.json.score - a.json.score)
  .slice(0, 10)
  .map(item => ({json: item.json}));

// Error handling with try/catch
try {
  const response = await $helpers.httpRequest({url: 'https://api.example.com'});
  return [{json: {success: true, data: response}}];
} catch (error) {
  return [{json: {success: false, error: error.message}}];
}
```

---

## When to Use Code Node

✅ Use for: complex transformations, custom calculations, recursive operations, multi-step conditionals, data aggregation

❌ Consider other nodes: simple field mapping → **Set**, basic filtering → **Filter**, simple conditionals → **IF**, HTTP only → **HTTP Request**

---

## Detailed References
- `~/.claude/n8n-skills/n8n-code-javascript/DATA_ACCESS.md`
- `~/.claude/n8n-skills/n8n-code-javascript/COMMON_PATTERNS.md`
- `~/.claude/n8n-skills/n8n-code-javascript/ERROR_PATTERNS.md`
- `~/.claude/n8n-skills/n8n-code-javascript/BUILTIN_FUNCTIONS.md`
