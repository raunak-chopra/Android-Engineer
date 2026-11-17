## 2026-11-06 — Preserve reusable resource and asset guidance

- Behavior: preserve reusable resource discovery, owner-asset intake and skill reference guidance. Machine-local asset paths are redacted and omitted evidence links labelled local evidence not shipped. Asset libraries, fonts, generated slide guides and catalog/apps.json remain excluded.
- Changed files: four skill references, design source notes, README, capability/work-status documents, resource/owner-asset guides and five research documents in this checkpoint.
- Reason: resume source preservation while separating reusable toolkit guidance from local project work and third-party assets.
- Verification: isolated validate-engineer.ps1 -Compact passed: 29 skills, 105 Markdown, 60 JSON, context budget, contracts and behavioral corpus. Independent review recorded in the chat workspace; no app/device/model evaluation was run.
- Rollback: revert this checkpoint on the feature branch. Original source and staging are untouched. Remote push and PR require separate exact owner approval.

## 2026-10-22 — Maintained assistant capability guide

Added `docs/Codex-Engineer-Capabilities-and-How-to-Use.pptx` and editable sources under `docs/codex-guide/`. The 36-slide guide combines current capability coverage, usage examples, operating limits and all 29 repository skills. Preserved the 2026-10-09 presentations. Reconciled `docs/CAPABILITIES.md`, added the README maintenance pointer and updated work status. No skill, standard, dependency or application behavior changed.

Owner requested ongoing updates in this chat. Created active heartbeat `keep-engineer-capability-ppt-current` to check daily at 10:00 AM IST and refresh only material verified capability or usage changes. Future replacements must preserve owner edits, archive the prior version and pass verification. The schedule depends on local app/machine availability and permissions, and it is not an immediate software-release event hook.

Verification: all 36 slides rendered and individually inspected; package integrity, geometry, slide count, heading-fit, font policy and first-party import pass. File SHA-256: `aabbd2408a92a9f9b38e3671801ab98c305fa95bd958dccbef2eea96b3907dc6`. Delivery used a verified exclusive copy after the bundled finalizer's Windows hard-link step returned `EPERM`. Native PowerPoint was not tested; no capability benchmark or app/game/device run was performed. Evidence and limits appear in `docs/codex-guide/verification.json` and `MAINTENANCE.md`.

Rollback: cancel only the named heartbeat, remove only the new guide/supporting files and their added references, and restore this task's documentation additions while preserving prior owner work. No commit, push, PR or publication occurred.

## 2026-10-07 — Exclude machine-local staging from Git

- Changed behavior: root `.tmp/` staging files and emulator snapshots no longer appear as commit candidates. No local files are deleted; pending one-off repair scripts and raw evidence remain local for separate review.
- Changed files: `.gitignore`, `docs/version-history.md`.
- Reason: repository maintenance found approximately 4.7 GB of untracked staging data, including emulator disk/snapshot/key files, which must not be published as project source.
- Verification: independent read-only review found routing (32/32), skill contracts (14/14), and the 10-case behavioral corpus passing. The full repository validator has five existing documentation-link failures; the older M7 branch also has seven shader whitespace failures. This hygiene change does not accept or release M7.
- Rollback: revert the scoped hygiene commit on a feature branch if needed. The ignored files remain on disk; do not force-add emulator or key files.

## 2026-10-09 — Restore the shared toolkit in main

Integrated the preserved restructure branch into the main checkout while retaining main's Claude-co-authored ignore cleanup. Resolved .gitignore by retaining both exclusion sets, repaired seven documentation-link findings, added a 27-skill capability inventory, removed README placeholders, and updated roadmap/status records.

Validation: repository validator, skill contracts (27), routing cases (32), behavioral corpus (10; no model runs), context budget and lazy-load recipes passed. All nine lazy-load safety regressions passed. Fresh-context review found no Blocking or Important issues; its minor EOF and compatibility wording findings were corrected. Historical archived log whitespace warnings retained. Remote verification failed due to GitHub DNS resolution; hosted CI and project builds/runtime were not run.

Rollback: revert the integration merge with parent 1 on a local branch; preserve the restructure branch. No history rewrite or external action authorized or performed.

## 2026-10-12 — Mobile game guidance upgrade and record correction

Local commit b37be0c contains the mobile-game-ux and android-game-engineering skills, game references, routing, Claude entry point and research digest. The approved implementation and independent review are recorded in docs/work-status.md. Corrected stale pending/adoption and commit wording after inspecting the actual checkout; this follow-up changes documentation only.

Latest checks: 29 skill contracts, 35 routing cases, 17 lazy-load recipes and enforced context budgets pass. Historical safety/corpus/clean-copy validator evidence retains its scope. Real-game effectiveness is not established by structural checks. Rollback: undo only this documentation correction; preserve the applied skills and pre-existing owner work. No new commit or external action was made in this correction.

## 2026-10-21 — Index the owner's additional game asset packs

Organized 19 archives in the owner's named Downloads/Game Assets folder into seven categories, preserved all original archive bytes, and indexed 14,552 extracted working files with usage-status notes. The existing local lookup helper now searches these packs/assets alongside the earlier source library. Persistent navigation and selection notes live in `docs/OWNER_GAME_ASSETS.md`, linked from `docs/RESOURCE_LIBRARY.md`; organization and lookup helpers remain machine-local under ignored `artifacts/`. No standards, skills, dependencies or project code changed.

Verified all 19 original archive hashes, all 14,552 extracted file hashes/sizes, inventory consistency, 40 local links, new pack/asset searches and existing component search. No engine, visual, audio or runtime validation ran. Four packs have explicit noncommercial limits and eight lack a bundled usage license. Rollback uses the Downloads folder's exact move journal and removal of only the new lookup registration/documentation references; preserve earlier owner changes and original archives.

## 2026-10-21 — Design resources deep dive and Tier 2 skill-reference upgrade

Completed the 12-source design deep-dive report (`docs/research/design-resources-deep-dive-2026-10-21.md`) and, following owner confirmation in chat (`"yes"`, 2026-10-21), updated four conditionally loaded skill references (`.codex/skills/visual-design-system/references/handoff.md`, `.codex/skills/product-ux-design/references/research.md`, `.codex/skills/web-frontend/references/widgets.md`, `.codex/skills/mobile-game-ux/references/assets-and-screen-contracts.md`) and `.codex/sources/design-lazy-2026-10-07.md`. The updates add 3-tier semantic token rules (`bg/fg/border` × `default/subtle/muted/emphasized/status` + `on-*` contrast pairs), orthogonal `variant × density × tactile` axes, `tabular-nums`, `@media (hover: hover)` and coarse-pointer `>=1rem` focus zoom guards, `prefers-reduced-motion` frame-loop termination, deterministic async button/error-summary recovery, ultrawide HUD aspect constraints, dynamic input prompt glyphs, and links to `docs/RESOURCE_LIBRARY.md` and `docs/OWNER_GAME_ASSETS.md`.

Verified with PowerShell 7 (`pwsh.exe`): context budget (`55,043` bytes, `20.64%` reduction), lazy-load contract (17 recipes, 15 managed skills, 17 references all `<=2,400` bytes; `43,719` CRLF managed stored bytes), skill contracts (29/29), trigger evaluation (35/35 strict), behavioral corpus (10 cases), and link/whitespace checks across all modified files pass. Fresh-context Tier 2 review found no Blocking issues; two Important status/line-ending reconciliation items were fixed. Rollback: revert the five `.codex/` files, remove `docs/research/design-resources-deep-dive-2026-10-21.md`, and restore the prior lines in `docs/research/design-resources-report-plan-2026-10-21.md`, `docs/RESOURCE_LIBRARY.md`, `docs/work-status.md` and this file.


## 2026-10-21 — Correct overbroad design-resource guidance

Owner approved the review findings in chat. Changed `.codex/skills/visual-design-system/references/handoff.md`, `.codex/skills/product-ux-design/references/research.md` and `.codex/skills/web-frontend/references/widgets.md` to make validation/progress timing evidence-based, avoid assuming `1rem` means `16px`, preserve necessary rendering under reduced motion and use tabular numerals where alignment helps. Reconciled `docs/research/design-resources-deep-dive-2026-10-21.md`, its report plan, `.codex/sources/design-lazy-2026-10-07.md` and `docs/work-status.md`. Corrected the Vant Back claim and distinguished corpus validation from model/runtime evidence. This entry supersedes overbroad wording in the initial expansion entry above.

Verification: context budget, lazy-load contract, 29 skill contracts, 35 strict triggers, three skill-creator validators, 38 local links and whitespace checks pass. Behavioral corpus: 10 Android cases, zero model runs. Nine lazy-load safety regressions also passed. Independent fresh-context reviewer `/root/guidance_review` found zero Blocking, Important or Advisory findings; evidence paths and scope are in `docs/work-status.md`. Full-repository validation was not rerun. No app/game pilot or runtime/battery validation. Rollback: reverse only the follow-up patch using the pre-correction copies in ignored `.tmp/design-guidance-correction-2026-10-21/before/`; preserve prior owner changes.
