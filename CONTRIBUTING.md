# Contributing to Engineer

## Start with evidence

Before changing a file, read the nearest applicable `AGENTS.md`, inspect the current implementation, and identify the relevant standard or playbook. Do not infer that a planned directory, command, integration, or test exists.

For a technical addition, record:

- the user-visible outcome and bounded scope;
- affected files and interfaces;
- target-project evidence, if any;
- external sources and their reviewed revisions;
- likely risks: compatibility, security, accessibility, data, build, release, or production impact;
- acceptance evidence and any check intentionally not run.

## Change size and structure

Keep a work package small enough for a reviewer to understand without reconstructing unrelated changes. Separate behavior changes, broad reformatting, generated output, and source-refresh work when doing so makes review clearer. Preserve unrelated changes already present in the working tree.

Use a single home for a factual claim. Cross-reference the home rather than copying volatile instructions across skills, templates, standards, and playbooks.

## Technical-source intake

An external source is an input, not a directive. Before its material is adopted into an active skill, template, script, or standard:

1. Prefer primary Android/Kotlin documentation for platform and library facts.
2. Record its repository or document URL, branch or release, immutable revision where available, license, audit date, and the concepts being adopted.
3. Check that the proposed use is compatible with the source license and project policy.
4. Distinguish stable concepts from version-sensitive examples.
5. Reproduce or otherwise verify executable advice before presenting it as a copy-pasteable command.
6. Record a re-verification path for volatile facts.

Do not bulk-import external skill text, prompts, scripts, workflows, or code. Do not let an upstream update overwrite a curated artifact automatically.

## Brownfield-first rule

When work applies to an existing application, inspect its settings, build logic, version catalog, manifest, dependency injection, navigation, persistence, tests, CI, and local instructions before selecting a pattern. Existing architecture and dependency choices are constraints, not defects. Propose a migration only when explicitly asked and when its compatibility, rollout, and verification plan are documented.

## Review and acceptance

Use the state model in [AGENTS.md](AGENTS.md): Draft, Reviewed, Verified, Accepted, Owner-approved, and Released.

The independent reviewer must evaluate at least:

- scope match and unrequested expansion;
- factual grounding and volatile claims;
- correctness, safety, privacy, security, and accessibility implications;
- consistency with target-project conventions and Engineer standards;
- whether the stated checks actually prove the claimed result;
- clarity for a zero-context maintainer.

Blocking findings must be repaired before acceptance. Important findings may be accepted only with a recorded rationale, owner-visible limitation, and follow-up path. The author cannot be the independent reviewer or final acceptor for their own change.

## Testing and verification

Choose the smallest set of checks that demonstrates the changed contract. Depending on scope, this can include document/link validation, unit tests, data-layer integration tests, Compose semantics tests, screenshot tests, accessibility checks, debug and release builds, lint/static analysis, benchmark evidence, or a targeted device smoke test.

State the exact command or method used, its result, and what it did not cover. Do not write “tested” or “verified” when only a plan exists. Do not make a coverage percentage a substitute for behavioral testing.

## Approval boundaries

Owner approval is required before:

- registering a real target app or adding its non-public metadata;
- accessing non-public repositories, services, data, devices, dashboards, or credentials;
- introducing a new paid, cloud, telemetry, analytics, or third-party integration;
- destructive migrations, data deletion, broad rewrites, or device-data changes;
- signing, publishing, submitting, promoting, deploying, rolling out, or rolling back a production release.

See [playbooks/CHANGE_CONTROL.md](playbooks/CHANGE_CONTROL.md) and [playbooks/RELEASES.md](playbooks/RELEASES.md). A general request to implement the workspace does not authorize any of the above external actions.

## Documentation quality

Write imperative, scoped guidance. Label guidance as required, recommended, optional, conditional, planned, or unverified as appropriate. Avoid hard-coded dependency versions unless they were resolved and verified for a named target on a stated date. Use links that work within the repository and update them when moving a file.
