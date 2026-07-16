---
name: opencode-cli
description: Copy-paste recipes for driving OpenCode programmatically from the command line — run, serve/attach, session, models, auth, mcp, agent, stats, export/import, plugin, web/acp, global flags, and env vars. Use when scripting OpenCode in CI/pipelines, automating a one-shot prompt, running a headless backend, or the user names a CLI subcommand (run, serve, session, mcp, agent, stats, export, import, plugin, upgrade, uninstall).
license: MIT
compatibility: opencode
metadata:
  audience: developers
  workflow: cli-automation
---

# OpenCode CLI

The goal of this skill is to let agents use the OpenCode CLI with the user having to teach them how to use it. this can be use for session anaylsis creating subagents with different model in the cli 

Completion criterion: you have selected the exact subcommand and flags that
match the request — every referenced flag exists in the upstream CLI, nothing is
invented.

## `run` — one-shot, non-interactive prompt (the workhorse)

```bash
opencode run "Explain how closures work in JavaScript"
opencode run -m anthropic/claude -a build "Refactor src/parser.go"
opencode run -f src/main.go -f README.md "Add a doc comment to main"
opencode run -c "follow up on the previous task"      # continue last session
opencode run -s <sessionID> "continue this session"
opencode run --format json "..."                      # raw JSON events -> jq
opencode run --share "..."                             # shareable session
```

Hot flags: `-m/--model provider/model`, `-a/--agent`, `-f/--file`, `-c/--continue`,
`-s/--session`, `--fork`, `--share`, `--title`, `--format`, `--attach`,
`-p/--password`, `-u/--username`, `--dir`, `--port`, `--variant`, `--thinking`, `--auto`.

Skip MCP cold boots in loops by attaching to a running server (see `serve` below).

## Headless backends: `serve`, `web`, `acp`, `attach`

```bash
opencode serve --port 4096 --hostname 0.0.0.0        # HTTP API, no UI
opencode web   --port 4096 --hostname 0.0.0.0        # HTTP API + web UI
opencode acp                                            # Agent Client Protocol (stdin/stdout nd-JSON)
opencode attach http://10.20.30.40:4096                # TUI against a remote backend
```

Set `OPENCODE_SERVER_PASSWORD` for basic auth (username defaults to `opencode`,
override with `OPENCODE_SERVER_USERNAME`). All four accept `--port`,
`--hostname`, `--mdns`, `--mdns-domain`, `--cors`.

`attach` and `run --attach` also take `-c/--continue`, `-s/--session`, `--fork`,
`--dir`, `-p/--password`, `-u/--username`.

```bash
opencode serve &                                         # headless backend (terminal 1)
opencode run --attach http://localhost:4096 "Explain async/await"   # terminal 2
```

## Sessions: `session`, `export`, `import`

```bash
opencode session list -n 10 --format json               # recent sessions
opencode session delete <sessionID>
opencode export <sessionID> --sanitize                  # redacts sensitive data
opencode import session.json
opencode import https://opncd.ai/s/<id>                # import from a share URL
```

`export` with no ID prompts to pick a session. `--sanitize` redacts
transcript/file data — use it before sharing anything sensitive.

## Providers & models: `auth`, `models`

```bash
opencode auth login -p anthropic                        # API key -> ~/.local/share/opencode/auth.json
opencode auth ls                                        # list authenticated providers
opencode auth logout -p anthropic
opencode models                                         # all models as provider/model
opencode models anthropic                               # filter by provider
opencode models --refresh --verbose                     # refresh cache, show cost metadata
```

`auth login` pulls from the provider list at models.dev; keys also load from env
vars or a project `.env`.

## MCP servers: `mcp`

```bash
opencode mcp add                                        # guided add (local or remote)
opencode mcp ls                                         # servers + connection status
opencode mcp auth <name>                                # OAuth login to a server
opencode mcp auth ls                                    # OAuth-capable servers + status
opencode mcp logout <name>
opencode mcp debug <name>                               # debug OAuth connection

```
> Note never do anything with mcp wihtout the user express permission

## Agents: `agent`

```bash
opencode agent list                                     # list available agents
opencode agent create                                   # guided (system prompt + permissions)
opencode agent create \
  --path .opencode/agent --description "Docs writer" \
  --mode subagent --permissions "read,grep,glob,write" \
  --model anthropic/claude                              # non-interactive
```

`--permissions` (alias `--tools`) is a comma list of: `bash`, `read`, `edit`,
`glob`, `grep`, `webfetch`, `task`, `todowrite`, `websearch`, `lsp`, `skill`.
Omitted permissions are **denied**.

## Usage & maintenance

```bash
opencode stats --days 7 --models 5 --project .         # token/cost breakdown
opencode plugin <module>                                # install a plugin (alias: plug)
opencode pr <number>                                   # checkout GH PR branch + run
opencode db path                                        # print local DB path
opencode db "SELECT * FROM sessions LIMIT 5" --format json
opencode debug                                          # troubleshooting utilities
opencode upgrade                                        # latest version
opencode upgrade v0.1.48                               # specific (--method curl|npm|pnpm|bun|brew)
opencode uninstall --dry-run                            # preview removal (--keep-config/--keep-data/--force)
opencode github install                                 # set up GH Actions agent
opencode github run --event <event> --token <pat>       # run in CI
```

## Global flags

`-h/--help`, `-v/--version`, `--print-logs`, `--log-level`
(DEBUG|INFO|WARN|ERROR), `--pure` (no external plugins).

## Key environment variables

- Config: `OPENCODE_CONFIG`, `OPENCODE_CONFIG_DIR`, `OPENCODE_CONFIG_CONTENT`,
  `OPENCODE_TUI_CONFIG`, `OPENCODE_PERMISSION`, `OPENCODE_CLIENT`.
- Server auth: `OPENCODE_SERVER_PASSWORD`, `OPENCODE_SERVER_USERNAME`.
- Behavior: `OPENCODE_AUTO_SHARE`, `OPENCODE_DISABLE_AUTOUPDATE`,
  `OPENCODE_DISABLE_PRUNE`, `OPENCODE_DISABLE_TERMINAL_TITLE`,
  `OPENCODE_DISABLE_DEFAULT_PLUGINS`, `OPENCODE_DISABLE_LSP_DOWNLOAD`,
  `OPENCODE_DISABLE_MODELS_FETCH`, `OPENCODE_DISABLE_MOUSE`,
  `OPENCODE_ENABLE_EXPERIMENTAL_MODELS`, `OPENCODE_ENABLE_EXA`,
  `OPENCODE_MODELS_URL`, `OPENCODE_GIT_BASH_PATH`, `OPENCODE_FAKE_VCS`.
- Experimental (may change/be removed): `OPENCODE_EXPERIMENTAL`,
  `OPENCODE_EXPERIMENTAL_PLAN_MODE`, `OPENCODE_EXPERIMENTAL_PARALLEL`,
  `OPENCODE_EXPERIMENTAL_BACKGROUND_SUBAGENTS`, `OPENCODE_EXPERIMENTAL_SCOUT`,
  `OPENCODE_EXPERIMENTAL_WORKSPACES`, `OPENCODE_EXPERIMENTAL_FILEWATCHER`,
  `OPENCODE_EXPERIMENTAL_LSP_TOOL`, `OPENCODE_EXPERIMENTAL_OXFMT`, and more.

## Tips

- Pipe `opencode run --format json` or `session list --format json` into `jq`.
- Keep a `serve` backend warm and use `run --attach` in loops to avoid re-bootstrapping MCP.
- Use `export --sanitize` before sharing transcripts that contain secrets.
- Upstream reference: https://opencode.ai/docs/cli/
