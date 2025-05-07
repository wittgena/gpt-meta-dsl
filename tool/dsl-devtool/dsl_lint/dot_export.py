import re

def dsl_to_dot(text):
    dot = ["digraph DSLFlow {", '  rankdir=LR;', '  node [shape=box];']

    # DSL Block 추출
    block_pattern = re.compile(r"(@[\w\.]+)\s*{(.*?)}", re.DOTALL)
    edges = []
    for match in block_pattern.finditer(text):
        block_name = match.group(1).strip()
        dot.append(f'  "{block_name}" [label="{block_name}"];')

        body = match.group(2)
        actions = re.findall(r"\+action:\s*(@[\w\.]+)", body)
        for target in actions:
            edges.append(f'  "{block_name}" -> "{target.strip()}";')

    dot.extend(edges)
    dot.append("}")
    return "\n".join(dot)
