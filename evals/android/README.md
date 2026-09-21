# Android routing evaluations

This directory contains a deterministic, lightweight trigger corpus for the Android skill library. It is intentionally independent of network access, Android Studio, Gradle, and a device: the check compares each prompt with the `name` and `description` frontmatter of discovered skills.

Run the strict check after changing skill metadata or routing cases:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\scripts\test-skill-triggers.ps1
```

During staged authoring, permit missing skill folders while still validating the corpus shape and coverage:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\scripts\test-skill-triggers.ps1 -AllowMissingSkills
```

The corpus covers every skill, unrelated prompts that must not route to Android,
nearest-neighbor collisions, and prompts that intentionally require multiple
skills. A positive case declares a primary skill, signals, a minimum score, and
a minimum lead over every non-adjacent skill; explicitly allowed adjacent skills
may be named for genuinely cross-cutting prompts. A negative case sets
`forbidAllPlanned` so every discovered planned skill is checked.

`skill-contracts.json` separately records the compact instructions and domain
invariants that compression must preserve. Run its deterministic guard after
changing any `SKILL.md`:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\scripts\test-skill-contracts.ps1
```

These are routing and named-contract guards, not semantic proofs. They catch
lexical ambiguity and missing required concepts, but cannot establish that
advice is factually correct or that a command compiles. Those claims require
independent review plus the template and reference-app checks in the
implementation plan.

## Behavioral evaluation protocol

`behavioral-cases.json` records realistic Android tasks and the observable
contract for a good run: primary and adjacent skills, checks, evidence, and
whether changes are allowed. Validate the offline corpus with:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\scripts\test-behavioral-evals.ps1
```

To score a run, provide a JSON report with `kind`, `schemaVersion`, a
`provenance` object, and a `runs` array. Each run must contain `caseId`,
`selectedSkills`, `checksRun`, `evidence`, and optional `changedPaths` arrays.
Provenance must identify the source type, repository revision, collection time,
and whether the evidence is `self-reported` or `independently-verified`. The
source type must be `codex-run`, `manual`, or `imported`; independently verified
reports also require reviewer, review-time, and artifact metadata. The
runner checks expected and forbidden skills, primary-skill ordering, required
checks and evidence, and the no-change boundary. It rejects example-only or
malformed reports. Report labels remain self-attested unless independently
verified; neither a passing corpus nor report proves the underlying Android
advice is correct.

`behavioral-report.example.json` is a format-only sample and must not be
reported as evidence from a real Codex run.

When a skill is renamed or split, update `plannedSkills` and its positive case in the same reviewed change. Keep negative cases genuinely outside Android so accidental broad trigger descriptions remain visible.
