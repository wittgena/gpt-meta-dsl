class DagGenerator:
    def __init__(self, gpt_client):
        self.gpt = gpt_client

    def generate_dsl(self, natural_language: str) -> str:
        prompt = f"""
다음 요청을 +dag DSL로 구조화해줘. strict-default 기반으로 reason, fallback, runner, id, depends_on 등을 포함해.

요청:
{natural_language}

DSL:
"""
        return self.gpt.complete(prompt).strip()
