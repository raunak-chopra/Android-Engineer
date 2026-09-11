# Incident playbook

## Scope and operating boundary

This playbook provides a safe response model for issues affecting a target application, Engineer-generated asset, release candidate, CI pipeline, or future production integration. It does not create monitoring, pager ownership, access to live systems, or authority to modify a production environment.

When an incident is reported, preserve the distinction between **investigation** and **action**. Read-only evidence gathering within authorized scope may proceed. Any action that changes production data, traffic, availability, distribution, credentials, configuration, or customer experience requires explicit owner authorization unless a pre-approved, exact containment procedure says otherwise.

## Triage

Capture, without exposing sensitive data:

- incident time, reporter, affected application/environment, and customer impact;
- observed behavior, expected behavior, and reproducibility;
- affected versions, source revision, device/OS details, and region where relevant;
- evidence location, redaction status, and confidence level;
- current owner and communication channel;
- actions already taken and their authorization.

Do not speculate about root cause in an incident summary. Label hypotheses as hypotheses.

## Severity guide

| Severity | Example impact | Response focus |
| --- | --- | --- |
| Critical | Widespread outage, active data/security compromise, inability to contain high-impact harm | Establish owner, preserve evidence, request/execute only pre-authorized containment |
| High | Major feature unavailable, significant crash/regression rate, serious but bounded privacy/security concern | Reproduce, scope impact, prepare safe mitigation and owner decision |
| Moderate | Important workflow degraded with a workaround | Investigate, prioritize repair, monitor for escalation |
| Low | Isolated defect, documentation issue, minor regression | Record, reproduce, schedule ordinary change control |

Severity describes observed impact, not urgency alone. Escalate when evidence shows broader impact.

## Response sequence

1. Acknowledge and assign an incident owner.
2. Stabilize the record: time, scope, versions, evidence, and authorization boundary.
3. Gather read-only diagnostics and reproduce safely where possible.
4. Assess user impact, data/security exposure, and whether a release/rollback decision is needed.
5. Present containment or mitigation options with risks, expected effect, and required authorization.
6. Obtain explicit owner approval before any production-changing action, unless an exact pre-approved procedure applies.
7. Verify the result, monitor agreed signals, and communicate status using only supported facts.
8. Conduct a blameless follow-up: timeline, contributing conditions, evidence gaps, corrective actions, owners, and due dates.

## Evidence and privacy rules

- Avoid collecting credentials, payment data, personal data, full private payloads, or unredacted production logs unless the owner authorizes an appropriate secure process.
- Preserve original artifacts and record hashes/locations when practical; do not alter evidence in place.
- Keep incident communications factual, dated, and clear about uncertainty.
- Do not use an incident as a reason to bypass code review, testing, release approval, or security controls without an owner-authorized exception.

## Follow-up quality bar

A closed incident should identify what is known, what remains uncertain, immediate remediation, prevention work, and verification evidence. A fix should follow [CHANGE_CONTROL.md](CHANGE_CONTROL.md); a release or rollback should follow [RELEASES.md](RELEASES.md). Do not declare a root cause proven merely because a mitigation appeared to help.
