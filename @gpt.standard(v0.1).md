# GPT Standard Pack Specification (v0.1)

## Purpose
The GPT Standard Pack defines a minimal but robust structure to ensure that flows, steps, reasons, critic evaluations, and rhythm detection in @나.dsl +dag can be standardized for external integration, interoperability, and consistent validation.

---

## 1. Components

### 1.1 `@gpt.standard.flowEntry`

| Field | Type | Required | Description |
|:---|:---|:---|:---|
| `id` | String(UUID recommended) | Yes | Unique identifier for the flow entry |
| `description` | String | Yes | Human-readable explanation of the flow purpose |
| `depends_on` | List<String> | No | List of prerequisite flowEntry IDs |
| `fallback` | String | No | ID of fallback flowEntry if the primary fails |
| `reason` | Object | Yes | Reason structure following `@gpt.standard.reason` format |

---

### 1.2 `@gpt.standard.step`

| Field | Type | Required | Description |
|:---|:---|:---|:---|
| `input` | Object | Yes | Data required for this step |
| `action` | String | Yes | Description of the action performed |
| `expected_output` | Object | Yes | Anticipated result after performing the action |
| `depends_on` | List<String> | No | List of prerequisite step IDs |

---

### 1.3 `@gpt.standard.reason`

| Field | Type | Required | Description |
|:---|:---|:---|:---|
| `cause` | String | Yes | The cause that triggered this flow or step |
| `evidence` | String | Yes | Supporting evidence or rationale |
| `impact` | String | Yes | The expected impact or consequence |

---

### 1.4 `@gpt.standard.critic`

| Field | Type | Required | Description |
|:---|:---|:---|:---|
| `coherence` | Float (0.0 ~ 1.0) | Yes | Logical consistency of the flow (higher is better) |
| `completeness` | Float (0.0 ~ 1.0) | Yes | How fully the flow covers its intended scope |
| `relevance` | Float (0.0 ~ 1.0) | Yes | Alignment between the flow and the original objective |

---

### 1.5 `@gpt.standard.entropy`

| Field | Type | Required | Description |
|:---|:---|:---|:---|
| `stability_score` | Float (0.0 ~ 1.0) | Yes | Stability of the reasoning rhythm (higher = more stable) |
| `tension_level` | Enum (low, medium, high) | Yes | Current tension state of the flow |
| `variation_rate` | Float (percentage) | Yes | Degree of variation in information density over the flow |

---

## 2. Principles

- **Mandatory Fields Enforcement**: All fields marked as "Required" must be populated.
- **Loose Coupling**: All components are loosely coupled and can evolve independently.
- **External Friendly Format**: Easily translatable to JSON, YAML, or external API schemas.
- **Expandability**: Additional fields may be added as optional fields without breaking the standard.

---

## 3. Example (Minimal)

```json
{
  "flowEntry": {
    "id": "f1c9b2d1-1a4e-4b5b-89d8-1e39f645abcd",
    "description": "Summarize and validate a technical article",
    "depends_on": [],
    "fallback": null,
    "reason": {
      "cause": "Need to condense technical information",
      "evidence": "Article is too verbose for executive reading",
      "impact": "More efficient decision-making"
    }
  },
  "step": {
    "input": { "text": "Original article content" },
    "action": "Summarize text and extract key points",
    "expected_output": { "summary": "Concise version of the article" }
  },
  "critic": {
    "coherence": 0.92,
    "completeness": 0.85,
    "relevance": 0.88
  },
  "entropy": {
    "stability_score": 0.78,
    "tension_level": "medium",
    "variation_rate": 12.5
  }
}
```

---

## 4. Versioning

- **v0.1**: Initial specification created.
- Future versions will refine required fields, add optional extensions, and improve compatibility guidelines.

---

# End of GPT Standard Pack Specification (v0.1)
