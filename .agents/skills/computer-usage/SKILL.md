---
name: computer-usage
description: Environment orientation for AI agents. Use when starting a new session, asked "what can I do here", or when another skill needs to know what tools and configs exist on this machine.
---

# Computer Usage

Orients the agent to this machine: what's installed, what's configured, what skills are available. The agent reads `.config`, inventories tools, and knows where to reach everything before doing real work.

## Setup

Run once per session. Skip if you've already seen the output.

```bash
node .agents/skills/computer-usage/scripts/scan-config.mjs
```

If the script is missing, fall back to manual discovery:

1. `ls ~/.config/` — list installed tool configs
2. `cat ~/.zshrc` — read shell aliases and PATH
3. `cat ~/.config/opencode/opencode.json` — read MCP servers and providers

Completion criterion: you can name at least 5 installed tools and 2 shell aliases without looking them up.

## Environment Map

### Editors
| Tool | Command | Notes |
|------|---------|-------|
| Neovim | `nvim`, `n` | Primary editor, lazy.nvim plugins |
| VS Code | `code` | Available via CLI |
| Cursor | `cursor`, `c` | AI-powered editor |

### Shell Aliases
| Alias | Expands to |
|-------|------------|
| `oc` | `opencode --auto` |
| `n` | `nvim` |
| `c` | `cursor` |
| `ga` | `git add .` |
| `gc` | `git commit -m` |
| `gp` | `git push` |
| `ls` | `eza` |

### Key Tools
- **uv** — Python package manager
- **bun** — JavaScript runtime
- **lazygit** — Git TUI
- **television** — Terminal TUI



## Completion Criterion

You are oriented when you can answer these without looking:
1. What editors are installed?
2. What shell aliases exist?
3. How do you publish a plan?
