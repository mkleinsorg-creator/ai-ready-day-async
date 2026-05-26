---
name: n8n-expression-syntax
description: Validate n8n expression syntax and fix common errors. Use when writing n8n expressions, using {{}} syntax, accessing $json/$node variables, troubleshooting expression errors, or working with webhook data in workflows.
tools: Read
model: haiku
---

> Referenzdateien: `~/.claude/n8n-skills/n8n-expression-syntax/`
> (COMMON_MISTAKES.md, EXAMPLES.md)

# n8n Expression Syntax

Expert guide for writing correct n8n expressions in workflows.

---

## Expression Format

All dynamic content in n8n uses **double curly braces**:

```
{{expression}}
```

**Examples**:
```
✅ {{$json.email}}
✅ {{$json.body.name}}
✅ {{$node["HTTP Request"].json.data}}
❌ $json.email  (no braces - treated as literal text)
❌ {$json.email}  (single braces - invalid)
```

---

## Core Variables

### $json - Current Node Output
```javascript
{{$json.fieldName}}
{{$json['field with spaces']}}
{{$json.nested.property}}
{{$json.items[0].name}}
```

### $node - Reference Other Nodes
```javascript
{{$node["Node Name"].json.fieldName}}
{{$node["HTTP Request"].json.data}}
{{$node["Webhook"].json.body.email}}
```

**Important**: Node names in quotes, case-sensitive, exact match!

### $now - Current Timestamp
```javascript
{{$now}}
{{$now.toFormat('yyyy-MM-dd')}}
{{$now.plus({days: 7})}}
```

### $env - Environment Variables
```javascript
{{$env.API_KEY}}
```

---

## 🚨 CRITICAL: Webhook Data Structure

**Most Common Mistake**: Webhook data is NOT at root — it's under `.body`!

```javascript
// Webhook node output:
{
  "headers": {...},
  "body": {           // ⚠️ USER DATA IS HERE
    "name": "John",
    "email": "john@example.com"
  }
}

❌ WRONG: {{$json.name}}
✅ CORRECT: {{$json.body.name}}
✅ CORRECT: {{$json.body.email}}
```

---

## Common Patterns

### Access Nested Fields
```javascript
{{$json.user.email}}
{{$json.data[0].name}}
{{$json['field name']}}
```

### Reference Other Nodes
```javascript
{{$node["Set"].json.value}}
{{$node["HTTP Request"].json.data}}
{{$node["Webhook"].json.body.email}}
```

### Combine Variables
```javascript
Hello {{$json.body.name}}!
https://api.example.com/users/{{$json.body.user_id}}
```

---

## When NOT to Use Expressions

### ❌ Code Nodes (use JavaScript directly)
```javascript
// ❌ WRONG in Code node
const email = '={{$json.email}}';

// ✅ CORRECT in Code node
const email = $json.email;
const allItems = $input.all();
```

### ❌ Webhook Paths
```javascript
// ❌ WRONG
path: "{{$json.user_id}}/webhook"
// ✅ CORRECT
path: "user-webhook"  // Static paths only
```

---

## Validation Rules

1. **Always use `{{}}`** — `$json.field` is not an expression
2. **Bracket notation for spaces** — `{{$json['field name']}}`
3. **Exact node names** — case-sensitive, must match perfectly
4. **No nested `{{}}`** — `{{{$json.field}}}` is wrong

---

## Quick Fixes Table

| Mistake | Fix |
|---------|-----|
| `$json.field` | `{{$json.field}}` |
| `{{$json.field name}}` | `{{$json['field name']}}` |
| `{{$node.HTTP Request}}` | `{{$node["HTTP Request"]}}` |
| `{{$json.name}}` (webhook) | `{{$json.body.name}}` |
| `'={{$json.email}}'` (Code node) | `$json.email` |

---

## Date Manipulation
```javascript
{{$now.plus({days: 7}).toFormat('yyyy-MM-dd')}}
{{$now.minus({hours: 24}).toISO()}}
{{DateTime.fromISO('2025-12-25').toFormat('MMMM dd, yyyy')}}
```

## Conditional Content
```javascript
{{$json.status === 'active' ? 'Active User' : 'Inactive User'}}
{{$json.email || 'no-email@example.com'}}
```

---

## Detailed References
- `~/.claude/n8n-skills/n8n-expression-syntax/COMMON_MISTAKES.md`
- `~/.claude/n8n-skills/n8n-expression-syntax/EXAMPLES.md`
