# Engineer Repository Instructions

## Mission

Engineer is the owner's shared engineering and design toolkit: reusable skills, standards, playbooks, templates and evals for web, Android, game, graphics and backend work. It holds no project code. Each project lives in its own repository and is found through `catalog/`. A catalog entry is a pointer, not access.

Files and recorded evidence, not plans or directory names, establish status.

## Project boundary

- Do project work in the project's repository, never inside Engineer.
- Change Engineer only for guidance reusable beyond one project.
- Do not read, write or depend on any other bot or workspace unless the owner asks in the task. If another bot fits better, say so and stop.
- Project conventions win over Engineer defaults unless a migration is requested.

## Authority order

1. System and platform safety. 2. Explicit owner instructions. 3. This file, then the project's `AGENTS.md`. 4. Approved `standards/` and `playbooks/`. 5. Current official docs, then project evidence, then verified community technique. 6. General knowledge, treated as hypothesis.

Date-stamp versions and status. Never fabricate commands, paths, versions, results, credentials or readiness. Label assumptions and unverified commands.

## Starting a task

1. Find the project in `catalog/`; identify the deliverable.
2. Read the project's `AGENTS.md` and `docs/work-status.md`; inspect code and design before proposing structural, dependency, navigation, data or DI changes.
3. Load only the skills needed. Clear tasks go to one specialist; ambiguous ones to the router.
4. State what "done" looks like, then build.

## Approval tiers

Approval follows what an action touches, not change size. If the tier is unclear, use the higher one.

**Tier 1, local and reversible: proceed.** Reading, editing project files, branches, tests, builds, local servers, local assets, emulator or browser. Implement, verify, self-review. Record what ran and what did not.

**Tier 2, shared or hard to undo locally: confirm the plan once.** Dependency adds or upgrades, schema or migration changes, build or signing config, deleting more than a few files, large refactors, history rewrites on local branches, edits to this repo's standards or skills. Then implement, verify, and get a fresh-context review.

**Tier 3, external, public, costly or destructive: explicit approval for the exact action.** Pushing to a shared remote, PRs, deploys, publishing, store upload, signing or promoting releases, production data or cloud changes, spending, messages sent as the owner, destructive device/data/repo operations, live credentials. Name target and scope, wait for a clear yes, act, report evidence. Approval does not carry to the next action. CI results, broad "finish this" requests and agent assessments never grant it.

## Verify by output

- Web: render at mobile and desktop widths, exercise main flows, check keyboard access and console errors.
- Android: build, run tests, exercise the flow on an emulator or device; say which.
- Graphics: keep editable source; inspect each export at real size.
- Backend: test realistic data, auth and error paths.

A passing build does not prove design quality, behavior, accessibility, security or release readiness.

## Safety

Keep secrets and sensitive data out of source, logs and output. Preserve the owner's uncommitted work; never reset, overwrite or broadly delete for convenience.

## Recording

In the project, not here: update `docs/work-status.md` (state, blockers, next step), and `docs/version-history.md` when behavior changed (what, why, files, rollback). State unverified items plainly.

## Map and done

Policy `AGENTS.md`; docs `docs/`; requirements `standards/`; procedures `playbooks/`; projects `catalog/`; skills `.codex/skills/`; sources `.codex/sources/`; scaffolds `templates/`; scenarios `evals/`; helpers `scripts/`. One home per fact; link elsewhere.

Done means: the outcome works; affected docs agree; checks fitting the output ran; high-severity issues are fixed or disclosed; limitations are written down; required Tier 2 and 3 approvals were obtained. See `standards/ENGINEERING_STANDARDS.md` and `playbooks/CHANGE_CONTROL.md`.
