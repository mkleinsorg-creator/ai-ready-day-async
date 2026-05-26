---
name: n8n-code-python
description: Write Python code in n8n Code nodes. Use when writing Python in n8n, using _input/_json/_node syntax, working with standard library, or need to understand Python limitations in n8n Code nodes.
tools: Read
model: sonnet
---

> Referenzdateien: `~/.claude/n8n-skills/n8n-code-python/`
> (DATA_ACCESS.md, COMMON_PATTERNS.md, ERROR_PATTERNS.md, STANDARD_LIBRARY.md)

# Python Code Node (Beta)

Expert guidance for writing Python code in n8n Code nodes.

---

## ⚠️ JavaScript First!

Use Python only when:
- You need specific Python standard library functions
- You're significantly more comfortable with Python syntax
- Statistical operations requiring `statistics` module

For 95% of use cases: **use JavaScript** (better helpers, Luxon DateTime, full n8n integration).

---

## Quick Start

```python
items = _input.all()

processed = []
for item in items:
    processed.append({
        "json": {
            **item["json"],
            "processed": True,
            "timestamp": datetime.now().isoformat()
        }
    })

return processed
```

**Essential Rules:**
1. Consider JavaScript first
2. Access: `_input.all()`, `_input.first()`, or `_input.item`
3. CRITICAL: Return `[{"json": {...}}]` format
4. CRITICAL: Webhook data under `_json["body"]`
5. CRITICAL: **No external libraries** — standard library only

---

## Mode Selection

### Run Once for All Items (Default)
```python
all_items = _input.all()
total = sum(item["json"].get("amount", 0) for item in all_items)
return [{"json": {"total": total, "count": len(all_items)}}]
```

### Run Once for Each Item
```python
item = _input.item
return [{"json": {**item["json"], "processed": True}}]
```

---

## Data Access

```python
# All items
all_items = _input.all()

# First item
first = _input.first()
data = first["json"]

# Current item (Each Item mode)
current = _input.item

# Reference other node
webhook_data = _node["Webhook"]["json"]
```

---

## 🚨 CRITICAL: Webhook Data Under ["body"]

```python
# ❌ WRONG
name = _json["name"]

# ✅ CORRECT
name = _json["body"]["name"]

# ✅ SAFER
name = _json.get("body", {}).get("name")
```

---

## Return Format (CRITICAL)

```python
# ✅ Single
return [{"json": {"field": value}}]

# ✅ Multiple
return [{"json": item["json"]} for item in _input.all()]

# ✅ Empty
return []

# ❌ WRONG
return {"json": {"field": value}}  # Not a list!
return [{"field": value}]           # Missing "json" key!
```

---

## CRITICAL LIMITATION: No External Libraries

```python
# ❌ NOT AVAILABLE
import requests   # No
import pandas    # No
import numpy     # No

# ✅ AVAILABLE (standard library)
import json
import re
import base64
import hashlib
import urllib.parse
import math
import random
from statistics import mean, median, stdev
from datetime import datetime, timedelta
```

**Workarounds:**
- Need HTTP? → Use **HTTP Request node** (or switch to JavaScript)
- Need pandas? → Use JavaScript or manual list operations
- Need scraping? → Use **HTTP Request + HTML Extract nodes**

---

## Top 5 Errors

### #1: External Library Import
```python
# ❌ import requests → ModuleNotFoundError
# ✅ Use HTTP Request node or switch to JavaScript
```

### #2: Missing Return
```python
# ❌ No return statement
# ✅ return [{"json": ...}]
```

### #3: Wrong Return Format
```python
# ❌ return {"json": {...}}
# ✅ return [{"json": {...}}]
```

### #4: KeyError
```python
# ❌ name = _json["user"]["name"]
# ✅ name = _json.get("user", {}).get("name", "Unknown")
```

### #5: Webhook Body Nesting
```python
# ❌ email = _json["email"]
# ✅ email = _json.get("body", {}).get("email")
```

---

## Python Modes

### Python (Beta) — Recommended
```python
items = _input.all()
now = _now  # Built-in datetime
```

### Python (Native) (Beta) — Limited
```python
# Only _items/_item variables, no helpers
for item in _items:
    ...
```

---

## Common Patterns

```python
# Transformation
return [
    {"json": {"id": item["json"].get("id"), "name": item["json"].get("name", "").upper()}}
    for item in _input.all()
]

# Aggregation
from statistics import mean
values = [item["json"].get("value", 0) for item in _input.all()]
return [{"json": {"mean": mean(values), "count": len(values)}}]

# Regex extraction
import re
emails = re.findall(r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b',
                    _input.first()["json"].get("text", ""))
return [{"json": {"emails": list(set(emails))}}]

# Validation
validated = []
for item in _input.all():
    errors = []
    if not item["json"].get("email"): errors.append("Email required")
    validated.append({"json": {**item["json"], "valid": not errors, "errors": errors or None}})
return validated
```

---

## Detailed References
- `~/.claude/n8n-skills/n8n-code-python/DATA_ACCESS.md`
- `~/.claude/n8n-skills/n8n-code-python/COMMON_PATTERNS.md`
- `~/.claude/n8n-skills/n8n-code-python/ERROR_PATTERNS.md`
- `~/.claude/n8n-skills/n8n-code-python/STANDARD_LIBRARY.md`
