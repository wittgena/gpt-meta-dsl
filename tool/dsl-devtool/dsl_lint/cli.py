import sys
from pathlib import Path
from .core import lint_dsl_text

def main():
    if len(sys.argv) != 2:
        print("사용법: dsl-lint <파일경로>")
        sys.exit(1)

    file_path = Path(sys.argv[1])
    if not file_path.exists():
        print(f"❌ 파일을 찾을 수 없습니다: {file_path}")
        sys.exit(1)

    text = file_path.read_text(encoding="utf-8")
    result = lint_dsl_text(text)

    print("\n=== DSL Lint Report ===")
    for k, v in result.items():
        print(f"\n[{k.upper()}]")
        if v:
            print("\n".join(v))
        else:
            print("✅ None")
