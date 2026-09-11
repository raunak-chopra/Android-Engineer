---
name: android-compose-ui
description: Implement or review Jetpack Compose UI, Material 3 theming, state hoisting, previews, semantics, and UI behavior across Android form factors. Use for Compose screens and components; do not introduce Compose into an XML project without an explicit migration decision.
---

# Overview

Build UI from an agreed user flow and explicit states. Keep rendering deterministic and previewable, keep effects lifecycle-aware, and make semantics and adaptive behavior part of the component contract.

## When to use

- Creating or changing a Compose screen, component, theme, or preview.
- Reviewing recomposition, state ownership, side effects, UI events, or Compose performance.
- Adding semantics, test tags, adaptive layout behavior, or Material 3 design tokens.

## When not to use / routing

- Use `mobile-product-design` when the user goal, flow, primary action, or empty/error states have not been decided.
- Use `android-architecture` for cross-layer state ownership and `android-concurrency` for coroutine/Flow semantics.
- Use `android-navigation-adaptive` for route graphs, deep links, back stack, and window-level navigation.
- Use `android-accessibility-i18n` for a focused accessibility or localization audit; use `android-testing` for test strategy.
- Do not use for Views/XML-only changes, graphic assets, or a web UI.

## Evidence-oriented workflow

1. Inspect the existing Compose version, theme, design tokens, navigation entry points, state holders, resource conventions, and test utilities. Match local patterns before adding a new one.
2. Define the screen contract: inputs, user intents, rendered states (loading, empty, content, partial, error), retry behavior, and what survives recreation. Keep route/container code responsible for state collection and event wiring; keep content components as stateless as practical.
3. Hoist state to the lowest owner that must coordinate it. Use saveable state only for small UI state that should survive recreation, and keep durable/business state in an appropriate state holder. Do not mirror the same source of truth in several `remember` values.
4. Collect observable state with lifecycle awareness appropriate to the project and scope effects to a stable key and lifecycle owner. Avoid work during composition, unbounded launches, global scopes, and effect blocks that silently restart due to unstable keys.
5. Use the project’s Material 3 theme and semantic tokens. Prefer responsive constraints, slots, and adaptive layout primitives over fixed pixels. Preserve system insets, large text, touch targets, focus order, contrast, and content descriptions; route a full audit to `android-accessibility-i18n`.
6. Make UI behavior testable through visible semantics. Prefer user-observable roles, labels, state descriptions, and actions over implementation details; add a test tag only when a stable semantic node cannot express the contract.
7. Verify previews with representative states, unit/state tests for transitions, Compose semantics tests for behavior, and screenshot tests only for a deliberately controlled visual contract. Run the repository’s discovered checks; do not claim a Gradle task exists until the wrapper and task are confirmed.

## Acceptance criteria

- The screen’s states and events are explicit, and no business or transport logic is hidden in composables.
- Recreated configuration does not lose required state, duplicate subscriptions, or repeat unsafe effects.
- The UI follows existing theme/tokens, works within the supported window sizes, and remains usable with accessibility settings.
- At least one behavior test proves the primary interaction and relevant state branches; visual tests are deterministic if used.
- The implementation does not add an unrequested toolkit migration, dependency, or production mutation.

## Provenance and maintenance

This skill is based on current official [Jetpack Compose](https://developer.android.com/develop/ui/compose), [state](https://developer.android.com/develop/ui/compose/state), [side-effects](https://developer.android.com/develop/ui/compose/side-effects), and [Material 3](https://m3.material.io/) guidance reviewed 2026-09-10. It incorporates route/content separation and semantics-oriented testing patterns audited in `dpconde/claude-android-skill` commit `edfca5e36ceb7532708c28fd2fd5215a9f01d105` and `Drjacky/claude-android-ninja` commit `baa6e883e9355945838a51ae628e3747dbe6c764`, without copying their prose. Re-verify with `Get-ChildItem -Force -Recurse -File | Where-Object { $_.Name -match '^(build\.gradle(\.kts)?|libs\.versions\.toml)$' }` and inspect the actual Compose/theme/test versions before applying version-specific advice.

