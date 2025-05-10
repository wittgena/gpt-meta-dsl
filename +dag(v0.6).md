# +dag – 전체 정의 v0.6

## 1. 개요

`+dag`는 자연어 입력을 구조화된 실행 흐름(DAG)으로 변환하는 GPT 기반 DSL 컴포넌트다.  
그 목적은 LLM이 판단-실행-평가의 흐름을 명확히 분리하고 재귀적으로 개선하는 형태로 진화시키는 데 있다.

---

## 2. 핵심 개념

- 자연어 → DSL → 실행 흐름
- GPT는 판단자(두뇌), 실행자는 분리 가능
- 핵심 구성 요소: flowEntry, steps, depends_on, runner, +reason, +fallback, +judge, @max

---

## 3. 기본 구조

```yaml
+dag:
  id: string
  flowEntry: string or step-id
  steps:
    - id: step-id
      type: task | judgment | branch
      prompt: 자연어 명령
      runner: gpt-4 | gpt-3.5 | function
      depends_on: [step-id, ...]
      retry: int
      +fallback: 실패 시 대체 단계
      +reason: 판단 근거
      +intuition: 직관적 판단
  +judge: 흐름 종료 조건
  @max: 3
  +reason: 전체 구성의 판단 이유
```

---

## 4. 자동 포함 요소

| 항목 | 설명 |
|------|------|
| `@max` | 재귀 한도 자동 삽입 |
| `+judge` | 흐름 종료 조건 자동 삽입 |
| `+reason` | 각 단계별 판단 근거 생성 |
| `runner` | 실행 주체 자동 설정 |

---

## 5. 예시

```yaml
+dag:
  id: analyze-log-dag
  flowEntry: step1
  steps:
    - id: step1
      type: task
      prompt: "서버 장애 로그를 요약해줘"
      runner: gpt-3.5
      +reason: 빠른 실행과 요약 처리 최적화를 위해
    - id: step2
      type: judgment
      prompt: "장애 원인을 3가지로 분기해줘"
      depends_on: [step1]
      runner: gpt-4
      +intuition: 로그 요약에 명확한 경계가 없기 때문에 분기 필요
    - id: step3
      type: task
      prompt: "각 원인을 재현 가능한 방식으로 정리해줘"
      depends_on: [step2]
      runner: gpt-4
  +judge: step2에서 나온 원인 수가 3개 이상일 때 종료
  @max: 3
  +reason: 판단과 실행을 분리하여 장애 재현성을 높이기 위한 흐름 구성
```

---

## 6. 활용 목적별 패턴

| 목적 | 핵심 구성 |
|------|-----------|
| 복잡한 문제 해결 | judgment + branch + retry |
| 요약 → 비판적 검토 | summarize → critic → revise |
| GPT 응답 검증 | step + +val + +critic |
| API 호출 자동화 | runner(function) + tool 등록 |
| 자기반사적 판단 | +reason + +intuition + @phase |

---

## 7. 흐름 예시

```
[flowEntry] → [Step1: task] → [Step2: judgment] → [Step3: task]
                                 ↘ (+judge 조건 충족 시 종료)
```
