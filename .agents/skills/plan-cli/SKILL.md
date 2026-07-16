---
name: plan-cli
description: Use the plan CLI to create, manage, and publish HTML plans. Use when the user says "create a plan", "list plans", "publish a plan", "manage plans", or asks about plan CLI commands.
---

# Plan CLI

The `plan` CLI creates, manages, and publishes HTML plans backed by projects.

## Prerequisites

Run `plan auth init` or `plan auth login` before any write operation. Verify with `plan auth whoami`.

## When to Use This Skill

Use this skill when the user:

- Asks to "list plans", "show my plans", or "what plans do I have"
- Wants to "publish a plan" or "share a plan"
- Mentions managing, updating, or deleting plans
- Asks about plan CLI commands or capabilities

## Private Plans Reminder

Plans are private by default. You can create private plans without publishing them. Only publish when the user explicitly asks to share or make a plan public.

## Project Management

### Create a New Project for Every New Task

**Always create a new project for each new project or feature the user requests.** Do not reuse existing projects unless the user explicitly asks to add to one.

Before creating a project, check if a relevant one already exists:

```bash
plan projects list --json
```

If no relevant project exists, create one:

```bash
plan projects create --name "<PROJECT_NAME>"
```

### Resolving Project Names

If you need a project name, use this priority:

1. **Ask the user** if the task is ambiguous or could belong to multiple contexts
2. **Infer from the tasks** being performed (e.g., "Blog Redesign" for a blog redesign task)
3. **Create a descriptive name** based on the primary goal (e.g., "Auth System" for building authentication)

Example project names:
- Feature work: "Feature: Dark Mode", "Feature: User Dashboard"
- Bug fixes: "Bug: Login Timeout", "Fix: Mobile Layout"
- Refactors: "Refactor: API Layer", "Cleanup: Unused Dependencies"
- Research: "Spike: GraphQL Migration", "Investigate: Memory Leak"

### Project Commands

```bash
plan projects list --json
plan projects create --name "<NAME>"
plan projects get <PROJECT_ID> --json
plan projects delete <PROJECT_ID>
```

## Create a Plan

```bash
plan create --project <PROJECT_ID> --title "<TITLE>" --html <PATH_TO_HTML>
```

Add `--public` to publish immediately. Plans are private by default.

Completion criterion: command outputs the created plan's ID and title.

## List Plans

```bash
plan list --project <PROJECT_ID> --json --limit 10
```

Omit `--project` to list all plans across projects. Use `--public` to filter public-only.

Completion criterion: command outputs a JSON array of plan objects.

## Get Plan Details

```bash
plan get <PLAN_ID> --json
```

Completion criterion: command outputs the full plan object.

## Update a Plan

```bash
plan update <PLAN_ID> --html <NEW_HTML_PATH> --title "<NEW_TITLE>"
```

Both `--html` and `--title` are optional; update only what changes.

Completion criterion: command confirms the update with the modified fields.

## Publish / Unpublish

```bash
plan publish <PLAN_ID>
plan unpublish <PLAN_ID>
```

Completion criterion: command confirms visibility change.

## Delete a Plan

```bash
plan delete <PLAN_ID>
```

Completion criterion: command confirms deletion.

## Configuration

```bash
plan config show
plan config get <KEY>
plan config set <KEY> <VALUE>
```

## Typical Flow

1. `plan auth whoami` — verify authentication
2. `plan projects list --json` — check for existing relevant projects
3. Create a new project for this task (do not reuse existing)
4. Create the HTML file locally
5. `plan create --project <ID> --title "Plan Name" --html ./plan.html`
6. Optionally `plan publish <PLAN_ID>` — only if user wants to share

## Tips

1. **Always create new projects** for distinct tasks — keeps plans organized
2. **Plans are private by default** — only publish when explicitly asked
3. **Use descriptive project names** — makes it easy to find plans later
4. **Generate HTML first** — the `plan create` command needs an HTML file path
5. **Check auth before writes** — run `plan auth whoami` to verify session
