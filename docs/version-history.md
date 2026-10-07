
## 2026-10-07 — Exclude machine-local staging from Git

- Changed behavior: root `.tmp/` staging files and emulator snapshots no longer appear as commit candidates. No local files are deleted; pending one-off repair scripts and raw evidence remain local for separate review.
- Changed files: `.gitignore`, `docs/version-history.md`.
- Reason: repository maintenance found approximately 4.7 GB of untracked staging data, including emulator disk/snapshot/key files, which must not be published as project source.
- Verification: independent read-only review found routing (32/32), skill contracts (14/14), and the 10-case behavioral corpus passing. The full repository validator has five existing documentation-link failures; the older M7 branch also has seven shader whitespace failures. This hygiene change does not accept or release M7.
- Rollback: revert the scoped hygiene commit on a feature branch if needed. The ignored files remain on disk; do not force-add emulator or key files.
