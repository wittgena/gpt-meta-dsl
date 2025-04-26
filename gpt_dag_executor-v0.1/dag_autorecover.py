# 실패 흐름 자동 복구 시뮬레이터
def auto_recover_step(step: dict) -> bool:
    print(f"[AutoRecover] '{step.get('action')}' 실패 감지 → 재시도 시뮬레이션")
    # 기본적으로 재시도 1회만 허용
    retry_count = step.get("retry_count", 0)
    if retry_count < 1:
        step["retry_count"] = retry_count + 1
        print(f"[AutoRecover] 재시도 수행 중... ({step['retry_count']})")
        return True
    print("[AutoRecover] 재시도 한도 초과. 실패로 처리.")
    return False
