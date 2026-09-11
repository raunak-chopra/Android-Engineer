# Verification record

## Baseline scope

This record covers the local Engineer baseline: repository governance, four
audited community sources, fourteen Android skills, deterministic routing and
structure checks, three Android generator profiles, one extended reference app,
and non-deploying CI. It does not approve a target app, signing identity,
publication, deployment, or production action.

## Implementation and repair evidence

Implementation used separate Terra Max and Luna Max work packages. Root then
integrated and exercised the combined output. Verification found and repaired:

- a version-catalog accessor collision in generated Compose aliases;
- an incompatible Compose BOM/AGP/API combination by selecting the locally
  verified Compose BOM `2025.08.00` for AGP `8.13.2` and API 36;
- lost PowerShell escaping around the modular `kotlin-dsl` plugin;
- missing generated Gradle wrappers by embedding Gradle 8.13 wrapper assets;
- an unpinned wrapper download by adding Gradle's official SHA-256;
- CI that generated but did not compile templates by adding a three-profile
  Linux compilation matrix and Windows wrapper builds;
- lexical routing checks that did not detect competing skills by adding an
  explicit primary skill and minimum-lead assertion against non-adjacent skills;
- unvalidated SDK/version inputs and late wrapper discovery by adding generator
  grammar, SDK ordering, and wrapper preflight checks;
- mutable CI action tags by pinning every action to an immutable commit SHA;
- drift checks that ignored `trackedRef` by resolving each recorded ref;
- hard-coded reference UI copy and a tautological smoke test by using Android
  resources and asserting generated project identity;
- roadmap claims that exceeded the implemented baseline by naming target-bound
  work as deferred rather than implied complete.

## Deterministic checks

The following checks passed locally on 2026-09-11:

| Check | Result |
| --- | --- |
| `scripts/validate-engineer.ps1 -RequireSkills` | PASS: 14 skills, repository Markdown links, and repository JSON |
| `scripts/test-skill-triggers.ps1` | PASS: 20/20 cases; each positive primary outranks non-adjacent skills |
| Project stewardship skill-library validator | PASS: 14 skills |
| `scripts/check-skill-drift.ps1` | PASS: all four remote HEADs unchanged from audited SHAs |
| Drift `-UpdateLedger -WhatIf` | PASS: preview made no change |
| Generated `minimal` wrapper build | PASS: `help`, unit test, debug APK |
| Generated `standard` wrapper build | PASS: `help`, unit test, debug APK |
| Generated `modular` wrapper build | PASS: convention plugin, `help`, unit test, debug APK |
| Extended reference app | PASS: app/feature unit tests, debug APK, unsigned R8/resource-shrunk release APK |

Initial online resolution populated declared dependencies; fresh post-repair
profile builds ran with `--offline` through each generated wrapper. JDK 17 and
Android SDK 36 were used. Invalid SDK ordering was also rejected before a
destination was created. Hosted GitHub Actions execution remains unproven until
the first push or pull request.

The skill-creator `quick_validate.py` helper could not run because the bundled
Python environment lacks PyYAML. This is an environment limitation, not recorded
as a pass. The repository validator and project-stewardship validator both ran.

## Independent review

Independent Terra Max and Luna Max reviews identified reproducibility, CI depth,
routing ambiguity, source-license, reference-app, and scope-truth issues. The
listed local repairs were applied. Terra Max's final re-review found no remaining
Important issues and declared the local baseline ready for root Verified status.
Luna Max's final short re-review did not complete within its bounded window; its
earlier Blocking findings were repaired and independently covered by the Terra
re-review and deterministic gates.

Root disposition on 2026-09-11: the local baseline is **Verified** and
**Accepted**. Hosted M4/M6 evidence is intentionally still pending because no
commit or push was authorized. Nothing is owner-approved or released.

## Deferred evidence

These remain explicit follow-up packages because no real target application is
registered: navigation/restoration, persistence and sync, instrumentation UI and
accessibility tests, screenshot baselines, benchmarks, dedicated secret scanning,
release-evidence packaging, R8 mapping retention outside the build workspace,
signing, store upload, rollout, and production monitoring.
