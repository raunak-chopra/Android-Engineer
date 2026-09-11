---
name: android-navigation-adaptive
description: Implement or review Android navigation, route contracts, deep links, back-stack behavior, state restoration, and adaptive layouts for phones, tablets, foldables, and multi-window. Use for navigation or window-aware UI; do not force a navigation-library migration.
---

# Overview

Treat destinations and navigation arguments as contracts, and treat adaptive layout as a change in information arrangement rather than a scaled phone screen. Preserve user intent across back, recreation, process death, and supported window sizes.

## When to use

- Adding or changing destinations, nested graphs, deep links, navigation arguments, back behavior, or state restoration.
- Implementing list-detail, supporting-pane, navigation rail, drawer, or other adaptive arrangements.
- Testing multi-window, foldable, tablet, orientation, or large-font navigation behavior.

## When not to use / routing

- Route visual component work to `android-compose-ui` and product-flow definition to `mobile-product-design`.
- Route cross-layer state ownership to `android-architecture` and async behavior to `android-concurrency`.
- Route a library/version or Gradle change to `android-project-bootstrap`.
- Do not migrate between navigation libraries or major APIs solely to implement one screen unless the migration is requested and staged.

## Evidence-oriented workflow

1. Map the current destinations, graph ownership, route encoding, argument types, deep-link sources, back-stack policy, state holders, and tests. Identify whether the project uses Views, Compose, or both and preserve its navigation mechanism in brownfield work.
2. Define each route as a stable contract: required and optional arguments, validation, serialization, authentication/authorization expectation, restoration behavior, and what happens for malformed or stale links. Keep sensitive data out of URLs and route arguments where possible.
3. Decide whether state belongs in the destination entry, a screen state holder, saved state, or durable storage. Restore only state that should survive recreation/process death; do not duplicate the navigation back stack as an unrelated state machine.
4. Implement user-visible back behavior deliberately, including nested navigation, modal surfaces, predictive-back compatibility where supported, and unsaved changes. Test system back and direct destination entry, not only button taps.
5. For adaptive UI, choose arrangements from available window size, posture, and content needs. Preserve reading/order and selection semantics across single-pane and multi-pane layouts; avoid hard-coded device widths and do not assume orientation is the only change.
6. Keep deep links and external intents defensive: validate inputs, avoid exposing private destinations, require appropriate auth, and define unknown/expired target behavior. Coordinate with `android-security-release` for sensitive flows.
7. Verify navigation transitions, restoration, deep links, back behavior, and representative window configurations with the project’s existing tests/tools after confirming task names. Record unavailable form factors or device tests.

## Acceptance criteria

- Routes, arguments, back behavior, restoration, and malformed-link behavior are explicit and tested.
- Adaptive layouts preserve task continuity and accessibility across supported window configurations.
- No sensitive data is exposed in route strings or logs, and auth boundaries are enforced.
- Existing navigation conventions and library are preserved unless a reviewed migration is requested.
- Verification covers direct entry, recreation, back-stack edges, and at least the relevant compact/expanded arrangements.

## Provenance and maintenance

This skill is grounded in official [Navigation](https://developer.android.com/guide/navigation), [adaptive Compose layouts](https://developer.android.com/develop/ui/compose/layouts/adaptive), and [window size classes](https://developer.android.com/develop/ui/compose/layouts/adaptive/use-window-size-classes) guidance reviewed 2026-09-10. It incorporates adaptive navigation and state-restoration concerns audited in `Drjacky/claude-android-ninja` commit `baa6e883e9355945838a51ae628e3747dbe6c764` and focused routing patterns from `rcosteira79/android-skills` commit `0cdfc74ad89d5be0141807f6974d5ee37412d6f7`; community material is not copied. Re-verify with `Get-ChildItem -Force -Recurse -File | Where-Object { $_.Name -match '(Nav|Navigation|Route|DeepLink|Window|Adaptive)' }` and inspect the project’s actual navigation and window APIs before applying version-specific advice.

