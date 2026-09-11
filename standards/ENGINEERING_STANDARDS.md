# Engineering standards

## Normative language

The terms **MUST**, **MUST NOT**, **SHOULD**, and **MAY** are deliberate. A MUST is a release-blocking or acceptance-blocking requirement unless the owner records a narrow exception. A SHOULD requires a documented reason when omitted. A MAY is optional.

## Evidence and truthfulness

- Contributors MUST distinguish direct evidence, inference, recommendation, planned work, and unverified ideas.
- Contributors MUST date-stamp volatile claims and identify their source.
- A source citation MUST identify enough information to re-find the material: URL or local path, reviewed version/commit when applicable, and audit date.
- A recommendation based on an external project MUST be rewritten for Engineer's scope; do not copy unreviewed prompts or broad claims as policy.
- Commands MUST be verified before being presented as copy-pasteable instructions. Otherwise, label them unverified and state their expected environment.
- Verification output MUST describe the command or method, result, and meaningful gaps.

## Change discipline

- Inspect nearby code, instructions, tests, and build configuration before changing an established area.
- Keep changes bounded and reversible where practical.
- Preserve unrelated user work and avoid broad rewrites, formatting churn, or generated output changes unless they are explicitly in scope.
- Do not hard-code secrets, access tokens, signing material, user data, device identifiers, or production endpoints.
- Do not introduce external dependencies, telemetry, cloud services, or paid services without explicit owner direction and a documented privacy/security review.
- Prefer minimal visibility and minimal permissions. Expand visibility, data access, or privileges only for a demonstrated consumer need.

## Quality and testing

- Define the behavior or contract that a change must prove before implementation.
- Use the smallest appropriate test level, but add higher-level coverage when an interaction crosses layers.
- A bug fix SHOULD include a regression test that fails before the fix when the failure can be reproduced safely.
- Behavioral testing, error/empty/loading cases, accessibility, security, and release behavior MUST not be replaced with a coverage percentage.
- Tests and examples MUST be deterministic where practical: stable fixtures, controlled time, and no undeclared network dependency.
- Generated templates and scripts MUST be exercised in the supported environment before they are claimed to work.

## Security, privacy, and resilience

- Treat logs, screenshots, crash reports, analytics, test fixtures, and build output as potential data-exposure surfaces.
- Redact or avoid sensitive data in documentation and diagnostics.
- Do not weaken certificate, authentication, authorization, backup, export, encryption, or permission behavior merely to make a test pass.
- Document security-sensitive assumptions, expected failure behavior, and fallback paths.
- Preserve release provenance, version metadata, and optimization mapping files for artifacts that are actually released.

## Documentation and maintenance

- Documentation MUST describe the actual state, not aspirational state.
- Mark unimplemented items as planned or deferred.
- Use concise, imperative language for operational guidance.
- Give each volatile fact a re-verification path.
- Update internal links when moving or renaming a file.
- Keep a single canonical source for each rule and link to it from dependent documents.

## Review and approval

- Every meaningful change MUST receive independent review before acceptance.
- The author MUST NOT approve their own change.
- Automated checks are necessary evidence when applicable, but they MUST NOT be treated as a replacement for review.
- High-severity correctness, safety, security, privacy, accessibility, or production-risk findings MUST be resolved before acceptance.
- Owner approval is required for milestone transition and all external or production actions defined in the playbooks.

See [change control](../playbooks/CHANGE_CONTROL.md) for risk classification and [releases](../playbooks/RELEASES.md) for the release boundary.
