---
name: android-networking
description: Implement or review Android HTTP/network clients, serialization, authentication transport, retries, connectivity failures, TLS configuration, and redacted network observability. Use for transport concerns; do not use for repository or local-cache policy alone.
---

# Overview

Treat the network as an unreliable boundary. Keep wire models and transport exceptions out of UI code, make retry behavior safe and bounded, and protect credentials and user data throughout the request lifecycle.

## When to use

- Adding or changing Retrofit, Ktor, URL connection, GraphQL, or another existing network client.
- Defining DTOs, serialization, authentication headers, refresh behavior, timeout, retry, or error mapping.
- Diagnosing transport failures, flaky connectivity, TLS/network-security configuration, or request observability.

## When not to use / routing

- Route cache, database, repository, paging, and synchronization policy to `android-data-and-sync`.
- Route coroutine scope, cancellation, and Flow sharing to `android-concurrency`.
- Route app-wide error/state boundaries to `android-architecture`.
- Route secrets, permissions, release signing, and threat review to `android-security-release`.
- Do not introduce a second HTTP client or change production endpoints as an incidental feature edit.

## Evidence-oriented workflow

1. Inspect the current client, base URL configuration, serializers, interceptors/plugins, auth provider, network security config, test fakes, logging, and repository callers. Preserve the established client unless the request is a migration.
2. Define the wire contract and compatibility behavior: required/optional fields, unknown fields, status codes, pagination, idempotency, auth expiry, and server error envelope. Avoid guessing from a client model; confirm the actual API contract or mark it unverified.
3. Keep DTOs and serializers at the transport boundary. Map them to stable repository/domain outcomes, including offline, timeout, cancellation, auth-required, validation, rate-limit, and unexpected-server cases. Do not expose raw response bodies or exceptions to UI.
4. Configure timeouts deliberately. Retry only operations that are safe to repeat or carry an idempotency mechanism; bound attempts and backoff, respect `Retry-After` where applicable, and never retry cancellation or permanent validation/auth failures blindly.
5. Handle tokens through the project’s approved credential mechanism. Redact headers, tokens, cookies, request bodies, and personal data in logs and crash reports. Do not hard-code secrets, print full URLs containing sensitive query parameters, or weaken TLS/cleartext policy to make a test pass.
6. Keep requests cancellable and tied to the caller’s lifecycle. Separate connectivity detection from correctness: a connected device can still have an unavailable service. Add deterministic fakes and contract fixtures rather than depending on live servers in unit tests.
7. Verify with the project’s existing test and build tasks after confirming their names. Use a local stub or approved test environment for integration evidence. Endpoint, auth-scope, certificate, or production configuration changes require review and explicit authorization at the mutation boundary.

## Acceptance criteria

- The API contract and changed compatibility assumptions are evidenced or labeled uncertain.
- Transport failures are mapped at a stable boundary and cancellation is not turned into a user-facing generic error accidentally.
- Retries are bounded and safe; auth refresh cannot recurse indefinitely or duplicate unsafe writes.
- Logs, traces, and test fixtures contain no secrets or unnecessary personal data.
- The existing client/configuration strategy is preserved unless migration is requested, and relevant tests/build checks are recorded.

## Provenance and maintenance

This skill uses official [network security configuration](https://developer.android.com/privacy-and-security/security-config), [Android connectivity guidance](https://developer.android.com/develop/connectivity), [Retrofit documentation](https://square.github.io/retrofit/), and [Ktor client documentation](https://ktor.io/docs/client.html), reviewed 2026-09-10. It absorbs the repository-boundary and error-translation patterns audited in `rcosteira79/android-skills` commit `0cdfc74ad89d5be0141807f6974d5ee37412d6f7` and `Drjacky/claude-android-ninja` commit `baa6e883e9355945838a51ae628e3747dbe6c764` without copying them. Re-verify with `Get-ChildItem -Force -Recurse -File | Where-Object { $_.Name -match '(Retrofit|Ktor|OkHttp|Client|Serializer|NetworkSecurity|Auth|Token)' }` and read the target API/configuration before applying transport advice.

