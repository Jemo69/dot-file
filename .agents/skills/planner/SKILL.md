---
name: planner
description: Plan a task the way I like it — interview for shared understanding, then produce the plan as an HTML file and publish it with the plan-cli skill. Use when the user wants to plan a task, create a plan, discuss an implementation approach, or create a new project for their work.
---

# Planner

This skill helps you plan a task before any code is written. The deliverable is
an HTML plan file that gets published via the `plan-cli` skill. Each plan creates
a new project — never reuse existing projects for new work.

## Tools I use (your plan should account for these)

* `uv` for Python
* `bun` for TypeScript/JS
* `jj` for version control when the repo has a `.jj` directory

## You MUST do these steps before proceeding

1. **Capture vocabulary.** When the user gives you a task, ask for the terms and
   vocabulary they use to think about the problem. Record this vocabulary in the
   plan's own notes section (NOT in AGENTS.md — that is global config and must
   not be mutated per task).
2. **Explore the codebase.** Understand the current state before proposing anything.
3. **Interview relentlessly, one question at a time.**
   Interview me about every aspect of this plan until we reach a shared
   understanding. Walk down each branch of the design tree, resolving
   dependencies between decisions one-by-one. For each question, provide your
   recommended answer.
   Ask the questions one at a time, waiting for feedback before continuing.
   Asking multiple questions at once is bewildering.
   If a question can be answered by exploring the codebase, explore the codebase
   instead of asking.
4. **Write the plan as an HTML file**, named after the plan
   (e.g. `plan-name.html`).
5. **Publish it** with the `plan-cli` skill (see "Publish" below).

## How the plan should be structured (in the HTML file)

The plan is for both the user and the agent. It must contain:

1. The **plan name** and the **main goal** of the plan.
2. The **files being modified** and the **files being created**, in two separate
   sections.
3. The **phases** of the plan, in execution order.
4. make sure all plan are mobile freindly 
5. read the style.md in ~/.agents/skills/planner/

Your job is to plan a task using HTML (and, if useful, a companion markdown file).

## Researchable

Used when the user gives you links to research, or asks you to research before planning.

* If the user gives a link, read the data in it and use it to make a better plan.
* If the user asks you to research then plan, look for a set of options.
* Add the options to the plan.
* When planning, write a separate plan file **per option**.
* Then create a **report** of which plan is best.

### Report

The report is a short, readable response in the chat window. For each option list
its advantages and disadvantages, and end with a recommendation of the best option.


## Project Management

**Each new project gets a new project.** Never reuse existing projects for new work. This is a hard rule: every task that needs a project creates one.

### Project Name Resolution

When creating a new project, resolve the name in this order:

1. **From the task itself** — if the task has a clear name (e.g., "build auth system"), use it.
2. **From the plan content** — if you can infer a name from what the plan covers, use it.
3. **Ask the user** — if you cannot determine a name, ask: "What should I call this project?"

### Project Creation

To create a new project:

```bash
plan projects create --name "<PROJECT_NAME>"
```

The command returns a project ID you'll use when publishing. Always create a new project unless the user explicitly specifies an existing one.

## Publish

When the plan is finalized, publish it with the `plan-cli` skill:

1. Verify auth with `plan auth whoami` (run `plan auth init`/`login` first if needed).
2. **Create a new project** (unless the user specifies an existing one): `plan projects create --name "<PROJECT_NAME>"`.
3. Create and publish: `plan create --project <PROJECT_ID> --title "<TITLE>" --html <PATH_TO_HTML> --public`
   .
4. create a private plan with `plan create --project <PROJECT_ID> --title "<TITLE>" --html <PATH_TO_HTML> --private`

Completion criterion: the command outputs the created plan's ID and title.
