from dag_generator import DagGenerator
from dag_executor import GptDagExecutor
from dsl_validator import DslSchemaValidator

class FakeGptClient:
    def complete(self, prompt):
        return """
+dag("의존성 흐름 예시")

+if(data.ready) {
  +id: "prep"
  +action: "전처리"
  +runner: lambda
}

+if(prep.success) {
  +id: "train"
  +depends_on: "prep"
  +action: "모델 학습"
  +runner: GPT-4o
}

+if(train.done) {
  +id: "notify"
  +depends_on: "train"
  +action: "알림 전송"
  +runner: tool("slackBot")
}
"""

class ToolRegistry:
    def call(self, action):
        print(f"    → tool 실행됨: {action}")

gpt = FakeGptClient()
dag_gen = DagGenerator(gpt)
executor = GptDagExecutor(gpt, ToolRegistry())
validator = DslSchemaValidator()

user_input = "데이터가 준비되면 전처리하고, 그 다음 모델 학습 후 알림을 보내줘"
dag_dsl = dag_gen.generate_dsl(user_input)
steps = executor._parse_dsl(dag_dsl)
errors = validator.validate(steps)

if errors:
    print("[❗DSL 오류 발견]")
    for err in errors:
        print(" -", err)
else:
    print("[✔ DSL 유효성 통과]")
    executor.execute_dag(dag_dsl)
