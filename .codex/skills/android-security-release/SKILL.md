---
name: android-security-release
description: Review or implement Android security, privacy, permissions, secret handling, signing, R8, observability, release artifacts, and Play publication gates. Use for security or release work; require explicit approval immediately before external, destructive, signing, or publishing mutations.
---

# Overview

Protect users and release integrity from design through artifact delivery. Separate code changes from privileged operations, minimize sensitive data, and make every release claim traceable to an inspected configuration and verified artifact.

## When to use

- Reviewing manifest permissions, exported components, deep links, WebView, storage, authentication, TLS, logging, analytics, or privacy handling.
- Configuring signing, R8/shrinking, obfuscation, mapping retention, versioning, AAB/APK artifacts, CI secrets, crash reporting, or staged release checks.
- Preparing or reviewing a release while keeping publication and rollout under explicit authorization.

## When not to use / routing

- Route transport-specific serialization/retry behavior to `android-networking` and data migrations/sync to `android-data-and-sync`.
- Route ordinary build/module setup to `android-project-bootstrap` and performance diagnosis to `android-debugging-performance`.
- Route general test authoring to `android-testing`; return here for release/security acceptance criteria.
- Do not use this skill to infer signing credentials, Play IDs, rollout percentages, version codes, or production endpoints.

## Evidence-oriented workflow

1. Establish scope and threat model: assets, actors, trust boundaries, data classifications, supported OS/API levels, and release environment. Ask for or record the user’s authorization separately from the code change.
2. Inspect the manifest and merged manifest, exported components, intent filters/deep links, permissions, network security configuration, backup/data-extraction rules, WebView usage, storage, crypto/auth code, logging, analytics, and CI secret references. Treat generated/merged output as evidence, not as the edit location.
3. Minimize access and data: request runtime permissions only at a justified moment, explain denial/revocation, store tokens in an approved protected mechanism, validate external input, use platform cryptography correctly, redact logs/crash reports, and avoid PII in identifiers or analytics. Never commit secrets or weaken TLS/cleartext policy to unblock development.
4. Review release configuration: build types/flavors, debug flags, minification/resource shrinking, mapping/symbol files, dependency provenance, version code/name, signing configuration, AAB generation, reproducibility metadata, crash reporting, and rollback/staged rollout plan. Do not guess any value that affects publication or identity.
5. Verify the artifact in a safe environment: run confirmed lint/security/test checks, inspect the merged manifest and release build, confirm mapping archive and commit metadata, and smoke-test critical flows without real user data. Keep signing keys and tokens outside the repository and CI logs.
6. Stop before high-impact actions. Ask for explicit approval immediately before installing destructive device commands, deleting app/user data, accessing live accounts, signing with a real key, uploading to Play or another registry, changing production configuration, or starting a rollout. Report exactly what would happen and how to rollback.
7. Document findings by severity, exploit/precondition, affected artifact, remediation, residual risk, and verification evidence. Route functional regressions to `android-testing` and runtime diagnosis to `android-debugging-performance`.

## Acceptance criteria

- Threat boundaries, sensitive data flows, permissions, exported surfaces, and residual risks are documented for the changed area.
- No secrets, signing material, production identifiers, or PII are committed or printed, and insecure development shortcuts are not promoted.
- Release artifacts, version values, minification/mapping behavior, and critical smoke checks are verified from actual project configuration.
- External, destructive, signing, upload, and rollout actions are clearly separated and explicitly approved immediately before execution.
- A reviewer can reproduce the security/release evidence and understand rollback or containment steps.

## Provenance and maintenance

This skill uses official [Android security](https://developer.android.com/privacy-and-security), [app security best practices](https://developer.android.com/privacy-and-security/security-best-practices), [app signing](https://developer.android.com/studio/publish/app-signing), [R8](https://developer.android.com/topic/performance/app-optimization/enable-app-optimization), and [publishing](https://developer.android.com/studio/publish) documentation reviewed 2026-09-10. It incorporates the permission, secret, mapping, release, and approval boundaries audited in `Drjacky/claude-android-ninja` commit `baa6e883e9355945838a51ae628e3747dbe6c764`; no community prose or credentials are copied. Re-verify with `Get-ChildItem -Force -Recurse -File | Where-Object { $_.Name -match '(AndroidManifest|proguard|rules|sign|release|mapping|keystore|secret|workflow|\.ya?ml$)' }` and inspect merged/release configuration before making a release or security claim.

