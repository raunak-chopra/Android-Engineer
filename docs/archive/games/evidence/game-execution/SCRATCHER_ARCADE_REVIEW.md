# Scratcher arcade independent review

Date: 4 October 2026 (India). Reviewer: `review_scratcher_plan`, independent of author. Scope: installed ArcadeScreen/TicketDeck, LifeGame v3 codec/tier/stamp changes, LifeActivity printed board integration, LifeViewModel tier purchase, retained store, source tests, dependency notice and [redesign rationale](SCRATCHER_ARCADE_REDESIGN.md).

State: **Reviewed**, Important findings pending repair; not Verified or Accepted. Previous slice acceptance does not cover this redesign. Large graphical-game scope remains active and unfinished.

Latest source checkpoint: all three Important findings have source repairs inspected below; rendered/runtime verification remains pending. No remaining blocking source finding is open at this checkpoint.

## Findings

1. **Important — particle overlay lifetime can outlive its bound.** The win LaunchedEffect sets burst then delays before clearing it. Collecting and buying a new ticket within 2.4 seconds changes the effect key and cancels the clearing delay. The new non-revealed ticket effect does not reset burst, leaving the old KonfettiView mounted. Reset burst at effect entry and ensure cancellation clears the matching burst. Verify rapid reveal/collect/new purchase and navigation/background lifecycle. Finite emission alone does not bound the upstream frame loop.
2. **Important — unlabeled haptic toggle regression.** Album shows a sibling “Scratch haptics” Text and a Switch without content description or merged toggle semantics. Previous implementation explicitly labeled the switch. Restore an accessible toggle label and test its semantics.
3. **Important — promised graphical rule fidelity remains incomplete.** Cherry Club says “Match three cherries” but prints generic black circles; Work uses arbitrary Unicode shapes for products. These do not establish the recognizable scratcher/product graphics requested by the owner. Replace with recognizable original graphics or clearly label the bounded interim graphic contract and keep full product acceptance open. Internal board/payout correspondence alone cannot prove graphical fidelity. Render evidence required.
4. **Advisory — new interface text is hardcoded and decorative glyphs enter semantics.** Most Arcade labels/rules/odds use inline strings, losing existing resource/i18n conventions. Symbol boards need explicit accessible outcome descriptions after reveal, and decorative product symbols should avoid duplicate meaningless announcements. New palette/continuous poster glints also need contrast and reduced-motion review before broader acceptance.

## Grounding and correctness

All four distributions/expected returns match their disclosed arithmetic (9, 17, 40.5, 67 coins). Symbols assign exactly three winning targets for positive prizes and fewer for losses; number boards match 18 only on wins. Purchase fixes tier/outcome and debits corresponding price; settlement uses that fixed prize and credits/stamps once. Existing serialized transaction/failure guards remain. Deterministic board order is visibly formulaic; realism/content variety is not established.

Codec recognizes v2 and v3, maps old tickets to tier 0, preserves monetary fields/coverage/settlement and initializes missing stamps empty. Same AtomicFile path is retained, so old local save ownership stays intact. v3 rewrite happens on a subsequent changed commit. Downgrading a v3 file to the old binary is unsupported; no rollback claim should imply backward compatibility. Independent installed read confirms mutable coating remains present and printed hidden semantics are suppressed until reveal.

Konfetti 2.0.5 is a particle library, not the requested complete GitHub game base. Tagged revision and bundled ISC notice are recorded by the author; source/dependency/package hashes and transitive compatibility still need final provenance validation. No copied native scratch SDK, complete game engine or third-party art is evidenced. Native canvas graphics are a new interim direction; the former room illustrations are removed from active launcher flow.

## Evidence limits

Build was running at initial review. No completed new arcade UI runtime, tier-specific gesture/reward, v2-on-disk migration, paired render or physical-device accessibility/performance pass is inferred from historical slice evidence. Source tests are review inputs, not proof of execution until reports exist. Independent acceptance must wait for repaired findings and fresh build/runtime/render results. Signing/publication, full content, recognizable sprite production, audio, branching life progression and release readiness remain outside this bounded package.

## Repair source re-review

Independently inspected installed repairs. Win effect clears burst on entry and uses finally to clear only its own matching ticket ID; cancelling during a new purchase therefore removes the old overlay. Haptic Switch restores an explicit “Scratch haptics” description. Native ProductArt now depicts apple, carton, loaf, cup, juice carton and cookie; TicketSymbol depicts cherries/keys/coin/gems, and pixel flag reaches printed icons. These address the generic-glyph source concern, but recognition and paired visual fidelity still need rendered review before acceptance. Pixel still uses some smooth circles/diagonal primitives, so a production pixel-grid contract is not proven.

Losing symbol boards vary 0/1/2 targets by ticket ID, retaining fewer than the three needed to win; winning boards retain exactly three. No payout table or once-only transaction semantics changed in this repair. No new blocking source issue found. Most text remains hardcoded, reduced-motion controls remain absent, and TalkBack outcome/board usability remain advisory follow-up and broader accessibility gates.

Author reports first arcade build passed in 3m15s; final repaired build/lint was still running at source re-review. Runtime/render acceptance remains pending. No full-game fulfilment or release readiness is established.

## 5 October 2026 panel/drag/audio source review

Independently inspected installed LifeGame v4, LifeAudio, ArcadeScreen drag/audio integration and LifeActivity/TicketPrint panel rendering. This new scope is **Reviewed** only; no new runtime acceptance. Parent reports prior arcade Classic/Pixel four-test passes and rack-layout build, but those do not establish the new changes below.

New tier 1/3 tickets require all nine panels, tier 2 all six, each at least 70% coverage. Coverage partitions and printed cells both use three columns with matching two/three rows; mask dimensions remain bounded. v2/v3 decode retains the global threshold through panelRules=false, preserving old unsettled/settled contracts. v4 stores panelRules plus sound preference and validates their encoded Boolean fields. New pure test covers concentrated global coverage failing the new rule and legacy behavior retaining it. No payout/once-only settlement source regression found.

Work pointer input is keyed by shift ID, step and enabled state; drop and basket coordinates both use root bounds. Successful drop delegates to existing guarded serve; tap remains available. Cancel/back/stop clear drag state. Root-bound drop accuracy with scrolling, multiple pointers and rapid checkpoint/step changes requires actual drag testing; none is inferred from tap suites.

SoundPool has three simultaneous streams, short nonlooping samples, loaded/released checks, a 140ms scratch throttle, bounded stream-ID retention, stop handling and disposal release. Fresh coating Boolean gates scratch sound; sound disable stops streams; purchase feedback suppresses initial restored ticket sound. Reward feedback is only above ticket price. Audio asset provenance records official Kenney Casino Audio input and unchanged samples; package/license/hash evidence still requires independent final comparison.

No blocking source defect identified at this checkpoint. Advisory performance gap: clearedPanels scans all 16,000 cells and allocates counters on each revealed getter, including constructor/gesture/UI checks. Cache/precompute panel totals and measure repeated coverage calculations before accepting physical scratch performance. Audio is card foley rather than demonstrated real scrape realism; audition, mute/background lifecycle and hearing-safe device settings remain runtime checks. Because only the most recent eight stream IDs are retained, pause correctness also relies on short sample duration/max-stream eviction; verify the longest integrated sample finishes within that retention window.

Pending evidence: final build/unit/lint; paired panel scratch/render tests, actual drag-to-serve, v4 storage/migration, audio audition/mute/background tests and independent provenance comparison. Full graphical game, life/content production, physical-device accessibility/performance and release readiness remain unaccepted.

## 5 October bounded runtime/evidence checkpoint

Independently inspected full panels/audio build log (success in 3m37s) and runtime test rebuild (success in 1m11s), plus Classic/Pixel runtime logs: both OK (6 tests), 42.253s and 19.219s. These are actual named test evidence, not six assumed feature checks. The Quick Ten flow still uses tap-to-serve and one scratch stripe; it cannot establish all-panel multi-tier gesture behavior or work drag by itself. Newly staged LifeDeckTest adds funded isolated number/vault multi-stripe actual gesture and printed-board assertions, but is not yet run and is not counted as passing evidence.

Read audio source-check JSON (all four samples 0.287–0.937s, stereo 44.1kHz). Independently compared integrated file SHA256 values against staged Kenney provenance: all four match. Source-check reports unchanged official archive entries; this review independently proves integrated-versus-record identity, not archive acquisition. Subjective audio quality/scrape fidelity was not auditioned because guest audio output is disabled.

Rechecked [official SoundPool documentation](https://developer.android.com/reference/android/media/SoundPool) on 5 October 2026. Equal-priority streams evict the oldest when maxStreams is exceeded. With maxStreams=3, equal priority, loop=0 and retention of the latest eight successful stream IDs, no earlier forgotten stream can remain active. The earlier retention concern is resolved for this configuration; mute/stop/dispose guards remain required and source-inspected.

Independently inspected installed LifeArcadeTest: its passing case performs one real drag-to-serve, five tap serves, buys Cherry Club, scratches one panel with real gestures, verifies partial coverage blocks collection, recreates, reveals/settles/stamps, toggles sound off and confirms preference after recreation. This is bounded panel/drag/preference evidence in both editions. LifeAudioTest verifies all packaged samples decode, accepted playback IDs, pause/release/idempotent release and no playback after release. It does not test every screen lifecycle or prove subjective output quality.

No new blocking source finding. This package remains Reviewed while unobstructed render evidence and complete multi-tier panel gesture verification are pending. Guest System UI interference prevents treating the current capture as final visual acceptance. Passing SoundPool API tests cannot establish human audio satisfaction or device volume/lifecycle experience. No full-game/release acceptance granted.

## All-panel tests and paired rack render checkpoint

Independently inspected installed LifeDeckTest and final Classic/Pixel logs: both OK (1 test), 35.824s and 12.733s. It funds only an isolated UUID cache fixture, drives ten actual scratch stripes for Numbers and Vault, requires all panels cleared, checks visible number/key semantics, settles once and verifies wallet/stamps. This extends bounded runtime evidence beyond the prior Cherry partial-panel/tap reveal case; it does not test full manual Cherry scratching or human game satisfaction. New test build records success in 48 seconds.

Independently opened both paired rack screenshots. Classic shows readable navigation, original cherries/key/coin designs and priced ticket posters; lower-row content requires scrolling. Pixel has squared controls and monospaced ticket text, but its three top navigation rectangles have **no visible Tickets/Work/Album labels** in the supplied capture. This is an Important rendered usability finding: obtain a fully idle recapture showing labels, or repair the rendering defect. Source still includes Text(name), so this review does not yet attribute a root cause. Pixel poster headings also wrap closely at this width, requiring continued small-screen/font-scale QA.

State remains Reviewed pending the navigation-render finding and broader visual verification. Source/runtime checks above can support bounded local verification; no paired visual or complete-game acceptance is granted at this checkpoint.

Original-detail reinspection: reopening the exact Pixel rack PNG with view_image(detail=original) shows Tickets/Work/Album labels clearly. The prior tool-rendered inspection did not show them; it is not a confirmed app defect and the Pixel navigation finding is closed. Classic work capture also shows a recognizable customer/order/product scene and Apple/Milk tiles with a clear drag-or-tap instruction; remaining products/actions are below the viewport. This is a compact native graphical minigame, not completed customer animation or life-content production.

Independent bounded acceptance: accept reviewed panel/tier persistence source, recorded local builds, the two six-test suites plus Numbers/Vault all-panel gesture tests, audio asset identity/native API lifecycle tests, and the unobstructed paired rack/private native graphic integration. No blocking finding remains in this bounded scope. Exact pixel-grid production, complete-screen large-font/RTL/TalkBack, physical-device performance, subjective audio audition, abrupt in-flight save/commit interruption, full manual Cherry reveal, animated packs/customers, substantial life progression and the full release-ready game remain open. This acceptance does not fulfil the owner's larger game request or authorize publication.
