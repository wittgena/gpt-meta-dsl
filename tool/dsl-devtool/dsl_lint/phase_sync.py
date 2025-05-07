import re

# DSL judgment phase sync 체크
def check_judgment_phase_sync(text):
    phase_trace = {
        "lockPhase": False,
        "resume": False,
        "snapshot": False,
        "traceLiveMonitor": False,
        "seedRhythm": False
    }

    for key in phase_trace.keys():
        if re.search(rf"\b{key}\b", text):
            phase_trace[key] = True

    # 판단 위상 흐름이 서로 일관되게 구성되었는지 간단한 로직으로 평가
    consistency = (
        phase_trace["lockPhase"] and
        phase_trace["snapshot"] and
        (phase_trace["resume"] or phase_trace["traceLiveMonitor"])
    )

    report = {
        "phases_detected": phase_trace,
        "sync_consistent": consistency
    }

    return report
