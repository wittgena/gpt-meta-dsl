# 🧠 DSL DAG: `cost_decision_loop_v2`

## `+dag`를 통해 GPT가 자동생성한, DSL 예시입니다.

```dsl
+dag: cost_decision_loop_v2

+phase: 문제 정의 → 영향도 평가 → 시뮬레이션 → 판단 및 반사 → 반복 여부 판단

### 🔹 Phase 1: 문제 정의
+task: define_candidate
@runner: planner
@output: candidate_config

### 🔹 Phase 2: 영향도 평가
+task: evaluate_impact
@input: candidate_config
@runner: evaluator
@output: impact_score

+judge: impact_score > 0.7
@method: score_threshold
@output: should_simulate

+intuition: 수치상 높지 않아도 구조적 중요도가 있는 항목 존재 가능
+reason: search-index 최적화나 캐시 TTL 조정은 latency cascade에 영향

### 🔹 Phase 3: 절감 시뮬레이션
+if: should_simulate
  +task: simulate_cost_saving
  @input: candidate_config
  @runner: simulator
  @output: saving_score

+judge: saving_score > 0.3
@method: delta_check
@output: is_profitable

+intuition: 절감 예상 수치는 낮아도 운영복잡도 감소 효과가 큼
+reason: 유지보수 대상 축소로 장애 대응 시 인력 비용 절감 가능성 존재

### 🔹 Phase 4: 판단 및 반사
+if: is_profitable
  +reflect: 대상 채택 및 실제 적용 흐름 연결
@else:
  +reflect: 대상 보류 및 개선 대상 재선정

### 🔁 Phase 5: 반복 평가 흐름
@나.dsl.recurse: evaluate_impact → simulate_cost_saving → reflect → define_candidate
@max: 3

### 📎 메타 평가 및 추적
@critic.auto
@나.dsl.debug
```