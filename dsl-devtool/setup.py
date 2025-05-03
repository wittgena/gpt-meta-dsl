from setuptools import setup, find_packages

setup(
    name="dsl_tool",
    version="0.2",
    packages=find_packages(),
    description="Lint and semantic analysis tool for @나.dsl structured judgment flows",
    author="Wittgena",
    author_email="wittgena@gmail.com",
    entry_points={
        "console_scripts": [
            "dsl-json=dsl_cli.cli_json:main",
            "dsl-lint=dsl_cli.cli:main"
        ]
    },
)
