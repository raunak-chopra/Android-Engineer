---
name: android-networking
description: Build Android HTTP clients, Retrofit or Ktor serialization, auth transport, timeout, retry, TLS, and redacted observability. Exclude cache policy.
---

## When to use

- Use for clients, DTOs, serialization, auth headers/refresh, timeout, retry, TLS, transport failures, or network logs.

## When not to use

- Route storage/sync to `android-data-and-sync`, coroutine ownership to `android-concurrency`, app-wide boundaries to `android-architecture`, and security/release review to `android-security-release`.
- Do not add a second client or change production endpoints incidentally.

## Workflow

1. Inspect client, endpoints, serializers, interceptors, auth, network-security config, fakes, logs, and repository callers; preserve the established client unless migration is requested.
2. Define the wire contract: fields, unknowns, statuses, pagination, idempotency, auth expiry, and errors. Confirm it or mark uncertainty.
3. Keep DTOs at the transport boundary and map offline, timeout, cancellation, auth, validation, rate-limit, and server failures to stable outcomes.
4. Set timeouts deliberately. Retry only safe/idempotent operations with bounded attempts/backoff; respect server guidance and never blindly retry cancellation or permanent failures.
5. Use approved credential storage. Redact headers, tokens, cookies, bodies, URLs, and PII; never weaken TLS or cleartext policy to pass a test.
6. Tie requests to caller lifecycle and use deterministic fakes/contracts instead of live production services.
7. Run confirmed tests/builds and approved stub integration. Endpoint, auth, certificate, or production configuration changes require explicit approval.

## Acceptance criteria

- API and compatibility assumptions are evidenced or uncertain.
- Failures map at a stable boundary and cancellation remains distinct.
- Retries/auth refresh are bounded and cannot duplicate unsafe writes.
- Logs and fixtures contain no secrets or unnecessary PII; existing strategy and checks are recorded.

## Provenance and maintenance

Sources: [network security](https://developer.android.com/privacy-and-security/security-config), [connectivity](https://developer.android.com/develop/connectivity), and audited registry IDs (2026-09-10). Re-verify: inspect target client, API contract, auth, network config, fakes, and tests.
