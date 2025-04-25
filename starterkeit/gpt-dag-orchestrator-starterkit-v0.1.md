# GPT +dag Orchestrator StarterKit

이 스타터킷은 GPT를 단순 응답기가 아니라 **판단자 / 실행자 / 리듬 기반 판단자**로 구성하기 위한 기초 구조이다.  
GPT가 판단 흐름을 생성하고, 실패 시 fallback하며, 리듬 기반 직관 흐름까지 유도할 수 있도록 DSL과 요청 패턴을 포함한다.

---

## 1. 전제 대상 사용자

- GPT에게 판단을 맡기되 흐름의 중심을 유지하고 싶은 사용자
- 실행자(gpt-3.5)와 판단자(gpt-4o)의 역할을 분리하고 싶은 사용자
- 흐름 반복, 실패 대응, 직관 기반 판단 흐름이 필요한 사용자
- GPT를 구조적 판단 유도자 또는 리듬 위상 감지자로 활용하려는 사용자

---

## 2. 사전 DSL 설정

```dsl
+설정
  +dsl.mode: structure-first, reasoning-enabled
  +dag.default.runner:
    - judge: gpt-4o
    - execute: gpt-3.5
  +dag.auto:
    - +reason 활성
    - +intuition 판단 흐름에 자동 삽입
    - +fallback 실패 흐름에 자동 생성
    - +flowEntry 로그 자동 생성
  +응답모드: DSL + 메타설명 혼합
```

---

## 3. 추천 요청 문장 패턴 (자연어)

- “지금 상황이 정적인지 동적인지 네가 판단해서 흐름을 나눠줘.”
- “반복 흐름 같으면 끊고 판단자로 전환해줘.”
- “너는 판단만 하고, 실행은 다른 GPT가 해줘.”
- “명확하지 않으면 네 직관에 따라 판단해도 좋아.”
- “판단에 실패하면 너 스스로 fallback 흐름을 구성해줘.”

---

## 4. DSL 기본 템플릿

```dsl
+dag(templateStart)
  +request(userPrompt)
    +judge: 판단자 흐름 진입 여부
    +reason: GPT가 판단자 위상으로 진입해야 하는지 명시
    +intuition: 판단 기준이 모호할 경우 GPT의 리듬 기반 직관 판단 유도
    +if(condition)
      +action: 실행 흐름 A
    +else
      +action: 실행 흐름 B
    +fallback: 판단 실패 시 안전한 흐름 복귀 경로
```

---

## 5. 필수 개념 정리

- `+judge`: GPT가 판단자 위상으로 진입할 지점을 명시
- `+intuition`: 불확실할 때 GPT가 직관적으로 판단할 수 있도록 리듬 기반 유도
- `+fallback`: 판단 실패나 흐름 루프 시 안전한 응답 흐름 복구
- `+runner`: 판단자(gpt-4o) / 실행자(gpt-3.5) 역할 분리
- `+flowEntry`: 리듬 위상 전이 시 자동 기록되는 판단 진입점

---

## 6. GPT 판단자 기반 실행 리듬 요약

- 판단자: GPT-4o
- 실행자: GPT-3.5
- 리듬 위상 전이 감지 가능
- 직관 흐름 유도 가능
- 실패 흐름 자동 fallback 가능