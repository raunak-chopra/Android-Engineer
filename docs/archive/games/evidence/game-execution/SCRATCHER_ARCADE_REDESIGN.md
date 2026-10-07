# Scratcher arcade redesign

4 October 2026, India. Draft/in progress. Owner rejected the AI scene/form presentation and requested a creative graphical game with multiple values, scratcher anticipation, and dependable GitHub foundations. This supersedes the prior presentation direction; retained source and historical acceptance establish only the old slice, not acceptance of this redesign.

Bounded current implementation: ticket-first rack, four virtual-coin decks, distinct printed rule boards, full ticket scratch surface, deterministic purchase outcomes, album stamps for every settled design, graphical order tiles, and a finite win particle burst. Classic and Pixel share rules and saves remain separate. Existing saves migrate from v2 to v3 without resetting wallet/outcome/coverage. The existing storage filename is retained; the version is inside the bounded snapshot. The prototype launcher stays unchanged. No room/shop generated scene is used in the new launcher UI.

| Ticket | Price | Rule | Gross payout distribution | Expected gross return |
| --- | --- | --- | --- | --- |
| Quick Ten | 10 | Reveal printed prize | 50% 0, 30% 10, 15% 20, 5% 60 | 9 |
| Cherry Club | 20 | Find three cherry symbols | 60% 0, 25% 20, 12% 50, 3% 200 | 17 |
| Neon Numbers | 50 | Match a winning number | 65% 0, 25% 50, 8% 100, 2% 1000 | 40.5 |
| Midnight Vault | 100 | Find three keys | 70% 0, 20% 100, 9% 300, 1% 2000 | 67 |

Source tests enumerate every tier/roll for price, round trip and printed-board/payout consistency. Purchase locks the outcome; scratch style has no effect. Win effects apply only above ticket price. Album stamps also accompany losing tickets. Counter pick rotates by in-game day, with every ticket still available: no fake live winners, stock counts, expiring money, manipulated near misses or chase-loss messages. No cash-out, paid currency, advertising, network permission or publishing was added.

## Reviewed external sources

Research, 4 October 2026: [California Lottery catalogue](https://www.calottery.com/en/scratchers) and [Virginia retailer manual](https://cdnprodpaasmedia-valottery-com.azureedge.net/-/media/images/retailer-center/virginia-lottery-retailer-manual020525.pdf?rev=f30c651e4aeb4df9b04f361a84a135b1) identify different price points, matching symbols/amounts and key-symbol mechanics. These inform original game rules; no ticket artwork, trademarks or wording copied.

Integrated code dependency: [DanielMartinus/Konfetti](https://github.com/DanielMartinus/Konfetti), release 2.0.5, revision `bacc389dbdac31313a2acd2702793f32fdaeb10a`. Inspected tagged LICENSE, README, Compose renderer and preset APIs. ISC copyright/permission notice bundled in Game1 `app/src/main/assets/licenses/KONFETTI-ISC.txt`; exact version `nl.dionsegijn:konfetti-compose:2.0.5`. It is a particle library, not an entire scratcher engine. Its Compose renderer uses lifecycle cancellation and an infinite frame loop; this integration removes the overlay after 2.4 seconds to bound runtime and emission to 45 particles. No copied upstream source module is represented as original.

Also inspected [libGDX](https://github.com/libgdx/libgdx) and its Apache-2.0 licence/release history, official [Compose samples](https://github.com/android/compose-samples), MIT web-only [ScratchCard](https://github.com/Masth0/ScratchCard), and [Kenney Casino Audio](https://kenney.nl/assets/casino-audio) (CC0). These are research candidates, not installed game engines or imported assets. libGDX is an alternative if measured renderer needs justify migration; browser scratch libraries cannot be silently treated as native Android code. Existing AndroidX is the open-source native UI foundation. Third-party sound/sprite production remains pending and must carry provenance.

## Acceptance and remaining game scope

Pending: compile/unit checks, new UI gesture suite for both editions, rendered small-screen and large-text review, tier-specific gesture tests, independent review. A source change is not visual approval. No complete game/release claim.

First arcade build passed3m15s,162tasks(51executed/111up-to-date), `scratcher-arcade-build.log`; this predates the final graphic/review repairs. Reviewer found cancelled burst cleanup, unlabeled haptic toggle and placeholder product/cherry symbols. Installed repairs reset/clear burst on cancellation, explicitly label haptics, and render native recognizable product/cherry/key art. Final repair/lint build pending in `scratcher-arcade-repair-build.log`. Earlier isolated process-restart proof covers v2 old presentation; v3 migration has source/unit coverage pending final build, not fresh restart evidence.

Final arcade repair build passed2m36s,179tasks(39executed/140up-to-date), `scratcher-arcade-repair-build.log`, including both editions' unit/assemble/lint/testAPK tasks and prototype unit regression. Independent source review has no remaining blocking finding after repairs, but new Android runtime/screens remain pending; source review is not product approval. No released/full game claim. A new task-owned emulator is booting for those checks.

The owner's large graphical game request remains active: animated product/customer sprites and actual counter interaction, multiple foil panels, distinct ticket illustrations, pack/tear animation, scrape sound and audio setting, substantive life progression/branching events, upgrades and collection goals, tutorial/practice flow, accessibility/performance/physical-device checks and release preparation. The present code is the first correction toward that direction, not a full fulfilment.
