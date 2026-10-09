# Engineer architecture

## Architectural intent

Engineer separates durable policy, curated implementation, executable validation, and target-application evidence. This makes it possible to improve guidance for web, Android, game, graphics and backend work without allowing an upstream source, a generated template, or an automation to silently become policy.

```text
Primary sources + target-project evidence
                 │
                 ▼
      Source ledger and reviewed policy
                 │
                 ├─────────────┬──────────────┬──────────────┐
                 ▼             ▼              ▼              ▼
        Curated skills     Templates        Playbooks      Standards
                 │             │              │              │
                 └─────────────┴──────┬───────┴──────────────┘
                                      ▼
                     Evaluations and reference application
                                      │
                                      ▼
                        Validation evidence and review record
```

The arrows are evidence flow, not automatic propagation. No upstream update may mutate an active skill, template, standard, or playbook without a bounded reviewed change.

## Repository zones

| Zone | Role | Authority boundary |
| --- | --- | --- |
| `AGENTS.md` | Repository-wide behavioral contract | Applies unless a more-specific instruction lawfully refines it |
| `docs/` | Architecture, roadmap, and evidence notes | Explains status; does not authorize external actions |
| `standards/` | Normative quality requirements | Defines expectations; target repository rules may add stricter constraints |
| `playbooks/` | Operational decision procedures | Requires explicit owner authorization where stated |
| `catalog/` | Pointers to projects (path, type, status, verified commands) | A pointer only; grants no access, and project code never lives here |
| `.codex/sources/` | Upstream provenance and review records | A record of review, not a content import mechanism |
| `.codex/skills/` | Concise task-routing instructions | Must point to evidence, not replace it |
| `templates/` | Selectable scaffolding | Must not impose architecture on brownfield projects |
| `evals/` | Task and routing regression evaluations | Tests a claimed workflow; does not prove all claims |
| `scripts/` | Deterministic validation helpers | Must be reviewed, scoped, and safe by default |
| `.github/` | Non-deploying CI configuration | Must not contain secrets or autonomous production promotion |

Verified status is recorded in [VERIFICATION.md](VERIFICATION.md) and planned work in [ROADMAP.md](ROADMAP.md); presence alone does not establish verification or owner approval.

## Knowledge model

Use one home for each durable fact:

- Standards own cross-cutting required behavior.
- Playbooks own operational sequence and approvals.
- A skill owns its trigger and task-specific runbook.
- A template owns generated structure and choice surfaces.
- An evaluation owns the testable scenario and expected evidence.
- The source ledger owns external provenance and audit history.
- The catalog owns explicit target-app metadata.

Cross-link instead of duplicating facts. If facts conflict, favor explicit owner direction, the target repository's local instructions, and current primary sources in that order.

## Context-loading model

Budget three surfaces separately: root instructions loaded for a run, skill names
and descriptions exposed for routing, and full entrypoints loaded after a skill
is selected. Keep enforceable safety and approval rules in `AGENTS.md`; links do
not substitute for active instructions. Keep descriptions discriminating, skill
bodies task-specific, and conditional depth in references. Measure UTF-8 bytes
and characters exactly; label token conversions as estimates.

The canonical limits and baseline live in `evals/context-budget.json`. CI checks
them together with skill contracts. A reviewed, expiring exception may preserve
necessary behavior, but compression alone cannot justify removing a safety,
brownfield, verification, or provenance invariant.

## Brownfield-first integration

Engineer supports two distinct workflows, for any platform:

1. **Greenfield:** choose a minimal template after defining the product, ownership, platform, data, accessibility, and release needs.
2. **Brownfield:** inspect existing build logic, module topology, versions, manifest, DI, state management, navigation, persistence, tests, CI, and local instructions before suggesting a change.

The brownfield workflow must not replace a target architecture merely because a template or external source uses another stack. Any migration requires explicit request, impact analysis, staged rollback/compatibility plan, and target-specific verification.

## Dependency and decision boundaries

- Platform facts (Android, Kotlin, web, game engine) belong to current official documentation or verified target evidence, not static memory.
- Dependency versions belong to a named target and verification date, not a general standard.
- The choice of Hilt/Koin, Retrofit/Ktor, Room/no local database, navigation mechanism, module layout, and sync model is conditional on a target application's requirements and conventions.
- Production authority stays with the owner. Repository policy, skills, templates, CI, and agents cannot elevate themselves to production authority.

## Evolution rules

Architectural changes are Tier 2 (see AGENTS.md): they require a written rationale, alternatives considered, affected zones, compatibility strategy, test/validation plan, and a fresh-context review. A change that alters the meaning of a standard or playbook must update affected cross-links in the same work package or explain why no update is needed.
