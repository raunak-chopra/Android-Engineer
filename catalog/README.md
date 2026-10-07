# Project catalog

`apps.json` lists the projects Engineer works on and where they live. It is a pointer, not a permission: a catalog entry grants no repository, credential, device, dashboard, hosting or production access. A missing entry means Engineer has no recorded location or status for that project.

## What Engineer does with an entry

1. Resolves the project's `path`.
2. Reads the project's `AGENTS.md` and `docs/work-status.md`.
3. Works in that repository, never inside Engineer.

## Entry format (schema version 2)

```json
{
  "id": "stable-lowercase-id",
  "name": "Human-readable name",
  "type": "web | android | game | backend | graphics | fullstack",
  "status": "planned | active | paused | archived",
  "path": "C:\\Users\\rauna\\Desktop\\Projects\\project-name",
  "remote": "non-secret repository URL, or null",
  "stack": ["godot-4", "gdscript"],
  "platforms": ["android", "web"],
  "commands": {
    "build": "verified command, or null",
    "test": "verified command, or null",
    "run": "verified command, or null"
  },
  "contextFiles": {
    "agents": "AGENTS.md",
    "status": "docs/work-status.md"
  },
  "production": {
    "enabled": false,
    "explicitApprovalRequired": true
  },
  "verifiedAt": "YYYY-MM-DD"
}
```

Field rules:

- `id`, `name`, `type`, `status`, `path`, `production`, `verifiedAt` are required.
- `commands` hold only commands that have actually been run successfully; otherwise `null`. Do not guess.
- `production.explicitApprovalRequired` must stay `true`. Deploys, publishing, store uploads, signing and spending always need explicit approval for the exact action.
- `verifiedAt` is the date the entry was last checked against the real project. Re-check when it is older than 90 days, or when the project is reported as changed.
- `path` may be anywhere on the machine; projects do not need to move to a common folder.

Never store credentials, tokens, signing details, private customer data, private URLs or production-control values in the catalog.

## Registering a project

Add an entry when the owner names a project to work on, or approves one. Fill only what is known; use `null` for unknown commands and `[To be supplied]` for unknown text. Update `updatedAt` at the top of the file.

## Current state

The catalog is empty (schema version 2). The earlier `synapse-zero-hour` entry was removed on 2026-10-07 because that folder was a test and was deleted. Register real projects (for example those under `C:\Users\rauna\Desktop\Games` and `C:\Users\rauna\Desktop\Projects`) when the owner names them.

## Validation

A validation script should check, on every run: valid JSON; required fields present; `path` exists; `contextFiles` exist at that path; `production.explicitApprovalRequired` is `true`; and `verifiedAt` is not older than 90 days (warning only). `[Script to be written in scripts/]`
