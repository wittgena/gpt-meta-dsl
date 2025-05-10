# 📘 @나.focusMap DSL V0.2 – nextSpec 확장 버전

이 문서는 기존 V0.1 구조를 유지하면서, `@focusMap.nextSpec` 확장 요소(`desc`, `group`, `condition_name`, `eval_trace`, `source_ref`)를 통합하여  
더 풍부한 판단 흐름 설명, 추적성, 메타 구조 해석이 가능하도록 개선한 FocusMap DSL입니다.

---

## 🔹 DSL 구조 with nextSpec 확장

```dsl
@focusMap.recursiveSpec {

  +init:
    focus_id: "entry"
    label: "judgment entry"
    desc: "판단 루프의 진입점으로 GPT가 판단자 모드로 진입하며 흐름을 초기화한다."
    phase: "initial"
    depth: 0
    action: +dag.bootstrapReflectiveRun
    next: ["f_critic"]

  +node {
    focus_id: "f_critic"
    label: "primary judgment"
    desc: "사용자의 논리 흐름 또는 주장 일관성에 대한 1차 판단을 수행하며, 복잡도와 불확실성에 따라 반복된다."
    phase: "critic"
    group: "core_judgment"
    recurse_if: "__this.entropy > 0.6 || __this.score < __this.prev.score"
    condition_name: "불확실성 기반 비판 루프"
    action: +critic
    eval_trace: "GPT 판단: 논리 구조 일부 모호. 재진입 필요"
    source_ref: "user.argument[1~3]"
    next: ["f_meta"]

    example:
      input: "Evaluate the consistency of the user's argument."
      trigger: "entropy = 0.72 → recurse"
      result: "GPT re-enters +critic with tighter focus on logic structure"
  }

  +node {
    focus_id: "f_meta"
    label: "evaluate the evaluation"
    desc: "GPT의 판단 자체에 대한 메타평가를 수행. 과잉 판단, 일관성 저하 등의 리스크 평가 루프"
    phase: "metaCritic"
    group: "self_reflect"
    recurse_if: "__this.phase == 'critic' && __this.val.variance > 0.3"
    condition_name: "비판 평가의 일관성 루프 조건"
    action: +metaCritic
    eval_trace: "GPT 판단: 판단 일관성 중간 수준. 메타 재귀 수행"
    source_ref: "internal.judgment.variance"
    next: ["f_intuition"]

    example:
      input: "Was the previous judgment coherent?"
      trigger: "val.variance = 0.4 → recurse"
      result: "GPT performs a meta-level critique on its prior assessment"
  }

  +node {
    focus_id: "f_intuition"
    label: "intuition fallback"
    desc: "판단 루프가 수치적 안정은 확보했으나, 리듬상 위화감이 존재할 경우 직관 판단을 활성화함"
    phase: "intuition"
    recurse_if: "__this.entropy > 0.75"
    condition_name: "감각 기반 불안정성 진입 조건"
    action: +intuition
    eval_trace: "GPT 판단: 수치는 적절하나 문맥상 어색함 존재"
    next: ["f_val"]

    example:
      input: "Intuitively, does this answer feel off?"
      trigger: "entropy spikes to 0.78 → recurse"
      result: "GPT applies a non-formal reevaluation, citing contextual dissonance"
  }

  +node {
    focus_id: "f_val"
    label: "final validation"
    desc: "판단 루프가 감각 및 수치 모두에서 안정화되었는지 판단 후 종료 여부를 결정함"
    phase: "val"
    terminate_if: "__this.phase == 'intuition' && __this.entropy < 0.3"
    condition_name: "직관 종료 안정 조건"
    action: +val
    eval_trace: "GPT 판단: 리듬 안정. 종료 가능"
    
    example:
      input: "Is the current answer stable and sufficiently validated?"
      trigger: "entropy = 0.21, phase = 'intuition' → terminate"
      result: "GPT exits the loop with a validated final response"
  }

  +config {
    maxDepth: 4
    allow_refocus_from: ["__this", "__this.prev"]
    trace_binding: true
    notify_on_overflow: true
    peer_evaluation: false
  }
}
```

---
## 🔸 구성 요약

| 구성 | 설명 |
|------|------|
| `+init` | 판단 흐름의 진입점. GPT 판단 루프 진입 |
| `+node` | 각 판단 위상별 실행 조건 및 재귀 조건 설정 |
| `+config` | 흐름 안정화 및 재귀 안전성 보장 옵션들 |

---

## 🔸 위상 흐름 요약

1. **entry (초기 진입)**  
2. → **f_critic** (기본 판단)  
3. → **f_meta** (판단에 대한 평가)  
4. → **f_intuition** (직관적 보완 판단)  
5. → **f_val** (최종 검증 및 종료 조건 판단)

---

## 🔸 리듬 제어 기준

- `__this.entropy`, `__this.score`, `__this.val.variance` 등의 판단 상태 기반 조건을 통해 재귀 루프 실행
- 위상 구조(critic → metaCritic → intuition → val)에 따른 판단 흐름 설계
- 종료 조건은 안정화된 위상과 낮은 혼란도(entropy) 기반

---

## 🔸 DSL 철학 요약
- 이 DSL은 GPT judgment 흐름을 구조적으로 재귀화하는 최소 단위이며,
- 실험적 judgment engine 또는 자기반사 루프 DSL의 기반이 됩니다.
- 각 판단 위상은 명시적 phase와 상태 기반 조건으로 구성되며, `__this`는 실행 흐름의 핵심 상태 캐리어이며, 판단 리듬의 재진입 조건의 중심축을 이룸

## 🔸 V0.2의 주요 확장 필드 정리

| 필드명 | 설명 |
|--------|------|
| `desc` | 판단 흐름의 맥락, 목적, 감각 기반 설명 명시 |
| `group` | 위상적으로 묶이는 노드 그룹 (예: 초기 판단, 메타 판단 등) |
| `condition_name` | 재귀 또는 종료 조건에 명명적 의미 부여 |
| `eval_trace` | 판단 수행 시 GPT 또는 판단자가 남긴 추론/요약 |
| `source_ref` | 판단에 대한 외부 근거 또는 입력 참조 링크/항목명 |