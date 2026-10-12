# Mobile game capability upgrade: resource assessment and proposed changes

Date: 2026-10-12 (Asia/Calcutta). Status: APPLIED 2026-10-12 after owner approval in chat ("go, apply the patch and finish the steps"); the check results below describe the preview and were re-run on the applied checkout (see docs/work-status.md). Deliverable is reusable Engineer guidance; the project catalog is empty and no game repository was accessed.

Read the [local Reddit digest](reddit-game-design-digest-2026-10-12.md) first. Proposed implementation is the [reviewable patch](mobile-game-upgrade-2026-10-12.patch). It was applied on 2026-10-12 and is kept for history only; do not re-apply it.

## Resources worth using

These are read-only references, not an installation list. Public default branches are mutable; no immutable commit or runtime compatibility was verified. License labels below describe what the upstream page exposed, not approval to redistribute every asset or install a package.

| Resource read | Concrete value | Scope and decision |
| --- | --- | --- |
| [OpenAI game UI frontend skill](https://github.com/openai/plugins/blob/main/plugins/game-studio/skills/game-ui-frontend/SKILL.md) | Visual direction, information hierarchy, playfield visibility and camera/menu input boundaries. | Browser-specific. Adapt concepts to native games; omit DOM/CSS rules and fixed HUD percentages. License file fetch failed; original synthesis only. |
| [Roblox UI/UX design documentation](https://github.com/Roblox/creator-docs/blob/main/content/en-us/production/game-design/ui-ux-design.md) | Tie information to current decisions; maintain visual conventions and consistency. | Official Roblox documentation, useful cross-engine principles. Do not import Roblox implementation or generalize retention claims. License page read; no content copied. |
| [Godot official demo projects](https://github.com/godotengine/godot-demo-projects), especially [GUI](https://github.com/godotengine/godot-demo-projects/tree/master/gui) and [mobile](https://github.com/godotengine/godot-demo-projects/tree/master/mobile) | Inspectable examples for theming, multiple resolutions, localization, accessibility and mobile features. | MIT at repository level. Choose a branch matching the target engine; master follows development. No demos run. |
| [Godot input propagation](https://docs.godotengine.org/en/stable/tutorials/inputs/inputevent.html) | GUI consumption and unhandled gameplay events help avoid a menu tap also firing an action. | Official engine guidance. Verify polling and custom input paths separately; event handling alone does not gate all input. |
| [Android games samples](https://github.com/android/games-samples) | Primary Android game engineering examples. | Apache-2.0 shown upstream. Engineering reference, not a polished UI template or mandatory engine. No build run. |
| [gamedev agent skills: UI/UX](https://github.com/gamedev-skills/awesome-gamedev-agent-skills/blob/main/skills/disciplines/game-ui-ux/SKILL.md) and [feel](https://github.com/gamedev-skills/awesome-gamedev-agent-skills/blob/main/skills/disciplines/game-feel/SKILL.md) | HUD scaling, safe areas, focus and event-based feedback. | Community guidance; existing Engineer provenance records Apache-2.0. Selective original synthesis; avoid bulk installation and numerical defaults without target evidence. |
| [AgentSkills game UI design](https://github.com/jeremylongworth-source/AgentSkills/blob/main/skills/game-ui-design/SKILL.md) | Screen-state coverage and UI views backed by explicit state owners. | MIT shown on repository/skill. Read as authored guidance, not verified behavioral improvement. |
| [Game feel skill](https://github.com/ronniebasak/game-feel-skill/blob/main/skills/game-feel/SKILL.md) | Diagnose responsiveness, motion, collision, camera and feedback before decorating. | MIT shown upstream. Treat fixed layers and absolute feel rules as opinions; genre may require precise position-driven movement or deliberate wind-up. |
| [Khronos glTF sample assets](https://github.com/KhronosGroup/glTF-Sample-Assets) | Known assets for inspecting import, material and animation behavior. | Per-model licenses/credits; not one blanket asset license. Test assets are not automatically suitable for a mobile shipping budget. |
| [Unity MCP](https://github.com/coplaydev/unity-mcp) | Candidate bridge for scene, asset and script operations. | Discovery only. No installation, execution, dependency approval or security/runtime audit performed. Defer until a Unity project has a demonstrated tooling need. |
| [Karpathy LLM wiki gist](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f) | Lead linked directly in the game-designer thread for source-backed knowledge organization. | Not a game-design curriculum or evidence of skill effectiveness. Retain small source records; avoid importing books or building another knowledge system without need. |
| [Game Accessibility Guidelines: basic](https://gameaccessibilityguidelines.com/basic/) | Remapping, readable text, alternatives to color/sound and accessible interactions. | Authored accessibility reference. Select relevant needs; custom engine rendering does not automatically expose Android accessibility semantics. |
| [Kenney assets](https://kenney.nl/assets) and [Poly Haven license](https://polyhaven.com/license) | Candidate consistent asset packs, HDRIs, textures and models. | Poly Haven's assets are CC0; website text/previews have different terms. Inspect the selected Kenney pack's license. No assets downloaded. |

## Corrections found in current guidance

1. The source record's Reddit failure is historical: six threads were readable in this research pass. Superseding evidence is appended rather than silently rewriting the older session's result.
2. The Android skill omits the Android 16 game-category exception. [Official documentation](https://developer.android.com/develop/adaptive-apps/guides/app-orientation-aspect-ratio-resizability) lists games based on `android:appCategory` among exceptions. Verify target SDK, category, distribution and actual behavior before applying a platform rule; adaptation tests still matter. Future SDK behavior must be rechecked.
3. Native Android multi-touch needs stable pointer IDs; indices can change when fingers enter or leave. [Android multi-touch guidance](https://developer.android.com/develop/ui/views/touch-and-input/gestures/multi) is the primary source to verify at implementation time. The proposed patch removes advice to track fingers by index alone.
4. The existing 50–100px finger-size claim is not a universal device-independent measurement. Use density-aware hit regions and observed occlusion. [Android accessibility guidance](https://developer.android.com/develop/ui/compose/accessibility/api-defaults) supports 48dp targets and warns about overlapping expanded regions; a custom engine must implement equivalent sizing deliberately.

## Concrete plan for approval

Apply the prepared seven-file patch:

- `.codex/skills/mobile-game-ux/SKILL.md`: add visual direction, a playable slice and screenshot/playtest evidence; keep current routing and seven workflow steps.
- `.codex/skills/mobile-game-ux/references/visual-direction-and-playtest.md`: add genre-based hierarchy and concrete visual critique.
- `.codex/skills/mobile-game-ux/references/assets-and-screen-contracts.md`: add asset handoff, screen states and input ownership.
- `.codex/skills/mobile-game-ux/references/playtest-evidence.md`: distinguish visual review, runtime usability and enjoyment evidence.
- `.codex/skills/mobile-game-ux/references/feel-and-touch.md`: remove unsupported physical-pixel assumptions and pointer-index guidance; make feedback parameters genre-specific and testable.
- `.codex/skills/android-game-engineering/SKILL.md`: correct SDK/category qualification and stable input tracking; direct engine-specific work to version-matched official demos.
- `CLAUDE.md`: add local research and game-skill discovery links while preserving one canonical policy and skill library. No `.claude/skills` duplicate or global configuration change.

Risk: reusable instructions affect future agent choices; the patch must stay within context budgets and avoid turning anecdotes into rules. Rollback: reverse only this patch against the preserved starting contents; never revert the owner's pre-existing uncommitted changes. No engine/plugin installation, dependency/config migration, push, PR or publication is included.

Before adoption, validate the proposed skills in an isolated local preview against existing skill contracts, routing, lazy-load and context budgets; inspect reference links and patch applicability. After approval/application, run checks on the actual checkout and obtain the required fresh-context review. Check scripts validate instruction structure, not game quality. Real-game and device evaluations remain unrun.

## Behavioral evaluation to perform in a real game later

Use the same request, assets, engine version and build target before/after the guidance update. Compare a new-player first round and retry path, a busy gameplay HUD, and a menu opened during multi-touch gameplay. Record whether the player understands the goal, predicts the action, can see the result despite fingers, and returns to play without unintended input. Record observed behavior, device and screenshots; keep fun/feel judgments separate from timings and crash/frame evidence. No retention gain or capability improvement is claimed before this evaluation.

## Verification record

The final proposal was checked in `.tmp/mobile-game-upgrade-preview-v2-2026-10-12` using the bundled PowerShell 7 executable found in this session. This does not retroactively change the older session's recorded tooling limitation.

| Check run against the proposed preview | Result |
| --- | --- |
| `scripts/test-skill-contracts.ps1` | PASS, 29 contracts/skills |
| `scripts/test-skill-triggers.ps1` | PASS, 34 cases (28 positive, 6 negative) |
| `scripts/measure-context-budget.ps1 -Enforce` | PASS, 54,905 entrypoint-library bytes, 20.84% reduction, 3,545 description characters; no budget edits |
| `scripts/test-lazy-load-contract.ps1` | PASS, 17 recipes; managed entrypoints/references within existing 2,400-byte limits |
| `scripts/test-lazy-load-safety.ps1` | PASS, nine safety regressions in isolated preview |
| `scripts/test-behavioral-evals.ps1` | CORPUS_PASS, ten cases; zero model runs |
| Local Markdown link inspection | PASS, 21 links across ten research/proposed guidance files |
| `git apply --check docs/research/mobile-game-upgrade-2026-10-12.patch` | PASS, patch applies to current checkout contents; not applied |

Initial drafts failed the context/lazy-load limits; the final draft was shortened and split into conditional references. A required provenance marker was restored, and the affected contract/budget checks reran successfully. These mechanical checks are not independent behavioral evaluations.

Not run: full repository validator, game builds, installed engine demos, physical-device or emulator game flows, live agent comparison, hosted CI and fresh-context adoption review. Unrelated owner changes remain preserved. The research is ready for Claude; active skill adoption and subsequent review are awaiting approval under [Engineer change control](../../playbooks/CHANGE_CONTROL.md).
