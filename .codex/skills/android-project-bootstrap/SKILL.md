---
name: android-project-bootstrap
description: Create, inspect, or safely evolve Android Gradle project structure, minimal project templates, modules, dependency declarations, convention plugins, and local build setup. Use for greenfield bootstrap or build-system changes; do not use for ordinary feature code.
---

# Overview

Bootstrap only what the product and repository need. A template is a starting point, not authority over an existing project. Resolve version-sensitive choices at execution time and leave a reproducible, compilable project behind.

## When to use

- Creating a new Android application or library from an agreed product brief.
- Adding or reshaping modules, convention plugins, source sets, or dependency management.
- Diagnosing project sync, JDK, AGP, Kotlin, KSP, or Gradle-environment incompatibility.
- Updating build configuration when the user has requested that change.

## When not to use / routing

- Route feature architecture and boundaries to `android-architecture`.
- Route UI implementation to `android-compose-ui`; route product flows to `mobile-product-design` first.
- Route dependency-specific network, persistence, or concurrency behavior to the corresponding specialist.
- Route build failures after configuration changes to `android-debugging-performance` as well as this skill.
- Do not use for release upload, signing-key handling, or Play rollout; route to `android-security-release` and require authorization.

## Evidence-oriented workflow

1. Determine whether the task is greenfield or brownfield. For an existing project, inspect the settings file, included builds, wrapper, version catalog, root and module build files, `gradle.properties`, manifests, CI, Java/Kotlin toolchain declarations, and documented commands before editing.
2. Record the current module graph and dependency direction. Preserve established plugin aliases, catalogs, source-set conventions, namespace/application IDs, test setup, and build cache strategy unless migration is explicitly requested.
3. For greenfield work, choose the smallest shape that supports the requested behavior: one app module may be enough. Add core, feature, benchmark, or convention-plugin modules only when an independent boundary, build isolation, or target requires them.
4. Resolve AGP, Gradle, Kotlin, KSP, Compose, compile SDK, and library versions from current official compatibility guidance and the project’s available toolchain. Date volatile choices. Never copy a stale version pin from a sample repository.
5. Add dependencies through the project’s canonical mechanism. Avoid unused dependencies, duplicate plugin declarations, forced repository changes, and generated names tied to another sample application. Do not add DI, persistence, networking, or offline-first infrastructure without a demonstrated requirement.
6. Make the smallest configuration change, then use the repository’s discovered Gradle wrapper and documented task(s) to verify configuration, compilation, unit tests, and relevant packaging. If the wrapper or task is absent, report that rather than inventing a working command.
7. Keep signing credentials, tokens, production endpoints, Play identifiers, and deployment settings out of source. Release mutations, device operations, and publishing require explicit approval from the user immediately before execution.

## Acceptance criteria

- The resulting module and dependency graph matches the requested scope and has no accidental sample-specific names.
- Existing project conventions are preserved unless a migration decision is recorded.
- Version choices have a dated source or are explicitly unresolved pending environment discovery.
- The wrapper/configuration check and the narrowest relevant build/test checks are recorded with outputs.
- No secrets, signing material, guessed IDs, publishing actions, or destructive migrations were introduced.

## Provenance and maintenance

This skill absorbs the conditional modularization and convention-plugin ideas from the audited `dpconde/claude-android-skill` commit `edfca5e36ceb7532708c28fd2fd5215a9f01d105`, the project-inspection discipline from `rcosteira79/android-skills` commit `0cdfc74ad89d5be0141807f6974d5ee37412d6f7`, and the bootstrap/brownfield boundaries from `Drjacky/claude-android-ninja` commit `baa6e883e9355945838a51ae628e3747dbe6c764`, all reviewed 2026-09-10. Prefer current [Android build guidance](https://developer.android.com/build) and [Gradle version catalogs](https://docs.gradle.org/current/userguide/platforms.html); verify compatibility against the target files before each use. Re-verify with `Get-ChildItem -Force -Recurse -File | Where-Object { $_.Name -match '^(settings\.gradle(\.kts)?|build\.gradle(\.kts)?|gradlew(\.bat)?|libs\.versions\.toml)$' }` and then only the project-documented wrapper tasks.
