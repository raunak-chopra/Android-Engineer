---
name: android-router
description: Route Android and Kotlin mobile work to the smallest relevant specialist skill after inspecting the repository; use for triage, unfamiliar Android projects, or requests spanning build, UI, data, tests, performance, security, and release. Do not use for non-Android work.
---

# Overview

Use this skill as the entry point for Android work. Establish what the repository actually contains before loading or applying a specialist skill. Keep the active context narrow: one primary specialist and only the adjacent skills needed by the change.

## When to use

- A request concerns an Android app, Android library, APK, Kotlin Multiplatform project with an Android target, or Android build tooling.
- The correct specialist is unclear, or a change crosses more than one Android concern.
- A new session is entering an unfamiliar mobile repository.

## When not to use / routing

- Use `android-project-bootstrap` for Gradle, module, dependency, JDK, or new-project setup.
- Use `android-architecture` for boundaries, state ownership, repositories, domain logic, or modularization decisions.
- Use `android-compose-ui` for Compose implementation or review; use `mobile-product-design` first when the user has not defined the flow or screen behavior.
- Use `android-data-and-sync` for local storage, caching, synchronization, paging, or WorkManager.
- Use `android-networking` for HTTP clients, serialization, authentication transport, retries, or TLS configuration.
- Use `android-concurrency` for coroutines, Flow, cancellation, dispatchers, or state/effect semantics.
- Use `android-navigation-adaptive` for routes, deep links, back behavior, window size, foldables, or list-detail layouts.
- Use `android-testing` for test strategy, fixtures, instrumentation, semantics tests, screenshots, or regression tests.
- Use `android-debugging-performance` for crashes, build failures, jank, memory, startup, battery, or trace-based diagnosis.
- Use `android-accessibility-i18n` for TalkBack, semantics, touch targets, localization, RTL, font scaling, or pseudolocales.
- Use `android-security-release` for permissions, secrets, data protection, signing, R8, Play artifacts, or release operations.
- Use `kotlin-multiplatform` when shared code or multiple Kotlin targets are part of the request.
- Route compiled APK/AAB analysis to an installed `android-reverse-engineering` skill when available; otherwise report that compiled-artifact analysis is unsupported by this library.
- For XML/Views implementation, preserve the target repository's existing approach and use current official Android guidance. `android-compose-ui` is not a Views/XML migration mandate.
- Do not use this router for generic Kotlin, backend, web, or iOS-only work.

## Local policy anchors

Repository-wide constraints live in root `AGENTS.md`. Apply
`standards/ANDROID_STANDARDS.md`, select checks from
`standards/ENGINEERING_STANDARDS.md`, and use `playbooks/RELEASES.md` for any
artifact or store work. These repository-root policy homes override duplicated
summaries in specialist skills.

## Evidence-oriented workflow

1. Classify the request as greenfield, brownfield, migration, defect, review, or release work. Record whether it changes user data, credentials, device state, or external systems.
2. Inspect the repository before making architecture or version assumptions. Locate the settings file, Gradle wrapper, version catalog, build files, manifests, source and test roots, CI configuration, documentation, and any existing agent instructions. A missing conventional path is evidence of absence only after the repository has been searched.
3. Identify the active stack from files rather than names: XML or Compose, navigation library and version, DI approach, persistence, network client, state container, module topology, test frameworks, and available targets. Record unknowns as unknown.
4. Select the smallest specialist set. Prefer the repository’s established conventions in brownfield work. Do not introduce offline-first storage, a new DI framework, a new navigation library, or extra modules merely because a reference architecture recommends them.
5. Obey explicit user and target-repository instructions for scope and local constraints. Use current official Android/Kotlin documentation to resolve platform facts, then locally verified community techniques and finally design heuristics. If a local constraint conflicts with a platform requirement, report the incompatibility instead of silently overriding either source. Date volatile claims and label anything not verified for the target.
6. Give the specialist the observed file paths, constraints, requested outcome, and verification surface. Keep unrelated skills unloaded.
7. Before any production, release, device-data, credential, or destructive mutation, stop for explicit authorization. A user request to implement code does not by itself authorize publishing, signing, deleting, or uploading.
8. After implementation, route to `android-testing` and any risk-specific specialist for evidence. Report the exact checks that ran, their results, and anything unavailable in the environment.

## Acceptance criteria

- The chosen specialist is justified by repository evidence and the user’s requested outcome.
- Existing conventions and compatibility constraints are recorded before changes are proposed.
- Unverified version, command, device, and release assumptions are not presented as facts.
- The work has a bounded verification plan and an explicit stop point for high-impact mutations.
- The final report names unresolved evidence gaps and routes follow-up work to a specific skill.

## Provenance and maintenance

This router synthesizes the audited structure of `dpconde/claude-android-skill` (commit `edfca5e36ceb7532708c28fd2fd5215a9f01d105`), `rcosteira79/android-skills` (commit `0cdfc74ad89d5be0141807f6974d5ee37412d6f7`), and `Drjacky/claude-android-ninja` (commit `baa6e883e9355945838a51ae628e3747dbe6c764`), reviewed 2026-09-10, with original routing guidance informed by [Android skills](https://developer.android.com/tools/agents/android-skills) and [Android architecture](https://developer.android.com/topic/architecture). These community sources are inspiration, not instructions to copy. Re-verify volatile platform claims against current official documentation and the target repository before each use; a safe first check is `Get-ChildItem -Force -Recurse -File | Where-Object { $_.Name -in @('settings.gradle','settings.gradle.kts','gradlew','gradlew.bat') }`.
