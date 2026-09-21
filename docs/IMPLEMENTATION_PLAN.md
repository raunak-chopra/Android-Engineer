# Engineer implementation plan

## Purpose

This plan stages a curated Android engineering workspace without claiming work that has not been demonstrated. It is a control document, not authorization to access external systems, publish artifacts, or change production.

All milestones use the approval sequence defined in [AGENTS.md](../AGENTS.md): Draft → Reviewed → Verified → Accepted → Owner-approved. “Released” applies only to a separately authorized external release.

## Program principles

- Start with target-project and primary-source evidence.
- Keep skills compact and routeable; put depth in focused references and tested helpers.
- Prefer brownfield alignment over template-driven replacement.
- Resolve volatile Android versions at execution time for a named target; do not fossilize them in general guidance.
- Build an evidence loop: guidance informs assets, assets are exercised by evaluations and a reference application, and findings correct the guidance.
- Treat independent review as a required gate, not a final polish pass.
- Keep any production or external action outside the implementation program until explicitly approved.

## Current implementation snapshot

| Milestone | Current evidence state |
| --- | --- |
| M0 | Verified and root Accepted locally on 2026-09-11; owner approval pending |
| M1 | Verified and root Accepted locally; three licenses confirmed, fourth source restricted, all four refs unchanged |
| M2–M3 | Fourteen skills and ranked 20-case routing corpus Verified and root Accepted locally |
| M4 | Three fresh generated profiles Verified on Windows and root Accepted locally; hosted CI proof pending |
| M5 | State-model reference app, unit tests, debug build, and unsigned R8 release build Verified and root Accepted locally; target scenarios deferred |
| M6 | CI definition reviewed and root Accepted as configuration; hosted execution and remaining follow-ups deferred |
| M7 | Draft implemented on 2026-09-15; context, routing, contract, and inspector checks pass locally; independent review pending |

No milestone is owner-approved or released yet. “Deferred” items need a real application or
an explicit follow-up package; they are not silently implied by this baseline.

## Execution allocation and review model

Assign separate implementer and independent-reviewer roles across bounded packages. Model choice is runtime-dependent and does not replace role independence or evidence. Root acceptance remains a separate decision: no author approves their own work.

Each package must identify its acceptance proof before implementation starts. A reviewer may return the work for repair repeatedly; it becomes Verified only after required repairs and checks complete. Do not batch every specialist skill or template into one unreviewable change.

## Milestones

### M0 — Workspace foundation

**Outcome:** repository-level instruction, architecture, contribution, standards, change-control, release, incident, and catalog documents establish the governance boundary.

**Deliverables:** root instructions, roadmap, architecture map, engineering and Android standards, operational playbooks, and an empty application catalog with a documented schema.

**Acceptance evidence:** internal links resolve; the documents agree on approval states, source priority, brownfield-first behavior, testing expectations, and production controls; no document claims a planned asset exists.

**Boundary:** M0 does not create active skills, templates, CI, real applications, releases, or production integrations.

### M1 — Source governance and validation infrastructure

**Outcome:** a local, reviewable record of upstream sources and deterministic checks for the library structure.

**Planned deliverables:** `.codex/sources/` registry and audit ledger, license notes, Windows-safe drift reporting, structural validation, broken-reference checks, and stale/volatile-claim reporting.

**Acceptance evidence:** each listed upstream source is pinned to a reviewed revision; checks are read-only by default; any rebaseline or write mode requires an explicit flag; scripts work on the supported Windows environment; no upstream content is overwritten automatically.

**License boundary:** a missing or conflicting license is itself a recorded
assessment. Engineer may synthesize attributed ideas in original prose but may
not copy source prose or code until a compatible license is independently
confirmed. Reviewed revisions must remain exact and drift-checkable.

### M2 — Core Android guidance

**Outcome:** a small routing layer and four core skills: project inspection/bootstrap, architecture, Compose UI, and testing-aware delivery.

**Deliverables:** concise, self-contained `SKILL.md` entrypoints, provenance
sections, and “when not to use” routing. Add focused references only when a
skill outgrows its activation budget or has genuinely conditional detail.

**Acceptance evidence:** trigger scopes do not collide; each skill respects brownfield evidence; no stale Android version pin is presented as universal; commands are verified or labelled unverified; structural validation and independent review pass.

**Boundary:** offline-first persistence, multi-module topology, DI framework, navigation library, and network stack remain conditional decisions.

### M3 — Specialist Android guidance

**Outcome:** focused skills for data and sync, networking, concurrency, adaptive navigation, testing, debugging/performance, accessibility/internationalization, security/release, mobile product design, and optional Kotlin Multiplatform.

**Delivery method:** ship in small review batches. Complete review, repair, and verification for one batch before starting the next.

**Acceptance evidence:** each skill has an explicit trigger, non-trigger, stable source hierarchy, verification path, and conflict rule with existing project conventions.

**Boundary:** Kotlin Multiplatform is optional and should not be authored as a mandatory Android baseline without a real target need.

### M4 — Selectable Android templates

**Outcome:** minimal, standard, and modular templates that represent increasing complexity without forcing it.

**Deliverables:** Windows-safe generator, documented complexity profiles,
embedded Gradle wrapper, CI compilation matrix, and a separately extended
reference fixture. DI, networking, and persistence remain deliberate follow-up
choices rather than generator switches without a product requirement.

**Template contracts:**

| Template | Intended scope | Required constraint |
| --- | --- | --- |
| Minimal | Single app module with Compose and a unit smoke test | No unnecessary data, navigation, or module abstraction |
| Standard | App, model boundary, feature module, and unit smoke test | Added boundaries are visible and intentionally small |
| Modular | Standard modules plus an included build and application convention plugin | Convention logic is demonstrated without pretending to enforce every future boundary |

**Acceptance evidence:** generated projects compile on the supported Windows
toolchain, CI compiles each profile on Linux, wrapper downloads are checksum
pinned, generated names are neutral, generator output works under common console
encodings, and the reference app supplies the deeper debug/release checks.

### M5 — Reference application and evaluations

**Outcome:** a deliberately small reference application and evaluation cases that exercise claimed workflows.

**Baseline evidence:** Compose rendering for loading/empty/success/error states,
a deterministic state reducer with unit tests, debug compilation, and an
unsigned R8/resource-shrunk release build. Navigation/restoration, persistence,
fake synchronization, instrumentation semantics, RTL/pseudolocale, and
screenshot coverage are deferred until a registered app has those requirements;
the specialist skills define their acceptance paths without forcing them into a
toy application.

**Acceptance evidence:** the application demonstrates rather than merely documents the relevant guidance; failures found by the app or evals result in corrections to the source guidance or an explicit limitation.

### M6 — CI and release controls

**Outcome:** repository checks that protect the curated library and pre-release evidence—not automatic production deployment.

**Baseline deliverables:** skill/link/JSON validation, routing evaluations,
read-only source drift checks, profile generation and compilation, reference
debug/unit/R8 release checks, and pull-request dependency review. Formatting,
dedicated secret scanning, release-evidence packaging, and R8 mapping artifact
retention remain named CI follow-ups before a real app release workflow exists.

**Acceptance evidence:** checks run from a clean environment; failure messages are actionable; secrets are not emitted; release controls require explicit inputs; no workflow can upload or promote production artifacts by default.

### M7 — Measured context efficiency

**Outcome:** reduce always-on instructions, skill-catalog metadata, activated
skill bodies, inspection output, and successful validation output without
weakening governance or Android decision quality.

**Deliverables:** versioned context budgets and baselines, deterministic budget
and skill-contract validators, a bounded Android project inspector, compact
validation output, 32 routing cases including adjacent-skill collisions, and
compressed governance and skill entrypoints. Exact UTF-8 bytes and Unicode
characters are the enforceable measures; byte-based token figures are estimates,
not billing measurements.

**Acceptance evidence:** `AGENTS.md` is at most 4,800 bytes; the 14 descriptions
total at most 3,200 characters; every entrypoint and router-plus-specialist set
meets its recorded ceiling; the library is at least 25% smaller than the recorded
69,362-byte baseline; routing, contracts, links, and JSON pass; inspector output
matches the reference and generated fixtures; and independent factual, doctrine,
and usability review records no unresolved blocking or important finding.

**Boundary:** M7 keeps `.codex/skills`, Android dependencies, templates, target
apps, production systems, and release behavior unchanged. Model tiering and
default subagent policy remain outside repository guidance.

## Cross-milestone quality gates

Before a milestone becomes Accepted:

- scope and status are stated accurately;
- source provenance and license implications are recorded where external material is used;
- no unverified command is represented as proven;
- relevant links, data formats, scripts, and examples are validated;
- applicable security, privacy, accessibility, internationalization, and release concerns were considered;
- independent review findings and repairs are recorded;
- unresolved limitations have an owner-visible disposition.

Before work crosses into production, the owner must explicitly approve the exact app, artifact/version, environment, destination, rollout scope, timing, and rollback owner. No milestone completion substitutes for this approval.

## Status vocabulary

- **Planned:** described here but not demonstrated in the working tree.
- **In progress:** an authorized bounded package is being implemented.
- **Verified:** checks and review evidence exist for the package.
- **Accepted:** root maintainer accepted the verified package.
- **Deferred:** intentionally postponed because the target need or evidence is absent.

Use these terms rather than vague phrases such as “mostly done” or “production-ready.”
