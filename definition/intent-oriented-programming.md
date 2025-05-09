# Intent-Oriented Programming (의도 중심 프로그래밍)

---

## 📌 정의 (Definition)

**의도 중심 프로그래밍 (Intent-Oriented Programming)**은  
사용자가 “무엇을 하고 싶은가”와 “왜 그렇게 하고 싶은가”라는 **의도(intention)**를 자연어 또는 DSL로 표현하면,  
이를 시스템이 구조화된 흐름으로 해석하고, 판단자(GPT 등)가 판단 흐름을 생성하며,  
실행자(LLM AI등)가 작업을 수행하는 **목적 기반 자동화 프로그래밍 패러다임**이다.

---

## 🧠 핵심 구성 요소

| 구성 요소 | 설명 |
|------------|------|
| **의도 표현** | 자연어 또는 DSL(+val, +create, +merge, +modify, +delete, +simulation 등)으로 목적과 동기를 명시 |
| **판단자** | 개발 흐름을 판단하고 자연어 또는 DSL(+eval, +critic, @gpt.entropy 등)을 통해 비평, 평가를 수행하고 재 실행을 유도 |
| **실행자** | LLM AI등의 실행자로 정의 |

---


## 📚 기존 개념과의 차이점

| 기존 개념 | 차이점 |
|-----------|--------|
| **Declarative Programming** | *무엇을* 기술하되 판단자/실행 분리 없음 |
| **Goal-Oriented Programming** | 목적 중심이지만 DSL, 판단 흐름, 자기반사 구조 없음 |
| **Intent-based Interfaces** | 주로 UI/UX 중심, 실행 흐름 자동화 없음 |
| **Agent-based Systems** | 상태 판단은 있으나 사용자 의도를 중심으로 하지 않음 |

---

## 🧩 왜 필요한가?

- LLM AI 시대, “코드를 짜는 행위”보다 **“의도를 말하는 행위”**가 중심이 되는 흐름 등장
- 프로그래머뿐 아니라 **기획자/디자이너/도메인 전문가도 구조화된 프로그래밍**을 할 수 있어야 함
- 흐름의 재사용, 자기판단, 추론 기반 자동화가 요구되는 시대에 가장 직관적인 구조

---

## 🚀 실험 기반 구현 예시

본 개념은 다음을 통해 실험적으로 구현되었다:

- `gpt_dag_executor-v0.1`
- @나.dsl과 +dag DSL
- condition_eval, dag_executor, autorecover 등 자동 흐름 구조

---

## ✅ 요약 정의

> **Intent-Oriented Programming**은  
> 의도를 중심으로 흐름을 설계하고, LLM AI 판단자와 DSL(or 자연어) 실행자가 협력하는  
> **“의사결정 기반 프로그래밍”의 실천적 구조화 방법론**이다.
