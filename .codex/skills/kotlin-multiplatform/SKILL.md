---
name: kotlin-multiplatform
description: Evaluate, design, implement, or test Kotlin Multiplatform shared code with Android and other Kotlin targets, including source-set boundaries, platform APIs, Gradle integration, interoperability, and target-specific verification. Use only when multiple targets or shared-code value is demonstrated.
---

# Overview

Share code where the behavior and ownership are genuinely common, and keep platform-specific APIs behind clear interfaces or source sets. Treat target availability, toolchain compatibility, and interoperability as constraints to verify—not promises inferred from a sample.

## When to use

- Adding or changing `commonMain`/platform source sets, shared domain/data code, expect/actual declarations, or KMP module boundaries.
- Assessing whether an Android feature or library should be shared with iOS or another Kotlin target.
- Debugging KMP Gradle, source-set, dependency, native interop, or target test failures.

## When not to use / routing

- Route Android-only work to the Android specialist skills; do not introduce KMP for a single target without a concrete reuse or roadmap requirement.
- Route Gradle/toolchain setup to `android-project-bootstrap`, shared state boundaries to `android-architecture`, and async semantics to `android-concurrency`.
- Route Android UI to `android-compose-ui`; do not assume Compose Multiplatform or native UI targets are interchangeable.
- Do not add an unavailable target, platform dependency, or publishing action based on an unverified example.

## Evidence-oriented workflow

1. List the actual targets, owners, release cadence, shared behavior, and platform-specific differences. Compare the cost of sharing, testing, and interop with a small duplicated implementation; record the decision and its assumptions.
2. Inspect settings, KMP plugins, source sets, dependency declarations, compiler/toolchain versions, expect/actual or interface seams, tests, CI matrices, and existing platform adapters. Preserve established topology in brownfield work.
3. Keep shared modules focused on platform-neutral contracts and logic. Put Android/iOS UI, lifecycle, storage, permissions, threading constraints, and platform SDK types behind interfaces or target-specific implementations. Avoid leaking a platform type through `commonMain` merely to reduce a short-term wrapper.
4. Choose a dependency only after verifying that it supports every required target and the project’s toolchain. Date volatile Kotlin, plugin, compiler, and library compatibility claims. Keep platform-specific dependency versions and initialization in their target source sets.
5. Define error, concurrency, memory, serialization, and resource behavior across targets. Check native interop naming, nullability, suspend/Flow consumption, binary compatibility, and cancellation rather than assuming JVM behavior transfers unchanged.
6. Test shared logic in the common source set and platform adapters on each supported target. Run the project’s confirmed Gradle tasks for the available target matrix; if a target/toolchain is unavailable, report the unverified path and do not claim cross-platform success.
7. Review packaging, size, startup, debugging, and release implications before publishing a shared artifact. External repository publication, signing, or production changes require `android-security-release` and explicit authorization.

## Acceptance criteria

- The sharing decision has a demonstrated multi-target benefit and named platform boundaries.
- `commonMain` contains no accidental platform API leakage, and target adapters have explicit contracts and tests.
- Toolchain/dependency compatibility is current, dated, and verified for each available target.
- Common behavior and target-specific behavior are tested independently; unavailable targets are reported.
- No KMP migration, publication, or release mutation occurs without a reviewed scope and explicit approval.

## Provenance and maintenance

This skill is grounded in current [Kotlin Multiplatform documentation](https://www.jetbrains.com/help/kotlin-multiplatform-dev/multiplatform.html) and [Android’s Kotlin Multiplatform guidance](https://developer.android.com/kotlin/multiplatform), reviewed 2026-09-10, with source-set and boundary patterns informed by the audited `rcosteira79/android-skills` commit `0cdfc74ad89d5be0141807f6974d5ee37412d6f7` and `Drjacky/claude-android-ninja` commit `baa6e883e9355945838a51ae628e3747dbe6c764`. Version and target claims remain volatile and community prose is not copied. Re-verify with `Get-ChildItem -Force -Recurse -File | Where-Object { $_.Name -match '(settings\.gradle|build\.gradle|commonMain|androidMain|iosMain|jvmMain|nativeMain|\.def$)' }` and inspect the actual target matrix and toolchain before giving KMP-specific commands.

