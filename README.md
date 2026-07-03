# eigensoftware/homebrew-dais

Homebrew tap for [Dais](https://github.com/eigensoftware/dais) — a control panel
for running an autonomous multi-agent software company.

## Install

```sh
brew install eigensoftware/dais/dais
```

or:

```sh
brew tap eigensoftware/dais
brew install dais
```

## After installing

Dais orchestrates headless [Claude Code](https://docs.claude.com/en/docs/claude-code)
agents — install that CLI separately (it is not distributed via Homebrew). Then
create a workspace to operate on:

```sh
dais init ~/my-company
dais status
```

See the [main repository](https://github.com/eigensoftware/dais) for docs.
