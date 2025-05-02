# 🧪 @focusMap.nextSpec 예시 – 사용자의 PR 리뷰 평가 흐름 적용 예

이 예시는 PR 리뷰 상황에서 사용자의 판단 흐름을 `@focusMap.nextSpec` 구조로 모델링한 예제입니다.  
각 판단 흐름은 `+critic`, `+metaCritic`, `+intuition`, `+val` 위상으로 구성되며,  
각 단계마다 `desc`, `condition_name`, `eval_trace`, `source_ref` 등의 확장 필드를 활용하여 판단 맥락을 명확히 설명합니다.

---

## 🔹 DSL 예시

```dsl
@focusMap.recursiveSpec {

  +init:
    focus_id: "entry"
    label: "PR 평가 시작"
    desc: "사용자의 리뷰 요청에 대한 판단 루프 시작점"
    phase: "initial"
    action: +dag.bootstrapReflectiveRun
    next: ["f_logic"]

  +node {
    focus_id: "f_logic"
    label: "로직 검토"
    desc: "기능 구현의 논리 흐름이 정확한지 판단하며, 복잡도나 불명확성이 존재하면 반복"
    phase: "critic"
    group: "logic"
    recurse_if: "__this.entropy > 0.6"
    condition_name: "복잡한 로직 판단 조건"
    action: +critic
    eval_trace: "GPT 판단: 로직 구조는 이해되나 예외 케이스가 누락됨"
    source_ref: "PR diff[lines 20~50]"
    next: ["f_style"]
  }

  +node {
    focus_id: "f_style"
    label: "코딩 스타일 평가"
    desc: "컨벤션, 네이밍, 포맷 등 일관성을 점검"
    phase: "critic"
    group: "style"
    recurse_if: "__this.entropy > 0.55"
    condition_name: "스타일 불일치 반복 조건"
    action: +critic
    eval_trace: "GPT 판단: 변수 이름 중 일부가 팀 컨벤션과 어긋남"
    source_ref: "style-guide.md"
    next: ["f_meta"]
  }

  +node {
    focus_id: "f_meta"
    label: "피드백 과잉 여부 점검"
    desc: "비판이 과도하거나 판단 일관성이 낮을 경우 메타 검토 수행"
    phase: "metaCritic"
    recurse_if: "__this.val.variance > 0.35"
    condition_name: "메타 판단 루프 조건"
    action: +metaCritic
    eval_trace: "GPT 판단: 피드백 일부가 반복되며 정보 가치가 낮음"
    next: ["f_val"]
  }

  +node {
    focus_id: "f_val"
    label: "최종 승인 여부"
    desc: "전체 판단 루프가 안정화되었는지 평가하고, 승인 또는 보완 요청을 결정"
    phase: "val"
    terminate_if: "__this.entropy < 0.3"
    condition_name: "판단 안정화 종료 조건"
    action: +val
    eval_trace: "GPT 판단: 전반적으로 안정된 PR로 승인 가능"
  }

  +config {
    trace_binding: true
    maxDepth: 5
    allow_refocus_from: ["__this", "__trace"]
    peer_evaluation: true
    notify_on_overflow: true
  }
}
```

---

## ✅ 요약

- 각 판단 단계가 단순 흐름이 아닌 **맥락, 조건, 결과**가 풍부하게 명시됨
- PR Review 자동화 또는 GPT 기반 판단 흐름 기록에 최적화된 DSL 형태