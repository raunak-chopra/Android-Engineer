# Design resources: research brief, initial findings and detailed report plan

Date: 2026-10-21 (Asia/Calcutta). Status: planning deliverable complete; initial source reconnaissance complete; full source-level deep-dive report and owner-approved Tier 2 skill-reference updates completed in [design-resources-deep-dive-2026-10-21.md](design-resources-deep-dive-2026-10-21.md); project runtime pilots remain deferred until a target project is selected.

Follow-up evidence: the owner requested hands-on learning and React downloads. A pinned six-component local cache and selective source findings are recorded in [React asset study](react-assets-study-2026-10-21.md). This was the selective-inspection stage; the later source report supersedes its pending-audit status. Runtime pilots remain pending. The report's Section 11.1 records the owner-approved guidance corrections. The initial planning-pass record below retains its original scope.

Subsequent owner direction expanded downloads to complete useful collections. See the [complete library record](reuse-library-downloads-2026-10-21.md) and [task-based reuse guide](../RESOURCE_LIBRARY.md). Pinned downloads supersede sampling as the resource acquisition approach; they do not establish comprehensive source review or runtime quality.

## Purpose and scope

Turn the owner's 12 links into practical improvements to how we think about, describe, design and build apps and games. The final research should answer three separate questions: what should we learn, what can we reuse in a product, and what can we redistribute in Engineer's reusable toolkit?

This document contains a researched plan and preliminary findings, not a completed deep audit. It belongs in Engineer because it concerns reusable guidance across projects. The catalog currently contains no app entries. No other project or bot workspace was accessed. No standards, skills, dependencies or project code were changed.

The supplied `ant-design/ant-desig` address could not be fetched. Working assumption: the intended source is [ant-design/ant-design](https://github.com/ant-design/ant-design), whose repository was accessible. Confirm this only if a different source was intended.

## Initial conclusions

1. The list combines component libraries, a motion library, a design-system directory, a reading library and two discovery feeds. They need different evaluation methods.
2. Most implementation sources target the web. UI Kitten targets React Native. A useful principle can cross platforms; React/Vue code cannot simply be used as native Compose or engine UI.
3. The most promising shared learning is a vocabulary of semantic roles, component states, composition, information hierarchy, feedback and theme consistency. These are research priorities, not proof that a particular library improves our products.
4. Games need additional evidence about active play, controls, readability, feedback and assets. App settings, menus and inventories may benefit from app patterns, but gameplay requires its own evaluation.
5. Availability is different from redistribution permission. Two supplied sources already require special handling: React Bits' custom license and the reading library's third-party publications. See the rights findings below.

## All 12 supplied sources and the questions they should answer

Repository facts below come from the linked upstream pages inspected on 2026-10-21. Learning and reuse columns are proposed investigation directions. They are not adoption verdicts or measured quality rankings.

| Source | What was observed | What to study closely | Potential outcome for us |
| --- | --- | --- | --- |
| [Ant Design](https://github.com/ant-design/ant-design) | Enterprise web design language and React components; design resources, internationalization and theme customization | How principles become layout and component decisions; forms, data density, recovery and theme roles | Pattern references for complex apps and game management tools; original rules for hierarchy and state clarity |
| [React Bits](https://github.com/DavidHDev/react-bits) | Animated React components and backgrounds; linked introduction describes copyable variants and creative tools | Motion purpose, timing, interaction feedback, reduced-motion alternatives, dependency and rendering costs | Selected effects within products after review; motion vocabulary and examples rather than a redistributed component pack |
| [daisyUI](https://github.com/saadeghi/daisyui) | Tailwind CSS component library; official theme documentation describes built-in and custom themes | Semantic color roles, theme scope, component variants, and where behavior remains the app's responsibility | Rapid web theme studies and guidance for coherent variations |
| [Vuetify](https://github.com/vuetifyjs/vuetify) | Vue component framework; README describes responsive layout, theme configuration and customization | Material-derived hierarchy, adaptive layouts, density and defaults; customization without losing coherence | Vue project candidate; platform-neutral lessons about layout and consistent component defaults |
| [Chakra UI](https://github.com/chakra-ui/chakra-ui) | React component system; documentation defines semantic tokens and references to base tokens | Semantic roles, recipes, composed components, focus and interaction state handling | A clearer design-to-code vocabulary; React implementation candidate subject to project fit |
| [Awesome Design Systems](https://github.com/alexpate/awesome-design-systems) | Directory labels components, voice/tone, design kits and source availability | Follow a bounded sample of systems to original guidance; compare content, governance and pattern explanations | A curated primary-source reading map; public source visibility alone does not establish reuse rights |
| [Vant](https://github.com/youzan/vant) | Vue library for mobile web; README links themes, demos, design resources and internationalization; accessibility described as improving | Compact mobile tasks, pickers, overlays, touch behavior, long content and safe-area handling | Mobile-web patterns; hypotheses to translate and validate for native apps |
| [UI/UX Design Library](https://github.com/justinhartman/ui-ux-design-library) | Reading collection organized by UX, interaction, typography, testing, mobile and other topics; copyright section retains author rights | Title-level relevance, publication date, publisher provenance and permission; practical exercises per reading | Annotated curriculum linked to authorized originals; no bulk PDF copying into Engineer |
| [UI Kitten](https://github.com/akveo/react-native-ui-kitten) | React Native components based on Eva; runtime themes and compatibility guidance | Theme mapping, native component states and current platform support; reconcile README, release and package evidence | React Native candidate; conceptual theme mapping for other native toolkits |
| [React Suite](https://github.com/rsuite/rsuite) | React web components; versioned documentation and SSR/framework guides | Data entry, filtering, tables, date controls, validation, density and accessible interaction | Reference for operational apps, content tools and game administration interfaces |
| [ux-ui-design topic](https://github.com/topics/ux-ui-design) | Mixed discovery page containing learning projects and agent-related material | Deduplicate, identify authors and inspect promising repositories directly | Small discovery shortlist with explicit accept/reject reasons |
| [ui-ux-design topic](https://github.com/topics/ui-ux-design) | Mixed discovery page containing templates, mobile apps, course work and skills | Same screening; find actual design reasoning and working examples rather than rely on tags | Additional candidates only when they fill a documented gap |

### Concrete first findings worth pursuing

**Role-based visual language.** [Chakra's semantic-token documentation](https://chakra-ui.com/docs/theming/semantic-tokens) separates contextual roles from base values. Proposed lesson: describe intent such as `text.muted`, `surface.raised` or `action.danger` before choosing a color. Test how these roles survive light/dark modes, disabled states and different brands.

**Theme variation with a stable component vocabulary.** [daisyUI's theme documentation](https://daisyui.com/docs/themes/) describes built-in themes and custom themes. Proposed lesson: compare themes using identical content and states; evaluate identity, readability and interaction clarity separately. A new palette alone is not a complete design direction.

**Principles connected to decisions.** [Ant Design's values page](https://ant.design/docs/spec/values/) exposes Natural, Certain, Meaningful and Growing as value headings. The text extraction was incomplete, so the full rationale still needs inspection. Proposed exercise: for every principle we retain, write one observable design decision and one counterexample instead of borrowing a slogan.

**Motion and creative production.** The [React Bits introduction](https://reactbits.dev/get-started/introduction) lists text animation, backgrounds, micro-interactions and tools for backgrounds, product shots, shapes, textures and sounds. These expand the research beyond component selection. Evaluate one example from each relevant category, including a static alternative, asset/export rights and device cost. No tool or export was exercised in this pass.

**Language belongs in the design system.** Awesome Design Systems explicitly includes voice/tone as a resource dimension. Follow [GOV.UK Design System](https://design-system.service.gov.uk/) for task patterns and content references, then compare primary guidance from a small contrasting sample. Do not infer that an entire linked system is openly licensed from its inclusion in a list.

## Rights and provenance findings

These are observations of upstream terms, not blanket clearance of every file, design kit, template, dependency or asset. Final adoption requires the exact version and files to be checked.

| Resource | Evidence inspected | Consequence for the research |
| --- | --- | --- |
| Ant Design | [MIT license text](https://raw.githubusercontent.com/ant-design/ant-design/master/LICENSE) | Candidate for attributed code reuse; inspect separate ecosystem assets individually |
| daisyUI | [MIT license text](https://raw.githubusercontent.com/saadeghi/daisyui/master/LICENSE) | Evaluate core library separately from linked commercial offerings |
| Vuetify | [Package MIT license text](https://raw.githubusercontent.com/vuetifyjs/vuetify/master/packages/vuetify/LICENSE.md) | Root license points to the package file; follow such indirection during audit |
| Chakra UI | [MIT license text](https://raw.githubusercontent.com/chakra-ui/chakra-ui/main/LICENSE) | Core source and premium resources require separate records |
| Vant | [MIT license text](https://raw.githubusercontent.com/youzan/vant/main/LICENSE) | Assess linked icons, kits and ecosystem packages individually |
| UI Kitten | [MIT license text on master](https://raw.githubusercontent.com/akveo/react-native-ui-kitten/master/LICENSE.txt) | Verify the selected release and branch before use; related icons/themes need their own provenance |
| React Suite | [Repository MIT label](https://github.com/rsuite/rsuite) | Raw `main/LICENSE` fetch failed; retrieve exact file and release before copying |
| React Bits | [Current custom license](https://raw.githubusercontent.com/DavidHDev/react-bits/main/LICENSE.md) says MIT plus Commons Clause, with express restrictions | It permits use within products but restricts redistribution of components, tools, sounds and standalone exports. Do not classify it as unrestricted MIT or vendor its content into a reusable Engineer pack |
| UI/UX Design Library | [README copyright section](https://github.com/justinhartman/ui-ux-design-library#copyright) | Each author's rights remain; publicly downloadable PDFs are not automatically open educational resources |
| Directory/topic links | [Awesome list](https://github.com/alexpate/awesome-design-systems), [topic one](https://github.com/topics/ux-ui-design), [topic two](https://github.com/topics/ui-ux-design) | Check every destination independently; list licensing does not license linked material |

The full evidence register should distinguish code, documentation, fonts, icons, illustrations, audio, templates, design files and trademarks. Record owner, source URL, exact file, version/commit, checked date, terms, required notices, allowed use and unresolved questions. A summary badge never substitutes for file-level evidence.

## Detailed report structure

The intended deliverable is a navigable Markdown report with appendices. Its length should follow the evidence; a practical target is approximately 20–30 reading pages excluding the register. A PDF or deck can be derived later if useful.

| Chapter | Questions to resolve | Required output |
| --- | --- | --- |
| 1. Decisions and scope | Which resources merit learning, product reuse, experiments or exclusion? For which platforms? | Short prioritized decision matrix with confidence and rationale |
| 2. Source landscape | What do all 12 inputs contain? What is original versus an index or derivative? | Ten repository dossiers and two topic discovery records |
| 3. Design thinking | How do user tasks, hierarchy, disclosure, constraints and recovery shape design? | Principle-to-decision examples, evidence limits and counterexamples |
| 4. Visual language | How are color, typography, spacing, density, surfaces and themes organized? | Cross-system token map and original direction criteria |
| 5. Interaction and content | How do components communicate state, focus, errors, progress and next actions? | State matrices, content examples and motion rules to test |
| 6. App application | Which patterns fit web, mobile web, React Native and native Android? | Platform decision guide and three app task case studies |
| 7. Game application | Which lessons fit menus and HUDs? What must be learned from game-specific sources? | Separate shell, active-play and feedback guidance with examples |
| 8. Reusable resources | What code, assets, kits and learning materials can we actually use? | Curated register with rights and setup costs; free core versus paid extras |
| 9. Learning programme | What order builds judgment instead of familiarity with one framework? | Exercises, deliverables and review criteria |
| 10. Engineer upgrade proposal | What is missing or weak in our current guidance, and what exact edits would help? | Bounded path-level proposal, before/after examples and evaluation plan |

Every dossier should include purpose, audience, stack, documentation map, representative source paths, token architecture, five component/state samples, design resources, license boundaries, release/maintenance evidence, usability caveats and the proposed disposition. Supply exact links for reusable items, not just repository homepages.

## Research method and completion gates

### Pass 1 — Map and establish provenance

Complete the source register for all 12 inputs. Pin repository evidence to commits or releases. Record current documentation generation, package compatibility and archive/deprecation signals. Inspect recent release notes, representative resolved/unresolved issues and actual test/example locations; a last-updated date or star count does not establish health.

For each topic page, collect up to ten relevant candidates from the page as observed on the research date, deduplicate across both pages, and deeply inspect at most five unique candidates. Explain exclusions such as course solutions, portfolios without reusable guidance, missing rights or unrelated agent tooling. Do not install third-party skills found through these pages.

For Awesome Design Systems, begin with up to six contrasting systems selected for clear primary guidance on foundations, content, accessibility and governance. GOV.UK is already confirmed as a useful primary destination. Validate other destinations before recommending them. For the reading library, shortlist up to eight items and trace each to an author/publisher source before summarizing or recommending it.

**Gate:** every proposed reusable resource has an original source, clear type, platform scope and rights status. Unknowns remain explicitly unknown.

### Pass 2 — Inspect mechanisms and compare equivalent patterns

For every implementation library, inspect one foundation/theme mechanism plus five representative examples chosen for its role: action/button, input with validation, dialog or overlay, navigation, and list/data presentation. For React Bits use motion categories instead of forcing form-control comparisons. Trace docs to implementation and test/example evidence where available.

Capture anatomy, variants, state transitions, focus/keyboard behavior, touch behavior, long/localized content, loading/empty/error recovery, light/dark handling and reduced-motion alternatives. Distinguish upstream accessibility claims from behavior we actually test.

**Gate:** each extracted lesson has a specific example, intended problem, platform limits and a counterexample or failure mode. No generic “best UI library” score.

### Pass 3 — Synthesize original design guidance

Compare patterns around the same user task. Separate structural clarity from aesthetic preference. Produce original annotated examples for an app form, a dashboard/list task and a game menu/HUD. Explore at least three coherent directions: information-dense utility, calm consumer interface and expressive game interface. These are comparison briefs, not universal styles.

**Gate:** each direction is described through hierarchy, typography, surface treatment, spacing, motion and language; it works with realistic content and required states. Moodboards and mockups do not establish working usability.

### Pass 4 — Validate selected hypotheses in project repositories

Proposed pilots, deferred until an owner-selected project is identified:

| Pilot | Task and variation | Evidence to collect |
| --- | --- | --- |
| Web app | Find/filter an item, edit details, recover from validation; compare neutral and branded themes | Render at mobile/desktop widths; keyboard/focus, long content, error recovery and console checks |
| Native app | Complete a short mobile task with keyboard, interruption and large text | Native implementation and build/test evidence; emulator/device flow and assistive-technology checks |
| Game | Enter play, read HUD, pause/resume, recover/retry; test feedback with reduced motion and muted audio | Engine build, target-device play session, readability/input observations and frame-time evidence |

These are planned experiments. Do not add dependencies or create product code inside Engineer. Participant research, if used, needs an appropriate protocol and authorized recruitment; a heuristic review cannot be reported as a user finding.

**Gate:** separate observed results, measurements, interpretations and unresolved hypotheses. Choose device/performance budgets from the selected project's requirements, not from arbitrary universal numbers.

### Pass 5 — Deliver findings and a bounded adoption proposal

Assign each item one disposition: learn, adapt as an original pattern, reuse code in a named stack, use an asset under its verified terms, experiment, or defer/exclude. Include confidence and evidence level: documentation only, source inspected, or runtime checked.

Map proposed changes against the existing product UX, visual design, mobile product, game UX, frontend and graphics skills only after their relevant files are inspected. Avoid duplicate rules across skills. Each proposed edit needs a demonstrated gap, destination, rationale, example, check and rollback path.

**Gate:** report complete, findings sourced, uncertainties explicit, and future changes presented for review. Actual standards/skill edits follow Engineer's Tier 2 plan approval and fresh-context review requirements in [AGENTS.md](../../AGENTS.md). Research documentation itself is Tier 1.

## Design language to develop and test

The following vocabulary is an original proposed working model. The research should refine it rather than turn it into policy automatically.

| Vague request | More useful design statement | What it makes reviewable |
| --- | --- | --- |
| Make it modern | Prioritize the main task, use a deliberate type hierarchy and specify one coherent surface treatment | Hierarchy, typography and material choices |
| Make it pop | Give the primary action the strongest action contrast; keep supporting controls quieter | Attention and action hierarchy |
| Add polish | Define pressed, focus, loading, error and success states, including interrupted actions | Behavior and recovery |
| Make it playful | Use a chosen shape language and one feedback motif linked to player actions | Identity, consistency and feedback purpose |
| Add animation | Name the trigger, information conveyed, duration/easing, interruption behavior and reduced-motion fallback | Motion as an interaction decision |
| Make it mobile friendly | State thumb/input needs, safe-area behavior, text scaling and keyboard/overlay interaction | Platform constraints |
| Make the game UI better | Preserve playfield visibility, make critical HUD information legible and keep controls distinguishable under play conditions | Active-play usability |

Proposed shared layers: primitive values → semantic roles → component states → task patterns → product/game identity. Reuse intent across platforms; implement according to platform conventions. Separate color semantics from decorative palette, and navigation state from reward/progression state.

## Game-specific resources to add to the investigation

These sources fill gaps in the supplied list. Their primary pages were inspected, but individual demos/assets were not run or audited.

| Resource | Why include it | Boundary already established |
| --- | --- | --- |
| [Godot demo projects](https://github.com/godotengine/godot-demo-projects) | Official examples include GUI, mobile, audio and loading areas; useful for tracing design into engine behavior | README states MIT for demos and distinguishes stable-version branches from development master. Match the engine version and inspect asset notices |
| [Kenney support and asset licensing](https://kenney.nl/support) | Practical starting point for coherent game UI, art and audio asset searches | Support page says assets on asset pages are CC0; check the selected pack's included license. This does not establish terms for every Kenney product/tool |
| [Game Accessibility Guidelines](https://gameaccessibilityguidelines.com/) | Game-specific learning structured into basic, intermediate and advanced guidance | Treat as design guidance; do not claim a game's accessibility was verified by reading it |
| [Phaser examples](https://github.com/phaserjs/examples) | Official executable learning examples for web-game behavior | README describes Phaser 4 development examples despite the repository About text saying Phaser 3. It states source is MIT but example assets are not covered and may not be used in commercial/ad-supported games. Pin runtime version and replace assets |

The game report should cover menu and HUD hierarchy, information under time pressure, input feedback, pause/resume, save/retry clarity, control remapping, text readability, audio alternatives and reduced motion. It should distinguish onboarding, active play, progression and store interfaces. Do not transfer enterprise dashboard density directly into a small playfield.

## Learning sequence and tangible outputs

1. **Tasks and hierarchy:** analyze one real app flow and one game loop; produce a task/state map with assumptions and recovery paths.
2. **Foundations and semantics:** compare Ant, Chakra and daisyUI mechanisms; produce an original primitive/semantic/component token map with two themes.
3. **Components and content:** compare equivalent controls in the relevant stacks; produce state matrices and concise action, error and empty-state copy.
4. **Mobile translation:** study Vant and UI Kitten; explain what transfers conceptually and what must follow native conventions; produce annotated mobile layouts.
5. **Motion and game feedback:** examine selected React Bits effects alongside engine examples; produce one purposeful motion study, a reduced-motion alternative and a game feedback specification.
6. **Evidence and reuse:** review rights, implementation cost and pilot observations; produce a curated resource register and a short adoption recommendation.

Each exercise ends with a reviewable artifact and stated evidence limits. Reading completion is not proof of design skill; evaluate the resulting decisions and behavior.

## Proposed resource-register fields and decision rules

Fields: resource ID; name; original URL; repository/commit or edition; category; platform; exact useful file/page/example; problem solved; learning exercise; direct reuse versus conceptual adaptation; code/doc/asset terms; notice requirements; free/paid boundary; dependencies; maintenance evidence; inspection level; confidence; proposed disposition; destination; next verification date or trigger.

Evaluate task fit, design clarity, platform fit, accessibility evidence, customization effort, maintenance and rights separately as strong/mixed/weak/unknown, with reasons. Keep rights and compatibility as gates; do not average them away in a weighted score. A readable directory can be excellent for discovery and unsuitable for code reuse at the same time.

Recheck volatile claims immediately before adoption and when versions, maintainers or license files change. Preserve prior evidence as dated history rather than silently replacing it.

## Verification record and limitations of this planning pass

Completed: read Engineer policy, change control, standards, work status, empty catalog, relevant UX/visual skills and their research/handoff references; inspected all supplied valid pages and the assumed Ant correction; read selected official documentation and license texts; inspected four additional primary game resources. Self-review distinguishes source facts, recommendations and planned work. Local document checks are recorded in the accompanying work-status entry.

Limits: web results include cached extracts with varying crawl dates; no repository commits were pinned or downloaded. No comprehensive release/issue audit, component source walkthrough, PDF reading, design-kit inspection, UI rendering, accessibility test, performance measurement or project pilot ran. Vuetify and Vant theme/home documentation yielded no extractable body; their repository READMEs supplied the initial overview. Ant values text was incomplete. The attempted Adobe Spectrum content-standards URL was inaccessible; no finding relies on that page. React Suite's raw license path failed; its MIT status remains a repository-label observation in this pass. Final permission assessments need exact files/releases.

No toolkit readiness or quality improvement is claimed. Next research step: Pass 1, followed by source-level dossiers and synthesis. No decision about a project framework is implied by this plan.
