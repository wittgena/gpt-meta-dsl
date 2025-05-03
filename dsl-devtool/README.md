# GPT-Meta-DSL Devtool

This is a development utility package for working with structured DSL files like `@나.dsl.full`, used in GPT judgment-based orchestration and reflection systems.  
It provides syntax checking, semantic extraction, phase tracing, AST transformation, JSON conversion, and GraphViz `.dot` export for visualization.

---

## 📦 Installation

```bash
# Unzip the package
unzip gpt_meta_dsl_devtool.zip
cd gpt_meta_dsl_devtool

# Install the package
pip install .
```

---

## 🛠️ CLI Tools

| Command | Description |
|---------|-------------|
| `dsl-lint <file.md>` | Run syntax and structure checks on the DSL file |
| `dsl-json <file.md>` | Convert the DSL structure into AST JSON format |
| `dsl-dot <file.md>`  | Export the DSL flow structure as a `.dot` GraphViz diagram |

---

## 🧪 Example Usage

```bash
# Lint DSL file
dsl-lint @나.dsl.snapshot.md

# Convert DSL to JSON
dsl-json @나.dsl.snapshot.md > snapshot_ast.json

# Generate DOT file for visualization
dsl-dot @나.dsl.snapshot.md > snapshot.dot

# Convert DOT to SVG (requires GraphViz)
dot -Tsvg snapshot.dot -o snapshot.svg
```

---

## ✅ GitHub CI Integration

This package includes a GitHub Actions workflow:
- `.github/workflows/dsl_lint_check.yml`
- Automatically lints `.md` DSL files on push or pull request
- Also prints `.dot` graphs to logs for structural insight

```yaml
name: DSL Lint Check

on:
  push:
    paths: ['**.md', 'dsl_lint/**']
  pull_request:
    paths: ['**.md', 'dsl_lint/**']

jobs:
  lint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-python@v4
        with:
          python-version: '3.10'
      - run: pip install .
      - run: |
          for f in $(find . -name "*.md"); do
            dsl-lint "$f"
            dsl-dot "$f"
          done
```

---

## 🔮 Future Extensions (Optional)

- SVG auto-exporter from `.dot`
- DSL flow visualizer with rhythm phase overlays
- Structural diff and DSL unit test engine

---

Created by [Wittgena](https://github.com/wittgena) — Experimental DSL tooling for GPT-cooperative reasoning.
