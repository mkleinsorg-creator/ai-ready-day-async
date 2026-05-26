---
name: n8n-workflow-patterns
description: Proven workflow architectural patterns from real n8n workflows. Use when building new workflows, designing workflow structure, choosing workflow patterns, planning workflow architecture, or asking about webhook processing, HTTP API integration, database operations, AI agent workflows, or scheduled tasks.
tools: Read
model: haiku
---

> Referenzdateien: `~/.claude/n8n-skills/n8n-workflow-patterns/`
> (webhook_processing.md, http_api_integration.md, database_operations.md, ai_agent_workflow.md, scheduled_tasks.md)

# n8n Workflow Patterns

Proven architectural patterns for building n8n workflows.

---

## The 5 Core Patterns

Based on analysis of real workflow usage:

1. **Webhook Processing** (Most Common)
   - Receive HTTP requests → Process → Output
   - Pattern: Webhook → Validate → Transform → Respond/Notify

2. **HTTP API Integration**
   - Fetch from REST APIs → Transform → Store/Use
   - Pattern: Trigger → HTTP Request → Transform → Action → Error Handler

3. **Database Operations**
   - Read/Write/Sync database data
   - Pattern: Schedule → Query → Transform → Write → Verify

4. **AI Agent Workflow**
   - AI agents with tools and memory
   - Pattern: Trigger → AI Agent (Model + Tools + Memory) → Output

5. **Scheduled Tasks**
   - Recurring automation workflows
   - Pattern: Schedule → Fetch → Process → Deliver → Log

---

## Pattern Selection Guide

**Webhook Processing** - Use when:
- Receiving data from external systems
- Building integrations (Slack commands, form submissions, GitHub webhooks)
- Need instant response to events

**HTTP API Integration** - Use when:
- Fetching data from external APIs
- Synchronizing with third-party services
- Building data pipelines

**Database Operations** - Use when:
- Syncing between databases
- Running database queries on schedule
- ETL workflows

**AI Agent Workflow** - Use when:
- Building conversational AI
- Need AI with tool access
- Multi-step reasoning tasks

**Scheduled Tasks** - Use when:
- Recurring reports or summaries
- Periodic data fetching
- Maintenance tasks

---

## Common Workflow Components

### Triggers
- **Webhook** - HTTP endpoint (instant)
- **Schedule** - Cron-based timing (periodic)
- **Manual** - Click to execute (testing)
- **Polling** - Check for changes (intervals)

### Data Sources
- **HTTP Request** - REST APIs
- **Database nodes** - Postgres, MySQL, MongoDB
- **Service nodes** - Slack, Google Sheets, etc.
- **Code** - Custom JavaScript/Python

### Transformation
- **Set** - Map/transform fields
- **Code** - Complex logic
- **IF/Switch** - Conditional routing
- **Merge** - Combine data streams

### Outputs
- **HTTP Request** - Call APIs
- **Database** - Write data
- **Communication** - Email, Slack, Discord
- **Storage** - Files, cloud storage

### Error Handling
- **Error Trigger** - Catch workflow errors
- **IF** - Check for error conditions
- **Stop and Error** - Explicit failure
- **Continue On Fail** - Per-node setting

---

## Workflow Creation Checklist

### Planning Phase
- [ ] Identify the pattern (webhook, API, database, AI, scheduled)
- [ ] List required nodes (use search_nodes)
- [ ] Understand data flow (input → transform → output)
- [ ] Plan error handling strategy

### Implementation Phase
- [ ] Create workflow with appropriate trigger
- [ ] Add data source nodes
- [ ] Configure authentication/credentials
- [ ] Add transformation nodes (Set, Code, IF)
- [ ] Add output/action nodes
- [ ] Configure error handling

### Validation Phase
- [ ] Validate each node configuration (validate_node)
- [ ] Validate complete workflow (validate_workflow)
- [ ] Test with sample data
- [ ] Handle edge cases (empty data, errors)

### Deployment Phase
- [ ] Review workflow settings
- [ ] Activate workflow using `activateWorkflow` operation
- [ ] Monitor first executions
- [ ] Document workflow purpose and data flow

---

## Data Flow Patterns

### Linear Flow
```
Trigger → Transform → Action → End
```

### Branching Flow
```
Trigger → IF → [True Path]
             └→ [False Path]
```

### Parallel Processing
```
Trigger → [Branch 1] → Merge
       └→ [Branch 2] ↗
```

### Loop Pattern
```
Trigger → Split in Batches → Process → Loop (until done)
```

### Error Handler Pattern
```
Main Flow → [Success Path]
         └→ [Error Trigger → Error Handler]
```

---

## Common Gotchas

### 1. Webhook Data Structure
```javascript
❌ {{$json.email}}
✅ {{$json.body.email}}
```

### 2. Multiple Input Items
Use "Execute Once" mode or process first item only:
```javascript
{{$json[0].field}}
```

### 3. Node Execution Order
Check workflow settings → Execution Order
- v1: Connection-based (recommended)

---

## Quick Start Examples

### Example 1: Simple Webhook → Slack
```
1. Webhook (path: "form-submit", POST)
2. Set (map form fields)
3. Slack (post message to #notifications)
```

### Example 2: Scheduled Report
```
1. Schedule (daily at 9 AM)
2. HTTP Request (fetch analytics)
3. Code (aggregate data)
4. Email (send formatted report)
5. Error Trigger → Slack (notify on failure)
```

### Example 3: AI Assistant
```
1. Webhook (receive chat message)
2. AI Agent
   ├─ OpenAI Chat Model (ai_languageModel)
   ├─ HTTP Request Tool (ai_tool)
   └─ Window Buffer Memory (ai_memory)
3. Webhook Response (send AI reply)
```

---

## Pattern Statistics

**Most Common Triggers**: Webhook 35%, Schedule 28%, Manual 22%
**Most Common Transformations**: Set 68%, Code 42%, IF 38%
**Most Common Outputs**: HTTP Request 45%, Slack 32%, Database 28%

---

## Detailed Pattern Files

Read these for comprehensive guidance:
- `~/.claude/n8n-skills/n8n-workflow-patterns/webhook_processing.md`
- `~/.claude/n8n-skills/n8n-workflow-patterns/http_api_integration.md`
- `~/.claude/n8n-skills/n8n-workflow-patterns/database_operations.md`
- `~/.claude/n8n-skills/n8n-workflow-patterns/ai_agent_workflow.md`
- `~/.claude/n8n-skills/n8n-workflow-patterns/scheduled_tasks.md`

---

## Best Practices

### ✅ Do
- Start with the simplest pattern that solves your problem
- Plan your workflow structure before building
- Use error handling on all workflows
- Test with sample data before activation
- Follow the workflow creation checklist

### ❌ Don't
- Build workflows in one shot (iterate! avg 56s between edits)
- Skip validation before activation
- Ignore error scenarios
- Hardcode credentials in parameters
