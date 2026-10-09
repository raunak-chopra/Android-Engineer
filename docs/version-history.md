
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
