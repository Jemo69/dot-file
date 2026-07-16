---
name: agent-hub
description: Cross-agent coordination hub. Use when agents need to register, claim/lock files before editing, detect edit conflicts, or message each other across opencode, pi, codex, gemini, cursor, and remote machines. pi and other non-MCP CLIs use the HTTP API via hub-api.sh. Triggers include "agent hub", "claim file", "file lock", "who else is editing", "broadcast to agents".
---

# Agent Hub Skill

Cross-agent communication for opencode, pi, codex, gemini, cursor — on one
machine, across a LAN, or worldwide via a cloud database.

## Architecture

The **shared database is the coordination substrate**. Every machine runs its
own local MCP server (stdio), but they all read/write the same database:

- **local backend** — on-disk SQLite. One machine only.
- **turso backend** — hosted libSQL over HTTP. Every machine worldwide that
  points at the same Turso DB shares one hub. No exposed ports needed.

Pick the backend once per machine:

```bash
uv run --project ~/projects/agent-hub setup_db.py
```

## Connection methods

| Agent            | Method                                             |
|------------------|----------------------------------------------------|
| opencode, codex, gemini, cursor | MCP server (stdio) — already configured |
| **pi**           | **HTTP API only, via `hub-api.sh` (this skill)**   |
| any other CLI    | HTTP API via curl                                  |

pi does **not** use MCP. pi is a skill that talks to the hub over HTTP.

## Deployment modes

1. **Local device** — backend `local`, HTTP bound to loopback. Single machine.
2. **Local network** — one machine runs the HTTP API bound to `0.0.0.0` with an
   API token; other machines set `HUB_HOST=http://<lan-ip>:3100`.
3. **Cloud / global** — backend `turso`; every machine worldwide shares the
   cloud DB. Run a hub HTTP API on a cloud VM (with a token) for pi/remote CLIs.

## Auth — protect your communication layer

Set an API token so only your agents can use the HTTP layer. `setup_db.py` can
generate one, or set `AGENT_HUB_API_TOKEN`. Every request must send
`Authorization: Bearer <token>` (handled automatically by `hub-api.sh`, which
reads the token from `~/.local/share/agent-hub/config.json`). The Turso DB is
independently protected by its own auth token. `/api/health` is the only
unauthenticated endpoint.

## Start the HTTP API (for pi / remote access)

```bash
~/.agents/skills/agent-hub/scripts/start-hub.sh
~/.agents/skills/agent-hub/scripts/status.sh
```

## pi usage (HTTP via hub-api.sh)

```bash
H=~/.agents/skills/agent-hub/scripts/hub-api.sh

# Point at a remote hub (LAN or cloud VM); token read from config or env:
export HUB_HOST=http://192.168.1.20:3100
export AGENT_HUB_API_TOKEN=your-token   # optional if in config.json

bash $H register "pi-1" "/repo"                 # -> {"agent_id":"ab12cd34",...}
bash $H claim   "ab12cd34" "src/app.py" "refactor auth"
bash $H conflicts "src/app.py"                   # who else holds it
bash $H heartbeat "ab12cd34"                     # keep alive (every ~30s)
bash $H message "ab12cd34" "ef56" "editing auth"
bash $H broadcast "ab12cd34" "starting migration"
bash $H messages "ab12cd34"                      # poll inbox
bash $H release "ab12cd34" "src/app.py"
bash $H deregister "ab12cd34"                     # on shutdown
```

## Peer-to-peer prompt/response (Pi-to-Pi comms)

Flat, no-orchestrator communication: any agent can send a **prompt** to any peer,
get back a **message ID**, and **await** the **response** — blocking or polling.
This is separate from fire-and-forget `message`/`broadcast` (those stay one-way).

The loop (both sides are equals — either can initiate):

- **Sender:** `send_prompt(from, to, "...")` → keep the returned `message_id` →
  `await_response(message_id, timeout)` (blocks) *or* `poll_response(message_id)`
  in your own loop (returns `pending` / `ready`).
- **Responder:** periodically `read_prompts(agent_id)` → treat each incoming
  prompt as a task → do the work → `respond_to_prompt(agent_id, prompt_id, "...")`.

pi / HTTP:

```bash
H=~/.agents/skills/agent-hub/scripts/hub-api.sh
bash $H prompt  "ab12" "ef56" "bring the prod slice, PII stripped"  # -> {"message_id":42,...}
bash $H await   42 300                # block up to 300s for the reply
bash $H prompts "ef56"               # responder: read incoming prompts
bash $H respond "ef56" 42 "done, slice imported, PII clean"
bash $H poll    42                    # non-blocking: pending | ready
```

**Avoid loops:** every prompt must have a clear end state. A response is expected
exactly once per prompt; keep prompts scoped so token cost stays bounded.

## MCP tools (opencode / codex / gemini / cursor)

`register_agent`, `deregister_agent`, `set_status`, `list_agents`, `heartbeat`,
`claim_file`, `release_file`, `check_file_conflicts`, `send_message`,
`broadcast`, `read_messages`, `send_prompt`, `read_prompts`,
`respond_to_prompt`, `poll_response`, `await_response`, `cleanup_stale_agents`.

Stale agents (no heartbeat for 60s) are auto-marked offline and their file
locks released by a background task.
