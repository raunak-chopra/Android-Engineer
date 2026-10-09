---
name: mobile-product-design
description: Define mobile product flows, primary actions, screen states, content, micro-interactions, adaptive behavior, and accessible implementation handoff.
---

## When to use

- Use when product intent, flow, hierarchy, states, feedback, accessibility, adaptation, or engineering handoff is unresolved.

## When not to use

- Route approved Compose work to `android-compose-ui`, routes to `android-navigation-adaptive`, accessibility/i18n validation to `android-accessibility-i18n`, and state ownership to `android-architecture`.
- Do not redesign unrelated screens, treat visual heuristics as laws, or use for web/desktop marketing artwork.

## Workflow

1. Inspect the existing product/app and name target user, situation, job, outcome, constraints, primary action, success signal, and research assumptions.
2. Map entry, next steps, back/cancel, completion, interruption/recreation, permission denial, recovery, and loss/stuck points.
3. Keep the first version to elements needed for the primary task; define hierarchy, labels, disclosure, navigation, validation, and feedback before decoration.
4. Specify meaningful states: loading, empty, partial, success, offline, error, permission, disabled, and destructive confirmation, including copy, actions, retry/undo, focus, and privacy.
5. Use product tokens and Material/adaptive patterns; test visual heuristics against contrast, large text, RTL, touch targets, and window sizes.
6. Produce a handoff with screen contract, components, routes, state model, resources, interactions, acceptance criteria, and unresolved decisions.
7. Validate with walkthroughs, representative content, available usability evidence, and behavioral/accessibility checks; update the brief when evidence changes it.

## Acceptance criteria

- User, primary task/action, outcome, entry/exit, and assumptions are explicit.
- Meaningful states, recovery, back, and completion feedback are specified.
- Handoff includes hierarchy, semantics, localization, adaptation, accessibility, and behavior-focused criteria.
- Visual heuristics remain conditional and do not override platform/accessibility requirements.

## Provenance and maintenance

Sources: [Material 3](https://m3.material.io/), [adaptive layout](https://developer.android.com/develop/ui/compose/layouts/adaptive), accessibility guidance, and audited registry IDs (2026-09-10). Re-verify: inspect the current product brief, app flow, design artifacts, target users, and form factors.
