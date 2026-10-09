# Change control playbook

## Purpose

Match the amount of control to the risk of an action. Routine local work moves fast; anything shared, external, costly or destructive needs a human yes. The three tiers are defined in [AGENTS.md](../AGENTS.md); this playbook gives the detail.

## Classify before acting

Classify by what the action touches, not by how many lines change. If a change fits more than one tier, use the higher. If unsure, use the higher.

| Tier | Typical examples | Gate |
| --- | --- | --- |
| 1: Local and reversible | Editing project files, adding tests, local builds and servers, local assets, emulator or browser runs, new local branches | None. Implement, verify, self-review. |
| 2: Shared or hard to undo locally | Dependency adds or upgrades, schema or migration changes, build or signing config, deleting more than a few files, large refactors, history rewrites on local branches, edits to Engineer's standards or skills | Confirm the plan once with the owner, then a fresh-context review after verification. |
| 3: External, public, costly or destructive | Push to a shared remote, PRs, deploys, publishing, store upload, signing, promoting or rolling out a release, production data or cloud changes, paid services, messages sent as the owner, destructive device/data/repo operations, live credentials | Explicit owner approval for the exact action (see below). |

## Tier 1 sequence

1. Inspect the existing code, design and instructions.
2. Define what done looks like.
3. Implement.
4. Verify by output type (see AGENTS.md "Verify by output").
5. Self-review the diff; record what ran and what did not.

## Tier 2 sequence

1. State in a short message: outcome, affected paths, risk, rollback path.
2. Wait for the owner's yes.
3. Implement and verify.
4. Get a review from a fresh context (another session or agent that did not author the change). Record findings by severity:
   - **Blocking:** unsafe, incorrect, ungrounded, security/privacy/accessibility harmful, or outside scope. Fix before finishing.
   - **Important:** substantial maintainability, usability or evidence concern. Fix, or record the rationale and a follow-up.
   - **Advisory:** non-blocking improvement. Do not hide a blocking concern here.
5. Record the outcome.

## Tier 3: production and external approval

No Tier 3 action happens without explicit owner approval in chat. The approval must identify:

- project and environment;
- artifact, version, commit or operation;
- destination or distribution channel;
- rollout scope and timing;
- validation evidence reviewed;
- rollback or containment plan;
- any accepted risk.

A prior approval, a passing CI run, a scheduled workflow, a broad request to "finish" or an agent instruction does not satisfy this. If the approval is ambiguous, stop and ask. Approval for one action does not extend to the next.

## Existing projects

Before changing build logic, manifests, dependency injection, navigation, data, CI, release or permissions, read the directly relevant existing implementation and state how the change preserves or deliberately migrates the project's conventions. A migration needs an explicit request, a compatibility and rollback plan, and project-specific verification.

## Exceptions

The owner may waive a gate for one named task. Record the target, scope, risk accepted and who handles rollback.

## Change record

Record the outcome in the project's `docs/work-status.md`, and in `docs/version-history.md` when behavior changed. Include the checks run, the checks not run, known gaps and the rollback path. Do not claim a check ran if it did not.
