---
name: mobile-game-ux
description: Design mobile game UX: core loop, first-time experience, HUD and menus, thumb-reach controls, game feel, design docs, accessibility. Exclude art generation and non-game app flows.
---

## When to use

- Game loops, onboarding, HUD, menus, controls, feel or visual critique.

## When not to use

- Non-game flows: mobile-product-design. Engine/input code: android-game-engineering. Compose: android-compose-ui. Vectors: graphics-assets; art creation: available tools.
- Do not invent player data, benchmarks or store claims.

## Workflow

1. Inspect the game and docs; identify player, genre, camera, devices, session and core loop.
2. Explore ideas, preserve the selected promise and verbs, then examine dead ends, exploits and failure/recovery. Prototype one round and retry before expanding.
3. Teach one mechanic through action and visible outcomes; define skip/replay and applicable interruption paths.
4. For visual direction or HUD critique read [visual guidance](references/visual-direction-and-playtest.md); for assets or screen systems read [contracts](references/assets-and-screen-contracts.md). Preserve established style and connect information to decisions.
5. For controls or feedback read [feel and touch](references/feel-and-touch.md); diagnose input/response before adding effects. Keep HUD clear of fingers and safe insets.
6. Specify reduced shake/flashing, readable text, color-independent cues and applicable control/audio options. Verify access in the actual renderer.
7. Read [playtest evidence](references/playtest-evidence.md) for verification. Inspect actual output and exercise first action, retry, menus and pause on a device or emulator; label missing checks.

## Acceptance criteria

- Selected loop, visual direction and applicable states are explicit; assumptions are hypotheses.
- Touch, access and safe areas have evidence or disclosed gaps; screenshots alone do not prove feel or enjoyment.
- Preserve project conventions and asset licenses; imports follow owner authorization.
- Record checks and omissions; Tier 2 needs fresh-context review (AGENTS.md).

## Provenance and maintenance

Original synthesis, revised 2026-10-12; [sources](../../sources/mobile-games-2026-10-12.md). Re-verify: target evidence and primary guidance at use time.
