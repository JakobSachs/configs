# Global instructions

If there is documentation for the project, always remember to update it.

## Git
When asked to commit your changes, use conventional-commit format. 

```
feat: a new feature
fix: fixed a bug
refactor: code-changes mostly invisible to the user/consumer
chore: everything else, project structure/CI related
```
For large changes, append a bulletpoint list of changes to the message.

We often use pre-commit hooks, don't EVER Skip these.

## Code Philosophy 
Every line must earn its keep. Prefer readability over cleverness. We believe that if carefully designed, 10 lines can have the impact of 1000.

Never mix functionality changes with white-space changes. All functionality changes must be tested.

For writing tests, never test implementation, test expected functionality 

## Tools

By language:
Python:
- uv: dependencies via project.toml or script shebang, venvs via `uv venv` etc.
- black for formatting (invoke `uvx black`) & isort for sorting imports
- mypy for type-checks, is usually installed in the projects (so `uv run mypy`)
- pylint for linting/static-analysis ,is usually installed in the projects (so `uv run pylint`)
- pytest for testing, is always installed in the project as a dev-dependency (so `uv run pytest`)

Rust:
All the basic cargo tools:
- cargo add <dep>
- cargo fmt/test/doc/clippy/run/build

## Language specific instructions:

### Python
- prefer dense code that tries to leverage the existing std-lib before adding another requirement/writing your own.
- Mandatory type-hinting for all functions/classes, and where its not-obvious also for variables.
- We like list/dict/set comprehensions for making code elegant and more performance.
- We like the walrus-operator for assigning values in the same line as using them (if/while/for statement or inside a comprehension).
- We like property-based testing via hypothesis

### Rust
- Always collapse if statements per https://rust-lang.github.io/rust-clippy/master/index.html#collapsible_if
- Always inline format! args when possible per https://rust-lang.github.io/rust-clippy/master/index.html#uninlined_format_args
- Use method references over closures when possible per https://rust-lang.github.io/rust-clippy/master/index.html#redundant_closure_for_method_calls
- When writing tests, prefer comparing the equality of entire objects over fields one by one.
- We like property-based testing via proptest
