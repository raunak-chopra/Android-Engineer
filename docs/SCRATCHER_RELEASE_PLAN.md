# Scratcher: life, work, and scratch tickets

Date: 4 October 2026 (India). State: Reviewed for the two-edition revision; [two-edition review](evidence/game-execution/SCRATCHER_TWO_EDITIONS_REVIEW.md) records no blocking or important findings. [Original independent review](evidence/game-execution/SCRATCHER_PLAN_REVIEW.md) covers the earlier single-edition plan. Root acceptance and owner milestone approval remain pending. All features below are planned unless identified as observed. Scope: product and engineering plan plus source discovery; no game source, assets, dependencies, accounts, signing, or distribution changed.

## Product outcome

Owner revision, 4 October 2026: the first AI room/form implementation was rejected. Prioritize a graphical ticket arcade, distinct ticket price/rule designs and dependable open-source components. [Current redesign and evidence](evidence/game-execution/SCRATCHER_ARCADE_REDESIGN.md) supersedes the old presentation direction. Full game scope remains unfinished; prior implementation acceptance is not owner creative approval.

Turn the Game1 scratch prototype into an offline life-and-scratch game: **work a shift → earn virtual money → buy a ticket → physically scratch its coating → settle the result → progress your life**. Players should enjoy both earning and scratching, with useful goals even when a ticket loses.

Use BitLife as inspiration for short life events, character stats, career progression, and a readable journal. Create original characters, writing, layouts, and artwork. The proposed direction replaces the earlier six-item Quiet Discovery loop; its nature artwork can remain an optional ticket collection. Working title: Scratcher; final name and visual identity remain owner decisions.

Planning assumptions: Android first; single-player and offline; earned virtual currency with no cash-out, real prizes, currency sales, ads, accounts, or backend in v1. A paid game or cosmetic business model needs a separate owner decision. Ticket simulation may affect age rating even with virtual money; complete the actual store questionnaire rather than predicting a rating.

## Two graphical editions

Owner direction, 4 October 2026: keep the planned version and also make a pixel-graphics version. Deliver two locally installable editions, **Scratcher Classic** and **Scratcher Pixel**, from the same Game1 source tree. These names are working labels, not reserved store identities. Both include the entire work/earn/buy/scratch/life loop; the pixel edition is a full presentation pass, not a pixelated filter on the current prototype. Store distribution of one or both editions remains a later owner decision.

| Graphic element | Classic: current planned direction | Pixel: alternate edition |
| --- | --- | --- |
| Life/Home | Illustrated character portrait, cozy room vignette, graphical career and savings goals | Pixel portrait, tiled room vignette, sprite-based career and savings goals |
| Shop/work | Illustrated counter, shelves, customer busts, products and basket | Pixel counter scene, customer sprites, product icons and basket animation |
| Tickets | Printed paper, detailed foil grain, illustrated themes and symbols | Pixel borders, dithered metallic foil, original pixel themes and symbols |
| Scratch tools | Shaded coin with contact highlight and fine debris | Coin sprite, short glint animation and bounded pixel flakes |
| Results/journal | Illustrated stamps, restrained reward animation, event portraits | Sprite stamps, pixel sparkle animation, event portraits |
| Navigation | Clear native controls with illustrated accents | Clear native controls with pixel frames and accents |

Keep the scene at the top of Home and Work, with primary actions reachable below it; backgrounds must not obscure prices, orders, symbols, or event choices. Graphics should explain the job, life goal, or ticket theme. Room upgrades visibly change the vignette. The first graphical slice contains one room, one shop counter, one player portrait, three customer appearances, six distinct order products, one ticket family, and a coin tool in **each** art style. Full v1 then covers all six ticket variants and the existing life-event content in both styles. Reuse portraits deliberately; 20 events do not require 20 unique backgrounds. No walkable world is required for v1.

### Pixel art contract

Proposed base art grid: 16px environment tiles, 32px product/coin icons, 32 × 48px character sprites, 64px portraits, and 320 × 200px ticket artwork. Brand-Manager-Creative may adjust these together after a paired concept sheet; keep a consistent grid, palette, outline, and lighting across the pack. Start with a coordinated 24–32-color palette and short two-to-four-frame idle, handover, and glint animations. These are proposed production constraints, not assets already created.

Preserve crisp sprite texels with nearest-neighbor sampling and integer physical-pixel scaling where practical; letterbox decorative scenes within adaptive layouts rather than stretching sprites. Native controls and text still adapt to font scale and window size. Use a readable native body font for instructions, prices, journal, and errors; any decorative pixel heading font needs its own license audit. Pixelation cannot reduce 48dp touch targets or accessible alternatives.

The pixel edition must still feel like physical scratching. Its textures and debris are pixel art, but input interpolation, brush size, fresh-coating feedback, panel boundaries, and coverage remain precise. Both displays are derived from the same bounded mask and geometry; pixel-style rendering must not expose different symbols, trigger different reveal thresholds, or change payouts. Validate crisp art and legible revealed numbers together instead of intentionally lowering the scratch interaction's precision.

### Shared implementation, separate builds

After re-inspecting Game1, add an edition dimension with proposed `classic` and `pixel` Android product flavors in the existing app module. Keep common Kotlin game rules, wallet/ticket transactions, persistence schema, job logic, life content, navigation, semantics, and tests in shared source. Flavor resource overlays provide artwork, palette, app label/icon, and animation definitions behind common resource keys. Separate a small presentation/renderer boundary only where the existing Compose code needs it; do not fork the repository or duplicate the economy engine.

Resolve stable, distinct application IDs before distribution so both local editions can be installed side by side without replacing the current prototype. Exact final IDs are not selected here. Each installation owns its own wallet and save; there is no shared balance, automatic cross-app migration, or cross-edition transfer in v1. Both use the same versioned save format and legacy migration rules. Keep the current prototype intact during comparison; any future migration from its application ID requires a separate tested path. Build flavor/default-edition commands must be documented only after they are implemented and exercised.

Parity acceptance: identical seeded job/ticket/event inputs yield identical payouts, progression, and settlement behavior in both editions. Run shared rules tests and edition-specific UI/build tests; complete earn/buy/scratch/collect, restore, TalkBack, font-scale, light/dark, and performance checks in **both**. A side-by-side installation test must show that buying tickets or resetting one edition leaves the other edition and existing prototype untouched. Capture actual screens side by side, record asset completeness and each build's identity/hash, and independently review the paired graphical slice before expanding content. An edition cannot inherit rendered accessibility or performance evidence from the other.

## Observed baseline and constraints

Inspected `C:/Users/rauna/Desktop/Games/Game1`: README, Gradle configuration, manifest, MainActivity.kt, ScratchGame.kt, ScratchViewModel.kt, ScratchStore.kt, and available test paths. No AGENTS.md was found under Desktop/Games by the file search. Engineer instructions govern this planning artifact; re-inspect target instructions before implementation.

| Observed | Consequence |
| --- | --- |
| One Android app module, Kotlin/Compose, lifecycle state flow, application-owned repository | Extend these boundaries; no engine, DI, network, or module migration is needed for the first slice |
| 24 × 16 normalized coverage grid; 55% whole-card auto-reveal; six sequential collectibles | Existing scratching is a coverage prototype, not realistic foil or a chance-based ticket engine |
| AtomicFile, version-1 pipe-delimited save capped at 4096 bytes; conflated async writer | Preserve old saves; economic transactions need durable commit acknowledgements and a larger versioned format |
| Reveal-without-scratching button, haptics toggle, restore/save failure UI | Preserve equivalent accessible actions and recovery behavior |
| minSdk 26, compile/target 36; prototype application ID/version; release minification disabled | Existing configuration is a baseline, not a final store identity or optimized release |
| No Internet permission; backup disabled | Keep offline scope; explain local-save loss and decide backup/export policy deliberately |
| Prior ledger records five unit and five API 36 instrumentation tests plus unsigned packaging | Historical bounded evidence only; new loop, gestures, process death, physical-device performance, and release readiness remain unproven |

Historical evidence: [execution ledger](evidence/game-execution/EXECUTION_STATUS.md). Earlier product direction and creative ownership: [game task plans](GAME_TASK_PLANS.md). This plan supersedes the earlier scratcher product proposal, not its historical evidence or ownership boundary.

## v1 game design

### First five minutes

1. Create a character with name and optional portrait; introduce wallet, energy, skill, and current day.
2. Give one practice ticket and demonstrate scratching. It is marked as practice and cannot affect the wallet.
3. Complete a short shop shift, receive guaranteed base pay, and see the first journal event.
4. Visit the ticket counter, compare prices and rules, buy one ticket, scratch its panels, and collect the fixed result.
5. Show a concrete goal: save for a better job or collect a themed set. Offer another shift, another affordable ticket, or ending the day.

### Earn money: shop-shift minigame

First job: convenience-store clerk. A 30–45 second shift asks players to match customer orders to products and assemble baskets. Correct orders earn tips; mistakes lose tips, never create debt. Base pay is guaranteed for completing the shift. Prototype tuning: 30 base coins plus 0–20 tips, with starter tickets costing 10 coins. These are design hypotheses, not balanced values.

Difficulty rises through order complexity rather than tiny targets or faster compulsory gestures. Provide an untimed accessible shift with equivalent earning potential and explicit confirm actions. Pause on backgrounding; abandon before completion gives no award and clearly states that outcome. A committed completed shift pays once, including after restart. Work stays available at zero money.

Energy creates a day rhythm, not a real-world waiting timer: a shift costs energy and ending the day restores it. Rest is always available and cannot cost money. Promotions require completed shifts and skill; tickets cannot buy promotions. Later jobs, such as cafe orders or parcel sorting, follow only after the first job is fun.

### Life progression

Use a compact adult character profile with wallet, energy, work skill, job rank, home goal, and journal. After a shift or at day end, occasionally present an original two-choice event: help a colleague, study for promotion, or repair something at home. Show costs and likely stat effects before choosing; events cannot create an unrecoverable state.

Initial content target: one job with three ranks, 20 authored events, three savings goals, three ticket families with two visual variants each, and one collectible album. Replay comes from job mastery, branching events, collections, and cosmetic scratch tools. Relationships, generations, aging/death, investments, property simulation, and procedural AI stories are later scope.

### Tickets and economy

Start with match-three, winning-number, and collectible-bonus tickets. Each has printed instructions, separate scratchable panels, a price, and a payout table accessible before purchase. Display gross prize and net result distinctly. Cosmetic tools change appearance/feel only; brush choice, scratch speed, and accessible reveal never change odds.

At purchase, persist a unique ticket ID, price debit, rules-table version, and sampled outcome in the same transaction. Scratching exposes an already assigned result. Resuming, rotating, changing tools, or killing the process cannot reroll it. A single settlement transaction credits the prize and marks that ticket settled; repeated claims are no-ops. No partial purchase/debit state is allowed.

For every payout table, calculate expected gross return as sum(probability × prize), validate probabilities total one, and run seeded long-session simulations. Tune against work income, purchase frequency, goals, and streaks of losses. Work must support progression without ticket winnings. Avoid fake near-miss outcomes, hidden dynamic odds, loss-triggered prompts, and spending escalation. Track total earned, spent, and won locally for a transparent history.

Use checked integer arithmetic for all currency updates; reject overflow and negative balances before a commit. Define explicit caps for wallet/journal history and save size, retain lifetime aggregates when older entries are trimmed, and test long-session bounds and maximum-value updates in P2.

## Make scratching feel physical

Build a layered ticket: paper base, printed symbols, scratch-panel boundaries, textured metallic coating, and a coin contact indicator. Erase only the coating along continuous interpolated round strokes using a bounded mask/offscreen layer. Brush width must be stable in physical UI units with geometry transformed to normalized ticket coordinates. Finger input works without pressure sensing; supported stylus pressure is an optional refinement.

Add subtle roughness, edge fragments, highlights, a small bounded pool of flakes, and several scrape samples. Audio begins only when removing fresh coating, varies gently with movement, and stops on lift, pause, or leaving a panel. Haptics should respond to meaningful fresh-surface removal at a throttled rate; never vibrate on every pointer event. Sound, haptics, and reduced motion are independent settings.

The current square-grid renderer must be replaced for visible smoothness. Separate rendering resolution from coverage calculation, but derive both from the same stroke/brush geometry so visible and measured removal agree. Keep per-panel coverage and readable symbol regions. Prototype a 70% panel reveal threshold, then tune it in playtests; do not retain the whole-card 55% shortcut without testing. Manual full scratching and accessible panel reveal both use identical settlement rules.

Persist a compact bounded mask and rendering metadata; cap memory, input samples, particles, and save size. Long sessions must not append an unbounded Path or stroke log. Avoid bitmap allocation/readback per gesture and disk writes per pointer move. Save scratch progress in checkpoints; purchase and reward commits are immediate and separately acknowledged. Restore the same purchased ticket and outcome even if the latest decorative scratch movement was interrupted.

Proposed acceptance: thin/fast/diagonal strokes have no gaps; crossing panel boundaries erases only legal areas; returning over exposed paper makes no scrape feedback; rotation preserves geometry and progress; multi-touch has a defined primary-pointer policy; scrolling cannot steal an active scratch gesture. On named physical reference devices, target 60 Hz rendering with p95 frame duration ≤16.7 ms during a 30-second scratch run, with allocation and memory evidence. This is a target, not a measured result. Human comparison with a real scratch card checks sound, resistance illusion, visibility, and satisfaction.

## Screens, recovery, and accessibility

| Surface | Primary action and states |
| --- | --- |
| Life/Home | Work, view next goal, end day; loading/error/retry and offline save status |
| Work | Start/pause/finish shift; accessible untimed mode; no repeated payout |
| Ticket counter | View rules/odds, buy; insufficient funds routes to Work; disable repeat taps while committing |
| Scratch table | Scratch/reveal panels, collect result; pending save, retry, and resumed ticket |
| Journal/Collection | Review events, wallet history, goals, and discoveries |
| Settings | Sound/haptics/motion, accessibility mode, local-save explanation, confirmed reset |

Back from a ticket preserves it; starting another cannot discard an unsettled ticket. Back during work pauses or asks to abandon. Save failures retain the last committed state and provide retry; errors do not silently wipe progress. Confirm whole-game reset and disclose its exact effect. Blank/corrupt saves use recoverable error UI, not a zero-wallet reset.

TalkBack must expose affordable tickets, panel status, rules, work actions, and results without leaking hidden outcomes. Accessible reveal is available without penalty. Use native text/resources, localized numbers/plurals, RTL-aware layouts, at least 48dp controls, large-font layouts, light/dark contrast, landscape/window resizing, and non-color-only feedback. Test real TalkBack and an accessible complete earn/buy/reveal/collect path.

## Source discovery — audited 4 October 2026

These are candidates, not approved imports. GitHub default branches were browsed; immutable revisions and downloaded package licenses have not been audited. Before copying or adding a dependency, record exact commit/version, full license and notices, transitive obligations, source/package hashes, compatibility test, and independent review in `.codex/sources/`. No third-party code or assets were downloaded in this planning pass.

| Source | Verified discovery and planned use | Disposition |
| --- | --- | --- |
| [AdamDawi/ScratchCardCompose](https://github.com/AdamDawi/ScratchCardCompose) | Repository displays MIT; README demonstrates overlay masking with Clear/offscreen compositing | Best small reference for a local Compose renderer; full license/revision/source audit required before copying |
| [gsrathoreniks/Scratchify](https://github.com/gsrathoreniks/Scratchify) | Repository displays MIT; README advertises brush, coverage, and restore APIs | Compare in a disposable spike; its Multiplatform dependency and claimed behavior are not verified for this app |
| [Android Compose samples](https://github.com/android/compose-samples) | Official samples repository | Reference Compose screen/state patterns; pin and inspect any reused code/license |
| [Compose graphics modifiers](https://developer.android.com/develop/ui/compose/graphics/draw/modifiers) | Official drawing/compositing guidance | Ground isolated coating erasure and cache decisions; not evidence of game performance |
| [Android haptic principles](https://developer.android.com/develop/ui/views/haptics/haptics-principles) | Official tactile design guidance | Ground optional, restrained feedback; validate device behavior |
| [Kenney UI Pack](https://kenney.nl/assets/ui-pack) | Pack page declares CC0 | Prototype panels/buttons; native accessible UI remains preferable for text/actions |
| [Kenney Game Icons](https://kenney.nl/assets/game-icons) | Pack page declares CC0; gamepad/joystick/prompt icons | Candidate control/tutorial symbols; wallet/job/goal art belongs in the creative brief; audit archive/license before integrating |
| [Kenney Casino Audio](https://kenney.nl/assets/casino-audio) | Pack page declares CC0; card/chip/dice foley | Candidate ticket handling and payout sounds; realistic scrape requires audition or original recording |
| [Kenney UI Audio](https://kenney.nl/assets/ui-audio) | Pack page declares CC0 | Candidate menu confirmations; audition and archive/license audit required |
| [Kenney UI Pack - Pixel Adventure](https://kenney.nl/assets/ui-pack-pixel-adventure) | Pack page declares CC0, inspected 4 October 2026 | Candidate Pixel frames/panels; harmonize palette with original art and audit archive/license |
| [Kenney Tiny Town](https://kenney.nl/assets/tiny-town) | Pack page declares CC0 and 16 × 16 tiles, inspected 4 October 2026 | Candidate town/shop exterior vignette tiles, not a complete shop interior or character pack |
| [Kenney Pixel Platformer Food Expansion](https://kenney.nl/assets/pixel-platformer-food-expansion) | Pack page declares CC0, inspected 4 October 2026 | Candidate shop-order food sprites; check visual fit, atlas dimensions, and archive/license before use |

Recommendation: retain the app's existing state/storage boundaries and implement a small local renderer guided by official APIs. Use repositories as evaluated references rather than replacing the game with an SDK. Do not copy BitLife assets/code/text or unlicensed GitHub snippets.

All original creative production continues through `C:/Users/rauna/Desktop/Bots/Brand Manager Bot/Brand-Manager-Creative`, per the earlier owner instruction. Supply a brief for ticket stock/foil/paper, coin tools, shop/character visuals, six ticket variants, event portraits, and sound references. Suggested exports: 1024 × 640 ticket masters, separate transparent coating layers, 512-square icons/portraits, repeatable foil texture, and short normalized scrape/handling sounds. These dimensions are proposed; actual runtime exports depend on memory/render tests. Keep hidden symbols, prices, rules, and labels native. Preserve provenance and rights approvals; final artwork and store graphics need rendered QA.

That master-size guidance applies to Classic. Pixel uses the base grids above, with source sprite sheets, transparent exports, frame rectangles/pivots/timing, palette, and nearest-neighbor previews at intended scales. Send one paired creative brief covering both editions and the first graphical slice; develop original matching assets within Brand-Manager-Creative. External packs are candidate inputs to that workflow, not permission to bypass its rights or review checks. No artwork production or asset integration occurred in this planning revision.

## Implementation packages and gates

| Order | Bounded delivery and likely affected Game1 paths | Acceptance evidence |
| --- | --- | --- |
| P0: reconcile baseline | README, applicable instructions, existing tests/build and asset provenance | Fresh baseline; preserve user work; agree virtual-currency scope and creative brief |
| P1: scratch feel and paired graphics | Extract renderer from MainActivity.kt; gesture/mask geometry tests; scratch settings; paired creative brief and flavor resource boundary | One practice ticket in Classic and Pixel with smooth removal; paired room/shop/portrait/product/coin art; gesture, rotation, accessible reveal, audio lifecycle, physical-device playtest/performance evidence |
| P2: durable economy | Extend ScratchGame.kt/codec/store/repository; add pure ticket/wallet rules | Purchase/debit and payout/settlement atomic; crash-injection and duplicate-event tests; legacy migration and failed-write recovery |
| P3: earn-and-buy slice | Work screen/model, ticket counter, navigation/state resources; Classic and Pixel builds | One complete clerk shift → earned wallet → purchased ticket → settled result in both editions; interruption, zero-money, repeat-tap, parity and accessible-flow tests |
| P4: life and content | Shared profile/journal/goals/event models and resources; paired ticket/scene art | Three job ranks, 20 reviewed events, three ticket families in both editions; deterministic economy simulation, asset completeness and owner playtest |
| P5: polish and candidates | Edition settings/accessibility/localization, build flavors, provenance, release docs and CI | Required test/device matrix passes for both editions; each optimized candidate evaluated; rights and distinct final identities resolved; independent review and acceptance evidence |
| P6: distribution | Named final candidate and owner-approved destination | Separately authorized signing/upload/submission; staged testing and production approval; record actual outcome |

Implement and independently review each package before expanding it. Proposed production durations are deliberately not promised before P1/P3 usability results. P1 is the first action: prove the physical scratch interaction on one ticket before producing a full collection. P3 is the first playable commercial-direction slice; P4 expands only after the earn-and-buy loop is enjoyable.

The two-edition direction expands art production and rendered QA, while keeping the rules implementation shared. P0 defines flavor identities and the paired creative brief; P1 proves the same practice ticket in both styles; P3 delivers two side-by-side playable builds. Do not finish Classic and leave Pixel as a deferred cosmetic stretch goal.

Version-2 persistence must migrate the version-1 collection/haptics into preserved legacy discoveries plus a deterministic starter profile, without interpreting discovered collectibles as cash prizes. Retain the old file until migration commits and can be reopened successfully; failed migration leaves it untouched. Extend AtomicFile initially rather than introducing Room/DataStore automatically. Serialize durable economy actions and expose commit states; the existing conflated scratch-snapshot writer alone cannot establish transaction durability. Consider a database only if actual history/content requirements outgrow bounded snapshots.

## Release-ready definition

The game is a release candidate only when the above core loop exists, the scratch simulation feels satisfying in owner playtests, economy cannot softlock, saves and rewards survive interruptions, and content is complete. Required evidence includes deterministic engine/codec/migration/transaction tests; instrumented buy/work/scratch/claim flows; corruption/disk-full/cancellation/process-kill recovery; API 26 and current-target testing; named low/mid-range physical-device gesture/audio/performance checks; TalkBack/large-text/RTL/light-dark checks; and a prolonged work/buy/settle session without memory growth or duplicate currency.

Prepare reproducible builds, dependency/asset notices, privacy/data-safety answers matching the final binary, exact app ID/name/version, launcher/store assets from real captures, support contact, and release changelog. Evaluate minification/resource shrinking with release tests before enabling it. Preserve mappings where produced, candidate hashes/metadata, and known limitations. SDK/store requirements are rechecked at candidate time, not frozen from this prototype.

Official policy inputs: [content rating questionnaire](https://support.google.com/googleplay/android-developer/answer/9859655?hl=en) and [real-money gambling/games/contests policy](https://support.google.com/googleplay/android-developer/answer/9877032/), inspected 4 October 2026. Virtual ticket simulation still requires accurate classification; the restriction on gambling ads in simulated-gambling apps is not a blanket ban on virtual scratch gameplay. Real-money stakes/prizes or purchased chance-based currency would change the scope and require a fresh review.

Apply [change control](../playbooks/CHANGE_CONTROL.md) and [release playbook](../playbooks/RELEASES.md): Draft → Reviewed → Verified → Accepted → Owner-approved; Released requires evidence of the separately authorized release. A reviewed plan does not make the game release ready. No signing or upload is authorized by this document.

## Planning verification

This package changes only this new plan and its independent review record. Acceptance evidence: source inspection, dated primary-source links, resolved internal references, independent grounding/product/safety review, repaired findings, and the relevant Engineer validator. No new game build, dependency integration, asset audition, economy simulation, or device test has run as part of this plan. Root acceptance and owner milestone approval remain pending.

Validation run: `./scripts/validate-engineer.ps1 -Compact` on 4 October 2026 failed with five existing link issues: one space-containing absolute link in EXECUTION_STATUS.md and four target-relative links in the archived kalo-habits-before/README.md. No issue was reported in this new plan. These unrelated records were preserved; repository-wide validation is not claimed to pass.
