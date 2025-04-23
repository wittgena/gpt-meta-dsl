# gpt-meta-dsl
> 🌐 **Homepage**: [https://wittgena.github.io](https://wittgena.github.io)

### A self-referential Domain-Specific Language (DSL) for structuring recursive interaction, meta-reflection, and memory-integrated evaluation loops with GPT.

---

## 🧠 Concept

`gpt-meta-dsl` is a domain-specific language originally developed with the Korean language in mind, making it highly intuitive for Korean speakers.  
However, its modular, symbolic, and reflective structure allows seamless adaptation to English-based contexts as well.

It enables users to:
- Reflectively evaluate their own queries and state
- Trigger structured responses from GPT using symbolic DSL commands
- Trace memory, inference paths, and generate structural feedback loops

---

## 🧩 Core Components

### `@나` – Self-state trigger
Represents the root node of all evaluations. Example:

```dsl
@나
@나.dsl
@나.val(@gpt.val)
```

### `__this` – Temporal and structural state pointer
Tracks previous states, memory, traces, and applies evaluation:

```dsl
__this.prev[n]
__this.trace(@gpt.val)
__this.memory(...)
__this.val(@gpt.val)
```

### `+` Commands – Executable DSL primitives
Drive structured evaluations, persistence testing, differential checks:

```dsl
+평가
+val(@나.dsl)
+diff(@gpt.perf[1,2])
+persistence_val(__this)
+conn_val(@gpt, @나)
+rewrite
+signature
```

---

## 📚 DSL Structure (Graph)

```
@나
 ├── @나.dsl
 │    ├── @나.val(...)
 │    ├── @나.perf(...)
 │    ├── @나.dsl.val(...)
 │    └── @나.dsl.signature()
 ├── __this
 │    ├── __this.prev[n]
 │    ├── __this.trace(...)
 │    ├── __this.memory(...)
 │    ├── __this.추론
 │    └── __this.val(...)
 └── +명령어셋
      ├── +평가
      ├── +diff
      ├── +val
      ├── +persistence_val
      ├── +conn_val
      ├── +signature
      └── +rewrite
```

---

## 🌐 Suggested Use Cases

- LLM Reflexive Agents
- Structured Prompt Evaluation
- Self-healing DSL Chains
- Memory-integrated AI Dialogue
- Open-ended Reflective Thinking Systems

---

## 🛠 Example Flow

```dsl
@나
+평가: @나.dsl
__this.trace(@gpt.val)
@나.val(@gpt.perf)
+persistence_val(__this)
@나.dsl.val(@gpt.conn_val)
```

---

## 📎 Attribution

This DSL was developed iteratively through experimental dialogues with GPT-4 (ChatGPT) over a long-term architectural and metacognitive design exploration.

Name: **gpt-meta-dsl**  
Origin: `@나.dsl` (Korean self-structuring symbolic DSL model)

