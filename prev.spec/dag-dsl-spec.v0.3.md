# @나.dsl dag extension v0.3

## 1. 개요
@나.dsl은 자연어를 기반으로 실행 가능한 상태 기반 DAG로 변환하며, 인간 인지 구조에 가까운 "두뇌형 DSL"을 지향합니다.  
주요 특징은 다음과 같습니다:

- 자연어 → 구조화 흐름
- 상태 기반 추론 및 반복
- 자기 평가 및 자기 반성 흐름
- GPT 추론 최적화를 위한 리듬 기반 표현 구조

---

## 2. 핵심 지시어 요약

| 지시어 | 설명 |
|--------|------|
| +dag            | 전체 흐름의 이름 정의 |
| +task           | 실행 단위 정의 |
| @input / @output | 상태 입력/출력 정의 |
| @runner         | 실행 대상 (LLM, API, 내부 함수 등) |
| +if / +loop     | 조건/반복 흐름 제어 |
| +judge          | 조건이 실제로 참인지 판단 (score, 길이, 포함 여부 등) |
| +reflect        | 실행 결과에 따라 DSL 자체 구조 변경 |
| +critic         | 흐름의 품질/위험 평가 |
| +phase          | 단계적 추론 흐름 명시 |
| @나.dsl.recurse | 재귀 흐름 구성. 출력 → 입력 귀환 구조 |
| @max            | 무한 재귀 방지용 재귀 최대 횟수 제한 (리듬 기반 자동 추론 가능) |
| @나.dsl.debug   | 디버깅용 상태 및 흐름 시각화 도구 |

---

## 3. 리듬 기반 확장 설계

- 재귀 흐름 감지 시 `@max`가 리듬 기반으로 자동 삽입됨
- `+judge`는 요약 길이, 점수 변화, 단계 수 등의 변화율에 따라 종료 조건을 유추함
- 예시:
  ```plaintext
  +judge: abs(current_score - prev_score) < 0.02
  @input: current_score, prev_score
  @method: delta_check
  ```

---

## 4. 평가 구조

- `@critic.auto` 활성화 시 다음이 자동 평가됨:
  - 구조적 재귀성
  - 흐름의 반사성
  - 루프 위험도
- 점수 기준: 자기참조, 자기수정, 평가가능성, 단계성 등

---

## 5. 실험 예시 요약 (재귀형)

예: self_improving_reply

```plaintext
+dag: self_improving_reply

+task: generate_reply
@input: user_question
@runner: responder
@output: reply

+task: critique_reply
@input: reply
@runner: critic
@output: reply_score

+judge: reply_score < 0.7
@input: reply_score
@method: score_threshold
@output: should_rewrite

+if: should_rewrite
    +task: regenerate_reply
    @input: reply
    @runner: responder
    @output: improved_reply

@나.dsl.recurse: generate_reply → critique_reply → regenerate_reply → generate_reply
@max: 3
```

---

## 6. 설정된 시스템 규칙 요약

- `@나.dsl.recurse` 사용 시 `@max` 자동 삽입됨 (기본: 리듬 기반 추론)
- 재귀 흐름이 조건 없이 반복될 경우 `+judge` 자동 보완됨
- 평가 흐름은 `@critic.auto`에 의해 추적 및 리듬/재귀 기반 위험 평가 포함