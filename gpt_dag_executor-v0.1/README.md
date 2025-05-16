# dag_executor

---

## 1. 현재까지 진행 상태

- 코드는 직접 작성하지 않고, +val, +eval, +critic, @gpt.entropy 등의 DSL 지시어를 통해 생성함
- +dag DSL 구조에 기반하여 자연어 의도를 구조화하고 흐름을 설계함
- 코드는 DSL 흐름을 해석하는 결과물로 생성되었음

---

## 2. 최종 목표

- 코드를 사람이 직접 작성하지 않고,
- **DSL(+dag)만을 통해 dag_executor를 완성하고, 테스트하며, 품질을 평가하는 체계 구축**

---

## 3. 최종 빌드 플랜

### 3.1 1차 실행 완성
- +dag DSL을 기반으로 dag_executor를 최소 실행 가능한 상태로 구축
- 자연어 입력 → DSL 변환 → 실행 → 결과 출력까지 정상 동작

### 3.2 DSL 기반 테스트 코드 생성
- dag_executor 자체를 검증할 수 있는 test code를 +dag DSL로 자동 생성
- 예시: "입력 DSL → 예상 실행 결과"를 검증하는 흐름

### 3.3 자기 품질 평가 수행
- 생성된 테스트 코드를 실행
- +critic, @gpt.entropy를 통해 실행 결과를 메타적으로 평가
- 테스트 통과율, 결과 일관성 등을 기반으로 품질 점수 산정

### 3.4 빌드 완료 선언
- 평가 기준(테스트 통과율, 일관성 등)을 만족하면 빌드 완료 선언
- 빌드 완료 기준은 DSL로도 명시될 수 있음 (예: +judge: test_pass_rate > 95%)

---

## 4. 추가 확장 가능성

- 자기반사 흐름 강화 (테스트 실패 시 자동 DSL 재구성)
- DSL 자체 개선 (예: +auto-improve 지시어 실험)
- 다양한 자연어 입력 변형에 대한 견고성 실험

---

## 5. 최종 요약

> dag_executor는 코딩 없이, +dag DSL을 통해 생성, 테스트, 평가, 완성까지 이르는
> **자기반사형 DSL 주도 프로그래밍 시스템(Intention-Oriented Self-Programming System)** 으로 완성될 것이다.

## 📦 dag_executor-v0.1 Notice

This repository includes the **original prototype of the DAG-based judgment executor** (`dag_executor-v0.1`) developed as part of the `dag.dsl` and `gpt-meta-dsl` project.

The current version is preserved here for historical reference and internal alignment with `judgment_runtime`.

### 🚀 For latest stable & extensible version:
Please refer to the standalone repository:

🔗 [dag_executor (v0.2+)](https://github.com/wittgena/dag_executor)

That repository supports:
- Assistant API-ready CLI execution (`dag-exec run`)
- Plugin-based architecture
- GPT-based self-improving executor flow (`gpt_assist/`)
- Better documentation and onboarding

This directory (`dag_executor-v0.1`) remains useful for:
- DSL-aligned self-reflective experiments
- Meta-judgment structural testing