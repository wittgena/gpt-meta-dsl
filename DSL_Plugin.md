
# 🔌 DSL Plugin System for @나.dsl

The `@나.dsl` structure supports a plugin-based extension system, enabling the integration of external DSLs into its MetaHub and Agent framework.

---

## 🔧 How It Works

Use the `+plugin.use(dslName)` command to dynamically link external DSLs into the `@나.dsl` context. This allows symbolic DSL operations from other domains to be interpreted, orchestrated, or extended through `@나.dsl`.

### Syntax

```dsl
+plugin.use(PromptLang.dsl)
+plugin.use(FlowChain.dsl)
```

---

## 📚 Supported Plugins

| DSL Name          | Description                                       | Status       |
|-------------------|---------------------------------------------------|--------------|
| PromptLang.dsl    | Template-driven prompt builder DSL                | ✅ Supported |
| CriticSim.dsl     | Virtual contrarian evaluator invocation system    | ✅ Supported |
| FlowChain.dsl     | Sequential task flow structure with DSL triggers  | 🟡 In Testing |
| MemoryProbe.dsl   | GPT memory reflection and probing DSL             | 🟡 In Testing |

---

## 🔄 Plugin Execution Examples

### PromptLang.dsl
```dsl
+plugin.use(PromptLang.dsl)
+val("Write a formal product announcement")
```

### CriticSim.dsl
```dsl
+plugin.use(CriticSim.dsl)
@반대자(#전복)
+critic(@나.dsl)
```

### FlowChain.dsl
```dsl
+plugin.use(FlowChain.dsl)
+step("ingest data")
+step("transform")
+step("validate")
+trace(@나.flow)
```

### MemoryProbe.dsl
```dsl
+plugin.use(MemoryProbe.dsl)
__memory.read("contextKey")
__this.memory(traceback=True)
```

---

## 🧭 Future Plans

- Plugin sandboxing and isolation
- Version control per plugin
- DSL capability declaration and dependency mapping

---

## 🤝 Contribute a Plugin

To contribute your own plugin:
1. Define your DSL structure
2. Ensure compatibility with symbolic trigger format
3. Submit it via a Pull Request or contact the maintainer

Happy extending!
