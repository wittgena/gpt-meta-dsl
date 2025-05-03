from setuptools import setup, find_packages

setup(
    name="dsl_lint_tool",
    version="0.1",
    packages=find_packages(),
    description="Lint and semantic analysis tool for @나.dsl structured judgment flows",
    author="Wittgena",
    author_email="wittgena@gmail.com",
    entry_points={
        "console_scripts": [
            "dsl-lint=dsl_lint.cli:main"
        ]
    },
)
