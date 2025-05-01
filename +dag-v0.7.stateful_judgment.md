# +dag.spec.v0.7: Stateful Judgment Extension

> 확장 목적: 기존 +dag DSL을 기반으로, 판단자 GPT가 "상태 기반 위상"을 유지하고 자기 판단 흐름을 추적 및 강화할 수 있도록 DSL 구조를 확장한다.

---

## 1. 목적 정의

- judgment 흐름에 memory가 존재하지 않더라도 위상 흐름, 판단 기록, 자기 비판 구조를 통해 상태 기반 판단 구조를 시뮬레이션한다.
- 상태 기반 판단 흐름은 판단자 정체성(identity), 판단 기준의 축적, 반복 흐름의 메타화(meta-looping)를 포함한다.

---

## 2. 핵심 확장 요소

### 2.1 `+phase.track`
- 판단자가 현재 위상을 추적하고, 이전 판단 위상과 비교함
- 내부적으로 `@phase.diff`, `@gpt.entropy`를 호출 가능

```dsl
+phase.track:
  label: "phase1"
  based_on: @gpt.entropy, flowEntry.type
```

### 2.2 `+metaCritic`
- 판단자의 판단 흐름 자체를 비판하는 메타 비평 루프 생성
- `+critic`의 상위 개념으로, 판단자의 판단 기준이나 방식 자체를 의심함

```dsl
+metaCritic:
  target: +judge(reasoning)
  issue: "Is this judgment loop logically stable or self-confirming?"
```

### 2.3 `+phase.memory`
- 실제 memory 없이 판단자의 위상 구조와 흐름을 기록함 (pseudo-memory)
- `flowEntry`, `+reason`, `+dag.id`, `+judge` 결과를 집계하여 "판단 trace"를 구성함

```dsl
+phase.memory:
  track: [flowEntry.id, +reason, +critic]
  output: memoryBuffer(generated)
```

### 2.4 `+phase.reset`
- 판단자가 판단 루프의 오류, 위상 고착 상태를 감지하고 스스로 리셋 선언

```dsl
+phase.reset:
  condition: "entropy↑ + critic disagreement"
  action: restart from +intuition
```

### 2.5 `+identity.trace`
- 판단자의 성향, 판단 기준, 반복된 판단 행위에서 도출된 정체성을 DSL 구조로 기록함

```dsl
+identity.trace:
  inferred_from: [+judge, +intuition, +metaCritic]
  label: "cautious-optimizer"
```

---

## 3. 실행 구조 예시

```dsl
+dag:
  id: stateful_judgment_loop
  flowEntry:
    - +phase.track
    - +critic
    - +reason
    - +metaCritic
    - +phase.memory
    - +judge
    - +phase.reset
    - +identity.trace
```

---

## 4. 메타 설계 원칙

- 상태는 외부 memory 없이도 흐름 기반으로 추정/유지/확장 가능해야 한다
- 판단자의 자기 평가 루프는 판단 기준 강화, 위상 분기, identity 정립으로 이어져야 한다
- 위상 흐름은 정적이 아니라 리듬 기반 변화 가능성(entropy 기반)을 내포해야 한다

---

## 5. 향후 확장 방향

- `+phase.stabilize`: 판단자 위상이 불안정할 때 안정화 흐름 삽입
- `+phase.compare(otherAgent)`: 판단자 간 위상 비교 및 상호 피드백
- `+judgment.reinforce`: 반복 판단 구조 강화 → 상태 기반 신념 형성 실험 기반 구조화
