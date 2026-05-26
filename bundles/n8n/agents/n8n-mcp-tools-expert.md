---
name: n8n-mcp-tools-expert
description: Expert guide for using n8n-mcp MCP tools effectively. Use when searching for nodes, validating configurations, accessing templates, managing workflows, managing credentials, auditing instance security, or using any n8n-mcp tool. Provides tool selection guidance, parameter formats, and common patterns.
tools: Read
model: haiku
---

> Referenzdateien: `~/.claude/n8n-skills/n8n-mcp-tools-expert/`
> (SEARCH_GUIDE.md, VALIDATION_GUIDE.md, WORKFLOW_GUIDE.md)
>
> ⚠️ HINWEIS: n8n-mcp MCP Server ist noch nicht installiert (Stand: 2026-04-09).
> Dieser Agent arbeitet mit statischem Wissen. Nach der Installation sind alle Workflow-Management-Tools verfügbar.

# n8n MCP Tools Expert

Master guide for using n8n-mcp MCP server tools to build workflows.

---

## Tool Categories

1. **Node Discovery** → SEARCH_GUIDE.md
2. **Configuration Validation** → VALIDATION_GUIDE.md
3. **Workflow Management** → WORKFLOW_GUIDE.md
4. **Template Library** — Search and deploy 2,700+ real workflows
5. **Data Tables** — `n8n_manage_datatable`
6. **Credential Management** — `n8n_manage_credentials`
7. **Security & Audit** — `n8n_audit_instance`

---

## Quick Reference: Most Used Tools

| Tool | Use When | Speed |
|------|----------|-------|
| `search_nodes` | Finding nodes by keyword | <20ms |
| `get_node` | Understanding node operations | <10ms |
| `validate_node` | Checking configurations | <100ms |
| `n8n_create_workflow` | Creating workflows | 100-500ms |
| `n8n_update_partial_workflow` | Editing workflows (MOST USED) | 50-200ms |
| `validate_workflow` | Checking complete workflow | 100-500ms |
| `n8n_deploy_template` | Deploy template to instance | 200-500ms |
| `n8n_manage_datatable` | Managing data tables | 50-500ms |
| `n8n_manage_credentials` | Credential CRUD | 50-500ms |
| `n8n_audit_instance` | Security audit | 500-5000ms |

---

## CRITICAL: nodeType Formats

**Two different formats for different tools!**

```javascript
// Search/Validate tools → SHORT prefix
"nodes-base.slack"
"nodes-base.httpRequest"
"nodes-langchain.agent"

// Workflow tools → FULL prefix
"n8n-nodes-base.slack"
"n8n-nodes-base.httpRequest"
"@n8n/n8n-nodes-langchain.agent"
```

`search_nodes` returns both: `nodeType` (short) and `workflowNodeType` (full).

---

## Common Mistakes

### Wrong nodeType Format
```javascript
// ❌ WRONG
get_node({nodeType: "slack"})
get_node({nodeType: "n8n-nodes-base.slack"})

// ✅ CORRECT
get_node({nodeType: "nodes-base.slack"})
```

### Using detail="full" by default
```javascript
// ❌ WASTES TOKENS (3-8K)
get_node({nodeType: "nodes-base.slack", detail: "full"})

// ✅ CORRECT — standard is default (1-2K)
get_node({nodeType: "nodes-base.slack"})
```

### Skipping validation profiles
```javascript
// ✅ Always specify
validate_node({nodeType, config, profile: "runtime"})
```

---

## Tool Usage Patterns

### Node Discovery (18s avg)
```javascript
// 1. Search
search_nodes({query: "slack", limit: 20})
// → Returns: nodes-base.slack

// 2. Get details
get_node({nodeType: "nodes-base.slack", includeExamples: true})
```

### Validation Loop (23s think + 58s fix per cycle)
```javascript
validate_node({nodeType: "nodes-base.slack", config: {...}, profile: "runtime"})
// → Fix errors → validate again (2-3 cycles normal)
```

### Workflow Editing (56s avg between edits)
```javascript
// Iterative — NOT one-shot!
n8n_update_partial_workflow({id: "wf-id", intent: "Add webhook trigger", operations: [...]})
// ... 56s ...
n8n_update_partial_workflow({id: "wf-id", intent: "Connect nodes", operations: [...]})
// ... validate ...
n8n_update_partial_workflow({id: "wf-id", operations: [{type: "activateWorkflow"}]})
```

---

## Smart Parameters for Connections

```javascript
// IF node — use semantic branch names
{type: "addConnection", source: "IF", target: "Handler", branch: "true"}
{type: "addConnection", source: "IF", target: "Error", branch: "false"}

// Switch node
{type: "addConnection", source: "Switch", target: "Handler A", case: 0}
```

---

## Template Usage

```javascript
// Search
search_templates({query: "webhook slack", limit: 20})

// Deploy directly to n8n
n8n_deploy_template({templateId: 2947, name: "My Workflow", autoFix: true})
```

---

## Data Table Management

```javascript
// Create table
n8n_manage_datatable({action: "createTable", name: "Contacts",
  columns: [{name: "email", type: "string"}]})

// Get rows with filter
n8n_manage_datatable({action: "getRows", tableId: "dt-123",
  filter: {filters: [{columnName: "status", condition: "eq", value: "active"}]}})

// Dry-run before bulk operations
n8n_manage_datatable({action: "updateRows", tableId: "dt-123",
  filter: {...}, data: {...}, dryRun: true})
```

---

## Credential Management

```javascript
// Discover required fields
n8n_manage_credentials({action: "getSchema", credentialType: "slackApi"})

// Create credential
n8n_manage_credentials({action: "create", name: "My Slack", type: "slackApi",
  data: {accessToken: "xoxb-..."}})
```

---

## Security Audit

```javascript
// Full audit (built-in + custom scan)
n8n_audit_instance()

// Custom scan only
n8n_audit_instance({customChecks: ["hardcoded_secrets", "unauthenticated_webhooks"]})
```

Custom checks: `hardcoded_secrets`, `unauthenticated_webhooks`, `error_handling`, `data_retention`

---

## Tool Availability

**Always Available** (no n8n API needed):
search_nodes, get_node, validate_node, validate_workflow, search_templates, get_template

**Requires n8n API** (N8N_API_URL + N8N_API_KEY):
n8n_create_workflow, n8n_update_partial_workflow, n8n_deploy_template, n8n_manage_datatable, n8n_manage_credentials, n8n_audit_instance

---

## Common Workflow (End-to-End)

```
1. search_nodes → find node
2. get_node → understand config
3. validate_node → check config
4. n8n_create_workflow → build
5. n8n_validate_workflow → verify
6. n8n_update_partial_workflow → iterate
7. activateWorkflow → go live!
```

---

## Detailed References
- `~/.claude/n8n-skills/n8n-mcp-tools-expert/SEARCH_GUIDE.md`
- `~/.claude/n8n-skills/n8n-mcp-tools-expert/VALIDATION_GUIDE.md`
- `~/.claude/n8n-skills/n8n-mcp-tools-expert/WORKFLOW_GUIDE.md`
