---
name: android-architecture
description: Design Android boundaries, UI state, repositories, domain logic, dependency direction, and modularization. Use for cross-layer architecture decisions.
---

## When to use

- Use when behavior crosses layers or state, effects, mapping, repositories, DI, modules, or domain ownership need a decision.

## When not to use

- Route Gradle mechanics to `android-project-bootstrap`, Compose to `android-compose-ui`, coroutines to `android-concurrency`, data/sync to `android-data-and-sync`, and transport to `android-networking`.
- Define unresolved user flows with `mobile-product-design` first.
- Skip architecture expansion for a simple local edit; do not add layers, modules, DI, or caches without evidence.

## Workflow

1. Capture behavior plus lifecycle, offline, concurrency, privacy, performance, target, ownership, and change constraints.
2. Inspect modules, UI entry points, state holders, repositories, models, DI, storage, network, and tests; map actual dependency direction.
3. Name one owner for each durable state and transient effect. Model meaningful loading, empty, partial, success, and error outcomes.
4. Translate platform, transport, and storage failures below stable boundaries; keep representation mapping with its owner.
5. Add a domain layer only for reused or complex rules. Add modules only for demonstrated dependency, ownership, target, reuse, or build isolation.
6. Preserve brownfield DI, navigation, state, and storage. For migration, define a seam, compatibility period, rollback, and proof of benefit.
7. Validate the smallest boundary that proves the decision, then affected integration/build paths; record alternatives and evidence.

## Acceptance criteria

- State/effect owners, dependency direction, and error boundaries are explicit.
- Every abstraction or module has a consumer, constraint, or measured benefit.
- Brownfield conventions are preserved or migration and rollback are recorded.
- Tests or evidence exercise the boundary and expose unresolved tradeoffs.

## Provenance and maintenance

Sources: [Android architecture](https://developer.android.com/topic/architecture) and audited registry IDs (2026-09-10). Re-verify: inspect the target's settings, build files, state holders, repositories, and tests before changing boundaries.
