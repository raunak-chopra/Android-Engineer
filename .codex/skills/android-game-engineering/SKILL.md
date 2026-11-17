---
name: android-game-engineering
description: Build or review Android games: engine choice, touch input, lifecycle, safe areas, large screens, performance and thermal limits, Play delivery and Level Up. Exclude non-game apps.
---

## When to use

- Android game engine, input, lifecycle, rendering, performance or delivery work.

## When not to use

- Loop/HUD/feel design: mobile-game-ux. Non-game Android: android-router. Signing/rollout: android-security-release.
- Do not migrate engines without owner request.

## Workflow

1. Inspect engine, build, manifest, input, saves and services; preserve project conventions.
2. For new games compare team skills, 2D/3D, size, tooling and license; measure a small prototype on target hardware. Inspect version-matched official demos when useful.
3. Native Android pointer IDs persist while indices change; resolve each event's index from its ID. Respect engine touch APIs. Clear held actions on cancel/pause/menu; prevent UI taps reaching gameplay. Handle saves, audio focus, back and insets.
4. Verify SDK, category and actual windows against current Android guidance: API 36 overrides at sw600dp have a game-category exception. Test applicable rotation, resize, split and foldable states; opt-out ends at targetSdk 37; recheck.
5. Measure before tuning: frame time, memory, thermal, battery and size on target hardware. Read [engine and release notes](references/engines-and-release.md) for platform/tooling sources.
6. Services, assets and editor bridges follow consent, policy and owner authorization. Install no engine/plugin/MCP bridge without approval.
7. Build, run applicable tests and exercise the flow on a device or emulator; name it. Release/upload need explicit approval for the exact action.

## Acceptance criteria

- Versions and commands come from the project or dated primary docs.
- Input cancellation, interruption and applicable window paths have runtime evidence or disclosed gaps.
- Performance/size claims cite measurements and device.
- Record checks and omissions; Tier 2 needs fresh-context review, Tier 3 exact approval (AGENTS.md).

## Provenance and maintenance

Original synthesis, revised 2026-10-12; [sources](../../sources/mobile-games-2026-10-12.md). Re-verify: primary guidance and project evidence at use time.
