---
name: android-accessibility-i18n
description: Audit or implement Android accessibility and internationalization, including semantics, TalkBack, touch targets, focus, contrast, content descriptions, plurals, RTL, font scaling, locales, and pseudolocales. Use for inclusive UI quality; do not reduce accessibility to a color check.
---

# Overview

Make the same task perceivable, operable, and understandable across assistive technologies, languages, scripts, font scales, and window sizes. Test behavior with real semantics and localized resources, not assumptions based on the default emulator.

## When to use

- Reviewing or building Compose/Views UI for TalkBack, keyboard/switch access, focus, touch targets, contrast, semantics, or announcements.
- Localizing strings, plurals, dates, numbers, layouts, content descriptions, or user-generated text.
- Testing RTL, pseudolocales, large fonts, high-contrast settings, orientation, tablets, or foldables.

## When not to use / routing

- Route general Compose rendering to `android-compose-ui` and screen/task definition to `mobile-product-design`.
- Route route/back-stack and adaptive navigation to `android-navigation-adaptive`.
- Route security-sensitive user data or release gates to `android-security-release`.
- Route test harness and screenshot strategy to `android-testing` while keeping the accessibility contract here.
- Do not use visual polish heuristics to override platform accessibility requirements.

## Evidence-oriented workflow

1. Identify the user task, supported locales, form factors, input modes, and accessibility settings. Inspect existing semantics, resources, themes, focus handling, custom views, and test utilities before editing.
2. Audit the semantic tree and interaction contract: role, name, state, value, action, traversal order, grouping, and live-region/announcement behavior. Ensure decorative content is not announced and meaningful state changes are discoverable.
3. Check operability: target size, spacing, keyboard/switch focus, touch alternatives, gestures with non-gesture alternatives where needed, focus restoration, error association, and dismiss/back behavior. Check contrast and non-color cues against current platform guidance.
4. Localize all user-visible text, including errors, content descriptions, notifications, and test fixtures that render in UI. Use plural and gender/select rules when the locale requires them; format dates, times, numbers, and units with locale-aware APIs; preserve user text safely.
5. Exercise long translations, missing translations, RTL mirroring, pseudolocale expansion, large font/display size, dark/light themes, reduced motion where supported, and compact/expanded windows. Do not use hard-coded widths or string concatenation that breaks grammar or bidi ordering.
6. Verify with automated semantics/resource checks and a manual TalkBack or equivalent pass on critical flows. Test loading, empty, success, partial, validation-error, permission-denied, and offline/error states. Record device, locale, font scale, and settings for each finding.
7. Fix the smallest semantic/resource/layout cause, then rerun the affected checks and `android-testing` evidence. Do not disable accessibility checks, clip text, or hide content merely to silence a failure without a reviewed rationale.

## Acceptance criteria

- Critical tasks have meaningful names, roles, states, actions, focus order, and feedback for assistive users.
- Controls remain operable with supported input modes, target sizes, contrast, font scales, and window configurations.
- No user-facing text or relevant description is hard-coded; plurals, formatting, RTL, expansion, and bidi behavior are tested.
- Critical states and validation errors are announced or otherwise discoverable, and a manual assistive-technology check is recorded where available.
- Any unavailable device/tool check is reported explicitly; no accessibility gate is bypassed.

## Provenance and maintenance

This skill is grounded in official [Android accessibility](https://developer.android.com/guide/topics/ui/accessibility), [Compose semantics](https://developer.android.com/develop/ui/compose/accessibility), [localization](https://developer.android.com/guide/topics/resources/localization), and [RTL](https://developer.android.com/training/basics/supporting-devices/languages) guidance reviewed 2026-09-10. It adapts the accessibility, internationalization, and semantic-testing checklists audited in `Drjacky/claude-android-ninja` commit `baa6e883e9355945838a51ae628e3747dbe6c764` and the design workflow in `ceorkm/mobile-app-ui-design` commit `4c67a0e71727b6afaaafbcbb1b11c7660de5fac9`; community claims remain heuristics until verified. Re-verify with `Get-ChildItem -Force -Recurse -File | Where-Object { $_.Name -match '(strings|plurals|locale|values-|layout|Composable|View|Accessibility|Semantics)' }` and inspect the project’s actual locales, test devices, and accessibility tooling.

