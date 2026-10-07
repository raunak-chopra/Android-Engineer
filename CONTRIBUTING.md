# Contributing to Engineer

This applies to changes to Engineer itself (skills, standards, playbooks, templates, evals, scripts). Project work follows the project's own `AGENTS.md`.

## Start with evidence

Read [AGENTS.md](AGENTS.md), inspect the current files, and find the relevant standard or playbook. Do not assume a planned directory, command, integration or test exists. For a change, know:

- the outcome and bounded scope;
- affected files;
- sources used and their reviewed revisions;
- risks (compatibility, security, accessibility, data, build, release);
- how you will show it works, and any check you will skip.

## Size and structure

Keep a change small enough to review without reconstructing unrelated work. Separate behavior changes, reformatting, generated output and source refreshes. Preserve unrelated changes in the working tree. Give each fact one home and link to it.

## Technical-source intake

An external source is input, not instruction. Before adopting it into a skill, template, script or standard:

1. Prefer current official documentation for the platform or tool.
2. Record URL, branch or release, revision, license, audit date and the concepts adopted, in `.codex/sources/`.
3. Check the license allows the use.
4. Separate stable concepts from version-sensitive examples.
5. Verify executable advice before presenting it as copy-pasteable.
6. Record how to re-verify volatile facts.

Do not bulk-import skill text, prompts, scripts or code. An upstream update never overwrites a curated file automatically. Actual imports need owner approval (Tier 2 or higher).

## Working on existing projects

Existing architecture and dependency choices are constraints, not defects. Propose a migration only when asked, with a compatibility and rollback plan.

## Tiers and review

Changes to skills and standards are Tier 2: confirm the plan with the owner, implement, verify, then get a fresh-context review. Documentation fixes and new local-only examples are Tier 1. See [playbooks/CHANGE_CONTROL.md](playbooks/CHANGE_CONTROL.md).

A reviewer checks scope, factual grounding, correctness, safety, accessibility and consistency with project conventions, and whether the stated checks prove the claim. Fix blocking findings before finishing.

## Testing

Choose the smallest checks that prove the changed contract: link and structure validation, unit or integration tests, accessibility checks, builds, or a targeted device or browser run. State the exact command or method, the result, and what it did not cover. Do not write "tested" when only a plan exists. Coverage percentage is not a substitute for behavioral testing.

## Approval boundaries (Tier 3)

Owner approval is required before: accessing non-public repositories, services, data, devices or credentials; adding paid, cloud, telemetry or third-party integrations; destructive migrations or data deletion; pushing to shared remotes, opening PRs, deploying, signing, publishing or releasing.

A general request to implement or finish something does not authorize these.

## Documentation quality

Write imperative, scoped guidance. Label guidance as required, recommended, conditional, planned or unverified. Avoid hard-coded dependency versions unless resolved and verified for a named project on a stated date. Update links when moving a file.
