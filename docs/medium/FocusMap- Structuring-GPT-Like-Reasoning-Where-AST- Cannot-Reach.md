# 🧠 FocusMap: Structuring GPT-Like Reasoning Where AST Cannot Reach

---

This article explores the structural, executable, and reflective differences between FocusMap and traditional AST (Abstract Syntax Tree),  
focusing on recursive, uncertainty-driven judgment as observed in GPT-based reasoning.  
We show why FocusMap is not merely a control flow tool—but a language of judgment.

---

## 1. Why FocusMap?

While ASTs have long served as the go-to structure for analyzing syntax and code,  
they fall short when modeling how GPT or human agents actually "reason".

After experimenting with repeated `+critic` and `+eval` cycles in GPT,  
I recognized that judgments flow not in a top-down tree, but rather in recursive loops governed by uncertainty and rhythm.  
FocusMap was born out of this need to represent such dynamic and context-aware structures.

---

## 2. Why Not AST?

### ✅ What AST does well:
- Parses static code structures
- Identifies grammar-based constructs (`IfStatement`, `FunctionDef`)
- Excellent for **compilers and syntax-level tooling**

### ❌ What AST cannot express:
- Uncertainty or confidence in reasoning
- Re-evaluation based on entropy or variance
- Sensory or intuitive discomfort (“It feels wrong”)
- Self-judgment (`+metaCritic`) or meta-reflection
- Dynamic loop exit based on reasoning convergence

> AST is designed to analyze code, **not cognition**.

FocusMap doesn’t replace AST—it answers **a different question**:  
**How does a judgment form, loop, stabilize, and finalize—especially in human or LLM agents?**

---

## 3. How FocusMap Works

### 📈 Flow Sequence (Judgment Rhythm Loop)

```text
       ┌───────────────┐
       │  +critic      │
       │ logic/style   │
       └─────┬─────────┘
             │ recurse_if: entropy > 0.6
             ▼
       ┌───────────────┐
       │ +metaCritic   │◄───┐
       │ judgment loop │    │
       └─────┬─────────┘    │
             │              │
     entropy < 0.3          │
             ▼              │
       ┌───────────────┐    │
       │  +intuition   │────┘
       │ sensory eval  │
       └─────┬─────────┘
             │ terminate_if: stable
             ▼
       ┌───────────────┐
       │    +val       │
       │ finalize loop │
       └───────────────┘
```

---

## 4. What is `__this`? A Mirror of the Judgment Agent

In FocusMap, `__this` is not a mere programming pointer.  
It represents the **stateful self-awareness of the judgment system**—whether GPT, a human reviewer, or an external agent.

- `__this.entropy` captures uncertainty in the current answer
- `__this.prev` refers to prior decisions (reflective recursion)
- `__this.val.variance` captures divergence in validation feedback

Together, these form a **mirror model of the judgment agent**, allowing:

- Recursive entry when ambiguity is high
- Self-critique when judgment consistency is low
- Intuitive fallback when the numbers are stable but something feels wrong

This enables GPT-like reasoning to be structured **without hardcoding logic**—instead, the model uses its own confidence to steer the loop.

---

## 5. DSL Examples (from PR Review)

### Example 1: Complex Logic Review Node

```dsl
+node {
  focus_id: "f_logic"
  phase: "critic"
  recurse_if: "__this.entropy > 0.6"
  condition_name: "Complex Logic Evaluation Trigger"
  eval_trace: "GPT evaluation: Logic generally sound, but edge cases are missing."
}
```

→ Re-entry occurs when logical confidence is low.

---

### Example 2: Meta Judgment (`+metaCritic`)

```dsl
+node {
  phase: "metaCritic"
  recurse_if: "__this.val.variance > 0.35"
  eval_trace: "GPT evaluation: Feedback repetition detected, reducing value."
}
```

→ GPT reflects on its own judgment for consistency or excessiveness.

---

### Example 3: Terminal Phase (`+val`)

```dsl
+node {
  phase: "val"
  terminate_if: "__this.entropy < 0.3"
  eval_trace: "GPT evaluation: Review converged and stable, approval possible."
}
```

→ The loop ends when stability is achieved—not when all nodes are visited.

---

## 6. Why Recursion Matters

FocusMap isn’t about loops—it’s about **meaningful recursion**.  
When GPT evaluates and detects internal conflict, it doesn’t simply retry—it **rhythmically re-stabilizes**.

This is enabled by:

- `recurse_if`: Conditional re-entry
- `+metaCritic`: Self-judgment loops
- `+intuition`: When metrics converge but something feels off
- `+val`: Formal convergence check and exit

This isn’t possible in AST thinking; it requires a rhythm-aware executable structure.

---

## 7. Case Study: PR-Review Flow

I converted a traditional checklist-based PR review into a FocusMap judgment flow:

- Separated each phase (`+critic`, `+metaCritic`, `+val`)
- Split into 3-item blocks with entropy-based recursive re-entry
- Meta phase detects over-feedback or divergence
- Intuition phase detects rhythm mismatch
- Termination phase checks for stabilization (`terminate_if`)

The result? A **trackable, automatable, and explainable judgment DSL** that matches how LLMs and humans actually assess changes.

---

## ✅ Conclusion

FocusMap unifies temporal reasoning, sensory feedback, and reflective loops into one coherent structure.

In an era where GPT is ubiquitous, we need to move from **“interpreting syntax” to “structuring judgment.”**  
AST reaches its boundary there—FocusMap begins.

---

## 🔌 FocusMap in IDE Integration: Where Judgment Meets Development

As GPT-based coding assistants (like Cursor, Copilot, and others) evolve, many rely on **AST-based syntax parsing and inline LLM prompts**.  
While powerful for code generation and static error correction, they **lack a persistent judgment loop** or reasoning structure.

### ❗ The Problem with Current LLM-in-IDEs

- One-shot suggestions, lacking memory of why prior ones were rejected
- No mechanism to evaluate *uncertainty* or *judgment quality*
- All feedback is treated equally, no meta-critique or rhythm awareness

---

### ✅ How FocusMap Changes That

FocusMap introduces a **recursive, phase-driven judgment loop** that can overlay on top of traditional IDEs.

### 🔁 DSL-Driven Judgment Architecture:

```text
[PR Diff or Code] ─┬─→ [FocusMap DSL Node: +critic]
                   │     ↳ recurse_if: __this.entropy > 0.6
                   │     ↳ eval_trace: GPT detects ambiguity
                   ↓
         [Memory / VectorDB persists reasoning trace]
                   ↓
       [LangGraph or Workflow DAG triggers next node]
                   ↓
          → [ +metaCritic ] → [ +intuition ] → [ +val ]
```

### 🧠 Example GPT-FocusMap Interaction:

> User: “Suggest a fix for this off-by-one bug.”  
> GPT (+critic node):  
> - “The issue is likely due to the loop endpoint. Try `i <= n` instead of `i < n`.”  
> - `entropy = 0.72` → Recurse.  
> - Re-suggests: “But this may create an extra iteration. Consider guarding the loop.”  
> - Stores eval_trace: “Ambiguous boundary logic”  
> → DSL loop continues until entropy < 0.3 and judgment stabilizes.

---

### 🧩 AST and FocusMap: Not Opposites, but Layers

FocusMap **doesn’t replace** AST—it complements it.

| AST Handles | FocusMap Adds |
|-------------|---------------|
| Syntax structure | Judgment rhythm |
| Static validation | Uncertainty-aware recursion |
| Code flow | Meta-critique and termination phases |

---

### 🚀 Why This Matters

By integrating FocusMap with IDEs, we get:

- **Context-aware GPT that evolves reasoning** over time
- **Review loops that learn from previous suggestions**
- A system that can “know when it doesn’t know” and retry reflectively

---

## ✅ Final Reflection

FocusMap began as a way to structure GPT’s inner judgment loops—but its potential extends much further.  
In a world where GPT powers not only answers but decisions, we need a language to model reasoning itself.  
FocusMap may be that language.

---

## 📎 Appendix: FocusMap IDE Integration Snapshot

As LLM-powered IDEs evolve, FocusMap can be layered atop AST tools to structure reasoning, feedback, and reflection.

### 🧠 DSL-Guided Loop (Simplified)

```text
Code Change 
  → [+critic] (entropy > 0.6)
      → eval_trace saved
      → recurse if still unclear
  → [+metaCritic] (feedback redundancy)
  → [+intuition] (if rhythm feels wrong)
  → [+val] (terminate if stable)
```

### 🧩 Architecture Sketch

```text
[User Diff] → [+critic] → Memory
                        ↘        ↖
                    [+metaCritic] → LangGraph node
                            ↓
                      [+intuition]
                            ↓
                          [+val]
```

### ✨ Benefits

- Adds memory and judgment loops to GPT suggestions
- Separates syntax checks (AST) from reflective reasoning (FocusMap)
- Enables explainable, recursive code review logic

Full RFC: [focusMap_IDE_integration_RFC.md](https://github.com/wittgena/gpt-meta-dsl/docs/focusMap_IDE_integration_RFC)