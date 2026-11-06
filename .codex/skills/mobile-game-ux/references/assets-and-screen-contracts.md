# Asset and screen contracts

Read for asset integration or multi-screen handoff. Original synthesis, 2026-10-12 (updated 2026-10-21). Use existing project docs; do not create a second source of truth.

## Assets

Keep editable sources, export settings and provenance. For 2D specify display scale, atlas/padding, pivots and animation states. For 3D specify scale/orientation, silhouette, materials/textures, rig/clips and measured mobile budgets. Camera and device set limits; do not invent universal polygon/texture budgets.

Choose cohesive licensed packs or compatible assets; consult the [resource library](../../../../docs/RESOURCE_LIBRARY.md) and [owner game assets](../../../../docs/OWNER_GAME_ASSETS.md), enforcing commercial vs noncommercial/unknown terms before shipping. Inspect one asset in engine at representative lighting and camera distance before expanding. Label placeholders and missing states. Generated assets need the same inspection and integration.

## Screens and input

For each applicable screen record entry, player goal, primary action, state owner, data, transitions, back/cancel, focus, interruptions and return to play. Include only relevant loading/error, locked/disabled, preview/commit, result and pause states. Constrain HUD spread on ultrawide displays, keep overscan/safe-area margins clear, and swap input glyphs dynamically for controller, touch or keyboard. Avoid inventing shops or social flows when unneeded.

UI observes authoritative game state; it is not a second health, inventory or save system. Specify whether menus pause simulation, consume gestures and gate gameplay/camera input. Trace launch -> meaningful action -> result -> retry/next round plus interruption recovery. Teach through visible actions and outcomes without covering the task.

Keep selected direction, contracts, feel parameters and evidence/gaps in the game's docs for handoffs. Load only relevant references and keep engine commands verified.

Examples: [Godot demos](https://github.com/godotengine/godot-demo-projects) (match stable branch), [Khronos assets](https://github.com/KhronosGroup/glTF-Sample-Assets) (per-model license), [AgentSkills game UI](https://github.com/jeremylongworth-source/AgentSkills/blob/main/skills/game-ui-design/SKILL.md), [deep dive](../../../../docs/research/design-resources-deep-dive-2026-10-21.md).
