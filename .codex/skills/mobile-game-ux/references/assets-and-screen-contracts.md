# Asset and screen contracts

Read for asset integration or multi-screen handoff. Original synthesis, 2026-10-12. Use existing project documentation; do not create a second source of truth.

## Assets

Keep editable sources, export settings and provenance. For 2D specify intended display scale, atlas/padding, pivots and animation states. For 3D specify scale/orientation, silhouette, materials/textures, rig/clips and measured mobile budgets. The camera and device determine limits; do not invent universal polygon/texture budgets.

Choose cohesive licensed packs or compatible assets when useful. Inspect one asset in engine at representative lighting and camera distance before expanding. Label placeholders and missing states. Generated assets need the same inspection/integration as other assets; this guidance does not install an art pipeline.

## Screens and input

For each applicable screen record entry, player goal, primary action, state owner, data, transitions, back/cancel, focus, interruptions and return to gameplay. Include only relevant loading/error, locked/disabled, preview/commit, result and pause states. Avoid inventing shops or social flows for games that do not need them.

UI observes authoritative game state; it does not become a second health, inventory or save system. Specify whether menus pause simulation, consume gestures and gate gameplay/camera input. Trace launch -> meaningful action -> result -> retry/next round plus interruption recovery. Teach through visible actions and consequences; let needed instructions remain readable without covering the task.

Keep selected direction, contracts, feel parameters and evidence/gaps in the game's docs for Codex/Claude handoffs. Load only relevant references and keep engine-specific commands verified.

Implementation examples: [Godot demos](https://github.com/godotengine/godot-demo-projects) (choose matching stable branch; master tracks development). Material/import fixtures: [Khronos assets](https://github.com/KhronosGroup/glTF-Sample-Assets) (per-model license). State-owner inspiration: [AgentSkills game UI](https://github.com/jeremylongworth-source/AgentSkills/blob/main/skills/game-ui-design/SKILL.md). None were run in this research.
