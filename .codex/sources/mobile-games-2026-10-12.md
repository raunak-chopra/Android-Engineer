# Mobile game skills provenance

Read date: 2026-10-12. Scope: original local instructions; no imported code, prompts, assets, fonts, dependencies or installers. This is discovery, not an approved import list. Web pages and repositories are mutable; re-check at use time.

## Community evidence (Reddit)

Reddit could not be opened by the fetch, browser or search tools in the first session. A later research pass read six threads (five owner-supplied plus one mobile puzzle UX thread, including exposed comments); the owner supplied its output as local files. Use these instead of fetching Reddit:

- [Reddit digest](../../docs/research/reddit-game-design-digest-2026-10-12.md): selective paraphrase with stated limits. Self-reported results (plays, revenue, speed) were not verified and promotional posts are not benchmarks. No controlled comparison of skill effectiveness exists in the threads.
- [Resource assessment and applied patch](../../docs/research/mobile-game-upgrade-plan-2026-10-12.md).

Threads: r/ClaudeAI 1unr6wb (3D game quality), r/aigamedev 1rjrh7j (Claude and Unity workflow, self-promotional), r/gamedev 1us59ct (Claude for game development), r/ClaudeAI 1t5ui23 (browser games), r/aigamedev 1w1uemt (game designer skill), r/gamedesign 1rq18qg (touch controls). The owner's earlier pasted summary (brainstorm then cross-examine the loop, diagrams, review passes, editor bridges over MCP, code and art kept separate) is consistent with the digest and is treated the same way: community evidence, not requirements.

## GitHub (public API, queried 2026-10-12; not primary sources)

- [gamedev-skills/awesome-gamedev-agent-skills](https://github.com/gamedev-skills/awesome-gamedev-agent-skills): reported Apache-2.0, 75 skills incl. game-ui-ux, game-feel, godot-ui-control, input-systems. Inspiration only; wording is original.
- [android/skills](https://github.com/android/skills): reported Apache-2.0, official; no game-specific skills at read date.
- [android/games-samples](https://github.com/android/games-samples): reported Apache-2.0 samples.
- [playgameservices/play-games-plugin-for-unity](https://github.com/playgameservices/play-games-plugin-for-unity): licence not classified by the API; Unity-only Level Up skills; reference only.
- [libgdx](https://github.com/libgdx/libgdx), [gdx-liftoff](https://github.com/libgdx/gdx-liftoff), [ktx](https://github.com/libktx/ktx) (last push reported 2025-06), [Unciv](https://github.com/yairm210/Unciv): engine and reference projects.
- Lists (leads, not rules): [awesome-game-design](https://github.com/Roobyx/awesome-game-design), [awesome-gamedev](https://github.com/fronkongames/awesome-gamedev).

## Official documentation (read 2026-10-12)

[Android games hub](https://developer.android.com/games), [Level Up guidelines](https://developer.android.com/games/guidelines), [quality](https://developer.android.com/quality), [Android skills](https://developer.android.com/tools/agents/android-skills), [large-screen behaviour](https://developer.android.com/develop/adaptive-apps/guides/app-orientation-aspect-ratio-resizability). Google's Play Games Level Up skills are Unity-only per [their page](https://developer.android.com/games/engines/unity/ai-skills-for-level-up).

Corrections adopted from the research pass, checked against the large-screen page: the Android 16 override at sw600dp has a game exception based on `android:appCategory`; the per-app opt-out ends for apps targeting API 37, so recheck game handling for newer target SDKs. Native Android pointer indices change while pointer IDs are stable. The earlier 50 to 100 pixel finger-size claim was removed as device-dependent.

## Benchmarks

GameAnalytics 2025 figures (median D7 about 3.4 to 3.9 percent; 75 percent of projects under 3 percent D28) were read through third-party summaries. The skills do not rely on them; verify against the primary report before use.

Not verified: any engine, demo or skill behaviour on a physical device or emulator.
