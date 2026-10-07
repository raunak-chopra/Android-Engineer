# Release playbook

## Scope and status

This playbook governs any release process later exercised through Engineer. It does not establish an active release pipeline, signing configuration, store account (for example Google Play) or hosting account, app, track, credential, or production authority. Registering a project in `catalog/` does not authorize a release. Every release step below is a Tier 3 action in AGENTS.md.

## Release boundary

Creating a local build, producing a candidate artifact, signing an artifact, uploading it, submitting it for review, promoting it, rolling it out, and rolling it back are distinct actions. Each has a different risk profile and requires the authority specified below.

| Action | May be automated by default? | Required authorization |
| --- | --- | --- |
| Local debug build and test | Yes, if scoped to local project work | Normal work-package approval |
| Candidate release build | Only when explicitly configured and no secrets are exposed | Fresh-context review of candidate evidence |
| Signing with real credentials | No | Explicit owner authorization for named artifact/target |
| Upload or submission to distribution service | No | Explicit owner authorization for named artifact/destination |
| Production promotion, rollout, or rollback | No | Explicit owner approval with rollout and rollback details |

## Candidate preparation

Before seeking owner approval for a candidate, assemble evidence appropriate to the target app:

- exact source revision and clean/reproducible build inputs;
- resolved version identifier (for Android, version name and `versionCode`) from the target—not invented values;
- debug and release build results;
- required unit, integration, UI, accessibility, localization, and device evidence;
- lint/static analysis and dependency/security results;
- release shrinking/obfuscation or bundling evidence where applicable;
- artifact checksum/metadata and storage location;
- symbol or mapping file preservation plan where applicable (for example R8/ProGuard mapping);
- known issues, monitoring signals, staged-rollout proposal, and rollback plan.

The release owner must be able to distinguish evidence actually produced from checks that remain unrun.

## Owner approval request

Request explicit approval only after the candidate has been verified and reviewed. The request must include the app, environment, artifact/version, source revision, distribution target, rollout percentage or scope, timing, monitored metrics, rollback condition, rollback owner, and known risks. Do not infer any missing value.

## Execution safeguards

- Keep signing material and service credentials outside the repository and logs.
- Never print, commit, or copy sensitive credential values into an issue, artifact, screenshot, or agent response.
- Verify the destination account, app identifier, artifact, version, track/environment, and rollout scope immediately before an authorized external action.
- Preserve release evidence, mapping files, metadata, and approval reference for each actual release.
- Stop if the action differs from the approval, validation evidence is stale or missing, or target identity cannot be established.

## Rollout and rollback

Prefer a staged rollout only when the target product and owner approve it. Define success signals, error thresholds, observation window, and rollback owner before rollout. A rollback is a production action; do not execute it merely because an alert exists unless the owner has explicitly pre-authorized the named containment action. Use [INCIDENTS.md](INCIDENTS.md) for investigation and communications.

## Post-release review

Record the actual artifact/version, destination, time, approval reference, rollout scope, observed result, incidents, and follow-up work. Update guidance only after reviewing evidence; do not convert a one-off release outcome into universal policy without validation.
