---
name: android-project-bootstrap
description: Create or change an Android Gradle project or template, modules, dependencies, convention plugins, JDK, AGP, or Kotlin setup. Exclude feature code.
---

## When to use

- Use for greenfield templates or requested Gradle, module, dependency, source-set, JDK, AGP, Kotlin, or KSP changes.

## When not to use

- Route feature boundaries to `android-architecture`, UI to `android-compose-ui`, and unresolved flows to `mobile-product-design`.
- Route runtime dependency behavior to its specialist and build failures to `android-debugging-performance`.
- Route signing, uploads, and rollout to `android-security-release`; require explicit approval.

## Workflow

1. Classify greenfield or brownfield. Inspect settings, included builds, wrapper, catalogs, build files, properties, manifests, CI, toolchains, and documented commands.
2. Record modules and dependency direction; preserve aliases, source sets, IDs, tests, and build conventions unless migration is requested.
3. For greenfield work, choose the smallest project shape. Add modules only for demonstrated ownership, reuse, target, or build-isolation boundaries.
4. Resolve and date AGP, Gradle, Kotlin, KSP, Compose, SDK, and library compatibility from current official guidance and the available toolchain.
5. Use the canonical dependency mechanism. Do not add DI, storage, networking, or offline infrastructure without a requirement.
6. Make the smallest change and run discovered wrapper tasks for configuration, compilation, tests, and relevant packaging. Report absent tasks.
7. Keep secrets and release identifiers out of source; signing, device, publishing, and production actions require explicit approval.

## Acceptance criteria

- The module graph matches scope and preserves conventions unless migration is recorded.
- Version choices are dated and sourced or explicitly unresolved.
- Discovered wrapper, build, and test evidence is recorded.
- No secrets, guessed IDs, publishing, or destructive migration is introduced.

## Provenance and maintenance

Sources: [Android build](https://developer.android.com/build), [version catalogs](https://docs.gradle.org/current/userguide/platforms.html), and audited registry IDs (2026-09-10). Re-verify: run `scripts/inspect-android-project.ps1 -Path <target> -Area Build` and only discovered wrapper tasks.
