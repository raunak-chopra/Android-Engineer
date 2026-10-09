# Game task plans

Date: 3 October 2026. State: Reviewed. Scope: planning only; no game source, tracker task status, signing, accounts, or external systems changed. Root acceptance and owner milestone approval remain pending.

Execution began 4 October 2026 after the owner's instruction to do all packages and continue. Follow the [execution ledger](evidence/game-execution/EXECUTION_STATUS.md) for current implementation, review and verification evidence; the dated observations below describe the original planning pass. The Quiet Discovery nature brief was continued, six Brand-Manager-Creative illustrations were produced, and Game1 now contains a local scratcher slice. Sudoku's API 36 preparation is implemented. Runtime findings and repairs are recorded separately; tracker items are not automatically marked complete.

## Inventory and sequence

Source task list: `C:/Users/rauna/Documents/Codex/2026-10-01/i-w/outputs/project-tracker.md`. Game folders are under `C:/Users/rauna/Desktop/Games`.

## Creative development owner

Owner instruction, 3 October 2026: use `C:/Users/rauna/Desktop/Bots/Brand Manager Bot/Brand-Manager-Creative` for all creative asset development. This applies to all game work packages below. No creative assets are requested or produced in this planning pass.

Engineering supplies a bounded creative brief with game identity, screen placement, required dimensions/formats, light/dark and accessibility needs, animation/performance budget, acceptance criteria and provenance requirements. Brand-Manager-Creative develops the assets through its own workflow; engineering verifies and integrates reviewed outputs. Asset existence does not establish licensing or successful in-app rendering.

| Game | Creative work package |
| --- | --- |
| Sudoku | Audit and refine the existing Quiet Focus identity/icon only where needed; palette and UI treatment proposals; optional store graphics and screenshot composition |
| Word Finder | Preserve the calm brain-break identity; board/highlighter and completion treatment proposals; licensed sound/visual assets if needed; optional store graphics and screenshot composition |
| Scratcher | Concept directions first, then one card treatment, reveal surface, small collectible set and completion treatment for the approved prototype |

Do not rebuild existing assets solely to create work. Approve the scratcher concept before producing a full collection; specify any needed asset rights and exports in the creative brief.

| Task | Observed foundation | Proposed next outcome |
| --- | --- | --- |
| Sudoku | Single-module Compose app, Room, DataStore, engine/game-state tests; compile/target SDK 34 | Verified personal-use gameplay and polish, then separate release preparation |
| Word Finder | Single-module Compose app, DataStore, JSON active-game store, generator/selection/progress tests; compile/target SDK 36 | Verified selection, saved progress, daily mode and content, then separate release preparation |
| New games / scratcher | Game1 and game2 have no visible contents in this inspection | One small offline scratcher prototype and a documented continue/stop decision |

Recommended order: baseline both existing apps; complete Sudoku reliability and polish; complete Word Finder reliability and content; prepare their release packages if desired; prototype the scratcher. Game1/game2 are placeholders, not two defined game requirements. Do not invent a second game solely to fill the second folder.

## Sudoku

Preserve the current offline Kotlin/Compose/Room/DataStore architecture and the calm personal-use direction in `plan.md` and `Plan1.md`. The task tracker adds release preparation beyond the original personal-use scope; keep it a separate work package.

1. **Baseline and reconcile plans.** Inspect build/wrapper compatibility, manifests, navigation, persistence and current screens. Run unit tests, lint and a debug build on the available toolchain, recording failures rather than upgrading everything at once. Compare every applicable Plan1 item with current source. Its old path under Desktop/Projects and missing-icon observation are stale: the inspected folder is Desktop/Games/Sudoku and its manifest references `ic_sudoku`.
2. **Prove gameplay and saved state.** Verify generated grids are valid and uniquely solvable across multiple deterministic seeds and all difficulties; examine the generator fallback, which can return the last attempted puzzle after five attempts without meeting the requested clue range. Check actual difficulty experience separately from clue count. Exercise entry, erase, notes, hints, undo, mistake count and completion. Verify new-game replacement confirmation, background/pause timer behavior, rotation, process recreation and statistics counted once. Check Room schema/upgrade and backup/restore behavior before changing either.
3. **Finish the focused UI pass.** Compare current Home, Game, Completion, Statistics, Settings and theme source against Plan1. Repair only remaining issues: board readability, keypad/control reachability, selection/error/hint distinction, dark theme and landscape. Validate TalkBack navigation, adequate touch targets and large fonts. Do not add daily challenges, streaks or accounts to this package.
4. **Prepare optional distribution.** Choose source license, audit dependencies/assets, add README/setup instructions, changelog and non-deploying CI. Plan a compatible SDK/toolchain update for store submission, then test changed platform behavior and the unsigned release build. Prepare signing instructions, listing/screenshots and privacy/data disclosures matching actual behavior. Keep private keys outside source. Owner authorization is required before signing or uploading.

Acceptance evidence: recorded test/lint/build results; device or emulator evidence for the gameplay/restoration checklist; resolved blocking findings; a plan-versus-code checklist; and, for distribution work, a reviewed license/notices and release checklist. Presence of tests is not evidence they pass.

## Word Finder

Follow the reliability-first priority in Plan1; preserve manual wiring and the offline architecture. Daily-puzzle, definitions and player-progress source already exists, so assess it before treating those features as missing.

1. **Baseline and feature map.** Run the appropriate unit/lint/debug checks. Map Plan1 requirements to source and record implemented-but-unverified, missing and deferred items. Inspect Home/Game/Settings, PuzzleCatalog, GameViewModel and repositories together.
2. **Verify selection and generation first.** Exercise all eight directions, reverse selection, overlapping words, duplicate occurrences, short drags, cancelled drags and grid edges on different board sizes. Confirm valid-looking selections behave consistently with the validator. Test generator placement, deterministic identities and each theme/difficulty catalog; verify generation remains off the main thread. Measure slow cases before proposing optimization.
3. **Verify persistence and progression.** ActiveGameRepository already attempts temporary-file/atomic replacement and reports malformed saves and write failures. Test those paths, concurrent/rapid writes, restart, process recreation and completed-game cleanup; do not assume the mechanisms are proven. Verify daily identity around date/time-zone changes, repeated completion without duplicate rewards/statistics, hints, elapsed time and best times. Distinguish settings/progress storage from the active-game JSON file. Existing backup is disabled; document the consequence and decide export needs separately.
4. **Audit words and polish.** Review WordBank, ThemeWordBanks and WordDefinitions for suitability, definitions, duplicates and matching rules. NOTICE.md claims a hand-curated word bank; confirm provenance for all later content and assets, then audit dependency notices and choose a source license. Validate highlighter readability, sound/haptic toggles, reduced motion, large fonts and a usable alternative to drag-only play. Keep custom puzzle creation/export as a later package after the core checks pass.
5. **Prepare optional distribution.** Add README, changelog and non-deploying CI; test current platform behavior and unsigned release output. Prepare screenshots, truthful listing/privacy declarations, support details and signing procedure. SDK 36 in configuration alone does not prove release readiness.

Acceptance evidence: deterministic selection/generation regressions, save-failure/restoration and daily/progress evidence, reviewed content provenance, accessibility/device checklist, and a separate release package. Each numbered step can become a tracker task; completion requires evidence.

## New games / scratcher

Proposed concept, not an existing owner decision: a short-session offline scratch-to-reveal collection game. Use Game1 as the candidate workspace only after confirming the concept; leave game2 undefined.

1. **Define the loop.** Write a one-page brief: scratch a card, reveal a collectible, complete a small set, unlock the next set. Decide audience, visual theme, duplicate handling and why a player returns. Default prototype scope: fictional collectibles with no purchase or cash/prize redemption. If the owner means another kind of scratcher, revise the brief before implementation.
2. **Build one vertical slice.** One screen, one card style, one small collection, reveal threshold, replay/reset, optional haptic feedback and local progress. Use the simplest suitable Android setup after reviewing the existing workspace conventions. Add a tap-to-reveal accessibility alternative. No backend, ads or payment integration in the prototype.
3. **Prove the loop.** Test threshold edges, rapid touch input, background/resume, interrupted reveal, progress restoration and collection completion. Verify small-screen/large-font usability and frame responsiveness on an actual test environment. Hold a short owner playtest and record enjoyment, confusing actions and replay interest; no invented retention targets.
4. **Make a continue/stop decision.** If the loop is enjoyable, plan one bounded content expansion and a costed asset/content workflow. Otherwise retain the prototype and change the loop. Evaluate monetization, permissions, privacy and applicable platform policy as a distinct decision before adding purchases, rewards or SDKs.

Acceptance evidence: approved concept brief, playable local slice, recorded checks and playtest, and owner decision on further investment. No timeline estimate is committed before baseline/toolchain and content needs are known.

## Common gates and evidence limits

New-app and update submissions currently require API 36 for ordinary Android mobile apps according to [official target SDK guidance](https://developer.android.com/google/play/requirements/target-sdk) checked 3 October 2026. Re-check at submission time. Sudoku's API 34 needs a migration assessment for that path; Word Finder's API 36 still needs behavioral validation. Use [core app quality guidance](https://developer.android.com/docs/quality-guidelines/core-app-quality) for platform, accessibility and interruption checks.

Inspection performed: source task tracker; both game plan documents; build configurations/manifests; source/test inventories; selected Sudoku generation and Word Finder save/progress code; folder contents; Engineer governance and Android router. Neither game has a visible root .git directory in the project inventory, but initialize/configure version control only as a deliberate implementation task. No build, unit test, lint, emulator, device or release audit ran during this planning pass. There are unrelated untracked Engineer files; preserve them.

Review and acceptance follow [change control](../../../playbooks/CHANGE_CONTROL.md). Independent review records findings; the author does not accept its own plan. Root acceptance and owner milestone approval remain separate gates. Keep tracker items pending until their outcomes have evidence. Reconcile any browser-local tracker edits/export with the source tracker before editing that dashboard; this pass used the on-disk task list.

Independent review: `review_game_plan`, 3 October 2026, reported no blocking or important findings. Advisory repair: describe Sudoku fallback as the last attempted puzzle, not a proven closest candidate. Local deterministic check passed for required plan sections and referenced source locations. Game runtime verification remains planned.
