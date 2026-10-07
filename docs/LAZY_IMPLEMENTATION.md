# Lazy skill implementation and audit

Date: 2026-10-07. State: Verified and Accepted locally after [independent review and separate root acceptance](evidence/lazy-implementation-2026-10-07/REVIEW.md). The owner authorized local implementation and a gaps/leaks audit with “ok lets go and double check for gaps and leaks in implementation and document the same.” Actual upstream imports remain subject to separate named approval.

## Implemented scope

- Four original local skills: [engineering-router](../.codex/skills/engineering-router/SKILL.md), [product-ux-design](../.codex/skills/product-ux-design/SKILL.md), [visual-design-system](../.codex/skills/visual-design-system/SKILL.md), [graphics-assets](../.codex/skills/graphics-assets/SKILL.md).
- Nine existing full-stack entrypoints shortened with essential controls retained; genuinely conditional stage, interaction, write/job, migration/recovery, security, topology, adoption and telemetry detail moved into references. `engineering-testing` stays self-contained.
- Exact reference-read conditions, focused-task bypass, one-coordinator selection and no default specialist fan-out. The prior full-stack eager-list wording was replaced with conditional stage selection.
- Twenty-seven common structural contracts; 32 existing Android and 17 full-stack/design metadata routing cases; 15 explicit local load recipes; two deterministic load/safety validators. The main library validator invokes the load check, and existing non-deploying CI now includes full-stack routing and safety regressions.
- [Design provenance](../.codex/sources/design-lazy-2026-10-07.md), [loading contract](LAZY_ROUTING_CONTRACT.md), [measurements](evidence/lazy-implementation-2026-10-07/LOAD_MEASUREMENTS_FINAL.json) and independent review/evidence. No upstream prompt, component, asset, dependency, binary or installer was imported or executed.

Affected paths are the four new and nine revised skill directories, source ledger, `evals/android/skill-contracts.json`, `evals/fullstack/trigger-cases.json`, `evals/lazy/`, seven new measurement sets in `evals/context-budget.json`, two new scripts, `scripts/validate-engineer.ps1`, two added non-deploying CI steps, this status document, linked plan/contract/inventory updates and the task evidence directory. Original Android skills, templates, global skills/settings and unrelated work are preserved. Rollback would reverse only this listed package with exact paths and review, never reset the checkout or broadly delete unrelated files. No rollback was executed.

## Context measurement

The pre-change snapshot was 51,337 entrypoint bytes and 2,883 description characters. Four skills were added while entrypoint bytes decreased to 48,897; descriptions are 3,187 characters. Current measurements and each selected file's bytes are in the linked report; the historical global budget remains unchanged at 52,000 entrypoint bytes, 3,200 description characters and 8,500 bytes per recorded set. New local router/specialist/reference limits are also checked. See [exact checks](evidence/lazy-implementation-2026-10-07/VERIFICATION.md).

Total stored text includes conditional references and is larger than the old entrypoint-only library; that is not hidden as a token saving. Savings concern selected managed context, not model billing, host metadata, target source reads, entire conversation history or compulsory external skill content. The deterministic checker measures authored load recipes, not actual language-model selection. Independent selections and accessed files are documented separately; neither proves universal routing accuracy.

## Audit findings and repairs

| ID | Finding | Disposition |
| --- | --- | --- |
| L1 | Full-stack coordinator wording could encourage loading eight specialists together | Replaced with one-stage selection and conditional map; focused tasks bypass the coordinator |
| L2 | Announcements reference guard was narrower than the changed-notification scenario | Essential announcement checks and exact changed-announcement read condition added; W3C notifications reference and recipe repaired |
| L3 | Assess-only suspicious-import recipe unnecessarily loaded adoption detail | Removed that reference from assess-only recipe; entrypoint rejection/permission controls suffice; actual adoption still requires the conditional reference |
| L4 | Safety-test helper could write evidence through unchecked junction ancestors | Root/ancestor/reparse and containment checks added before creation/writes; existing reports preserved; static independent review and negative path tests recorded |
| L5 | Synthetic report-preservation sentinel had invalid `.json` contents | Changed to valid JSON; two earlier author-generated sentinel files corrected only when exact old sentinel text matched; prior evidence not broadly rewritten |
| L6 | New routing/safety checks lacked CI wiring | Added full-stack/design metadata and safety steps; main validator checks load recipes; hosted CI execution remains unverified |

No credential value or user dataset was needed for this package. Validators do not execute instructions from JSON/Markdown, access network services or emit file bodies. Reports contain selected paths and byte counts. A suspected malicious upstream instruction is excluded; public popularity does not authorize adoption.

## Remaining gaps and limitations

| ID | Gap | Boundary/follow-up |
| --- | --- | --- |
| G1 | Host skill discovery/automatic selection is outside repository control | Entrypoints and tests guide selection; fresh-session catalog refresh and production runtime telemetry are not verified |
| G2 | Built-in external skills have their own context costs | Independent reviewer read imagegen entrypoint at 19,516 UTF-8 bytes. This exceeds the ordinary local managed-set budget; it is reported separately, not counted as zero total cost. Bypass local graphics/router layers for a clear raster task; do not modify/import an external replacement silently |
| G3 | No dedicated iOS/Flutter/React Native, desktop, pipeline, games or ML specialists yet | Preserve the inspected platform and use relevant primary docs for actual tasks; do not pretend deferred specialists exist or migrate to another framework |
| G4 | No full target app/UI security or accessibility verification | Independent synthetic SVG/handoff artifacts and routing walkthroughs are limited skill evidence; no actual users, screen-reader session, database migration, restore, load test or production action occurred |
| G5 | Five unrelated evidence links fail the whole-repository validator | Record separately; they do not become a clean global PASS and were not changed to conceal findings |
| G6 | Metadata budget has little remaining room | Measure before adding any more descriptions; no automatic expansion or ceiling increase |
| G7 | Actual junction rejection fixture could not be created under filesystem permissions | Static guards and non-junction rejection tests are evidence; blocked junction creation is not a passing runtime reparse test |
| G8 | File checks are not an operating-system security boundary | Path/reparse checks reduce accidental traversal; they do not protect against a privileged concurrent filesystem swap. Execute helpers only in the controlled workspace |

No unresolved blocking finding may be accepted within scope. Independent review must assess the final repairs and evidence before updating this document's state. All actual imports, external services, deployments and destructive operations retain their explicit owner gates.
