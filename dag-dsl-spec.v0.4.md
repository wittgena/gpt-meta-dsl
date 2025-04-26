## 🔧 +dag DSL 사양서 (v0.4)

> **목적**: 자연어 입력을 기반으로 GPT가 판단 가능한 구조적 흐름(DAG)을 생성하고, 그 흐름 내 각 스텝의 조건, 역할, 재귀, 반사 판단을 자동화하는 실행형 DSL

---

### 1. `flowEntry`
- **역할**: 생성된 흐름의 시작점 (루트 노드)  
- **의미**: 자동 삽입되거나 수동 정의 가능

---

### 2. `steps`
- **역할**: 각 흐름 단계에서 GPT가 판단하거나 외부 툴 실행  
- **구성 요소**: `name`, `input`, `tool`, `description`, `next`, `condition`  
- **특징**: 순차, 분기, 반복 흐름 구성 가능 (DAG 노드로 표현)

---

### 3. `judge`
- **역할**: 조건 기반 분기 판단 수행  
- **위치**: step 내부 또는 분기점  
- **예시**: `+judge: if result.score < threshold then → step2 else → step3`

---

### 4. `runner`
- **역할**: 각 step 실행 담당 GPT 모델 또는 외부 엔진  
- **예시**: GPT-4o(판단자), GPT-3.5(실행자)

---

### 5. `+fallback`
- **역할**: step 실패 시 대체 흐름 지정  
- **보완 요소**: `+auto.retry`와 함께 복구 흐름 구성 가능

---

### 6. `+reason` / `+intuition`
- **역할**: GPT 판단의 이유나 직관을 명시  
- **기능**: 자기반사적 판단 근거로 활용

---

### 7. `@gpt.entropy`
- **역할**: 흐름 내 정보량 변화 추정  
- **용도**: 루프 탈출, phase 전환 감지, 판단 다양성 확보

---

### 8. `+meta`, `+reflect`
- **역할**: 전체 또는 특정 흐름의 자기 평가 지시어  
- **예시**:  
  - `+meta: 전체 흐름의 간결성 평가`  
  - `+reflect: step3 판단 기준 재검토`

---

### 9. `dagType`
- **역할**: 생성된 DAG 유형 명시  
- **예시**: `branch-type`, `loop-type`, `sequential-type`

---

### 10. `step-level annotation`
- **역할**: 각 단계에 GPT 역할, 의도, 조건 등을 주석처럼 첨부  
- **예시**: `// 목적: 사용자 입력을 분석하여 intent 추출`

---

> `+dag`는 `@나.dsl`의 실행형 counterpart로서, GPT가 실행 가능한 구조화 흐름을 만드는 핵심 메타 DSL이다.
