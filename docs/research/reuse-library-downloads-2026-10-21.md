# Complete source and asset collection download record

Date: 2026-10-21 (Asia/Calcutta). Scope: owner-authorized local downloads and indexing for future selective reuse. No project integration, dependency installation, global font installation or upstream code execution.

## Outcome

Downloaded 21 complete archives totaling 967,441,240 bytes: 12 repository snapshots and nine Kenney asset packs. React Bits contains 218 distinct components in each of four source variants, giving 872 component/variant combinations. These are the complete collections at the recorded revisions, superseding the earlier six-component sampling approach.

Final extracted inventory: 36,114 files totaling 359,854,261 bytes, including 1,903 Lucide SVG files, 8,513 Kenney media/font files (including format and style variants), and 61 Godot demo projects in the selected categories. Compressed archives retain the complete original snapshots; the extracted source shelf is intentionally focused.

Local root: `artifacts/reuse-library/2026-10-21/` under Engineer, already covered by the repository's artifact ignore rule. Full ZIP snapshots are retained. Useful source, examples, asset packs and notices are extracted for lookup; source snapshots do not become installed dependencies or project code. The [resource library guide](../RESOURCE_LIBRARY.md) is linked from Engineer's README so the collection can be found on future tasks.

The local `README.md`, `index/COLLECTIONS.md`, `index/REACT-BITS.md` and `index/ASSET-PACKS.md` provide navigation. `find_resource.py` searches components, imports, icons, media, demos and collections without running upstream code. JSON and CSV indexes record exact paths and hashes.

## Repository snapshots

Each URL below identifies the actual downloaded commit. They are reproducible source references, not recommended dependency versions for a particular project.

| Collection | Revision | Intended reuse |
| --- | --- | --- |
| [Ant Design](https://github.com/ant-design/ant-design/tree/4e3564d0f3088d0ef96210182732f579c38e5df3) | `4e3564d0f308` | React forms, tables, task patterns and theme implementation |
| [React Bits](https://github.com/DavidHDev/react-bits/tree/e12c22192ac7b4b452c5e2feb9b586d74765d696) | `e12c22192ac7` | Complete animation, text, card, interaction and background source variants |
| [daisyUI](https://github.com/saadeghi/daisyui/tree/bf3bac3a397b543e55641ecb2d60a2ed961f09ec) | `bf3bac3a397b` | Tailwind components and themes |
| [Vuetify](https://github.com/vuetifyjs/vuetify/tree/5ac58863f4ee4b8c089ad1fb52c408081f9cf8cb) | `5ac58863f4ee` | Vue components, layout, styles and examples |
| [Chakra UI](https://github.com/chakra-ui/chakra-ui/tree/fa9696f328ea5a0df8685c6d8460edbd779b63b9) | `fa9696f328ea` | React primitives, recipes, tokens and compositions |
| [Vant](https://github.com/youzan/vant/tree/dbf8019eae0d094385caa170c590ff73eea2b9b1) | `dbf8019eae0d` | Vue mobile-web components and interaction patterns |
| [UI Kitten](https://github.com/akveo/react-native-ui-kitten/tree/e73dce62f946e39c946ba4006dbd6c082d393161) | `e73dce62f946` | React Native components, Eva mappings, icons and examples |
| [React Suite](https://github.com/rsuite/rsuite/tree/f61a3ed41f2b12cc9543f2a104624c54822627ca) | `f61a3ed41f2b` | React operational app components and examples |
| [Awesome Design Systems](https://github.com/alexpate/awesome-design-systems/tree/b366f8c3e24e7411cc0a99a6c01edc3c7e19714d) | `b366f8c3e24e` | Offline discovery and learning reference |
| [Lucide](https://github.com/lucide-icons/lucide/tree/20aef31db93fe4d9f398dbb15b120d99c48eef95) | `20aef31db93f` | Consistent editable SVG icons and React/native adapter source |
| [Godot demo projects](https://github.com/godotengine/godot-demo-projects/tree/b761b4cd5718a7118f2c95eb55f181d0a5f004f1) | `b761b4cd5718` | GUI, mobile, audio, loading and 2D implementation references |
| [Official Compose samples](https://github.com/android/compose-samples/tree/0bc770fd28510b5a16395349e7281f11386ac82f) | `0bc770fd2851` | Native Android screens, composables, state and interaction examples |

Full repository snapshots include development/build context. Extracted trees focus on relevant components, examples and documentation. Upstream agent instructions and selected executable tooling are excluded from extraction and are never treated as local instructions. Complete source variants are available rather than one handpicked visual style. Files omitted from extracted trees remain in the original archives.

## Complete game asset packs

All nine packs were downloaded through their official free download links after their pages indicated CC0. Included license notices were retained for inspection. Exact download URLs and SHA-256 values are in local `metadata/kenney--*.json`; included pack version/date takes priority over a guessed archive filename version.

| Pack | Useful contents |
| --- | --- |
| [UI Pack](https://kenney.nl/assets/ui-pack) | General buttons, panels, sliders and interface elements |
| [UI Pack — Sci-Fi](https://kenney.nl/assets/ui-pack-sci-fi) | A coherent science-fiction UI family |
| [UI Pack — Adventure](https://kenney.nl/assets/ui-pack-adventure) | Adventure-themed interface elements |
| [UI Pack — Pixel Adventure](https://kenney.nl/assets/ui-pack-pixel-adventure) | Pixel interface elements and sprite sheets |
| [Game Icons](https://kenney.nl/assets/game-icons) | Game/interface symbols and variations |
| [Input Prompts](https://kenney.nl/assets/input-prompts) | Keyboard, mouse, touch and controller families; included notice identifies 1.5A |
| [Kenney Fonts](https://kenney.nl/assets/kenney-fonts) | Display/pixel font files; no system installation performed |
| [UI Audio](https://kenney.nl/assets/ui-audio) | Click, switch and interface cues |
| [Interface Sounds](https://kenney.nl/assets/interface-sounds) | Additional interface feedback sounds |

Source formats, alternate color/style exports, PNGs, SVGs, sprite sheets, audio and fonts are retained where supplied. Indexed file counts include variants and formats, not only unique designs. Genre-specific character/world art is left to a project's actual art direction instead of collecting unrelated themes.

## Rights and selection findings

- React Bits' pinned custom license distinguishes product integration from standalone redistribution. Keep this private source shelf local and preserve applicable notices when integrating into a product.
- Lucide's actual license includes ISC plus MIT terms for listed Feather-derived icons, despite the API returning `NOASSERTION`. Vuetify likewise needs its nested package license rather than its API label.
- React Suite's actual pinned LICENSE was retrieved and read from its archive, resolving the earlier failed raw-file fetch.
- The inspected Kenney pack notices state CC0. Assets and source remain attributed in the inventory for traceability even where attribution is optional.
- Google's Compose examples carry Apache 2.0 terms; Godot demo source has MIT terms and nested font/asset notices. Inspect the exact media or font before copying it.
- The PDF library was excluded from bulk download because its publications retain individual author rights. Topic feeds were not treated as components to install. Phaser's mixed-rights example art was excluded from the product-asset shelf.

These downloads do not constitute comprehensive legal clearance or a dependency/security review. Root project licensing does not establish the rights of every remotely referenced asset, premium offering or nested third-party file.

## Adaptation approach

Select a component or asset based on the task, inspect its implementation and companion files, adapt it to the project's design and state behavior, then verify the integrated result. Prefer the existing project stack. A source snapshot is not a substitute for its supported package/build contract. Record copied paths, upstream revision, notices and local changes in the target project. Dependency additions follow existing Tier 2 approval; no dependencies were added during this download task.

## Verification scope

The local preparation checks archive SHA-256 values, ZIP CRC, extraction containment, source/asset counts and generated file inventories. A generated file manifest records checksums for extracted bytes. Final inventory consistency, local navigation and search-helper checks are recorded in [work status](../work-status.md).

Final checks passed: 21 collections with notices present; all 36,114 indexed paths exist and are unique; byte totals reconcile; all 218 React Bits components have four source variants; specialized index paths resolve; 986 relative links across nine guide/catalog documents resolve; no trailing whitespace in those documents. Component/import, icon, asset and collection searches and a no-match search returned usable results. All nine Kenney included notices were checked for CC0. Archive checks ran during preparation for each collection. Local `index/verification.json` preserves the final check output.

No upstream install hook, build or demo was run. No browser/device rendering, assistive-technology validation, audio playback, font glyph coverage, performance measurements or full source audit was performed. Download completeness and searchability do not prove production readiness. The original comparative research report remains separate work.

Rollback: remove only this dated library and its new documentation references if the owner no longer wants it; retain all unrelated owner work. No external publication, repository push, purchase or message occurred.
