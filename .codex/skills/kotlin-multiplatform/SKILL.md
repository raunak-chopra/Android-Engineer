---
name: kotlin-multiplatform
description: Evaluate or build Kotlin Multiplatform shared code, source sets, platform APIs, Gradle integration, interop, and target tests when multi-target value exists.
---

## When to use

- Use for demonstrated multi-target sharing, source sets, expect/actual, platform adapters, interop, KMP Gradle, or target failures.

## When not to use

- Route Android-only work to Android specialists; Gradle setup to `android-project-bootstrap`; shared state to `android-architecture`; async semantics to `android-concurrency`; Android UI to `android-compose-ui`.
- Do not introduce KMP for one target or assume Compose Multiplatform/native UI interchangeability.
- Do not add unavailable targets, dependencies, or publishing from an unverified example.

## Workflow

1. List actual targets, owners, releases, shared behavior, and platform differences; compare sharing/test/interop cost with small duplication.
2. Inspect settings, plugins, source sets, dependencies, toolchains, expect/actual or interface seams, tests, CI, and adapters; preserve brownfield topology.
3. Keep shared modules platform-neutral. Put UI, lifecycle, storage, permissions, threading, and SDK types behind target-specific interfaces/implementations.
4. Verify every dependency and toolchain against each supported target; date volatile compatibility and keep platform setup in target source sets.
5. Define cross-target error, concurrency, memory, serialization, resource, naming, nullability, Flow/suspend, binary, and cancellation behavior.
6. Test common logic and each supported target adapter with confirmed tasks; report unavailable targets without claiming success.
7. Review packaging, size, startup, debugging, and release effects; publishing/signing/production requires security review and explicit approval.

## Acceptance criteria

- Sharing has demonstrated multi-target benefit and named platform-specific boundaries.
- `commonMain` avoids platform leakage; adapters have contracts and tests.
- Compatibility is dated and verified for each available target.
- Common/target behavior is tested separately; unavailable targets and approval-gated mutations are explicit.

## Provenance and maintenance

Sources: [Kotlin Multiplatform](https://www.jetbrains.com/help/kotlin-multiplatform-dev/multiplatform.html), [Android KMP](https://developer.android.com/kotlin/multiplatform), and audited registry IDs (2026-09-10). Re-verify: inspect target source sets, adapters, toolchains, CI target matrix, and tests.
