---
name: android-architecture
description: Design or review Android application boundaries, UI state, repositories, domain logic, dependency direction, and modularization. Use when behavior crosses layers or a team needs an architecture decision; do not force this onto a simple local edit.
---

# Overview

Make data ownership, state transitions, and dependency direction explicit. Choose the lightest architecture that preserves the required behavior, testability, lifecycle safety, and future change boundary.

## When to use

- Establishing or reviewing app, feature, core, data, domain, or presentation boundaries.
- Deciding where state, side effects, mapping, validation, and error translation belong.
- Assessing offline-first, modularization, repository, DI, or state-management proposals.
- Refactoring architecture in response to a defect, scale, ownership, or build-time constraint.

## When not to use / routing

- Route Gradle/module mechanics to `android-project-bootstrap`.
- Route Compose-specific state/effects and semantics to `android-compose-ui`; route coroutine semantics to `android-concurrency`.
- Route persistence/sync boundaries to `android-data-and-sync` and transport concerns to `android-networking`.
- Route a new user flow or information hierarchy to `mobile-product-design` before choosing implementation structure.
- Do not create a domain layer, repository abstraction, feature module, DI framework, or offline cache when the requirement and evidence do not justify its cost.

## Evidence-oriented workflow

1. Capture the requested user behavior and non-functional constraints: lifecycle, offline needs, concurrency, privacy, performance, platform targets, team ownership, and expected change frequency.
2. Inspect the current module/package graph, UI entry points, ViewModels or controllers, repositories/data sources, models, DI setup, persistence, network clients, and tests. Draw the actual dependency direction before proposing an idealized one.
3. Define a single owner for each durable state and each transient effect. Prefer observable UI state that represents loading, empty, success, partial, and error outcomes; keep one-shot events distinct from durable state.
4. Keep platform/library failures below a repository or use-case boundary and expose stable domain-facing errors where callers need them. Keep mapping and validation close to the boundary that owns the representation. Do not let UI code know transport or database details.
5. Use a domain layer only for reusable or genuinely complex business rules. Keep simple transformations near their consumer. Make offline-first conditional: choose it when product behavior, latency, reliability, or conflict requirements demand local truth; otherwise avoid speculative storage and sync.
6. Start with packages or a modest module graph. Split modules only for a demonstrated dependency boundary, independent ownership, build isolation, target separation, or reusable artifact. `api`/`impl` pairs are optional, not a default feature shape.
7. Preserve the existing DI, navigation, state, and persistence mechanisms in brownfield work. If a migration is requested, document an incremental seam, compatibility period, rollback path, and evidence that the new approach solves the stated problem.
8. Validate the contract at the smallest layers that prove it, then run affected integration/build checks. Record rejected alternatives and evidence, not just the preferred diagram.

## Acceptance criteria

- State owners, side-effect owners, dependency direction, and error boundaries are named.
- Every new abstraction or module has a concrete consumer, constraint, or measured benefit.
- Lifecycle, cancellation, empty/error/partial states, and retry behavior are addressed where relevant.
- Brownfield conventions are preserved or an explicit migration decision exists.
- Tests or other evidence exercise the proposed boundary, and unresolved tradeoffs are visible to the reviewer.

## Provenance and maintenance

This skill synthesizes official [Android architecture recommendations](https://developer.android.com/topic/architecture), [UI-layer guidance](https://developer.android.com/topic/architecture/ui-layer), and [data-layer guidance](https://developer.android.com/topic/architecture/data-layer), checked 2026-09-10, with conditional boundary patterns observed in the audited `dpconde/claude-android-skill` commit `edfca5e36ceb7532708c28fd2fd5215a9f01d105`, `rcosteira79/android-skills` commit `0cdfc74ad89d5be0141807f6974d5ee37412d6f7`, and `Drjacky/claude-android-ninja` commit `baa6e883e9355945838a51ae628e3747dbe6c764`. Re-verify with `Get-ChildItem -Force -Recurse -File | Where-Object { $_.Extension -in @('.kt','.kts','.java') }` plus targeted reads of the project’s actual boundaries; re-check official guidance when platform behavior changes.

