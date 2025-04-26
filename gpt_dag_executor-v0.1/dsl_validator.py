class DslSchemaValidator:
    REQUIRED_FIELDS = {"if", "action", "runner"}
    ALLOWED_RUNNERS = {"gpt", "gpt-4o", "gpt-3.5", "human", "lambda", "tool"}

    def validate(self, dag_steps: list[dict]) -> list[str]:
        errors = []
        ids = set()
        for i, step in enumerate(dag_steps):
            missing = self.REQUIRED_FIELDS - set(step.keys())
            if missing:
                errors.append(f"[Step {i}] Missing fields: {missing}")
            runner = step.get("runner", "").lower()
            if runner and all(valid not in runner for valid in self.ALLOWED_RUNNERS):
                errors.append(f"[Step {i}] Unknown runner: {runner}")
            if "id" in step:
                if step["id"] in ids:
                    errors.append(f"[Step {i}] Duplicate ID: {step['id']}")
                else:
                    ids.add(step["id"])
            if "depends_on" in step:
                for dep in step["depends_on"].split(","):
                    if dep.strip() and dep.strip() not in ids:
                        errors.append(f"[Step {i}] Unknown depends_on reference: {dep.strip()}")
            for k in step.keys():
                if k not in {"if", "id", "action", "reason", "fallback", "intuition", "runner", "depends_on"}:
                    errors.append(f"[Step {i}] Unknown field: {k}")
        return errors
