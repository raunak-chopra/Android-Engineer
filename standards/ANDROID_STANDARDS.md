# Android standards

## Applicability and discovery

These standards guide curated Android work; they do not override a target application's explicit instructions or verified conventions. Before changing an Android project, inspect its local instructions, Gradle settings and build logic, version catalog, manifests, module topology, dependency injection, UI stack, navigation, persistence, test setup, CI, and release configuration.

Use current official Android and Kotlin documentation for platform or library facts. Do not present a dependency version, Android API level, build-plugin version, or experimental API as timeless guidance. Resolve it for the named target, verify it, and record the date.

## Architecture

- UI MUST expose lifecycle-safe observable state and make state transitions understandable.
- Prefer unidirectional data flow: events enter through a deliberate boundary, state flows outward, and side effects are explicit.
- Separate long-lived UI state from one-shot effects based on the target project's established semantics.
- Keep networking, database, file, and platform/library exception details below a repository or equivalent data boundary where appropriate; translate them into meaningful application-level outcomes.
- Add a domain/use-case layer only when it clarifies reused or genuinely complex business logic.
- Keep Android framework dependencies out of pure models and business logic where the target architecture allows it.
- Choose offline-first behavior, local persistence, feature APIs, and additional modules only when product requirements, ownership boundaries, build performance, or reuse justify them.

## Compose and adaptive UI

- Separate stateful screen/route coordination from stateless, previewable content where doing so improves testability and reuse.
- Model loading, empty, content, partial-data, permission-denied, and error states deliberately when they are meaningful to the user flow.
- Hoist state to the lowest common owner that needs it; do not create shared state merely to avoid parameters.
- Use stable keys for changing lazy-list content and avoid unnecessary composition work.
- Build adaptive layouts from available window space and user task needs, not device-name assumptions.
- Use semantic design tokens and Material guidance as inputs; do not turn aesthetic heuristics into universal rules.
- Treat interaction, keyboard, focus, screen-reader, and back-navigation behavior as part of the UI contract.

## Concurrency, data, and networking

- Respect lifecycle and structured-concurrency ownership. Do not launch unbounded work to hide cancellation or errors.
- Make dispatcher, retry, timeout, cancellation, and error semantics deliberate and testable.
- Keep remote models, cached/storage models, and UI models distinct when their lifecycles or constraints differ.
- Use fakes, controlled clocks, and deterministic fixtures for tests whenever possible.
- Do not choose Hilt, Koin, Retrofit, Ktor, Room, DataStore, WorkManager, Paging, or a synchronization strategy by default. Align with the target or document a target-specific choice.

## Testing and verification

- Select tests according to the changed contract: JVM/unit, repository/DAO integration, ViewModel/state, stateless Compose, navigation/DI integration, instrumented device, screenshot, macrobenchmark, or release build.
- Test Compose behavior through semantics and user-observable behavior first; use test tags deliberately rather than as the only contract.
- Include failure, cancellation, restoration, loading, empty, and permission outcomes where the feature supports them.
- Run a release-mode/R8 build when a change can affect shrinking, reflection, serialization, manifest behavior, or distribution output.
- Do not claim device compatibility based only on a local compile or a single emulator run.

## Accessibility and internationalization

- Ensure actionable controls have clear semantics, meaningful labels, and accessible touch targets.
- Verify focus order, TalkBack behavior for critical flows, keyboard behavior where applicable, contrast, and error announcement behavior.
- Use resources, plural handling, locale-aware formatting, and RTL-aware layout behavior.
- Test pseudolocale and RTL behavior when a screen contains user-facing text or directional layout.
- Never lower accessibility requirements to satisfy a visual mood or an external design heuristic.

## Security, performance, and release safety

- Request only the permissions required by a documented user-facing capability and handle denial gracefully.
- Avoid logging tokens, personal data, private URLs, or sensitive payloads.
- Diagnose performance with evidence such as traces, benchmarks, or reproducible measurements; do not optimize based only on intuition.
- Preserve R8/ProGuard mapping files, artifact metadata, and source revision for a real release.
- Build an Android App Bundle for a Google Play release unless an approved distribution requirement calls for another artifact.
- Never invent a `versionCode`, signing identity, Play track, rollout percentage, production target, or rollback setting.

See [engineering standards](ENGINEERING_STANDARDS.md), [change control](../playbooks/CHANGE_CONTROL.md), and [releases](../playbooks/RELEASES.md) for cross-cutting requirements.
