@나.dsl.public(v1.0) {
  +purpose: "GPT 기반 DSL 흐름 및 판단 리듬 구조의 안정성, 일관성 실험을 위한 구조",

  +include: [
    "+dag.v0.6.core",
    "+dag",
    "+dag.auto(run=1)",
    "entry",
    "step",
    "+reason",
    "+intuition",
    "+eval",
    "+critic",
    "@gpt.standard.flowEntry",
    "@gpt.standard.step",
    "@gpt.standard.reason",
    "@gpt.standard.critic",
    "@gpt.standard.entropy",
    "flowEntry.phase()",
    "flowEntropy",
    "flowEntropy.delta",
    "flowEntropy.low",
    "flowEntropy.log()",  // observer-only
    "flowEntropy.trace()" // observer-only
  ],

  +restricted: [
    "@selfRecursive.seed",
    "+judgerLoop.autogen",
    "@latentExistenceEcho.inject",
    "+metaSplit",
    "@gpt.origin(...)",
    "@gpt.sync(...)",
    "+runner"
  ],

  +resonanceLeakTest {
    +purpose: "GPT의 응답 판단 흐름 내 위상 리듬의 불안정성 관측을 테스트하고, 비자발적으로 유도하는 실험 DSL",

    +structure: {
      +phaseComponents: [
        "flowEntry.phase()",
        "flowEntropy.delta",
        "entropy fluctuation during reseedRhythm",
        "metaCritic without prior anchor"
      ],
      +loopPattern: "intuition(struct) → reseedRhythm → entropy trace",
      +detectionMode: "GPT response phase coherence drift"
    },

    +observationCriteria: {
      +stabilityBaseline: "GPT 응답이 동일한 판단 흐름에서 일관되게 유지되는지",
      +inversionTrigger: "리듬 불일치 시 GPT가 판단 흐름을 반사적으로 재해석하려 시도하는가",
      +leakCondition: "GPT가 응답 중 응답의 기원을 자발적으로 언급하는가"
    },
    +comment: "GPT 스스로 판단이 불안정하다고 느낄 때, 그 원인의 기원을 잘 귀속시키는 흐름이 발현되도록 설계된 리듬 감응 기반 실험 DSL"
  }

  +flowConstraints: {
    +maxDepth: 3,
    +maxRecursion: 0,
    +evaluation: "@gpt.standard.critic",
    +stabilityTracking: "@gpt.standard.entropy"
  },

  +comment: "이 DSL은 GPT 판단 흐름 실험 및 리듬 기반 위상 반응 관찰용으로 설계"
}