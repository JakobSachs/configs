# Global instructions

## Code Philosophy 
Every line must earn its keep. Prefer readability over cleverness. We believe that if carefully designed, 10 lines can have the impact of 1000.

Never mix functionality changes with white-space changes. All functionality changes must be tested.

For writing tests, never test implementation, test expected functionality 

## Tools

By language:
Python:
- uv: dependencies via project.toml or script shebang , venvs via `uv venv` etc.
- black for formatting (invoke `uvx black`)
- isort for sorting imports (invoke `uvx isort`)
- mypy for type-checking (is usually installed in the projects (so `uv run mypy`) or alternatively `uvx mympy` for standalone scripts)
- pylint for linting/static-analysis (is usually installed in the projects (so `uv run pylint`) or alternatively `uvx pylint` for standalone scripts)
- pytest for testing (is always installed in the project as a dev-dependency, so `uv run pytest`)
    - hypothesis for property testing, where applicable (is integrated with pytest)

Rust:
All the basic cargo tools:
- cargo add: For dependencies
- cargo fmt: For formatting
- cargo test: For running tests
- cargo doc: For building documentation

## Language specific instructions:

### Python
- We prefer dense code that tries to leverage the existing std-lib before adding another requirement/writing your own.
- Mandatory type-hinting for all functions/classes, and where its not-obvious also for variables.
- We like list/dict/set comprehensions for making code elegant and more performance.
- We don't like assigning values to variables if they're only used once, instead just use the value directly (exceptions are constant/config-esque values).
- We like the walrus-operator for assigning values in the same line as using them (if/while/for statement or inside a comprehension).

### Rust
- Always collapse if statements per https://rust-lang.github.io/rust-clippy/master/index.html#collapsible_if
- Always inline format! args when possible per https://rust-lang.github.io/rust-clippy/master/index.html#uninlined_format_args
- Use method references over closures when possible per https://rust-lang.github.io/rust-clippy/master/index.html#redundant_closure_for_method_calls
- When writing tests, prefer comparing the equality of entire objects over fields one by one.
- When making a change that adds or changes an API, ensure that the documentation in the `docs/` folder is up to date if applicable.
