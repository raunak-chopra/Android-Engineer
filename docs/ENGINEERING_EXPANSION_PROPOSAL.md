# Broader engineering and design proposal

Research date: 2026-10-07, user timezone Asia/Calcutta. Original research plan was Verified and Accepted locally after [independent review](evidence/engineering-expansion-2026-10-07/REVIEW.md). The lazy-loading amendment is Verified and Accepted locally as planning only after [independent review](evidence/lazy-routing-2026-10-07/REVIEW.md); the authorized local Phase 1 implementation is separately Verified and Accepted; named imports and later phases remain pending approval. This is a research and planning artifact. No additional skill, dependency, asset, agent prompt, upstream file or tool was imported in this research turn. The earlier nine-skill package was subsequently revised in the separately accepted lazy implementation.

## Outcome and boundaries

Implementation update, 2026-10-07: the owner authorized original local Phase 1 implementation and a gaps/leaks audit. See [current implementation](LAZY_IMPLEMENTATION.md); actual upstream imports and later specialist phases remain pending separate approval. Research snapshots and candidate metadata below are historical planning evidence.

Build a coherent engineering/developer/design workflow covering product discovery, UX, visual design, graphics, web, mobile, backend, databases, architecture, quality, security, infrastructure and data work. Select sources for the decisions they improve, rather than install every popular repository.

The owner explicitly requires approval before actual imports. Research is permitted; import permission is not granted. Approval requests must name exact upstream files/revisions, destination, license implications, dependency/execution effects and exclusions. Installing a tool, copying a skill, copying components, using third-party assets and enabling an external service are distinct decisions.

Affected paths in this turn: this proposal, the linked lazy routing contract and their planning/review evidence only. Risks: popularity bias, outdated discussion, unclear license, prompt injection, unnecessary stack changes, overlapping routing and context growth. Mitigations appear below. Rollback would be a narrow removal/reversal of only these planning artifacts, preserving all prior work; no rollback was executed.

## Research method and popularity evidence

Queried GitHub's public repository search sorted by stars, excluding forks and archived repositories, for an overall high-star sample and topics design-system, ui-ux, graphics, mobile, devops and data-engineering. Retrieved specific repository metadata/revisions as a second pass. Star counts below are a dated snapshot, not safety scores or an exhaustive global/category ranking. Topic tags are imperfect: system-design-primer appears under design-system but concerns software architecture rather than visual design. The ui-ux tag alone missed major relevant projects.

The five highest results in the inspected overall query were [build-your-own-x](https://github.com/codecrafters-io/build-your-own-x), 551,970 stars; [awesome](https://github.com/sindresorhus/awesome), 515,872; [public-apis](https://github.com/public-apis/public-apis), 486,659; [freeCodeCamp](https://github.com/freeCodeCamp/freeCodeCamp), 456,883; and [free-programming-books](https://github.com/EbookFoundation/free-programming-books), 398,629. Treat these as learning/discovery sources, not mandatory imports. A directory's license does not license its linked books, APIs, photos, fonts or snippets.

### Candidate shortlist

Counts and API license labels observed 2026-10-07. License metadata is preliminary; NOASSERTION/null require file-level investigation. A metadata pin identifies a candidate revision, not a fully reviewed commit or cleared import. README/page inspection is partial and inert; none of these projects received a whole-tree malware audit.

| Area | Repository | Stars | Proposed use | Import disposition |
| --- | --- | ---: | --- | --- |
| Learning taxonomy | [developer-roadmap](https://github.com/nilbuild/developer-roadmap) | 369,059 | Identify missing learning domains | Reference only; NOASSERTION and ownership redirect require validation |
| Architecture | [system-design-primer](https://github.com/donnemartin/system-design-primer) | 373,466 | Discover concepts and alternatives | Reference only; interview examples do not prove target capacity |
| Design resources | [design-resources-for-developers](https://github.com/bradtraversy/design-resources-for-developers) | 67,100 | Find fonts, colors, icons and design tools | Recommended discovery source; review each linked asset separately |
| Design tools | [Awesome-Design-Tools](https://github.com/goabstract/Awesome-Design-Tools) | 41,414 | Find UX/prototyping tools | Discovery only; no plugins or paid tools installed |
| Product design collaboration | [Penpot](https://github.com/penpot/penpot) | 60,778 | Study design/developer handoff | Optional tool, not a prerequisite; MPL-2.0 metadata |
| Component workflows | [Storybook](https://github.com/storybookjs/storybook) | 91,204 | Component states, documentation and verification | Recommended workflow reference; install only for a suitable target |
| Component implementation | [shadcn/ui](https://github.com/shadcn-ui/ui) | 125,244 | Study composable React components | Conditional; copied components become maintained target code |
| Icons | [Lucide](https://github.com/lucide-icons/lucide) | 24,887 | Consistent icon system | Conditional asset import; NOASSERTION requires exact license check |
| Browser 3D | [Three.js](https://github.com/mrdoob/three.js) | 116,309 | Rendering, scenes and graphics integration | Conditional; do not turn ordinary UI into a 3D app |
| React 3D | [React Three Fiber](https://github.com/pmndrs/react-three-fiber) | 32,776 | React-specific rendering integration | Only for an existing or approved React/Three.js need |
| Games | [Godot](https://github.com/godotengine/godot) | 118,220 | 2D/3D game-specific workflow | Separate optional domain; no engine installed |
| Mobile | [Flutter](https://github.com/flutter/flutter) | 179,358 | Flutter-specific architecture and verification | Reference; no default framework switch |
| Mobile | [React Native](https://github.com/react/react-native) | 126,809 | Native/JS integration and mobile testing | Reference; API redirected old facebook path to react owner |
| iOS architecture | [Composable Architecture](https://github.com/pointfreeco/swift-composable-architecture) | 14,950 | Compare state/effect/testing boundaries | Example, not mandatory Swift dependency |
| Android | [Now in Android](https://github.com/android/nowinandroid) | 21,891 | Existing Android evidence and sample patterns | Reuse established Android skills; no wholesale sample import |
| Browser verification | [Playwright](https://github.com/microsoft/playwright) | 97,217 | Interaction and browser regression workflows | Conditional existing/approved tooling |
| Accessibility checks | [axe-core](https://github.com/dequelabs/axe-core) | 7,608 | Automated accessibility evidence | Supplement manual checks; popularity is not the selection criterion |
| Infrastructure | [Kubernetes](https://github.com/kubernetes/kubernetes) | 128,369 | Operational concepts when target uses Kubernetes | No default cluster adoption or cloud actions |
| Infrastructure as code | [OpenTofu](https://github.com/opentofu/opentofu) | 30,408 | Plan/state/provider workflow | Reference; no provider, state or credential access |
| Data transformations | [dbt](https://github.com/dbt-labs/dbt) | 13,973 | Lineage, transformation and data-test workflow | Reference; API redirected dbt-core path; validate identity before adoption |

[Graphite](https://github.com/GraphiteEditor/Graphite) is an additional graphics/motion candidate (27,485 stars in the topic query; Apache-2.0 API label), metadata-level only in this pass. It may inform procedural asset workflows but is not selected as a required tool.

### Popular agent design packs: hold for exact-file review

[awesome-design-md](https://github.com/VoltAgent/awesome-design-md) had 119,886 stars in the topic snapshot; its README proposes copying brand-derived design documents into projects. Keep it as an optional inspiration candidate, not imported policy. Brand references need originality and asset-rights review; the repo license is not permission to reuse every brand asset. Promotional integrations are not part of this proposal.

[taste-skill](https://github.com/Leonxlnx/taste-skill) advertises multiple frontend/image workflows. Its README labels its v2 default experimental and describes strong visual/motion prescriptions, including GSAP skeletons. Those are reasons to review fit and exact instructions, not evidence of malware. Metadata pin retrieval failed for these two packs in this pass; neither is approved for import. Do not run their installer commands or paste their prompts into active instructions without the requested review and owner approval.

## Reddit findings and how they affect the plan

Reddit posts/comments are anecdotes and discovery leads. Upvotes are not technical validation. Read communities on both sides of a framework comparison; do not adopt hearsay about support, security, benchmarks or store compliance.

| Discussion | Useful signal | Planning implication |
| --- | --- | --- |
| [200+ design resources](https://www.reddit.com/r/webdev/comments/geslxq) and [visual-design resources](https://www.reddit.com/r/webdev/comments/iq6bcq) | Community points to design-resource lists and visual fundamentals | Add typography, hierarchy, spacing and composition; re-check old links and current asset terms |
| [Design-system resources](https://www.reddit.com/r/Frontend/comments/1of2ago/design_system_resources/) | Discussion recommends inspecting established components/design systems | Plan tokens, state coverage and component handoff instead of a screenshot-only design workflow |
| [Underrated UX research methods](https://www.reddit.com/r/userexperience/comments/1l8sq7k/whats_the_most_underrated_ux_research_method/) | Participants discuss interviews, top tasks and contextual/longitudinal methods | Keep discovery/research distinct from polished UI; label untested user assumptions |
| [Penpot discussion](https://www.reddit.com/r/opensource/comments/1b8n7fo) | Interest in an open-source collaborative design alternative | Preserve tool choice and assess current capabilities from Penpot's own documentation |
| [React Native community comparison](https://www.reddit.com/r/reactnative/comments/1v5qdd2/at_what_point_would_you_choose_flutter_over_react/) and [Flutter community comparison](https://www.reddit.com/r/FlutterDev/comments/1v599mk/flutter_vs_react_native_in_2026_which_would_you/) | Different preferences and tradeoffs across communities | Select by team, target platforms, native integrations and measured prototype results; never by subreddit winner |
| [Experienced engineering resources](https://www.reddit.com/r/ExperiencedDevs/comments/1kc54xu/best_books_for_experienced_developers_on/) | Discussion spans architecture and broader engineering responsibilities | Include decision records, communication, constraints and maintainability, beyond framework recipes |

One UI-elements thread failed to open; only its search snippet was available and it is not grounding for the proposal. Apple HIG and Material websites rendered minimal text through the browser reader; their official entrypoints are recorded below, not claimed as fully inspected technical guidance.

## Proposed routing model

The owner's lazy-loading requirement is specified in the [lazy routing contract](LAZY_ROUTING_CONTRACT.md): direct specialist routing, single-coordinator precedence, conditional references, measured load budgets and adjacent/negative fixtures. That contract is the canonical home for the expanded loading rules; this table identifies candidate responsibilities.

Proposed, not implemented. Add one compact `engineering-router` only because the combined library now spans several platforms and artifact types. Keep `fullstack-delivery` as the coordinator for web/API/storage features; keep `android-router` as the Android coordinator. Route from desired outcome and inspected target, not keyword popularity.

1. Determine deliverable: product decision, design specification, asset, app behavior, data operation, diagnosis or operational change.
2. Inspect target instructions, technology and existing assets. Honor an explicitly selected tool/framework/skill.
3. Choose the smallest responsible specialist set. Add a cross-cutting specialist only for a demonstrated boundary: security for changed trust, accessibility for interaction/access changes, architecture for consequential ownership changes.
4. Define a handoff artifact and its verification. Implementation consumes agreed design/contract evidence; an image does not become working UI automatically.
5. Preserve user authority. Imports wait for named approval; deployment, destructive actions and external writes retain their separate gates.

| Request | Responsible route | Artifact and verification |
| --- | --- | --- |
| Understand users or define a confusing flow | Proposed `product-ux-design`; existing `mobile-product-design` for mobile specifics | Assumption map, user/task flow, information architecture and consent-aware research plan; real usability findings only if performed |
| Improve appearance or build a reusable design language | Proposed `visual-design-system` + target UI specialist | Original typography/color/spacing tokens, component states, responsive specifications; contrast, long-text, focus and state checks |
| Create a logo/icon/illustration | Proposed `graphics-assets` chooses vector/code or existing `imagegen` for raster | Editable/native asset where appropriate, export specs and rights record; inspect small-size clarity, backgrounds and target rendering |
| Create a 3D/motion interaction or game | Proposed conditional `graphics-motion-3d` reference workflow | Scene/animation brief, performance budget and reduced-motion/fallback behavior; actual runtime verification |
| Build a web feature | Existing `fullstack-delivery` with web/backend/database specialists | Working flow, API/schema compatibility, authorization and regressions |
| Build or repair Android | Existing `android-router` and Android specialists | Target build/test evidence; design goes through existing mobile-product-design |
| Build or repair iOS | Proposed `ios-development` with official Apple references | Swift/SwiftUI lifecycle, navigation, data and accessibility evidence; target build/runtime required |
| Build Flutter or React Native | Proposed `cross-platform-mobile` with on-demand framework references | Platform capability matrix, native integration and platform-specific runtime checks; no implicit migration |
| Desktop-specific behavior | Proposed `desktop-engineering` only for a real target | OS integration, permissions, windowing, packaging and updater evidence; no packaging install by default |
| Change infrastructure/CI | Proposed `platform-devops` + existing supply-chain/security/reliability | Reviewed configuration/plan and isolated evidence; credential use and apply/deploy remain separate actions |
| Build data pipelines or analytics | Proposed `data-engineering` + database/security where needed | Schema/lineage, backfill, data quality, idempotency and retention evidence |
| Build AI/ML behavior | Existing product/backend/security/testing first; proposed `ai-ml-engineering` only with a concrete need | Data/model provenance, evaluation set, privacy/cost bounds and failure behavior; no unnecessary framework adoption |
| Produce documentation, charts or presentations | Existing documents/pdf/presentations/spreadsheets/visualize skills | Use their artifact-specific verification; do not duplicate them in new skills |

Accessibility/internationalization, performance, privacy, documentation and developer experience are cross-cutting acceptance concerns. The proposal does not require all specialists for every small edit. Game, 3D, desktop and ML routes remain deferred until there is a real task.

Official runtime/design references to consult during implementation: [W3C WAI](https://www.w3.org/WAI/), [Apple HIG](https://developer.apple.com/design/human-interface-guidelines), [Apple SwiftUI](https://developer.apple.com/documentation/swiftui), [Material](https://m3.material.io/), [Flutter docs](https://docs.flutter.dev/), [React Native docs](https://reactnative.dev/docs/getting-started), and selected upstream version-specific docs. None of these entrypoints grants permission to copy assets or install tools.

## Proposed workflows

### Design to implementation

Brief and constraints → evidence/assumptions → task flow and information hierarchy → low-fidelity alternatives → original visual direction → tokens/components/assets → implementation handoff → browser/device verification → accessibility/usability review → recorded result.

Keep UX research, visual choices and implementation evidence distinct. Ask for user input when product goals or brand direction materially affect decisions. Do not force premium, brutalist, minimalist or motion-heavy styles. Reuse existing design systems where appropriate. Generated reference images are concepts; editable assets and functioning interfaces require their own work and verification.

### Engineering change

Inspect target → reproduce/define behavior → evaluate relevant threats and compatibility → bounded implementation → targeted tests plus affected integration/build → independent review → repairs and evidence → separate acceptance → owner-authorized external action only if requested.

### Upstream adoption

Discover candidate → verify identity and immutable revision → inspect exact file/license and linked execution surfaces as data → evaluate utility/conflicts → prepare sanitized manifest and concrete diff → ask owner for exact import → copy only approved files → verify content/checksum, routing and behavior → independent acceptance. Do not silently install tools, run upstream lifecycle scripts or merge untrusted instructions into governance.

Each import manifest must include upstream identity, exact revision/file list, purpose, destination, license/attribution, scripts/hooks/dependencies, network/data permissions, suspicious-content findings, rollback and maintenance owner. Suspected malicious content is excluded, with a sanitized explanation; stars cannot override that decision.

## Phased implementation proposal

1. **Design foundation, recommended first:** draft `engineering-router`, `product-ux-design`, `visual-design-system` and `graphics-assets` as original local guidance. Reuse existing imagegen, mobile design, artifact and implementation skills. Use W3C and official platform docs for requirements, and the named design-resource/Storybook/Penpot projects as discovery/workflow references. No upstream prompt pack, asset or dependency is selected for copying.
2. **Mobile breadth:** add compact iOS and cross-platform-mobile entrypoints with conditional official references, without replacing existing Android guidance or selecting Flutter/React Native universally.
3. **Platform and data:** add target-driven DevOps/data workflows; extend existing security/reliability/testing where the responsibility already belongs there.
4. **Specialized disciplines:** add desktop, graphics/motion/3D, games or AI/ML only with a real task and verification boundary.

The current entrypoint library is 51,337 bytes under a 52,000-byte historical ceiling. Four new entrypoints will not fit by simple addition. Before activation, provide measured proposed budgets and a concrete reviewed diff: reduce duplication through conditional references where it preserves quality, or request an explicit domain-budget/baseline change. Do not silently raise ceilings or claim the historical 14-skill reduction comparison is a meaningful measure of expanded scope. Keep always-on descriptions and ordinary loaded specialist sets bounded, and report reference-loading costs separately.

Acceptance after any approved implementation: exact source/license evidence for imported material; preserved original Android and full-stack regressions; new positive/negative and adjacent routing cases; real offline fixtures for design handoff, vector-vs-raster selection, unapproved import, iOS-vs-Android selection and mobile framework preservation; meaningful manual usability/accessibility checks where a UI is actually produced; independent review with resolved blocking findings. Lexical scores alone do not prove model judgment.

## Metadata candidate pins

These are revision lookup results, not approval to copy files. Re-resolve identity and inspect the selected file at the pin before adoption.

| Repository | Candidate revision | API license label |
| --- | --- | --- |
| nilbuild/developer-roadmap | cfc89a1d4b6d94b03147dce03d1facc13173e0bb | NOASSERTION |
| donnemartin/system-design-primer | ae9bbd7b02d90b9866215de185217d33f39ab733 | NOASSERTION |
| bradtraversy/design-resources-for-developers | 37b44d0eecdd4f99cc1c39a034572437dc044da8 | MIT |
| goabstract/Awesome-Design-Tools | dc60e63c248c44acb42f09fb0c985b77b5fe4bf5 | MIT |
| penpot/penpot | 6473dc85abbb352e2cbda40e2d3c6e409e157d34 | MPL-2.0 |
| storybookjs/storybook | a63043ec5ba9e1d07d7a9f7f373b643343cfaccf | MIT |
| shadcn-ui/ui | dd34945272729ecd198fabb0e32082f6321c210e | MIT |
| lucide-icons/lucide | e33a85960309a984de6c31562a0086600b0904ad | NOASSERTION |
| mrdoob/three.js | 7c419ddae99fe0f666b509072fcf47e2017542e7 | MIT |
| pmndrs/react-three-fiber | d604b18bbda025d9ca682efb322cc76b99350e52 | MIT |
| godotengine/godot | 3ea0cf3e72699c5e3b35f7956670ac93b9d1d4a0 | MIT |
| flutter/flutter | d454b1b841d223f28bb725bb2928e2ac337b5611 | BSD-3-Clause |
| react/react-native | bf62cce504e569cf9c6e12ae21d5c96ddb3a5538 | MIT |
| pointfreeco/swift-composable-architecture | bc2db5ba8ad3a47deba5db32fa340637ba6c9a76 | MIT |
| android/nowinandroid | a49ed253d75e61a2b6ab80a8da677b57437b08eb | Apache-2.0 |
| microsoft/playwright | d469960fdfc461e2d5795a3fa48a58a52a91ecaf | Apache-2.0 |
| dequelabs/axe-core | 8944d7652e388f6a7a0b3766579548d8720bd9fd | MPL-2.0 |
| kubernetes/kubernetes | dffafe8699f3c41b300e8ebf361cd0b4115f3e7a | Apache-2.0 |
| opentofu/opentofu | 6d58bff177a4c2c15981bcfffa9b861d9a766880 | MPL-2.0 |
| dbt-labs/dbt | b5756747aa8769029e26d90b81444b791f8e9a51 | Apache-2.0 |

## Approval boundary

Recommended next decision: approve Phase 1 original local design/routing drafts and budget proposal, with zero copied upstream files, assets, installers or dependencies. If the owner wants actual third-party imports, first prepare the exact-file manifest described above and ask for that named import separately. Nothing in this research or proposed plan grants that approval.
