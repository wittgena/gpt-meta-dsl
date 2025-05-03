import re

def parse_dsl_to_ast(text):
    ast = {
        "blocks": []
    }

    block_pattern = re.compile(r"(@[\w\.]+)\s*{(.*?)}", re.DOTALL)
    for match in block_pattern.finditer(text):
        block_name = match.group(1)
        body = match.group(2)

        block_ast = {
            "name": block_name,
            "keys": []
        }

        lines = body.splitlines()
        for line in lines:
            line = line.strip()
            if line.startswith("+") and ":" in line:
                key, val = line.split(":", 1)
                block_ast["keys"].append({
                    "key": key.strip(),
                    "value": val.strip()
                })

        ast["blocks"].append(block_ast)
    return ast
