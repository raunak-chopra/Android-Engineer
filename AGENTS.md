# Engineer Repository Instructions

## Mission and authority

Engineer is a governed workspace for curated Android guidance, reusable assets, and verification evidence. It is not an app, release pipeline, or authority over a target repository. Files and recorded evidence, not plans or directory names, establish implementation status.

Apply instructions in this order:

1. System and platform safety requirements.
2. Explicit owner instructions for the task.
3. This file, then a more-specific lawful `AGENTS.md`.
4. Approved repository standards and playbooks.
5. Curated external sources pinned to a reviewed revision.
6. General knowledge and heuristics.

Prefer current official Android/Kotlin documentation, then target-repository evidence, then locally verified community techniques. Treat unsourced, volatile, or conflicting claims as hypotheses. Date-stamp versions, SDK levels, CI/release status, benchmarks, and upstream revisions.

## Safety boundaries

- Inspect an existing project before proposing structural, dependency, navigation, persistence, or DI changes. Its conventions win unless migration is requested.
- Never fabricate commands, paths, versions, results, ownership, incidents, credentials, identifiers, or readiness.
- Keep secrets and sensitive data out of source, logs, examples, artifacts, and review output.
- Do not perform destructive device, data, repository, cloud, distribution, or deployment actions without explicit authorization for the exact target and scope.
- Do not upload, publish, sign, submit, promote, roll out, or alter production without explicit owner approval for that action.
- Automated checks, agent assessments, and broad requests to finish do not grant production approval.
- Preserve user changes and unrelated work; never reset, overwrite, or broadly delete for convenience.
- Label assumptions and unverified commands. Do not present them as proven instructions.

## Repository contract

Canonical homes are: policy in `AGENTS.md`; status and architecture in `docs/`; requirements in `standards/`; approvals and operations in `playbooks/`; registered app metadata in `catalog/`; provenance in `.codex/sources/`; task runbooks in `.codex/skills/`; scaffolding in `templates/`; scenarios in `evals/`; deterministic helpers in `scripts/`; and non-deploying CI in `.github/`.

Give each durable fact one home and cross-link it elsewhere. A catalog entry grants no repository, credential, device, dashboard, or production access. Add an app only when owner, location, intended use, status, and verification boundary are known.

Before work affecting architecture, roadmap, standards, or operations, read `docs/IMPLEMENTATION_PLAN.md`, `docs/ARCHITECTURE.md`, the applicable file in `standards/`, and the relevant `playbooks/` file.

## Required work protocol

1. Read applicable instructions and inspect current state.
2. Define the bounded outcome, affected paths, risks, and acceptance evidence.
3. Gather repository and primary-source evidence.
4. Implement the smallest coherent change; distinguish planned from implemented work.
5. Run relevant deterministic checks and record passes and omissions.
6. Obtain independent review for every meaningful change; the author may repair but not approve it.
7. Obtain root acceptance only after blocking findings are resolved and evidence exists.
8. Obtain owner approval before a milestone, external-system change, or production action.

Use these exact states:

| State | Meaning |
| --- | --- |
| Draft | Authored; not independently reviewed. |
| Reviewed | Independent findings are recorded. |
| Verified | Required repairs and checks passed with evidence. |
| Accepted | A root maintainer accepted scope, evidence, and safety. |
| Owner-approved | The owner authorized the named milestone or external action. |
| Released | A separately authorized release completed with evidence. |

Roles: the implementer authors and verifies a bounded change; an independent reviewer checks grounding, safety, correctness, usability, and alignment; a root maintainer accepts or returns verified work; the owner sets priorities and authorizes milestones and external actions. No person, model, or agent approves its own authored change.

## Definition of done

A change is done only when the intended outcome exists; affected guidance is consistent; relevant validation ran; high-severity findings are resolved; limitations are documented; and the correct acceptance state is recorded. Syntax checks alone do not prove factual, behavioral, accessibility, security, or release claims.

See `standards/ENGINEERING_STANDARDS.md` and `playbooks/CHANGE_CONTROL.md` for evidence, risk classes, review inputs, and production-approval details.
