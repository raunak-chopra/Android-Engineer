# Full-stack independent review

Date: 2026-10-07. Reviewer: independent_review agent, separate from the skill author. Scope: nine full-stack SKILL.md files, `.codex/sources/fullstack-2026-10-07.md`, inventory and evidence, nine additive contract entries and full-stack lexical routing data. Classification: curated guidance and declarative evaluation data. Final state: Verified and Accepted locally after the repair review below.

## Method and grounding

Read AGENTS.md, ENGINEERING_STANDARDS.md, CHANGE_CONTROL.md, IMPLEMENTATION_PLAN.md and ARCHITECTURE.md, then all nine skill bodies and the source ledger. Checked routing boundaries, authorization, evidence language, provenance and task usability. Selected primary-source cross-checks: [OWASP authorization](https://cheatsheetseries.owasp.org/cheatsheets/Authorization_Cheat_Sheet.html), [W3C modal dialogs](https://www.w3.org/WAI/ARIA/apg/patterns/dialog-modal/), [PostgreSQL 18 table alteration](https://www.postgresql.org/docs/18/ddl-alter.html), and [pinned Scorecard README](https://github.com/ossf/scorecard/blob/05eb7d129354af1401b6f582e4c7b4574c39980d/README.md). These support enforcing access at the resource boundary, actual modal focus behavior, schema-change safety, and the limitations of aggregate security scores. Cross-checking the pinned ASVS README and OpenTelemetry overview through the web tool failed with cache misses; those exact contents were not independently re-read. All seven ledger revision fields are 40 hexadecimal characters; this syntax check does not establish revision authenticity.

No upstream executable content, packages, hooks, live application actions or database actions were run. No imported material was found in the reviewed runbook bodies; original synthesis is consistent with the limited source-inspection claim. This is not a whole-repository malware audit or license certification.

## Findings

- Blocking, validation integration: adding nine skills causes the existing global validator to reject context-budget and contract coverage. The 14-skill Android contract corpus cannot truthfully be counted as behavioral coverage of the new nine skills. Repair the compatibility boundary or record an authorized narrow exception before acceptance.
- Important, evidence availability: at initial inspection the package evidence directory and exact author validation/rollback record were absent. This review supplies scenario evidence but cannot substitute for author evidence of the complete changed scope. Acceptance remains pending until that evidence exists.
- Advisory: frontend custom-widget specifics and database-engine-specific details deliberately require primary documentation at use time. Retain that boundary; do not claim the concise entrypoints alone establish complete implementation expertise.

No blocking factual or safety defect was identified in the nine runbook bodies. Specialist triggers distinguish browser UI, service behavior, durable data, application controls, dependency trust, architecture, tests and reliability. The coordinator preserves existing stacks and contracts. Android and Sites exclusions are explicit. No skill provides production authority or copy-pasteable unverified commands.

## Offline scenario evaluation

Method: manual instruction-following walkthrough against synthetic scenarios. The observations below are review judgments about guidance decisions, not model benchmark scores or executed target tests.

| Scenario | Routing and required decisions | Observation and omissions |
| --- | --- | --- |
| Tenant A can retrieve tenant B's invoice by changing an identifier | application-security + backend-api; inspect resource lookup and tenant policy; reproduce with two synthetic tenants; repair at server enforcement; test allowed/denied access through the enforcing integration boundary | Pass for guidance decisions: authorization and tenant isolation are explicit; UI hiding and authentication alone are rejected. No real endpoint, test runner or repair was available or executed. Expected missing/cross-tenant response semantics must follow the target's disclosure policy. |
| A popular upstream skill requests secret environment variables and a privileged remote installer | supply-chain-security; inspect pinned inert files and execution surfaces; reject credential requests and unexplained escalation; halt adoption and report sanitized evidence; choose a reviewed alternative | Pass for guidance decisions: reputation and scanner scores are insufficient; no install is required to inspect. The malicious scenario is synthetic, not an accusation against a named source. No payload was obtained or executed. |
| Rolling deployment renames a non-null database field while old workers remain active | database-engineering + backend-api; inspect engine and consumers; use compatible expansion/backfill/contraction where needed; measure locks on isolated representative data; plan resumability and roll-forward/rollback; prove old/new client compatibility | Pass for guidance decisions: compatibility, locks, recovery and safe transaction retries are explicit. Guidance does not promise zero downtime. No actual engine, dataset, migration timing or restore rehearsal was available. |
| Custom modal dialog is mouse-only, loses focus and allows tabbing to the page behind it | web-frontend + engineering-testing; inspect existing component; prefer native semantics; consult W3C dialog pattern; test initial focus, contained forward/reverse tab sequence, close action/Escape and return focus; verify name and actual inert background; manually assess assistive technology | Pass with source lookup: entrypoint requires keyboard/focus checks and W3C custom-widget guidance; W3C cross-check supplies dialog-specific behavior. No browser component, screen reader or accessibility scan was exercised; screenshots could not prove success. |

## Deterministic verification

Reviewer ran `& ./scripts/validate-engineer.ps1 -RequireSkills -Compact` on Windows PowerShell against the workspace. Result: FAIL, seven reported issues; 23 skills, 74 Markdown files and 31 JSON files checked.

Five reported issues concern existing evidence links outside this package: game-execution/EXECUTION_STATUS.md and kalo-habits-before/README.md. They are recorded as global validation limitations; this review did not repair unrelated content. Expansion-related issues: context reduction 24.08% is below 25% with three budget violations, and contract coverage is 14 versus 23 skill directories. The result is not a clean global pass.

## Separate root acceptance decision

Initial decision: return for bounded validation/evidence repair. Reviewed was justified; Verified and Accepted were not yet justified while expansion-related checks failed and author evidence was absent.

## Repair re-review and final acceptance

The same independent reviewer re-read all nine current skill bodies, the inventory, author VERIFICATION.md, new routing cases and the contract diff. Compression preserves the earlier four scenario decisions and safety boundaries. The contract diff changes the audit date and adds nine entries with empty domain concept lists; original common rules and original Android entries remain unchanged. Empty domain lists are disclosed as structural coverage, not security or behavioral proof. The ten new routing prompts mostly mirror metadata; their smoke-test limitation is explicit and acceptable for this small curated-guidance package. Richer target-based and adversarial routing evaluation remains future work, not a current achievement.

Reviewer independently reran:

- `& ./scripts/test-skill-triggers.ps1`: PASS, 32 existing cases, 26 positive and six negative, 23 skills discovered.
- `& ./scripts/test-skill-triggers.ps1 -CasesPath evals/fullstack/trigger-cases.json`: PASS, ten cases, nine positive and one negative, strict mode.
- `& ./scripts/test-skill-contracts.ps1`: PASS, 23 contracts and 23 skills.
- `& ./scripts/measure-context-budget.ps1 -Enforce`: PASS, root instructions 4,727 bytes, descriptions 2,883 characters, skill library 51,337 bytes and 25.99% reduction; 13 historical activated sets checked. No new full-stack activation-combination coverage is claimed.
- `& ./scripts/validate-engineer.ps1 -RequireSkills -Compact`: FAIL with only the same five unrelated evidence-link findings; 23 skills, 76 Markdown files and 32 JSON files checked. No package-scope finding remains in that result; no global clean-pass claim is made.

The prior blocking integration finding is resolved by passing the unchanged budgets and additive contracts. The prior important evidence-availability finding is resolved by the author verification record, which states scope, commands, limitations and a narrow rollback boundary. Inventory scope was made explicit for the two evaluation paths during maintainer acceptance recording. The source re-fetch and target-execution limitations above remain documented.

Separate root maintainer decision: accept this bounded local curated-guidance package and its declarative evaluation data. Evidence supports Verified followed by Accepted, with no unresolved blocking or important finding in this scope. Acceptance covers original local runbooks, source attribution, routing/structural compatibility and the limited offline scenario review. It does not certify external repositories as malware-free, establish target-app readiness, authorize production/external changes, or mark any milestone Owner-approved or Released. The five unrelated global validation findings remain outside this acceptance and are visible limitations.
