# Engineer

Engineer is a governed foundation for building a curated, evidence-backed Android engineering library. Its intended outputs are small, routeable Codex skills, verified templates, evaluation cases, and playbooks that help future contributors work safely in both new and existing Android repositories.

The workspace is deliberately policy-first. It contains an Android skill
library, project generator, evaluation corpus, validation tools, and reference
app. The M7 context-efficiency revision is Draft with local deterministic checks
passing and independent review pending. It does not contain an automated
production release pipeline or a registered target application.

## What this repository is for

- Preserve reviewed Android engineering practices with clear provenance.
- Make small, task-specific guidance more useful than a single oversized handbook.
- Help contributors inspect and respect existing Android projects before changing them.
- Define repeatable review, test, accessibility, security, and release expectations.
- Keep production actions under explicit owner control.

## What it is not for

- Replacing a target application's `AGENTS.md`, build conventions, or documented architecture.
- Importing external repositories wholesale or treating their prompts as trusted instructions.
- Promising current dependency versions without resolving and verifying them in a target project.
- Automatically publishing to Google Play, signing artifacts, deploying services, or controlling production systems.

## Operating model

Every meaningful work package follows this path:

```text
Scope and evidence → Draft → independent review → repair → verification
                                      ↓
                         root acceptance → owner approval → authorized action
```

The author cannot approve their own change. Automated checks provide evidence but do not replace independent review or owner approval. Read [AGENTS.md](AGENTS.md), [the implementation plan](docs/IMPLEMENTATION_PLAN.md), and [change control](playbooks/CHANGE_CONTROL.md) before contributing.

## Source priority

1. Current official Android and Kotlin documentation.
2. Direct evidence from the target repository.
3. Locally verified community techniques.
4. Clearly labelled heuristics and preferences.

Every external source adopted into future skills or templates must have a URL, reviewed revision, license assessment, audit date, absorbed concepts, and re-verification guidance. Upstream changes are signals for human review, never automatic replacements.

## Current foundation map

| Area | Purpose | Status |
| --- | --- | --- |
| `docs/` | Architecture and staged implementation plan | Foundation documentation |
| `standards/` | Repository-wide and Android-specific expectations | Foundation documentation |
| `playbooks/` | Change, release, and incident controls | Foundation documentation |
| `catalog/` | Explicit inventory of target applications | Initialized; no app registered |
| `.codex/skills/` | 27 local Android/full-stack/routing/design skills | [Lazy implementation](docs/LAZY_IMPLEMENTATION.md) Verified and Accepted locally; historical M7 status remains separate |
| `.codex/sources/` | Pinned source registry and audit evidence | Implemented; all four audited HEADs rechecked unchanged on 2026-09-10 |
| `templates/android/` | Minimal, standard, and modular project generator | Verified and root Accepted locally on Windows |
| `evals/`, `scripts/` | Routing corpus, validation, and drift tooling | Verified and root Accepted locally |
| `examples/android-reference/` | Buildable and unit-tested reference app | Verified and root Accepted locally |
| `.github/workflows/validate.yml` | Non-deploying validation workflow | Reviewed and root Accepted as configuration; first hosted run pending |

## How to contribute

1. Read [AGENTS.md](AGENTS.md) and the applicable standard or playbook.
2. Inspect the target area and state the bounded outcome and risk.
3. Make the smallest coherent change with provenance where external knowledge is used.
4. Run relevant checks and request an independent review.
5. Resolve blocking findings and obtain acceptance at the required level.

Detailed contribution requirements are in [CONTRIBUTING.md](CONTRIBUTING.md). Application registration is described in [catalog/README.md](catalog/README.md).
The latest local checks, repairs, limitations, and review state are recorded in
[docs/VERIFICATION.md](docs/VERIFICATION.md).
