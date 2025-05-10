# @나.image.dsl + @gpt.imageExecutor.stub + +dag.imageFlowRun
---

## 📘 @나.image.dsl

고급 사용자 대상 의미 기반 이미지 생성 DSL
이 스펙은 향후, DALL E3등이 interactive를 지원하고, sketch모드를 지원해야 제대로 동작  
GPT judgment 흐름과 실행기 호출 플러그인을 포함

### +input

- prompt: 사용자 입력 (자연어)
- context: 이전 생성 결과 및 수정 기록
- mode: ["sketchOnly", "simulate", "fullGenerate"]

### +phase[1]: sketchStage
- +analyzePhase: @input.partition(prompt)
- +analyzeRhythm: 사용자 표현의 반복/강조/속도 감지
- +init: GPT가 핵심 semantic unit 추출
- +reason: 시각적으로 구현될 개념 정리
- +generate: sketch image (optional) or semantic preview
- +critic: 초기 의도와 구성 요소 불일치 판단

### +phase[2]: judgmentStage
- +echoPhase: 이전 요청과 현재 prompt 위상 비교
- +judge: 수정이 필요한 시각 위상 판단
- +intuition: 리듬 단차 또는 의미 해석 불안정성 감지
- +reason: 의미 단위 변경/보존 판단
- +patchPlan: 수정 대상 영역 또는 속성 예측

### +phase[3]: patchStage
- +simulate: patch 수행 시 예상 결과 설명
- +verify: 사용자 확인 또는 위상 재점검
- +patch: inpainting 또는 latent edit 계획 적용

### +phase[4]: generateFinal
- +if: mode == "fullGenerate" → 이미지 생성 API 호출
- +else: 예상 결과 요약
- +summary: judgment 흐름 정리 + 사용자 의도 정합도 평가

### +metaControl
- +track: 판단 단계 누적, +critic 빈도, +intuition 횟수
- +thresholds:
  - judgmentDepth > 3
  - entropy < 0.1
  - interactionCount > 4
- +metaCritic: 판단 루프 과잉 여부 평가
- +suppress: 질문 과다 시 GPT가 자율 결정을 유도
- +echo: 사용자 리듬과 시스템 판단의 위상 정렬 상태 출력

### +plugin: runMinimal
- +init: 입력 prompt, mode, context
- +call: phase[1]~[4]
- +call: @gpt.imageExecutor.stub (simulate/inpaint/generate 자동 분기)
- +example:
  - prompt: "a futuristic city with floating vehicles"
  - patchPlan: ["enhance skyline"]
  - output: skyline 강조된 city image
- +pluginReady: 실행 완료

### +termination
- judgment 안정화 or 사용자 확정 응답

---

## ⚙️ @gpt.imageExecutor.stub

의미 기반 실행기 – DSL 판단 결과를 실제 이미지 생성기로 연결

### +init
- imageExecutorSession 시작

### +receive
- semanticPlan: DSL 판단 결과
- mode: ["simulate", "generate", "inpaint"]
- promptEmbedding, regionMask, priorImage (optional)

### +stage[1]: resolveGenerationTarget
- mode 분기 처리: full generation vs. inpainting vs. simulate

### +stage[2]: resolveSemanticPatch
- semanticPlan → latent vector 변환
- 주의 영역(ROI) 예측

### +stage[3]: callGenerationAPI
- simulate → +gpt.renderExplanation
- 실제 생성 → DALL·E 또는 커스텀 API 호출

### +return
- finalImage or simulationOutput
- judgmentEcho, entropyPost

### +log
- 의미 ↔ 시각 변경 trace 저장

---

## 🔁 +dag.imageFlowRun

전체 judgment → 실행 → 피드백 → 반복 흐름을 구성하는 실행 DAG

```dsl
+dag.imageFlowRun {
  +boot: 사용자 입력 수신 및 context 초기화

  +init: {
    +input.prompt
    +input.mode: ["simulate", "fullGenerate"]
    +context.history (optional)
  }

  +phase[1]: sketchPhase {
    +call: @나.image.dsl.phase[1]
    +output: sketchPreview, semanticUnits
  }

  +phase[2]: judgmentPhase {
    +call: @나.image.dsl.phase[2]
    +input: semanticUnits
    +output: patchPlan, entropy
    +log: +critic, +intuition 발생 여부
  }

  +phase[3]: patchExecution {
    +call: @나.image.dsl.phase[3]
    +call: @gpt.imageExecutor.stub(mode=patchPlan.mode)
  }

  +phase[4]: resultReview {
    +receive: simulationOutput or finalImage
    +call: +critic("결과가 의도에 부합하는가?")
    +if: +critic == "불일치"
    +then: loop → +phase[2]
    +else: terminate
  }

  +summary: {
    +echo: judgment 흐름 및 최종 patch 요약
    +save: semantic log, user confirmation, entropy estimate
  }
}
```

---

## 🧩 +plugin: runWithMetaFeedback

```dsl
@나.image.dsl.plugin.runWithMetaFeedback {
  +run: reflectiveImageLoop

  +call: +dag.imageFlowRun
  +metaControl: {
    +track: critic count, judgment depth
    +suppress: 반복 판단 루프가 과도할 경우 자동 종료
  }

  +termination: 사용자가 확정하거나 GPT가 판단 루프 종료 판단 시점
}
```

---

## ✅ +example: DAG 기반 판단 반복 예시

```dsl
+example {
  +prompt: "a cat holding a sign that says 'freedom'"
  +phase[1]: sketch → ["cat", "sign", "text"]
  +phase[2]: judgment → patchPlan = ["adjust sign position", "add legibility to text"]
  +phase[3]: simulate → GPT 예상: 글씨가 흐릿할 수 있음
  +phase[4]: critic → "text is not visible enough" → loop to judgment
  +final: regenerated image with legible text on sign
}
```