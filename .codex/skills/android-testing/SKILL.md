---
name: android-testing
description: Plan and implement Android unit, integration, Compose semantics, screenshot, instrumentation, accessibility, and release verification. Use when a behavior needs evidence or a regression needs a durable test; do not optimize for a coverage number alone.
---

# Overview

Choose the smallest deterministic test that proves the contract, then add broader tests only for integration risk. A passing test is evidence about its scope, not proof that untested layers or devices are correct.

## When to use

- Adding a feature or regression test, choosing test levels, or reviewing test gaps.
- Testing ViewModel/state transitions, repositories, migrations, navigation, Compose semantics, screenshots, or release behavior.
- Diagnosing flaky, slow, environment-dependent, or misleading tests.

## When not to use / routing

- Route root-cause investigation and performance measurement to `android-debugging-performance` while keeping the needed regression test here.
- Route accessibility and localization audits to `android-accessibility-i18n`.
- Route build/test dependency or module setup to `android-project-bootstrap`.
- Do not add tests that merely mirror implementation details, depend on live services, or chase an arbitrary coverage target.

## Evidence-oriented workflow

1. State the behavior, risk, and failure mode. For a bug, reproduce it and create a focused test that fails for the observed reason before changing production code, unless the change is generated/configuration-only or an exploratory spike; label such exceptions.
2. Inspect the project’s test frameworks, fixtures, fake implementations, test source sets, device matrix, screenshot tooling, and existing naming/cleanup conventions. Reuse the local harness rather than adding a competing one.
3. Select the narrowest level that can observe the contract: pure JVM test for deterministic logic, repository/DAO integration test for storage mapping, state-holder test for transitions, Compose semantics test for user-observable UI, navigation/instrumented test for Android integration, screenshot test for a controlled visual contract, and release/device test for packaging or platform behavior.
4. Prefer hand-written fakes or approved test doubles at boundaries. Control clock, dispatcher, randomness, locale, density, network, images, animations, and database fixtures. Never use sleeps to manufacture synchronization when an awaitable signal or virtual time is available.
5. Cover meaningful states and failure branches: loading, empty, success, partial data, retry, cancellation, permission denial, malformed input, process recreation, offline, and duplicate action where applicable. Assert semantics, outcomes, and accessibility—not private implementation structure.
6. Keep screenshot tests deterministic with fixed dimensions, stable fixtures, controlled time, and known font/animation behavior. Treat pixel differences as a signal to investigate, not an automatic approval or rejection; review intentional visual changes.
7. Run the project’s documented narrow checks first, then the affected integration/release checks after confirming their task names and required emulator/device. Record command, environment, result, and unavailable coverage. Use coverage as a diagnostic signal, not a correctness definition.

## Acceptance criteria

- The test proves a stated contract and would fail for the original defect or missing behavior.
- Fixtures are deterministic, isolated, privacy-safe, and independent of live production services.
- Relevant lifecycle, error, accessibility, localization, and restoration branches are covered or explicitly out of scope.
- Broader build/device/release checks are selected based on risk and their actual results are reported.
- Flakes have a reproducible symptom and root-cause hypothesis; retries are not used to hide them.

## Provenance and maintenance

This skill uses official [Android testing guidance](https://developer.android.com/training/testing), [Compose testing](https://developer.android.com/develop/ui/compose/testing), and [testable architecture](https://developer.android.com/topic/architecture/test) documentation reviewed 2026-09-10. It synthesizes semantics-first testing, fake boundaries, and evidence ladders audited in `rcosteira79/android-skills` commit `0cdfc74ad89d5be0141807f6974d5ee37412d6f7` and `Drjacky/claude-android-ninja` commit `baa6e883e9355945838a51ae628e3747dbe6c764`; no community prose is copied. Re-verify with `Get-ChildItem -Force -Recurse -File | Where-Object { $_.FullName -match '(test|androidTest|benchmark|screenshot)' }` and inspect the project’s actual test tasks and fixtures before claiming a check is available.

