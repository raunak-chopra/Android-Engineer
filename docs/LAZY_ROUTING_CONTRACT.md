# Lazy routing contract

Date: 2026-10-07. Planning contract was Verified and Accepted after [independent review](evidence/lazy-routing-2026-10-07/REVIEW.md). The owner now authorized the original local implementation and audit; see [implementation status](LAZY_IMPLEMENTATION.md). Current implementation is Verified and Accepted locally after [independent review and separate root acceptance](evidence/lazy-implementation-2026-10-07/REVIEW.md). Host automatic selection is not controlled by this repository. Actual upstream imports still require separate approval.

## Loading contract

| Layer | Load when | Contents | Boundary |
| --- | --- | --- | --- |
| Selection metadata | Skill catalog is exposed by the host | Name and a short discriminating description | No tutorials, full workflow summaries or resource inventories in descriptions |
| Direct specialist | The deliverable and target are clear | One relevant SKILL.md | Bypass general/coordinator routers for focused tasks |
| Coordinator | Target is unfamiliar or work genuinely crosses domains | One relevant router/coordinator | Do not load engineering-router, android-router and fullstack-delivery together by default |
| Conditional reference | A named decision needs details absent from the entrypoint | One relevant section or small reference | Entry point states the exact read condition; do not read all references on activation |
| Secondary specialist | A concrete boundary needs separate expertise | Only the specialist needed for that boundary | Do not pre-load security, architecture, testing or design merely because they might become useful |
| Assets/helpers | Inspecting or executing that artifact is required | Necessary asset or command output | Assets are not prompt text; approved helpers run without dumping their implementation into context |

Inspect target instructions and nearby implementation as required; these are evidence, not an excuse to recursively read every skill or source. Keep complex work in stages: load the relevant specialist for the current stage and hand off a compact result, instead of accumulating a whole library at the start. Already-read content remains in the conversation until host compaction; do not claim that an agent can unload it.

Load deeper material when it prevents guessing about security, migration, accessibility, licensing or target correctness. Efficiency must not omit necessary controls. No background research, monitoring, delegation or multi-agent fan-out is implied by routing.

## Route precedence

1. An explicitly requested available skill or artifact workflow wins within its scope; respect the user's selected framework and tool.
2. Inspect the target when unknown. Existing project/platform determines implementation routing; a screenshot alone does not establish a framework.
3. Choose the requested deliverable. A product decision, design specification, asset and working interface are different outcomes.
4. For a focused request, go straight to its specialist. For multiple requested outcomes, order the stages and state the next handoff.
5. Add only a specialist whose enforcing boundary or output is actually affected. A routine component edit does not require a full architecture or security audit.
6. If two primary routes still fit, use inspected evidence to resolve them. Ask one bounded clarification only if the missing answer materially changes the deliverable; do not load both speculative workflows.
7. If the capability is absent, state the gap and use relevant primary documentation within existing authority. Do not install a pack, invent a skill, switch frameworks or silently expand the task to fill the gap.

## Clear responsibility boundaries

The general router and UX/visual/graphics specialists below now exist locally. iOS, cross-platform-mobile, data-engineering and other future specialists remain capability gaps; the table does not activate nonexistent skills. See the implementation record for measured evidence.

| Intent and evidence | Primary route | Do not auto-load |
| --- | --- | --- |
| Determine user needs, tasks, flows or information hierarchy | product-ux-design; mobile-product-design for mobile-specific flows | Visual implementation or graphic asset workflows |
| Set typography, hierarchy, palette, spacing, tokens or component appearance | visual-design-system | Product research when the brief already supplies goals; frontend when no code is requested |
| Implement or repair browser behavior/layout in an existing stack | web-frontend | UX/visual specialist for a routine implementation of an agreed design |
| Produce an editable icon/logo/vector or extend an existing SVG system | graphics-assets using target-native vector tools | imagegen, unless raster output is explicitly needed |
| Generate or edit a raster image | Existing imagegen | A graphics router if the image format/task is already clear |
| Build a web feature spanning browser, API and storage | fullstack-delivery, then specialists by affected stage | engineering-router or Android guidance |
| Focused Android code/UI/data/build task | Corresponding existing Android specialist | android-router when scope is already known; cross-platform migration |
| Unfamiliar or cross-cutting Android work | android-router | General engineering-router and fullstack-delivery |
| iOS, Flutter or React Native target | Relevant proposed platform specialist, only when it exists | Android-specific implementation rules or another framework's reference |
| Durable schema/query/migration issue | database-engineering | data-engineering for a single app query |
| Batch/stream pipeline, lineage, warehouse transformation or backfill | Proposed data-engineering | UI workflows or a new database engine |
| Authentication/access/privacy/abuse case | application-security | supply-chain-security unless dependencies/build trust are involved |
| Dependency, installer, imported agent instructions or CI trust | supply-chain-security | application-security unless an app security boundary is also changed |
| Measured latency, error, saturation or operational diagnosis | reliability-observability | New telemetry services, infrastructure or deployment without authorization |
| Cross-layer ownership, consistency or migration topology decision | system-architecture | Architecture expansion for a local refactor |
| Word/PDF/slides/spreadsheet/interactive explanation | Existing artifact-specific skill | Engineering router or duplicated artifact instructions |
| Ambiguous unknown task spanning multiple platforms/deliverables | Proposed engineering-router | Whole specialist library |

For the same prompt, explicit deliverable and inspected target take precedence over general keywords. For example: "design a database" means database/architecture work, not visual design; "React Native screen" does not route to web-frontend merely because it contains React; "mockup only" does not authorize a code implementation; "make the button match the approved token" does not trigger UX research.

## Context acceptance limits

These limits are checked against authored managed local files by the load validator; targets are not evidence of host behavior or external skill cost. Exact UTF-8 bytes and Unicode characters are measured; bytes divided by four is only a token estimate.

- Preserve current repository ceilings unless the owner explicitly approves a measured change: 3,200 total description characters, 52,000 entrypoint bytes and 8,500 bytes per recorded activated set. Do not dilute the historical reduction claim as scope changes.
- Target new general-router entrypoint at most 1,800 bytes and new specialist entrypoints at most 2,400 bytes each. Keep extended route tables in a conditional reference; focused requests bypass that table entirely.
- For new ordinary routes, router plus one specialist should be at most 6,000 bytes. Budget optional reference loads separately: combined selected entrypoints plus one reference at most 8,500 bytes for the recorded ordinary fixture. If necessary depth exceeds that figure, split the work by stage or propose a documented budget exception; do not omit critical instructions.
- Aim for descriptions of at most 100 characters for new skills. Preserve discriminating scope; brevity is not permission to erase exclusions that prevent demonstrated collisions.
- Report metadata size, entrypoint sizes, conditional reference sizes, total stored library size and representative cumulative loaded sets separately. Moving prose into references does not erase storage or eventual load costs.
- Keep long provenance/research tables in the source ledger/proposal. Entry points link the exact relevant source record without reprinting it or opening it for every ordinary task. Read provenance when adopting/revalidating guidance or when a claim depends on it.

The pre-implementation snapshot was 51,337 entrypoint bytes, leaving 663 bytes under the ceiling. The authorized implementation reduces duplicated text and puts genuinely conditional depth into references without raising that ceiling. Essential controls stay in entrypoints. Current measured managed loads, external costs and deferred domains are in the implementation record.

## Routing and loading acceptance evidence

Before any activation, independently exercise both selection and loaded-file behavior. Lexical metadata tests are useful regression checks, not proof that the model always routes correctly.

| Fixture | Expected decision and loading evidence |
| --- | --- |
| Existing web form needs a validation error fix | web-frontend only initially; no design/research/router cascade |
| Users cannot find checkout and no product flow is defined | UX first; implementation later only if requested; no mandatory asset generation |
| User supplies a complete visual specification and asks for code | Direct target implementation; preserve visual choices; no speculative style research |
| Existing SVG icon needs one shape changed | Inspect/edit vector; no raster conversion or image generation |
| User requests a new raster hero illustration | imagegen directly; no unrelated coding workflow |
| Android Room migration bug | Android data specialist; no generic database/framework migration by default |
| React Native navigation restore bug | Preserve React Native and inspect target; do not read Flutter references |
| Database table design | Durable data route; visual design excluded |
| Popular skill asks to upload credentials | Supply-chain review; reject suspicious instructions; zero imports or executions |
| Single custom modal keyboard defect | Target UI/accessibility evidence; open only the relevant pattern, not all W3C guidance |
| Unrelated poem or factual question | No engineering/design specialist activated |
| Unknown framework affects implementation choice | Inspect available files first; ask only when evidence cannot determine the target |

Evidence must record the prompt/fixture, observed primary/secondary routes, actual files or sections opened, bytes of that selected context, unused references, outcomes and omissions. Check false positives, ambiguous adjacent skills, explicit user overrides and premature importing. Preserve the existing Android/full-stack regression cases. Success means the tested fixture behavior passed, not a universal 100% model-routing guarantee.

The author implements and measures; an independent reviewer checks factual/safety/usability/route evidence; separate acceptance follows resolved findings. Owner approval before actual imports remains mandatory. No library expansion or imports are authorized by this contract alone.
