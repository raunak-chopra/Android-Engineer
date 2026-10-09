---
name: android-router
description: Route unfamiliar or cross-cutting Android work after repository inspection. Use for Android triage; exclude generic Kotlin, backend, web, and iOS-only work.
---

## When to use

- Use for an unfamiliar Android repository, uncertain routing, or work spanning multiple Android concerns.
- Skip the router when one specialist is already unambiguous.

## When not to use

- Route Gradle/modules to `android-project-bootstrap`; boundaries to `android-architecture`; Compose to `android-compose-ui`; unresolved flows to `mobile-product-design`.
- Route storage/sync to `android-data-and-sync`; HTTP/TLS to `android-networking`; coroutines/Flow to `android-concurrency`; routes/windows to `android-navigation-adaptive`.
- Route tests to `android-testing`; crashes/performance to `android-debugging-performance`; TalkBack/locales to `android-accessibility-i18n`; permissions/signing/releases to `android-security-release`; shared targets to `kotlin-multiplatform`.
- Route compiled APK/AAB analysis to an installed `android-reverse-engineering` skill when available; otherwise report that compiled-artifact analysis is unsupported by this library.
- Preserve Views/XML; Compose guidance is not a migration mandate. Do not use for generic Kotlin, backend, web, or iOS-only work.

## Workflow

1. Classify the work and note effects on user data, credentials, devices, or external systems.
2. Inspect instructions, settings, wrapper, catalogs, builds, manifests, source/tests, CI, and docs. Use `scripts/inspect-android-project.ps1` when available.
3. Identify UI, navigation, DI, persistence, network, state, modules, tests, and targets from files; record unknowns as unknown.
4. Select the smallest specialist set and preserve brownfield conventions. Do not add frameworks or modules without a demonstrated need.
5. Resolve volatile facts from current official Android/Kotlin sources and date them. Report conflicts instead of silently overriding local or platform constraints.
6. Pass observed paths, constraints, outcome, and verification surface to the specialist; keep unrelated skills unloaded.
7. Stop before production, release, device-data, credential, signing, deletion, or upload mutations until exact authorization exists; then report checks and gaps.

## Acceptance criteria

- Repository evidence justifies the chosen specialist and records compatibility constraints.
- Versions, commands, devices, and releases are verified or explicitly uncertain.
- The verification plan is bounded and high-impact mutations have an authorization stop.
- The report names evidence gaps and routes follow-up work.

## Provenance and maintenance

Sources: [Android agent skills](https://developer.android.com/tools/agents/android-skills), [architecture](https://developer.android.com/topic/architecture), and audited IDs in `.codex/sources/registry.json` (2026-09-10). Re-verify: run `scripts/inspect-android-project.ps1 -Path <target>` and inspect its cited files.
