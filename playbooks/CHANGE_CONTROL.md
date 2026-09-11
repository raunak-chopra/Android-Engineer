# Change control playbook

## Purpose

This playbook prevents a useful implementation plan from becoming implicit authority to make high-impact changes. It applies to documentation, skills, scripts, templates, evaluations, target-app integrations, and operational actions performed through Engineer.

## Classify the change before implementation

| Class | Typical examples | Minimum gate |
| --- | --- | --- |
| Documentation-only | Clarifying a non-volatile policy or cross-link | Independent review and link/consistency checks |
| Curated guidance | Skill, standard, source interpretation, template documentation | Provenance review, independent review, relevant validation |
| Executable local asset | Script, generator, template, evaluation, CI check | Security/safety review and deterministic execution evidence |
| Target-project change | App code, Gradle, architecture, migrations | Target inspection, project tests/builds, independent review |
| Sensitive or external change | Credentials, data, devices, paid service, telemetry, cloud/Play Console | Explicit owner authorization before access or action |
| Production change | Publish, deploy, submit, promote, rollout, rollback, delete/alter live data | Release/incident playbook and explicit owner approval for exact action |

If a change fits more than one class, use the stricter gate.

## Required sequence

```text
1. Scope and evidence
2. Risk classification and acceptance criteria
3. Draft implementation
4. Independent review
5. Repair and re-review as needed
6. Verification evidence
7. Root acceptance
8. Owner approval, if the milestone or action requires it
9. Authorized external or production action, if any
10. Record outcome and follow-up
```

Do not reorder the sequence to make an urgent or convenient change appear lower risk. An owner may authorize a documented exception, but the exception must name the target, scope, risk accepted, expiration, and rollback/containment owner.

## Evidence required for review

The implementer provides:

- stated outcome, scope, and affected paths/systems;
- source and target-project evidence;
- risks and mitigations;
- exact validation performed and result;
- known gaps, deferred work, and rollback path where relevant;
- proposed acceptance state.

The reviewer records findings by severity:

- **Blocking:** unsafe, incorrect, ungrounded, incompatible, security/privacy/accessibility harmful, or outside authorized scope. Must be repaired before acceptance.
- **Important:** substantial maintainability, usability, evidence, or future-risk concern. Must be repaired or accepted with a recorded rationale and follow-up.
- **Advisory:** non-blocking improvement. Record when useful; do not hide a blocking concern as advisory.

## Brownfield assessment

For an existing app, the work package must state what was inspected and how the proposed change preserves or intentionally migrates its conventions. Required investigation is proportional to scope, but changes affecting Gradle, manifests, DI, navigation, data, CI, release, or permissions must inspect the directly relevant existing implementation before authoring the change.

## Production approval policy

No production action is permitted without explicit owner approval. The approval must identify:

- application and environment;
- artifact, version, commit, or operation;
- destination or distribution channel;
- rollout scope and timing;
- validation evidence reviewed;
- rollback or containment owner;
- any accepted risk.

General ownership, a prior milestone approval, a passing CI run, a scheduled workflow, or an agent instruction does not satisfy this policy. If the approval is ambiguous, stop and request clarification.

## Change record

Until an automated change ledger is implemented, include the work-package evidence in the review or task record. Do not claim that a future ledger, CI check, or approval bot has run. Future automation must preserve the same evidence fields and cannot bypass human owner approval.
