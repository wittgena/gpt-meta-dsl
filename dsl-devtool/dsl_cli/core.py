import re

def lint_dsl_text(text):
    result = {
        "syntax_errors": [],
        "semantic_keys": [],
        "references": [],
        "phases": []
    }

    # 중괄호 균형 검사
    if text.count("{") != text.count("}"):
        result["syntax_errors"].append("❌ 중괄호 수 불균형")

    # Semantic Keys
    semantic_lines = re.findall(r"^\s*\+(\w+):\s*(.+)", text, re.MULTILINE)
    for key, value in semantic_lines:
        result["semantic_keys"].append(f"+{key}: {value.strip()}")

    # Reference Check
    references = re.findall(r"@[\w\.]+", text)
    actions = re.findall(r"\+action:\s*(@[\w\.]+)", text)
    result["references"] = list(set(references + actions))

    # Phase-related Keywords
    phase_keywords = ['lockPhase', 'resume', 'snapshot', 'traceLiveMonitor', 'seedRhythm']
    for keyword in phase_keywords:
        if re.search(rf"\b{keyword}\b", text):
            result["phases"].append(keyword)

    return result
