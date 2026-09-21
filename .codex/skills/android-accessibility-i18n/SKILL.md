---
name: android-accessibility-i18n
description: Audit Android accessibility and i18n: TalkBack, semantics, touch targets, focus, contrast, plurals, RTL, font scale, locales, and pseudolocales.
---

## When to use

- Use for assistive technology, semantics, operability, localized resources, RTL, pseudolocales, large text, or locale-aware formatting.

## When not to use

- Route general Compose to `android-compose-ui`, product flow to `mobile-product-design`, navigation to `android-navigation-adaptive`, security/release to `android-security-release`, and harness work to `android-testing`.
- Never let visual polish override accessibility requirements.

## Workflow

1. Identify task, locales, windows, input modes, and settings; inspect semantics, resources, themes, focus, custom views, and tests.
2. Audit role, name, state, value, action, traversal, grouping, and announcements; hide decoration and expose meaningful changes.
3. Check touch targets, spacing, keyboard/switch focus, gesture alternatives, restoration, errors, back/dismiss, contrast, and non-color cues.
4. Localize visible text, errors, descriptions, notifications, plurals, dates, numbers, and units; preserve user text and bidi ordering.
5. Exercise long/missing translations, RTL, pseudolocale expansion, font scale, display size, themes, reduced motion, and compact/expanded windows.
6. Run semantics/resource checks and a manual TalkBack-equivalent pass on critical states; record device, locale, and settings.
7. Fix root semantic/resource/layout causes and rerun evidence; do not disable checks, clip, or hide content to silence failures.

## Acceptance criteria

- Critical tasks expose meaningful semantics, focus, actions, and feedback.
- Controls remain operable across inputs, targets, contrast, font scales, and windows.
- Visible text uses resources; plurals, formatting, RTL, expansion, and bidi are tested.
- Critical states are discoverable and unavailable checks are reported without bypassing gates.

## Provenance and maintenance

Sources: [Android accessibility](https://developer.android.com/guide/topics/ui/accessibility), [localization](https://developer.android.com/guide/topics/resources/localization), and audited registry IDs (2026-09-10). Re-verify: inspect target semantics, resources/locales, windows, assistive tooling, and tests.
