# Full-stack extension

Date: 2026-10-07. State: Verified and Accepted locally by the independent reviewer/root maintainer. No owner milestone approval or release is claimed. See [review](evidence/fullstack-2026-10-07/REVIEW.md) and [verification](evidence/fullstack-2026-10-07/VERIFICATION.md).

The owner requested broader engineer/developer workflows. This additive curated-guidance package extends the Android library without changing existing skills, templates, CI, global settings, dependencies or production systems. It does not change the model or establish target application readiness.

## Inventory

The nine entrypoints were subsequently revised for conditional loading in the authorized [lazy implementation](LAZY_IMPLEMENTATION.md). That new revision is separately Verified and Accepted locally after its independent review and root acceptance; earlier evidence below remains historical.

| Skill | Purpose |
| --- | --- |
| [fullstack-delivery](../.codex/skills/fullstack-delivery/SKILL.md) | Inspect and coordinate cross-stack features |
| [web-frontend](../.codex/skills/web-frontend/SKILL.md) | Browser UI, state and accessibility |
| [backend-api](../.codex/skills/backend-api/SKILL.md) | Services, contracts and jobs |
| [database-engineering](../.codex/skills/database-engineering/SKILL.md) | Integrity, queries, migrations and recovery |
| [application-security](../.codex/skills/application-security/SKILL.md) | Threat modeling and defensive remediation |
| [system-architecture](../.codex/skills/system-architecture/SKILL.md) | Boundaries and design tradeoffs |
| [engineering-testing](../.codex/skills/engineering-testing/SKILL.md) | Behavioral regression and integration evidence |
| [supply-chain-security](../.codex/skills/supply-chain-security/SKILL.md) | Upstream instructions, dependencies and CI trust |
| [reliability-observability](../.codex/skills/reliability-observability/SKILL.md) | Diagnosis, telemetry and recovery planning |

## Scope and acceptance evidence

Affected paths: nine new skill directories, [source ledger](../.codex/sources/fullstack-2026-10-07.md), this inventory and review evidence, nine additive structural contracts in [common contract corpus](../evals/android/skill-contracts.json), and the [full-stack lexical routing corpus](../evals/fullstack/trigger-cases.json). Existing unrelated untracked work is preserved. Risks include broad routing, ungrounded generalization and upstream instruction injection; mitigate through scoped triggers, target inspection, pinned sources and no upstream execution/imports.

Acceptance requires structural/link validation, independent factual/safety/usability review, resolved blocking findings and separate root acceptance. Target-level build, migration, restore, security, accessibility and load tests require a real target and are unperformed here. Historical Android routing/context baselines do not validate this new set.

The runbooks reside in repository-local `.codex/skills`. Discovery in this already running session is unverified; no global installation is claimed. Explicitly reference the linked file if absent from the session catalog.

No milestone is owner-approved or released by this package. See [change control](../playbooks/CHANGE_CONTROL.md). This file tracks the additive general-engineering extension while the historical Android roadmap remains unchanged.
