# Plan CLI Reference

Full reference for the `plan` CLI — create, manage, and publish HTML plans.

## Auth

```bash
plan auth init      # first time setup
plan auth login     # login to existing account
plan auth whoami    # verify authentication
```

Always run `plan auth whoami` before any write operation. If it fails, run `plan auth init`.

## Projects

Plans belong to projects. List or create before making plans.

```bash
plan projects list --json                    # list all projects
plan projects create --name "Project Name"   # create new project
plan projects get <PROJECT_ID> --json        # get project details
plan projects delete <PROJECT_ID>            # delete project
```

## Create a Plan

```bash
plan create --project <PROJECT_ID> --title "Plan Title" --html ./plan.html
plan create --project <PROJECT_ID> --title "Plan Title" --html ./plan.html --public
```

The HTML file must exist before running this command. Add `--public` to publish immediately.

## List Plans

```bash
plan list --project <PROJECT_ID> --json --limit 10
plan list --json --limit 10                  # all projects
plan list --public --json                    # public plans only
```

## Get Plan Details

```bash
plan get <PLAN_ID> --json
```

## Update a Plan

```bash
plan update <PLAN_ID> --html ./new.html --title "New Title"
```

Both `--html` and `--title` are optional. Update only what changes.

## Publish / Unpublish

```bash
plan publish <PLAN_ID>     # make shareable
plan unpublish <PLAN_ID>   # remove from public
```

## Delete a Plan

```bash
plan delete <PLAN_ID>
```

## Config

```bash
plan config show           # show all config
plan config get <KEY>      # get one value
plan config set <KEY> <VALUE>  # set one value
```

## Typical Flow

1. `plan auth whoami` — verify auth
2. `plan projects list --json` — find or create project
3. Write HTML file locally
4. `plan create --project <ID> --title "Title" --html ./plan.html`
5. `plan publish <PLAN_ID>` — share it
