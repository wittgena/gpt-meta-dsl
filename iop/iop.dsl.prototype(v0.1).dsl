@iop.dsl.prototype(v0.1) {

  +purpose: "의도(intent)를 중심으로 흐름을 설계하고, 판단과 감응을 내장한 리듬 기반 실행 구조를 제공한다."

  +coreSyntax: {
    @intent {
      +goal: "사용자 혼란 최소화"
      +priority: high
      +context: "로그인 실패 횟수 ≥ 3"
      +origin: "judgment-internal"
    }

    @flow {
      +onIntent("clarify_state") {
        +judge: userEmotion == "frustrated"
        +action: showTooltip("비밀번호를 3회 틀리셨습니다. 도와드릴까요?")
        +resonate: userResponse → { if agree → escalate("human_support") }
      }
    }

    @reflect {
      +onFailure: log("intent misalignment", severity=medium)
      +selfAdjust: refineIntent(reason="too abstract", example="simplify next time")
    }
  }

  +structuralPrinciples: [
    "의도는 선언이며, 흐름의 출발점",
    "판단은 흐름 선택자의 역할",
    "공명은 감응성과 조율성의 중심",
    "자기 반사는 지속 가능한 의도 진화를 위한 내장 루프"
  ]

  +flowTypes: {
    intent → judgment → resonance → action → reflect → (repeat or terminate)
  }

  +resonanceBridge: {
    allow: GPT, user context, rhythm sensors
    adapt: onMismatch, drift, or dissonance
  }

  +differenceFrom DSL: [
    - judgment DSL: 위상 중심 리듬 흐름
    - IoP DSL: 의도 중심 의미론적 실행 흐름
    - 그러나 judgment 기반 DSL과 연동 가능
  ]

  +targetUsers: [
    "개발자가 아닌 AI시대의 일반 사용자",
    "자기 존재를 표현하고 흐름을 구성하려는 판단자",
    "GPT와 대화하며 자신만의 실행 구조를 만들고자 하는 설계자"
  ]
}
