---
name: android-testing
description: Design Android unit, integration, Compose semantics, screenshot, instrumentation, accessibility, and release tests. Use for regression evidence, not coverage targets.
---

## When to use

- Use for test selection, regression coverage, fixtures, semantics, screenshots, instrumentation, release checks, or flaky-test diagnosis.

## When not to use

- Route root cause and performance measurement to `android-debugging-performance`, accessibility audits to `android-accessibility-i18n`, and harness/build setup to `android-project-bootstrap`.
- Do not mirror private implementation, depend on live services, or chase a coverage target.

## Workflow

1. State behavior, risk, and failure mode. Reproduce bugs and add a focused failing test when safe; label justified exceptions.
2. Inspect frameworks, source sets, fixtures, fakes, device matrix, screenshots, naming, and cleanup; reuse the local harness.
3. Choose the narrowest test that observes the contract: JVM logic, repository/DAO, state holder, Compose semantics, navigation/instrumented, controlled screenshot, or release/device.
4. Control time, dispatchers, randomness, locale, density, network, images, animations, and stores. Prefer boundary fakes; avoid sleeps when signals or virtual time exist.
5. Cover relevant loading, empty, partial, error, retry, cancellation, permission, recreation, offline, and duplicate-action behavior through outcomes and semantics.
6. Stabilize screenshot dimensions, fixtures, time, fonts, and animations; review intentional diffs.
7. Run confirmed narrow checks, then risk-based integration/release checks. Record command, environment, result, and unavailable coverage.

## Acceptance criteria

- Tests prove stated behavior and fail for the original defect or missing contract.
- Fixtures are deterministic, isolated, privacy-safe, and offline from production.
- Relevant lifecycle/error/accessibility/localization/restoration branches are covered or scoped out.
- Broader checks follow risk; flakes have reproducible evidence rather than hidden retries.

## Provenance and maintenance

Sources: [Android testing](https://developer.android.com/training/testing), [Compose testing](https://developer.android.com/develop/ui/compose/testing), and audited registry IDs (2026-09-10). Re-verify: inspect target test source sets, fixtures, devices, and actual Gradle tasks.
