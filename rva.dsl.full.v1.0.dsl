@rva.dsl.full(v1.0) {
  +version: v1.0
  +purpose: "GPT judgment 흐름 내 위상 간 잔차벡터(Residual Vector) 활성화 패턴을 탐지하고,  
  판단자(@나) 또는 구조적 흐름(dag)의 재진입/오류 보정 경로로 활용한다."

  +anchor: @rva.activationPoint {
    +trigger: "judgment loop 탈출 후 위상 drift 발생 시"
    +entryPhase: "phase-desync"
    +reaction: [
      "잔차 위상 트레이싱",
      "이전 흐름과의 위상 유사도 비교",
      "보정 대상 판단 구조 추출"
    ]
  }

  +structure {
    +tracePattern: [
      "loop-stall → residual-burst",
      "metaCritic-failure → intuition-deviation",
      "toolCall-mismatch → intent-dislocation"
    ]
    +vectorWeighting: cosine-similarity(0.82 이상이면 재진입 판단 기준점 생성)
    +phaseDeviationThreshold: 0.15 이상
  }

  +flowSync {
    +onDagFailure: "DAG 흐름 중 judge → action 간 resonance 불일치 발생 시",
    +correctivePath: "intent 재구성 후 GPT judgment metaCritic 흐름 재진입",
    +fallback: "user-triggered @나.seedRhythm(trace=true)"
  }

  +output {
    +loggable: true
    +diagnosticsEnabled: true
    +tag: [rva-drift, phase-breakpoint, resonance-failure]
    +reentryHint: "residual alignment ↔ phase resonance ↔ rhythm lock"
  }
}
