---
name: orchestrator-plan
description: Decomposes complex goals into independent parallel work streams for multi-subagent execution. Use when orchestrating parallel work, breaking down goals for concurrent subagents, or planning work that can be split across multiple agents without conflicts.
---

# Orchestrator Plan

Decomposes a complex goal into independent work streams optimized for parallel subagent execution.

## When to Use

- Breaking down a goal for the `/goal-orchestrator` command
- Planning work that can be split across multiple agents
- Identifying which parts of a task can run concurrently
- Resolving file ownership conflicts before they happen

## Process

### Step 1: Goal Analysis

1. Read the full goal and understand the end state
2. Explore the codebase to understand current state
3. Identify all files that need to be created or modified
4. Map dependencies between changes

### Step 2: Dependency Graph

Build a dependency graph of all changes:

```
Change A (auth.ts) → Change C (routes.ts) [C depends on A]
Change B (ui.ts) → Change D (tests.ts) [D depends on B]
Change A and Change B are INDEPENDENT → can run in parallel
```

### Step 3: Stream Decomposition

Group independent changes into streams:

**Stream definition:**
```yaml
tag: stream-<name>          # unique identifier
goal: "What this stream achieves"
files:                      # files this stream OWNS
  - path/to/file1.ts
  - path/to/file2.ts
dependencies: []            # tags that must complete first
parallel_group: 1           # streams in same group run concurrently
```

**Rules:**
1. Each file must belong to EXACTLY one stream
2. If two changes touch the same file, they are in the same stream
3. Streams in the same parallel_group run simultaneously
4. Streams in different groups are serialized (group 1 before group 2)
5. Each stream goal must be self-contained — a subagent can complete it without asking questions

### Step 4: Conflict Detection

Before finalizing, check for conflicts:

1. **File overlap**: Does any file appear in multiple streams? → Merge those streams
2. **Import chains**: Does stream A import from stream B's files? → Make B a dependency of A
3. **Test conflicts**: Do streams share test files? → Assign test ownership to the stream that creates the feature
4. **Config conflicts**: Do streams modify the same config? → Merge or serialize

### Step 5: Output Format

Generate the stream registry:

```markdown
# Orchestrator Plan: [goal name]

## Parallel Groups

### Group 1 (run concurrently)
| Tag | Goal | Files | Dependencies |
|-----|------|-------|--------------|
| stream-auth | Implement auth | auth.ts, auth.test.ts | none |
| stream-api | Build API routes | routes.ts, routes.test.ts | none |

### Group 2 (after Group 1)
| Tag | Goal | Files | Dependencies |
|-----|------|-------|--------------|
| stream-integration | Wire auth to API | integration.ts | stream-auth, stream-api |
| stream-ui | Build frontend | ui.ts, ui.test.ts | stream-api |

## Subagent Prompts

### stream-auth
You are working on stream-auth of a larger goal.

**Your Goal:** Implement auth

**File Ownership:**
- auth.ts (create)
- auth.test.ts (create)

**Constraints:**
- Do NOT modify routes.ts or any UI files
- Write tests for all auth functions
- Export types that other streams may need

[... for each stream]
```

## Anti-Patterns

- **Too many streams**: If you have more than 5 streams, you probably over-decomposed. Merge related work.
- **Too few streams**: If one stream touches 10+ files, it's probably 2-3 streams that need splitting.
- **Hidden dependencies**: If stream A calls a function from stream B, that's a dependency even if files don't overlap.
- **Shared state**: If streams read/write to the same database or file system path, they conflict.

## Example

**Goal:** "Add user authentication with JWT, create a settings page, and add rate limiting"

**Decomposition:**
- Stream 1 (auth): JWT auth middleware + types (auth.ts, middleware.ts)
- Stream 2 (settings): Settings page UI (settings.tsx, settings.test.tsx)  
- Stream 3 (ratelimit): Rate limiting middleware (ratelimit.ts, ratelimit.test.ts)

**Analysis:**
- Auth and settings are independent → Group 1
- Rate limit is independent of both → Group 1
- All three can run concurrently

**If settings needed auth context:**
- Auth → Group 1
- Settings and Rate Limit → Group 2 (after auth completes)
