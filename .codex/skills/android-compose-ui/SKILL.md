---
name: android-compose-ui
description: Build or review Jetpack Compose and Material 3 screens, state, effects, previews, semantics, and adaptive UI. Exclude Views-only work unless migration is explicit.
---

## When to use

- Use for Compose screens, components, themes, previews, state/effects, recomposition, semantics, or adaptive Material UI.

## When not to use

- Route unresolved flows to `mobile-product-design`, cross-layer state to `android-architecture`, concurrency to `android-concurrency`, and route graphs to `android-navigation-adaptive`.
- Route focused accessibility/localization to `android-accessibility-i18n` and test strategy to `android-testing`.
- Do not use for Views/XML-only, graphic asset, or web work.

## Workflow

1. Inspect Compose versions, theme/tokens, navigation entry points, state holders, resources, and test utilities; match local patterns.
2. Define inputs, intents, rendered states, retry, and recreation. Keep route/content separation: route or container code wires state/events; content stays previewable.
3. Hoist state to its lowest coordinator. Keep durable state outside local `remember`; use saveable state only for small UI state that must survive recreation.
4. Collect state with lifecycle awareness and stable effect keys. Avoid work in composition, global scopes, unbounded launches, and accidental effect restarts.
5. Use project tokens and adaptive constraints; preserve insets, large text, touch targets, focus, contrast, and descriptions.
6. Expose user-visible semantics; use test tags only when semantics cannot express a stable contract.
7. Verify representative previews, state transitions, semantics behavior, and controlled screenshots using discovered tasks.

## Acceptance criteria

- States/events are explicit and composables hide no business or transport logic.
- Recreation does not lose required state, duplicate subscriptions, or repeat unsafe effects.
- UI follows project tokens and remains adaptive and accessible.
- Behavior tests prove the primary interaction; visual tests are deterministic.

## Provenance and maintenance

Sources: [Compose](https://developer.android.com/develop/ui/compose), [state](https://developer.android.com/develop/ui/compose/state), and audited registry IDs (2026-09-10). Re-verify: inspect target build/catalog, theme, state, and test files before version-specific advice.
