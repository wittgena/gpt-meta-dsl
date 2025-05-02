# 📘 FocusMap IDE Integration – RFC / Concept Note

---

## Title:
**FocusMap as a Judgment-Oriented Reasoning Layer for LLM-Powered IDEs**

---

## Abstract

Modern AI-enhanced IDEs like Cursor, GitHub Copilot, and Amazon CodeWhisperer utilize AST-based representations to support syntax-aware code generation.  
However, they lack a recursive judgment structure that aligns with how LLMs internally reason, revise, and stabilize over time.  

This RFC proposes a way to integrate **FocusMap**, a DSL designed to structure recursive, uncertainty-driven, and reflective judgment loops,  
as a higher-level orchestration layer over existing LLM coding pipelines.

---

## 1. Problem Statement

- One-shot GPT suggestions are often rejected, but no state memory tracks why
- No mechanism to re-evaluate or reflect on prior suggestions
- IDEs lack uncertainty-based re-entry or sensory loop fallback
- All feedback is context-agnostic and linear

---

## 2. Proposed FocusMap Role in IDEs

### 📌 DSL-Guided Judgment Orchestration

```text
[User Input / PR Diff] 
    ↓
[+critic node] 
    └─ recurse_if: entropy > 0.6
       → stores eval_trace → persists to memory / VectorDB
    ↓
[+metaCritic node]
    └─ recurse_if: val.variance > 0.35
    ↓
[+intuition node]
    └─ fallback if formal metrics stable but feels wrong
    ↓
[+val node]
    └─ terminate_if: entropy < 0.3 → judgment loop exits
```

---

## 3. Integration Architecture

- FocusMap DSL defines the reasoning loop and is embedded into IDE middleware
- GPT’s response trace (`eval_trace`, entropy, previous context) is passed into each node
- DSL flow transitions (e.g., `recurse_if`, `terminate_if`) decide whether to repeat, rephrase, or finalize
- Optionally orchestrated using LangGraph or external memory systems

---

## 4. Benefits

- Recovers reasoning lost in one-shot GPT interactions
- Makes GPT feedback loops inspectable and explainable
- Enables GPT to reflect, refine, and stabilize in IDEs
- Separates syntax validation (AST) from dynamic judgment structure (FocusMap)

---

## 5. Visual Summary

```
Code Change → GPT Critique → FocusMap Node → Memory → Reflect → Exit
                |                |                ↑
                └── Entropy ─────┘     Val.variance-based re-entry
```

---

## 6. Future Work

- Implement FocusMap middleware module in VSCode or Cursor plugin
- Hook into LLM execution traces (`logprobs`, `tool use`, `reflection tokens`)
- Link DSL nodes to UI feedback panels (e.g., show phase: +critic, +metaCritic)

---

## Authors:
Wittgena Lee (@wittgena)  
[github.com/wittgena/gpt-meta-dsl](https://github.com/wittgena/gpt-meta-dsl)