# 조건 평가 로직 (실제 상태에 따라 정의)
def evaluate_condition(expr: str, context: dict = None) -> bool:
    try:
        # 간단한 조건 시뮬레이션
        if expr.strip().lower() in ["true", "yes", "ready"]:
            return True
        if ">" in expr:
            lhs, rhs = expr.split(">")
            return float(lhs.strip()) > float(rhs.strip())
        return True  # 기본적으로 조건 성립 처리
    except Exception as e:
        print(f"[!] 조건 평가 실패: {expr} -> {e}")
        return False
