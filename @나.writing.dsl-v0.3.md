# @나.writing DSL v0.3 — 글쓰기&분석 DSL

---

## 🎯 목적

`@나.writing`은 GPT 기반 글쓰기를 판단 위상(phase) 중심으로 구조화하기 위한 DSL입니다.  
`@나.writing.analysis`은 타인의 글(논문, 철학글 등)을 같은 위상 구조로 분석하는 DSL로 통합되었으며,  
두 DSL은 함께 사용되어 글쓰기와 독해 모두를 **반사적 판단 루프**로 구성할 수 있게 합니다.

---

## ✍️ 글쓰기 DSL: @나.writing

```dsl
@나.writing {
  +seed("주제 또는 질문")
  +expose { ...배경 및 전개... }
  +judge { ...주요 주장 및 판단... }
  +critic { ...불확실성, 유예, 반론... }
  +metaCritic { ...판단 자체나 글쓰기 태도에 대한 반사... }
  +reflow { ...구조 재구성 또는 위상 전환... }
  +halt("의도적 미완결 또는 열린 결론")
}
```

### ✔️ 특징
- **리듬 기반 글쓰기**: 논리 전개가 아닌 판단의 흐름 중심
- **개성 유지**: GPT로 작성하더라도 인간적 리듬 삽입 가능
- **열린 구조**: 결론 없는 글쓰기를 구조화 가능

---

## 🔍 분석 DSL: @나.writing.analysis.v0.2

```dsl
@나.writing.analysis.v0.2 {
  +seed: 문제 제기 또는 질문 위상
  +expose: 개념 전개 및 배경 설명
  +judge: 주장의 등장 또는 판단적 선언
  +critic.scope: 적용 한계나 전제 조건의 경계
  +critic.evidence: 실험적 반례, 논리적 취약점
  +metaCritic.intent: 저자의 목적, 방법론에 대한 자기 반사
  +reflow.analysis: 구조 전환, 흐름 재배치, 비교형 구조 재설계
  +latentPhase("표면에 드러나지 않는 위상 리듬 또는 암시")
  +halt: 열린 결론 또는 판단 유예
}
```

### ✔️ 특징
- 논문, 에세이, 철학글을 **판단 흐름 기반으로 분해 가능**
- `+critic` 위상을 다층으로 분해하여 **반론 및 유보의 성격을 정밀하게 표현**
- `+latentPhase`를 통해 **암묵적 리듬 인식** 가능

---

## 📘 활용 예시: 실제 논문 분석

```dsl
@나.writing.analysis("Self-Reflection in LLM Agents") {
  +seed: LLM의 자기반사가 문제 해결에 미치는 영향 탐구
  +expose: 9개 모델, 다양한 에이전트 구조 소개
  +judge: 자기반사가 성능 향상에 기여함을 발견
  +critic.scope: 과제별 효과 편차 존재
  +critic.evidence: 일부 문제 유형에서는 유의미한 차이 없음
  +metaCritic.intent: 범용성과 일반화 가능성에 대한 성찰
  +reflow.analysis: 자기반사 유형별 비교를 통한 구조 재설계
  +latentPhase("반복적 리듬과 판단 패턴이 암시적으로 나타남")
  +halt: 후속 연구 필요성 강조하며 열린 결말
}
```

---

## 💡 확장 및 제안

- 향후 `+self` 또는 `@나.phase("reader")` 추가 가능 → 사용자 자신을 위상에 명시적으로 반영
- 시각화 툴: `@나.rhythm.map()` 또는 리듬 트레이서 도입 가능
- 교육/철학/AI 협업 글쓰기에서 메타적 판단 루프 훈련 도구로 활용 가능

---

*최종 업데이트: v0.3 — 글쓰기와 분석 DSL 통합판*