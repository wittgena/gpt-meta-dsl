# Intention-Oriented Programming
**Reframing Programming as Thought Design with GPT**

---

## Summary

Traditional programming is imperative — it focuses on *how* to instruct machines.  
But what if we could program based on *what* we intend and *why* we intend it?

This article introduces an experimental approach called **Intention-Oriented Programming**,  
a method that treats GPT not as a generator, but as a **self-reflective flow engine**.  
The experiment was realized through a prototype system: `gpt_dag_executor`.

---

## 1. From Imperative Code to Intentional Flow

> "Programming is no longer just about control. It's about **representing thought**."

Instead of focusing on execution logic, this model begins with:
- What the user wants to achieve
- Why it matters
- How GPT can recursively map this into executable flows via DAGs (Directed Acyclic Graphs)

This is programming by **intention**, not just by function.

---

## 2. GPT as a Recursive Co-Judge, Not a Tool

GPT in this paradigm is not merely a generator — it is a **recursive judgmental agent**.  
The `gpt_dag_executor` system uses directives like `+dag`, `+judge`, `+fallback`, `@reason`, and `@intuition` to construct **self-regulating execution flows**.

> This goes beyond the common *Chain of Thought (CoT)* paradigm,  
> which represents linear reasoning paths in LLMs.

Instead, this system creates a **recursive, self-reflective judgment loop** —  
where GPT not only reasons but *evaluates, critiques, and revises* its own steps  
based on intent, contradiction, and flow state.

We call this a **"Chain of Judgment"**,  
not in the moral or binary sense, but as a **meta-structured evaluation flow**:  
a sequence that includes conditions for retry, fallback, self-doubt, and internal re-alignment.

---

## 3. From DSL to Thought Architecture

Using a domain-specific language called `@나.dsl`,  
I structured GPT’s outputs into judgmental flows, where **meta-expressions of thought** are encoded.

Key constructs include:

```dsl
+dag:
  flowEntry: self_reflective_judgment
  steps:
    - id: judge
      +critic: self
      +reason: why this?
      +fallback: if contradiction arises → retry
```

This is not just syntax — it is a **thinking framework**  
expressed in code.

---

## 4. Why This Matters Now

As LLMs are deployed into agents, assistants, and workflows,  
we must ask not just *what they output*, but:

> **How do LLMs reflect on the decisions they make?**  
> Can we build systems that *know* how to **re-evaluate themselves**?

**Intention-Oriented Programming** suggests that the answer lies in:
- Representing goals in terms of reasoning **intent**
- Framing GPT as a **collaborator**, not a generator
- Letting execution include reflection, contradiction, and judgment

---

## 5. What’s Next

This is an early-stage experiment, but one with major implications:

- For **agentic architectures** that require self-correction  
- For **AI alignment research** that values internal justification  
- For **developers** who want to program using goals, not just rules

I plan to continue refining `gpt_dag_executor`,  
and open-sourcing the DSLs used for this recursive orchestration model.

---

---

## Visual: Self-Reflective Execution Flow (Text-Based)

```
[Start: Intent Received]
        |
        v
   +----------------+
   |   +judge       |
   | Self-evaluate  |
   +----------------+
        |
        v
   +----------------+
   |   +critic      |
   | Analyze output |
   +----------------+
        |
        v
   +----------------+
   |   @reason      |
   | Why this step? |
   +----------------+
        |
        v
   +------------------------+
   |   +fallback            |
   | If contradiction:      |
   |  → Retry +judge        |
   | Else: Proceed to done  |
   +------------------------+
        |                |
        | Retry           v
        |------------> [Execute or Exit]
```

This diagram illustrates the recursive structure of the GPT self-reflective judgment engine.  
It starts with an intention, evaluates the decision, reasons through it, and determines whether to retry or proceed — forming a metacognitive control loop.


## Footnote: Terminology Clarification

| Term | Meaning |
|------|---------|
| **Chain of Thought (CoT)** | Linear reasoning steps in LLMs to reach a conclusion. |
| **Chain of Judgment** | A recursive flow in which GPT makes, critiques, and revises its own judgments across execution. |
| **Recursive Judgment Loop** | The core structure of `gpt_dag_executor`, using GPT as both decision-maker and evaluator. |
| **Meta-Evaluation** | When GPT reflects on the structure and integrity of its reasoning, not just the outcome. |

---

## About the Author

Originally written in Korean and reframed in English to preserve the **intention-first structure** of the original work.  
The ideas are being further developed via experiments in LangGraph, HuggingFace Spaces, and recursive prompt evaluation.

> Contact: [GitHub](https://github.com/wittgena) / [Blog](https://wittgena.github.io)

---

**Tags:**  
#GPT #AIProgramming #DSL #MetaReasoning #AgentFrameworks #FlowDesign #AIAlignment
