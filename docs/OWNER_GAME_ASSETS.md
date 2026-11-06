# Owner-downloaded game asset library

Recorded: 2026-10-21 (Asia/Calcutta). Source: the owner's explicitly named folder `[local asset path] Assets`. This is a machine-local asset location, not a project repository or permission to access unrelated Downloads folders.

## Location and organization

The collection contains 19 original archives, totaling 236,413,706 bytes. They are filed under `Archives/<category>/` with their original names and bytes preserved. Extracted working copies live under `Library/<category>/<pack>/`. The root `README.md` is the browsing entry point; `Index/` contains pack/file indexes, hashes, original archive paths and a move journal. Categories: Game Kits, Characters, Environments, UI, Effects, Audio and Collections.

Use this collection alongside the earlier [source and asset library](RESOURCE_LIBRARY.md). The owner's stated preference is to find and adapt suitable existing assets/code before recreating them. Keep pack identities, licenses, editable sources, sprite metadata and meaningful variations together. Project-specific selections belong in the target project's repository.

The original archives remain the preservation source. OS metadata such as `__MACOSX`, Apple resource forks and `.DS_Store` is omitted from extracted working copies without deleting it from those archives. Nested ZIPs remain intact and indexed rather than being silently merged with other packs. Both Tiny Swords editions are retained because their archive hashes and contents differ. No exact duplicate archive was found among these 19 downloads.

## Pack selection memory

Terms below are observations of bundled documents, not a blanket clearance of all files or current online editions. A missing notice is recorded as missing; the words Free/Demo do not supply one.

| Category | Pack / extracted folder | Useful for | Included terms observation |
| --- | --- | --- | --- |
| Game Kits | Cute Fantasy Free / `cute-fantasy-free` | Animals, enemies, props and terrain | Noncommercial only; modifications allowed; no asset redistribution/resale |
| Game Kits | Farm RPG Free 16x16 / `farm-rpg-free-16x16` | Character, farm animals, crops, objects and tiles | No license notice found in the archive |
| Game Kits | Ninja Adventure / `ninja-adventure` | Actors, creatures, objects, environments, audio and font | Bundled CC0 notice and author README |
| Game Kits | Pixel Adventure 1 / `pixel-adventure-1` | Platformer sprites, enemies, traps, terrain and backgrounds | No license notice found in the archive |
| Game Kits | Sprout Lands Basic / `sprout-lands-basic` | Cozy farming characters, animals and environment | Noncommercial only; credit Cup Nooble; preserve additional included restrictions |
| Game Kits | Super Retro Ranch Free Tier v34 / `super-retro-ranch-free-34` | Ranch/farming material | Noncommercial only; premium-preview folders are not a premium entitlement; additional restrictions included |
| Game Kits | Tiny Swords Free Pack / `tiny-swords-free-pack` | Units, buildings, effects, UI and editable sprites | No license notice found in this archive; distinct edition |
| Game Kits | Tiny Swords Update 010 / `tiny-swords-update-010` | Terrain, units, resources and UI | No license notice found in this archive; distinct edition |
| Characters | Mana Seed Base Demo 2.0 / `mana-seed-base-demo-2` | Layered character base, movement and sword/shield animation | Demo note explicitly permits commercial/noncommercial use; inspect applicable author terms before selection |
| Characters | Tiny RPG 01 Free Soldier/Orc / `tiny-rpg-01-free-soldier-orc` | Character animation, projectiles and Aseprite | No license notice found in the archive |
| Characters | Tiny RPG 02 Free Demon/Monster / `tiny-rpg-02-free-demon-monster` | Character animation and Aseprite | No license notice found in the archive |
| Environments | Free Environment / `free-environment` | An environment sprite sheet | No license notice found in the archive |
| Environments | Modern Interiors Free v2.2 / `modern-interiors-free-2.2` | Indoor tiles/furniture and character actions | Explicitly noncommercial only |
| UI | Cozy UI Demo / `cozy-ui-demo` | Cozy arrows, panels and UI sprites | Developer note found; no usage license found |
| UI | Paper UI System v1.1 / `paper-ui-system-1.1` | Paper panels, animation, sprites and editable Aseprite | Bundled PDF permits commercial/noncommercial projects and edits; forbids asset redistribution/resale and logo/trademark use |
| UI | StudUI Lite v1.1.3 / `studui-lite-1.1.3` | Roblox UI model with scripts and six image textures | Monetized game use and changes permitted; no sharing/reselling the kit or claiming authorship; no scripts were run |
| Effects | Super Pixel Effects Free v3.1.0 / `super-pixel-effects-free-3.1.0` | Animation frames, sprite sheets and timing metadata | Included summary permits commercial product use, requests credit to Will Tice / unTied Games, restricts asset/tool redistribution and AI training; full referenced external license remains unverified |
| Audio | Super Dialogue Audio v1 / `super-dialogue-audio-1` | Dialogue sounds and variations | Bundled PDF states CC BY 4.0; credit Dillon Becker, link the license and indicate changes |
| Collections | Ansimuz Legacy / `ansimuz-legacy` | Multiple environment/character families; editable PSD/Aseprite | Bundled public-license PDF states CC0; author Luis Zuno / Ansimuz |

Four packs explicitly state noncommercial limits and eight lack a usage license in their supplied archive. Keep these labels visible during selection. Check author terms for an actual product use rather than treating a locally downloaded pack as automatically eligible for commercial shipping.

## Search and future updates

The existing local helper at `artifacts/reuse-library/2026-10-21/find_resource.py` also searches this collection through `index/external-libraries.json`. Use `--kind pack` for pack-level queries and `--kind asset` for individual extracted files; results include use status and absolute paths. The helper reads catalogue data, not bundled code. A missing/relocated external catalogue is reported without hiding the original library.

Source of truth for exact files: `[local asset path] Assets\Index\packs.json` and `files.csv`. Move mappings: `Index\move-journal.json`. Inspection/organization helpers and the original pre-move plan are retained under Engineer's ignored `artifacts/reuse-library/owner-game-assets-2026-10-21/`.

If new archives arrive later, inspect them as a new batch; do not overwrite an existing pack based only on a similar filename. Preserve versions and update the local indexes and this guide when availability or verified terms change. These repository documents and local indexes are the persistent record for future Engineer tasks.

## Verification and limits

Archive preservation, extraction, inventory, local links and lookup checks are recorded in [work status](work-status.md). Asset contents were organized and relevant included documents read, including PDF text extraction. No engine import, visual-quality review, audio playback, font installation or bundled script/model execution occurred. No original assets were edited or exported. No credentials, external uploads, purchases or messages were used.

Rollback uses the exact source/destination pairs in the move journal to restore original archive locations. Original archive bytes are verified by SHA-256. Keep extracted copies and indexes until the owner decides whether to remove them; no broad deletion is needed.
