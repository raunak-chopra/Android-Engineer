---
name: android-navigation-adaptive
description: Build adaptive Android navigation, route contracts, deep links, back stack, restoration, tablets, foldables, and multi-window. Exclude incidental library migration.
---

## When to use

- Use for destinations, graphs, deep links, arguments, back/restoration, panes, window size, tablets, foldables, or multi-window.

## When not to use

- Route components to `android-compose-ui`, flow definition to `mobile-product-design`, state ownership to `android-architecture`, concurrency to `android-concurrency`, and Gradle changes to `android-project-bootstrap`.
- Do not migrate navigation libraries for one screen unless requested and staged.

## Workflow

1. Inspect destinations, graph ownership, route encoding, arguments, deep links, back policy, state holders, UI toolkit, and tests; preserve brownfield navigation.
2. Define each route contract: arguments, validation, serialization, auth, restoration, and malformed/stale behavior. Keep sensitive data out of routes.
3. Place state in the destination, state holder, saved state, or storage according to lifetime; restore only what should survive recreation or process death.
4. Define system back, nested/modal behavior, unsaved changes, and supported predictive back; test direct entry as well as UI taps.
5. Choose pane/navigation arrangements from window size, posture, content, and task continuity; preserve reading, focus, and selection semantics.
6. Validate external intents/deep links, private destinations, auth, and unknown/expired targets; use security review for sensitive flows.
7. Test transitions, restoration, deep links, back edges, and relevant window configurations; report unavailable device coverage.

## Acceptance criteria

- Routes, arguments, back, restoration, and malformed links are explicit and tested.
- Adaptive layouts preserve task continuity and accessibility.
- Routes/logs expose no sensitive data and enforce auth.
- Existing navigation is preserved unless migration is reviewed; direct entry and relevant windows are verified.

## Provenance and maintenance

Sources: [Navigation](https://developer.android.com/guide/navigation), [adaptive layouts](https://developer.android.com/develop/ui/compose/layouts/adaptive), and audited registry IDs (2026-09-10). Re-verify: inspect target routes, state restoration, deep links, window APIs, and tests.
