---
name: mobile-product-design
description: Define or review mobile user flows, screen structure, content hierarchy, interaction states, feedback, adaptive behavior, and accessible design handoff before implementation. Use when product intent or UX is unresolved; do not use for Android code-only fixes.
---

# Overview

Turn a user goal into a testable mobile interaction contract before polishing implementation. Make the primary task, state transitions, feedback, accessibility, localization, and responsive behavior explicit so engineering does not have to infer product intent from a screenshot.

## When to use

- Shaping a new mobile feature, screen, onboarding flow, form, empty state, or error recovery.
- Reviewing whether an existing mobile flow is understandable, complete, accessible, or adaptive.
- Preparing a design handoff for Compose or Views, including content, states, semantics, and acceptance criteria.

## When not to use / routing

- Route implementation of an approved Compose screen to `android-compose-ui` and route navigation contracts to `android-navigation-adaptive`.
- Route accessibility/localization validation to `android-accessibility-i18n` and architecture/state ownership to `android-architecture`.
- Do not use fixed visual heuristics as laws, or redesign unrelated screens during a code fix.
- Do not use for a web/desktop-only product, marketing artwork, or pixel-copying without a user/task brief.

## Evidence-oriented workflow

1. Name the target user, situation, job to be done, desired outcome, constraints, and primary action. Define how success and abandonment will be observed; mark assumptions that need user research or product approval.
2. Map entry points, the current screen, next states, back/cancel behavior, completion/closure, interruption/recreation, permission denial, and recovery. Identify where users can get stuck or lose work.
3. Reduce the first version to the smallest elements needed for the primary task. Establish content hierarchy, labels, progressive disclosure, navigation, validation, and feedback before selecting colors, motion, or decorative treatment.
4. Specify loading, empty, success, partial, offline, error, permission, disabled, and destructive-confirmation states that the user can encounter. Define copy, actions, retry/undo, focus, announcement, and analytics/privacy implications for each.
5. Choose semantic design tokens and Material 3/adaptive patterns that match the product and existing app. Treat palette ratios, font counts, reading patterns, and placement heuristics as hypotheses; validate contrast, large text, RTL, touch targets, and window sizes with `android-accessibility-i18n`.
6. Produce an implementation handoff: screen contract, component responsibilities, route/argument needs, state model, content/resource inventory, interaction details, testable acceptance criteria, and unresolved product decisions. Do not make an unreviewed visual redesign while translating the brief to code.
7. Validate with a walkthrough, representative content, usability feedback when available, and the smallest behavioral/accessibility checks. Update the brief when evidence changes the flow, then hand the approved contract to the implementation specialist.

## Acceptance criteria

- A user, primary task, success outcome, entry/exit path, and unresolved assumptions are explicit.
- All meaningful states, validation/recovery paths, back behavior, and completion feedback are specified.
- Content hierarchy, semantic labels, localization needs, adaptive behavior, and accessibility constraints are included.
- Visual heuristics are treated as conditional decisions and do not override Material/accessibility requirements.
- Engineering receives a coherent, approved contract with behavior-focused acceptance criteria rather than only a static mock.

## Provenance and maintenance

This skill synthesizes the user/task, flow mapping, state coverage, and handoff workflow audited in `ceorkm/mobile-app-ui-design` commit `4c67a0e71727b6afaaafbcbb1b11c7660de5fac9`, reviewed 2026-09-10, and grounds implementation decisions in current [Material 3](https://m3.material.io/), [adaptive layout](https://developer.android.com/develop/ui/compose/layouts/adaptive), and [Android accessibility](https://developer.android.com/guide/topics/ui/accessibility) guidance. The audited community repository’s visual heuristics and unsourced outcome claims are not treated as rules. Re-verify with `Get-ChildItem -Force -Recurse -File | Where-Object { $_.Name -match '(design|wire|mock|screen|flow|product|ux|ui)' }` and review the current product brief and target form factors before implementation.

