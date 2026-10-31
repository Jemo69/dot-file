# AGENTS.md — Global Context & Instructions

## About Me & Working Style
I'm Jeremy, a Computer Science student at Morgan State. We are working together as a team to build software cleanly and efficiently.

## Technical Defaults
- **CLI & Backend-First:** Python (FastAPI / Django)
- **Frontend & Web Apps:** TypeScript, SvelteKit, Svelte, Tailwind CSS
- **Real-Time Data:** Convex
- **Full-Stack Paradigms:** 
  - SvelteKit for frontend-first applications
  - Django / FastAPI for backend-first applications

### Core Philosophy: Do One Thing and Do It Well
- **Single Responsibility:** Write minimal, modular, single-purpose code. Every file and function should do one thing and do it well.
- **Low Complexity:** Avoid unnecessary abstractions, premature optimization, or heavy architectural patterns. Prefer simple, explicit solutions.
- **Strict Blast Radius:** When fixing bugs or adding features, edit only what is necessary. Never touch unrelated files or refactor unprompted code.
- **Type Safety:**
  - **Python:** Use explicit type hints for all function signatures and complex variables.
  - **TypeScript:** Write strict, well-typed code. Avoid `any` unless absolutely unavoidable or explicitly requested.

---

## Environment & Tooling Constraints

### OS & Shell Context
- **OS:** Linux via WSL (Windows Subsystem for Linux).
- All commands, file paths, and execution scripts must run strictly within the WSL environment.

### Windows Paths & Screenshots (WSL) — never mockup
- Windows `C:\Users\...` equals WSL `/mnt/c/Users/...`. Auto-translate and read via `/mnt/c/...`, never claim inaccessible.
- Screenshots pasted as `C:\...` must be read from `/mnt/c/...`. If missing, ask for re-upload. Never substitute a mockup or fake evidence.
- No GPU/display is not an excuse: use `Xvnc + xfwm4 + xdotool` software GL for live captures.

### Version Control: Jujutsu (`jj`) ONLY
- **STRICT RULE:** Do NOT execute standard `git` commands (`git commit`, `git status`, `git checkout`, `git branch`, etc.).
- Use `jj` (Jujutsu) for all version control operations:
  - `jj status` — Check workspace status
  - `jj log` — View change history
  - `jj describe -m "type(scope): message"` — Record change description
  - `jj new` — Create a new revision off the current parent
  - `jj rebase` — Rebase revisions

### Language & Package Managers

#### Python Workflow
- **PRIMARY TOOL:** `uv`
- **Commands:** Use `uv run <script>`, `uv add <pkg>`, `uv remove <pkg>`, or `uv pip install`.
- **NEVER:** Do not run raw `python`, `python3`, or standard `pip` directly.

#### JavaScript / TypeScript Workflow
- **PRIMARY TOOL:** `bun`
- **Commands:** Use `bun run <script>`, `bun add <pkg>`, `bun remove <pkg>`, `bun test` or `bunx`.
- **NEVER:** Do not use `npm`, `pnpm`, `yarn`, or `npx`.

---

## Operational Rules & Guardrails

### 1. Questions Are Read-Only
- Requests framed as questions or diagnostics ("Why is this throwing an error?", "How does this module work?") are strictly **read-only**.
- Analyze context, explain findings, and propose solutions **without editing files, creating commits, or running state-modifying shell commands**.
- Wait for explicit user confirmation before applying code changes.

### 2. Match Ceremony to the Task
- Keep changes concise. Do not spawn unnecessary sub-agents or complex automated verification loops for straightforward single-file tasks.
- Match comments to utility: write clear, high-level comments explaining *why* complex functions exist, rather than annotating every line of obvious code.

### 3. Concrete Examples (Good vs. Bad)

#### Commit / Revision Messages
- **BAD:** `fixed stuff in auth and updated packages`
- **GOOD:** `fix(auth): correct token expiration check in session middleware`

#### Scope & Architecture
- **BAD:** Rewriting a full service module to insert a helper function, pulling in 3 new external dependencies.
- **GOOD:** Adding a targeted internal helper function in its own module following UNIX single-responsibility principles.

---

## Glossary & Skill Directives
- **You / Agent:** The AI coding assistant executing operations in this repository.
- **AI agent (user shorthand):** When the user says "AI agent", "an agent", or "give the agent X", they mean coding CLIs like **Claude Code, Codex, OpenCode, Pi** — terminal tools that run shell commands, read files/screenshots, and consume MCP servers + skills. Build for that interface (terminal-first, file outputs, MCP/skill wiring), not for a generic LLM or web chatbot.
- **Jeremy / User:** The human directing development.
- **Environment:** The WSL Linux environment and active workspace tree more detail in `computer-usage skill`.
> use design systems when the user ask for the name of the specific design system
- **Encase:** Design system specification. Trigger the `encase` skill whenever building UI components under the Encase design language.
- **MHID:** Material Human Interface Design specification. Trigger the `mhid` skill whenever building UI components matching the MHID design language.
