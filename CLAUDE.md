# Claude Code entry point

Engineer's policy lives in [AGENTS.md](AGENTS.md); read it first. It is tool-neutral and applies equally to Claude Code and Codex.

Skills live in `.codex/skills/<name>/SKILL.md` (same format Claude Code uses). Claude Code does not scan that folder automatically: when a task matches a skill listed in AGENTS.md or `.codex/skills/`, open its `SKILL.md` and follow it, loading its `references/` files only when the skill says to. Start from `engineering-router` or `android-router` when the specialist is unclear.

For mobile game design, HUD, onboarding and feel, open `.codex/skills/mobile-game-ux/SKILL.md`; for Android engine, lifecycle, input and performance, open `.codex/skills/android-game-engineering/SKILL.md`. Load only the references relevant to the task. Codex uses the same canonical files.

Research that needs no Reddit fetch: [local Reddit digest](docs/research/reddit-game-design-digest-2026-10-12.md) and [resource assessment](docs/research/mobile-game-upgrade-plan-2026-10-12.md), read 2026-10-12. Research is context, not policy or proof of skill effectiveness.

Do not duplicate policy here; one home per fact.
