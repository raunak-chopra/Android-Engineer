---
name: android-security-release
description: Review Android security or release: permissions, secrets, signing, R8, mapping, AAB/APK, privacy, observability, and Play approval gates.
---

## When to use

- Use for manifest attack surfaces, sensitive data, auth/TLS/logging, signing, R8, mappings, artifacts, CI secrets, or publication readiness.

## When not to use

- Route transport to `android-networking`, data migration/sync to `android-data-and-sync`, ordinary builds to `android-project-bootstrap`, performance to `android-debugging-performance`, and general tests to `android-testing`.
- Never infer credentials, Play IDs, rollout percentages, version codes, or production endpoints.

## Workflow

1. Define assets, actors, trust boundaries, data classes, OS/API support, and release environment; keep authorization separate from code changes.
2. Inspect source and merged manifests, exports/deep links, permissions, network security, backup, WebView, storage, crypto/auth, logs, analytics, and CI references.
3. Minimize access/data, handle denial, protect tokens, validate input, use platform crypto, and redact logs. Never commit secrets or weaken TLS/cleartext.
4. Inspect build types, debug flags, shrinking, mapping/symbol retention, provenance, versions, signing, AAB/APK, crash reporting, and rollback. Do not guess identity values.
5. In a safe environment, run confirmed lint/security/tests, inspect release artifacts/manifests, verify mappings and commit metadata, and smoke-test without real user data.
6. Stop for explicit approval before destructive device commands, data deletion, live access, real signing, upload, production change, or rollout; state effect and rollback.
7. Record severity, precondition, artifact, remediation, residual risk, and verification evidence.

## Acceptance criteria

- Threat boundaries, data flows, permissions, exports, and residual risks are recorded.
- No secrets, signing material, production IDs, or PII are committed or printed.
- Artifacts, versions, shrinking/mappings, and critical smoke checks come from actual configuration.
- External/destructive/signing/upload/rollout actions have immediate explicit approval and reproducible rollback evidence.

## Provenance and maintenance

Sources: [Android security](https://developer.android.com/privacy-and-security), [signing](https://developer.android.com/studio/publish/app-signing), [R8](https://developer.android.com/topic/performance/app-optimization/enable-app-optimization), and audited registry IDs (2026-09-10). Re-verify: inspect target manifests, security config, release build, mappings, CI, and artifact metadata.
