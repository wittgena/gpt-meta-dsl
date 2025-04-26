import re

class GptDagExecutor:
    def __init__(self, gpt_client, tool_registry):
        self.gpt = gpt_client
        self.tools = tool_registry

    def execute_dag(self, dag_dsl: str):
        steps = self._parse_dsl(dag_dsl)
        executed_ids = set()
        id_map = {step.get("id"): step for step in steps if "id" in step}

        while steps:
            pending = []
            for step in steps:
                dep = step.get("depends_on")
                if not dep or all(d.strip() in executed_ids for d in dep.split(",")):
                    print(f"[+] 실행 조건: {step['if']}")
                    if self._evaluate_condition(step["if"]):
                        runner = step.get("runner", "gpt").lower()
                        if "gpt" in runner:
                            self._run_with_gpt(step)
                        elif "tool" in runner:
                            self.tools.call(step["action"])
                        elif "human" in runner:
                            print(">> 사람 검토 필요:", step)
                        elif "lambda" in runner:
                            self._run_lambda(step)
                    executed_ids.add(step.get("id", step["if"]))
                else:
                    pending.append(step)
            if len(pending) == len(steps):  # 의존성 순환 또는 누락
                print("[!] 순환 의존 또는 누락된 depends_on 감지됨. 실행 중단.")
                break
            steps = pending

    def _parse_dsl(self, dag_dsl: str) -> list:
        steps = []
        blocks = re.findall(r"\+if\((.*?)\)\s*\{(.*?)\}", dag_dsl, re.DOTALL)
        for condition, block in blocks:
            step = {"if": condition.strip()}
            for field in ["+id", "+action", "+reason", "+runner", "+fallback", "+intuition", "+depends_on"]:
                pattern = re.search(rf"{re.escape(field)}:\s*[\"']?(.*?)[\"']?\s*(?:\n|$)", block.strip())
                if pattern:
                    step[field[1:]] = pattern.group(1).strip()
            steps.append(step)
        return steps

    def _evaluate_condition(self, condition: str) -> bool:
        print(f"    (조건 '{condition}' 은 평가 생략, 항상 True로 처리됨)")
        return True

    def _run_with_gpt(self, step: dict):
        print(f"    → GPT 실행: {step.get('action')}")

    def _run_lambda(self, step: dict):
        print(f"    → Lambda 함수 실행: {step.get('action')}")
