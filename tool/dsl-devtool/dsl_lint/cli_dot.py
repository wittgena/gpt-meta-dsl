import sys
from pathlib import Path
from .dot_export import dsl_to_dot

def main():
    if len(sys.argv) != 2:
        print("사용법: dsl-dot <파일경로>")
        sys.exit(1)

    file_path = Path(sys.argv[1])
    if not file_path.exists():
        print(f"❌ 파일을 찾을 수 없습니다: {file_path}")
        sys.exit(1)

    text = file_path.read_text(encoding="utf-8")
    dot_output = dsl_to_dot(text)
    print(dot_output)
