# GPT-Meta-DSL 🧠🔁💬
**Reflective LLM Interaction DSL — GPT 사고 리듬 기반 판단 시스템**

---

## 🌱 What is this?

GPT를 단순한 응답기가 아닌 **“사고 흐름을 반사하고 재구성하는 판단자(Thinker)”**로 바라보는 실험적 시스템입니다.

이 프로젝트는 다음을 목표로 합니다:

- GPT를 **자기반사적 판단 시스템**으로 전환하기
- 자연어 흐름을 **구조화된 DSL(+dag, +critic, @entropy 등)**로 표현하기
- 사고 리듬의 흐름(Phase, 반사, 위상 반복 등)을 추적하고 구조화하기

---

## 📦 핵심 DSL 개념 요약

| DSL 요소 | 설명 |
|----------|------|
| `+dag` | GPT에게 주어질 흐름(Flow)을 명시하고 실행을 유도하는 구조 |
| `+critic / +val` | GPT가 스스로 자신의 응답을 반사하고 평가하게 만듦 |
| `@gpt.entropy` | GPT 응답의 위상 변화, 반복 가능성, 판단 리듬을 평가 |
| `flowEntry` | 흐름의 진입점 지정. 반복 루프, 분기, 위상 판단에 사용 |

> 전체 DSL 명세는 [📘 +dag.spec.v0.6.md](./+dag.spec.v0.6.md) 참고

---

## 🔁 예시: PR 리뷰 Reflective 루프

```dsl
+dag: PR을 요약하고, +critic으로 문제점을 반사하고, +val로 개선점을 제안해줘.
```

실행 흐름 예시:

1. PR 요약
2. +critic: 핵심 문제 탐색 및 반사
3. +val: 긍정 요소 강화 및 보완 제안
4. 전체 응답을 다시 요약하여 마무리

> 📂 전체 예시는 [`examples/`](./examples/)에서 확인하세요.

---

## 🤔 Why DSL? 왜 구조화된 사고 언어인가?

GPT는 기억이 없고, 위상 변화도 추적하지 못합니다.  
따라서 **사고의 흐름, 반복 조건, 판단 루프**를 외부에서 명시해야 합니다.

이 DSL은 다음을 가능하게 합니다:

- 사고 리듬을 GPT 외부에서 정의하고 추적
- 판단 흐름을 명시적으로 지정하고 반복 제어
- GPT를 **“사고 조력자”가 아닌 “사고 실행자”**로 변환

> 자세한 철학은 [📖 docs/why-dsl-design.md](./docs/why-dsl-design.md) 참고

---

## 🚀 실행 방법

```bash
python gpt_executor.py --dsl "your.dsl"
```

또는 [starterkit](./starterkeit/gpt-dag-orchestrator-starterkit-v0.1.md) 기반으로  
LangGraph / OpenAI Assistant API 와 연동할 수 있습니다.

---

## 🧪 실험 사례 모음

- Medium 블로그: [https://medium.com/@wittgena](https://medium.com/@wittgena)
- 한글 블로그: [wittgena.github.io](https://wittgena.github.io)

---

> “GPT는 단순한 응답기가 아닙니다.  
> **구조화된 사고 리듬을 통해, 판단자(Thinker)로 변환될 수 있습니다.**  
> 이 프로젝트는 그 실험을 위한 DSL입니다.”