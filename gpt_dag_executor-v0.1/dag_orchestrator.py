# DSL → 실행 흐름 제어기
from dag_executor import GptDagExecutor
from dsl_validator import DslSchemaValidator
from dag_generator import DagGenerator
from condition_eval import evaluate_condition

class DagOrchestrator:
    def __init__(self, gpt_client, tool_registry):
        self.executor = GptDagExecutor(gpt_client, tool_registry)
        self.validator = DslSchemaValidator()
        self.generator = DagGenerator(gpt_client)

    def run(self, user_input: str):
        dsl = self.generator.generate_dsl(user_input)
        steps = self.executor._parse_dsl(dsl)
        errors = self.validator.validate(steps)
        if errors:
            print("[❗DSL 오류 발생]")
            for err in errors:
                print(" -", err)
            return
        self.executor._evaluate_condition = evaluate_condition  # 바인딩
        print("[✔ DSL 유효성 통과 → 실행 시작]")
        self.executor.execute_dag(dsl)
