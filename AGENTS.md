# Engineer Repository Instructions

## Mission and current state

Engineer is a governed workspace for curated Android engineering guidance, reusable project assets, and their verification evidence. It is not an application, a release pipeline, or a source of authority over a target application's own repository.

This repository began as a foundation and now includes implemented local assets.
A directory, script, template, skill, integration, application, or release
process is **not implemented** merely because it appears in a plan. Treat the
working tree and recorded verification evidence as the source of truth for
implementation status.

## Instruction and evidence order

Apply instructions in this order:

1. System and platform safety requirements.
2. Explicit owner instructions for the current task.
3. This file, then any more-specific `AGENTS.md` in the affected subtree.
4. Approved repository standards and playbooks.
5. Curated external sources, pinned to a reviewed revision.
6. General knowledge and design heuristics.

For technical claims, prefer current official Android/Kotlin documentation, then evidence from the target repository, then locally verified community techniques. Treat unsourced, volatile, or conflicting claims as hypotheses until verified. Date-stamp facts that can change, including dependency versions, SDK levels, CI status, release status, benchmarks, and upstream commit references.

## Non-negotiable safety boundaries

- Inspect an existing project before proposing structural, dependency, navigation, persistence, or DI changes. Existing project conventions win unless a migration is explicitly requested.
- Do not fabricate commands, paths, versions, test results, ownership, incidents, credentials, production identifiers, or release readiness.
- Keep secrets out of source control, logs, examples, generated artifacts, and review output. Refer only to secret names or documented secret-management mechanisms.
- Do not perform destructive device, data, repository, cloud, distribution, or deployment actions without explicit owner authorization for the exact target and scope.
- Do not upload, publish, sign, submit, promote, roll out, or alter production systems without explicit owner approval recorded for that release or incident action.
- Never treat an automated check, an agent's self-assessment, or a broad request to “finish” as production approval.
- Preserve user changes and unrelated work. Do not reset, overwrite, or delete broadly scoped paths to make a task easier.
- Mark assumptions and unverified commands clearly; do not present them as working instructions.

## Workspace contract

The planned workspace layout separates policy, implementation, and evidence:

```text
AGENTS.md                 # Repository-wide operating instructions
docs/                     # Architecture, roadmap, decisions, evidence notes
standards/                # Normative engineering and Android expectations
playbooks/                # Change, release, and incident operating procedures
catalog/                  # Explicitly registered target applications only
.codex/skills/            # Curated Codex skills
templates/                # Generated-project templates
evals/                    # Behavior and regression evaluations
scripts/                  # Deterministic validation helpers
.github/                  # Non-deploying CI configuration
```

Only add an application to `catalog/apps.json` after its owner, repository/location, intended use, status, and verification boundary are known. A catalog entry does not grant access to its repository, credentials, devices, dashboards, or production systems.

## Required work protocol

1. Read applicable instructions and inspect the current workspace state.
2. Define a bounded work package, its owner-visible outcome, affected paths, risks, and acceptance evidence.
3. Gather repository and primary-source evidence before authoring technical guidance.
4. Implement the smallest coherent change; keep planned and implemented material visibly distinct.
5. Run the relevant deterministic checks. Record what was run, what passed, and what was not run.
6. Obtain an independent review for every meaningful change. The author may repair findings but may not approve their own work.
7. Obtain root acceptance only after blocking findings are resolved and evidence is available.
8. Obtain owner approval before crossing a milestone, changing an external system, or taking any production action.

Use the exact approval states below; do not silently skip a state:

| State | Meaning |
| --- | --- |
| Draft | Authored or changed; not independently reviewed. |
| Reviewed | An independent reviewer recorded findings and severity. |
| Verified | Required checks and repairs have completed with evidence. |
| Accepted | A root maintainer confirmed scope, evidence, and safety. |
| Owner-approved | The owner authorized the named milestone or external action. |
| Released | A separately authorized release completed and its evidence was recorded. |

## Roles

- **Implementer:** owns a bounded change and its initial verification evidence.
- **Independent reviewer:** evaluates factual grounding, safety, correctness, usability, and alignment with this repository. This role must not be performed by the change author.
- **Root maintainer:** accepts or returns verified work based on evidence and unresolved risk.
- **Owner:** decides priorities, accepts milestones, and provides explicit authorization for external or production actions.

For the current implementation program, lower-cost implementation and review models may alternate author and reviewer roles. The review obligation is role-based, not model-based: no model, person, or agent approves its own authored change.

## Definition of done

A change is done only when its intended outcome is present, its affected guidance is internally consistent, relevant validation has been run, high-severity review findings are resolved, known limitations are documented, and the appropriate acceptance state has been recorded. A successful syntax check alone is never sufficient evidence for factual, behavioral, accessibility, security, or release claims.

Read `docs/IMPLEMENTATION_PLAN.md`, `docs/ARCHITECTURE.md`, `standards/`, and the relevant `playbooks/` before work that touches those topics.
