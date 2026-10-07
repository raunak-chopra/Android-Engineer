# Engineer

Engineer is a shared engineering and design toolkit. It holds reusable expertise for web design, web development, Android apps, game development, graphics and design, and supporting backend work. It does not contain project code: each project lives in its own repository, and Engineer points to it through [`catalog/`](catalog/README.md).

## How it works

```text
pick project (catalog) → read project AGENTS.md + work-status → load the needed skills
        → define "done" → implement → verify → record in the project
```

- **Skills** (`.codex/skills/`) are small specialist runbooks, loaded only when the task needs them. Clear tasks go straight to one specialist; ambiguous ones go through the router skill.
- **Projects own their context.** Requirements, architecture, design rules, status and history live in the project repo. Engineer holds only what is reusable across projects.
- **Lessons flow one way.** A lesson is promoted into Engineer only when it is useful beyond the project that produced it.
- **Engineer works alone.** It does not read or depend on other bots or workspaces unless the owner asks for that in a task.

Operating rules, including the three approval tiers, are in [AGENTS.md](AGENTS.md).

## Capability areas

| Area | Owns |
| --- | --- |
| Product and UX | requirements, journeys, screen flows, acceptance criteria |
| Visual design | typography, color, spacing, components, responsive behavior |
| Graphics | editable logos, icons, illustrations, asset formats and exports |
| Web development | frontend behavior, accessibility, browser verification |
| Android development | Kotlin/Compose, lifecycle, persistence, device verification |
| Game development | engine/framework choices, game loop, input, asset pipeline |
| Backend and data | APIs, auth, schemas, migrations, integrations |
| Delivery | build, CI/CD, hosting, store release, testing, security review |

Current skill coverage is listed in [docs/CAPABILITIES.md](docs/CAPABILITIES.md) `[To be written]`. Add skills or templates only when a real task exposes a gap.

## Repository map

| Path | Purpose |
| --- | --- |
| `AGENTS.md` | Short operating rules and approval tiers |
| `.codex/skills/` | Specialist workflows |
| `.codex/sources/` | Provenance and review records for adopted external knowledge |
| `catalog/` | Pointers to projects (location, platform, status). Grants no access. |
| `standards/` | Shared quality expectations |
| `playbooks/` | Delivery, review and release procedures |
| `templates/` | Starter scaffolds by area (android, web, backend, design) |
| `scripts/` | Reusable helpers and validation only |
| `evals/` | Routing and workflow regression scenarios |
| `docs/` | Architecture, capabilities, verification record, version history |

Project-specific code, assets and scripts do not belong here. Existing items of that kind (`synapse_zero_hour`, `ashfall_prototype`, and any project-specific scripts) are to be moved to their own repositories and referenced from the catalog.

## Using it on a project

1. Say which project and what you want (for example, "fix the layout bug on the Synapse menu screen").
2. Engineer finds the project in the catalog, reads its `AGENTS.md` and `docs/work-status.md`, and inspects the existing code and design before changing anything.
3. It works in the project repo, verifies the result by output type (browser, emulator or device, inspected exports), and updates the project's status and history.

A project needs at minimum an `AGENTS.md` (conventions and verified commands) and `docs/work-status.md` (current state, blockers, next step). Add `project-brief.md`, `architecture.md`, `design-system.md` or `version-history.md` when the project is big enough to need them.

## What it is not

- Not a replacement for a project's own `AGENTS.md`, build conventions or architecture.
- Not an authority to deploy, publish, sign, spend or change production. Those need explicit approval for the exact action (Tier 3 in AGENTS.md).
- Not a source of current dependency versions; resolve and verify versions inside the project.

## Source priority

1. Current official documentation for the platform or tool.
2. Direct evidence from the project.
3. Locally verified community techniques.
4. Clearly labelled heuristics.

Adopted external sources need a URL, reviewed revision, license note and audit date under `.codex/sources/`.

## Current status

`[To be supplied after reconciliation]` — verified readiness, last validation run and open limitations are recorded in [docs/VERIFICATION.md](docs/VERIFICATION.md), not in this file, so this README does not go stale.
