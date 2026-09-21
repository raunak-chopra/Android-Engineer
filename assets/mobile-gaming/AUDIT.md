# Supplied-link audit

Audit date: 2026-09-16. Scope: free/commercial-use assets relevant to a mobile gacha prototype. Directory pages were not treated as blanket licenses; each candidate still needs its own license file.

| Supplied link | Result | Action |
|---|---|---|
| [HotpotDesign/Game-Assets-And-Resources](https://github.com/HotpotDesign/Game-Assets-And-Resources) | Resource list mixes free and paid sources and explicitly warns that terms change. | Downloaded `hotpot-game-assets-and-resources.zip` as a reference snapshot; no listed third-party assets were copied automatically. |
| [itch.io free assets](https://itch.io/game-assets/free) | Directory reports 54,068 results and includes mixed licenses, pricing, and asset types. | Not bulk-downloaded; candidates must be selected and license-checked individually. |
| [Kenney assets](https://kenney.nl/assets) | Kenney pages identify individual packs and licenses; reviewed UI Pack, Pixel UI Pack, UI Pack - Sci-Fi, and related packs as CC0. | Source links recorded in `README.md`; direct archive retrieval requires the pack's download flow. |
| [CraftPix freebies](https://craftpix.net/freebies/) | Freebie catalog; license terms vary by item and must be checked per pack. | No blanket download. |
| [Reddit asset list](https://www.reddit.com/r/gamedev/comments/1m76pm4/the_ultimate_free_game_dev_asset_list_50_sites/) | Community list aggregating external sites; links and licenses are not authoritative. | Used for discovery only; no automatic third-party downloads. |

## Current files

- `hotpot-game-assets-and-resources.zip`: valid ZIP snapshot of the supplied GitHub list.
- `README.md`: reviewed sources, license notes, and download boundary.

## Required next selection

The game engine, art direction, and game loop are not yet specified, so “all required assets” cannot be determined safely. The minimum likely set is: character/portrait art, card frames and rarity badges, summon/reveal effects, currency/item icons, menus/HUD, one environment/background set, sound effects, and a font. Paid, attribution-only, unclear, or redistribution-restricted packs remain excluded until individually approved.
