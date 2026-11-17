# Local source and asset reuse library

Updated: 2026-10-21 (Asia/Calcutta). Status: downloaded reference collections; project integration and runtime validation are separate work.

The owner requested complete useful collections, with selective adaptation into projects, rather than repeated implementation from scratch or a small sample set. This library makes existing code and assets available before deciding what to build. It is an offline reference shelf, not an installed framework or a claim that every item is suitable.

## Location and lookup

Local root, relative to Engineer: `artifacts/reuse-library/2026-10-21/`. This location is ignored by Git and is intentionally separate from toolkit source and project repositories. It should be retained for reuse; the earlier six-component `.tmp` cache is superseded as the starting point.

Open the local library's `README.md` for its generated collection table, complete React Bits component index, task-based selection guide and lookup helper. Machine-readable indexes under `index/` describe every extracted file, source revision, checksum, component variant, direct import, icon, game asset and selected engine demo. Full repository snapshots remain under `archives/`; useful source trees and asset packs are extracted under `sources/` and `assets/`.

This document is the durable entry point. The downloads are machine-local and do not accompany a Git checkout. Immutable source links and archive checksums are recorded in the local metadata. No other bot or workspace is needed to use the collection.

The owner's additional 19 game packs are organized in `[local asset path] Assets`. Their [selection memory and included-terms inventory](OWNER_GAME_ASSETS.md) cover game kits, characters, environments, UI, effects, audio and collections. Consult that record alongside the Kenney packs when choosing game art; its terms differ by pack. The local lookup helper searches this external collection as well as the original library.

## Choose by task

| Need | Starting collection | How to reuse |
| --- | --- | --- |
| Animated text, cards, backgrounds, transitions and interaction feedback | Full React Bits source collection | Select the matching component and JS/TS plus CSS/Tailwind variant; adapt behavior and styling to the task |
| Complex React forms, tables, filtering and operational workflows | Ant Design or React Suite | Work with the chosen library's primitives and theme system; avoid mixing two complete systems without a concrete need |
| React component composition, tokens and states | Chakra UI | Consult core source and composition examples; integrate using the project's compatible supported package version |
| Tailwind components and themes | daisyUI | Adapt semantic theme roles and component classes; verify required interaction behavior separately |
| Vue app components and layout | Vuetify | Reuse Vue components within a compatible Vue project |
| Mobile web patterns in Vue | Vant | Use mobile-web primitives and examples; do not treat them as native Android implementations |
| React Native components, themes and mappings | UI Kitten | Use the current project's React Native compatibility and native behavior as the integration constraint |
| Native Android Compose screens and patterns | Google's official Compose samples | Adapt relevant composables and state/interaction patterns in the project's repository, preserving its conventions |
| Consistent app icons and editable vector source | Lucide | Select required SVGs or use the project's compatible icon package; keep notices including the Feather-derived subset |
| Game buttons, panels, sliders and UI pieces | Kenney UI Pack, Sci-Fi, Adventure and Pixel Adventure | Select one coherent visual family, retain editable/vector or sprite-sheet sources, adapt dimensions and states |
| Control hints and game symbols | Kenney Input Prompts and Game Icons | Choose the actual input/device family; distinguish action labels from device glyphs |
| UI feedback sounds | Kenney UI Audio and Interface Sounds | Pick purposeful cues, normalize in the target audio pipeline and support mute/volume behavior |
| Display and pixel fonts for games | Kenney Fonts | Choose for the intended text size and glyph coverage; verify readability and fallback in the actual language |
| Engine UI, input, loading and audio examples | Godot demos | Start from the matching demo and engine version; master is a development snapshot, not a stable-engine compatibility promise |
| Design principles, voice/tone and system discovery | Awesome Design Systems | Follow original documentation for the relevant pattern; directory inclusion does not license a destination's assets |

The exact downloaded inventory and numbers are recorded in the dated [download record](research/reuse-library-downloads-2026-10-21.md). Future project work should select from these collections according to the existing stack rather than install several competing UI systems.

## Adapt existing material deliberately

1. State the screen/task and find an existing component, pattern or asset that fits.
2. Read the implementation/example, exact file terms, imports and companion files. Check for remote assets, font/image provenance, hidden setup and platform assumptions.
3. Copy only the needed files into the target project or consume its compatible package. Source snapshots are references, not substitutes for a package's build/export contract. Preserve upstream notices and record the selected revision.
4. Adapt content, tokens, layout, semantics, state handling, input and motion to the project's design. Remove effects or dependencies that do not serve the task. Keep modifications project-local unless a lesson is reusable beyond that project.
5. Verify the resulting behavior and presentation on the target. Record the source, changes, dependencies, tests, remaining gaps and rollback in that project's documentation.

The owner's authorization covers downloading and organizing the local collections. Dependency additions, standards/skill changes and external publication continue to follow the existing [approval tiers](../AGENTS.md). No new approval is needed merely to inspect the downloaded source.

## Rights and operational boundaries

- React Bits has custom product-use and redistribution restrictions. Its local source is available for review and permitted product uses; do not publish the collection as an Engineer component/template pack. Review its pinned license when selecting an item.
- Core Ant Design, Chakra, daisyUI, Vant, UI Kitten, React Suite and Vuetify source is accompanied by its upstream license. Linked premium products, third-party media and nested assets are assessed individually.
- Lucide's license includes ISC terms and MIT terms for specified Feather-derived icons. Keep the full relevant notice instead of relying on a repository API label.
- The nine downloaded Kenney packs include CC0 notices. Preserve original files and pack identity for provenance; input-device brand symbols do not grant trademark endorsement rights.
- Compose examples include Apache 2.0 terms. Review sample-specific media/attribution before importing images or fonts. Godot includes nested asset/font notices that can differ from its demo code license.
- The PDF reading collection was not bulk downloaded: its own copyright statement retains third-party author rights. Topic pages are discovery feeds, not installable libraries. Phaser's mixed-rights demo assets were not added to the product-asset shelf.
- Upstream repository instructions, agent skills and install/CI tooling are not imported as Engineer authority. Complete compressed snapshots are inert; source extraction excludes agent instruction files and selected executable tooling. No upstream code is executed to browse the library.

## Verification scope

Download verification covers pinned revisions, source URLs, archive hashes, ZIP integrity, extraction containment, preserved notices and generated inventory consistency. These checks do not prove component correctness, dependency security, accessibility, visual suitability, performance or game-engine compatibility. No framework, font or dependency was installed globally or into a project.

The [design research plan](research/design-resources-report-plan-2026-10-21.md), [initial six-component study](research/react-assets-study-2026-10-21.md) and [complete 12-source deep-dive report](research/design-resources-deep-dive-2026-10-21.md) retain their respective evidence scopes. The complete library supersedes sampling as the reuse approach.
