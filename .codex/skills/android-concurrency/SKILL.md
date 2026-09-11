---
name: android-concurrency
description: Design, implement, or debug Kotlin coroutine and Flow behavior in Android apps, including scope ownership, cancellation, dispatchers, hot versus cold streams, backpressure, and deterministic tests. Use for asynchronous behavior rather than general architecture alone.
---

# Overview

Make asynchronous work owned, cancellable, and observable. Choose Flow or another primitive from the required delivery semantics, not from habit, and keep lifecycle and test control explicit.

## When to use

- Changing coroutine scopes, suspend functions, dispatchers, Flow operators, sharing, buffering, or event delivery.
- Diagnosing leaks, duplicate collectors, stale state, lost events, races, cancellation bugs, or flaky async tests.
- Designing refresh, retry, debounce, parallel work, or effect handling.

## When not to use / routing

- Route cross-layer state ownership and repository boundaries to `android-architecture`.
- Route persistence/sync scheduling to `android-data-and-sync` and transport semantics to `android-networking`.
- Route Compose effect APIs and UI rendering to `android-compose-ui`.
- Do not replace a project’s coroutine/test stack or add global scopes without an explicit migration reason.

## Evidence-oriented workflow

1. Identify the owner and lifetime of every coroutine: user action, screen, ViewModel, repository, application, or worker. Inspect existing scopes, supervisors, injected dispatchers, and cancellation behavior before editing.
2. State the delivery contract. Use a suspend function for one result, a cold `Flow` for repeatable computation, state-sharing for durable latest state, and an event/effect mechanism only when loss, replay, ordering, and multiplicity are explicitly acceptable. Do not treat `Channel`, `SharedFlow`, and `StateFlow` as interchangeable.
3. Keep structured concurrency: launch work in an owned scope, propagate cancellation, avoid `GlobalScope`, and do not swallow `CancellationException`. Use supervision only where sibling failure should be isolated and the recovery policy is defined.
4. Inject dispatchers or a coroutine context at a boundary when code performs blocking or time-sensitive work. Keep CPU, I/O, and main-thread work intentional; do not sprinkle dispatcher switches without evidence of the blocking operation.
5. Review Flow sharing, replay, buffer, conflation, and operator order. Prevent duplicate upstream work, unbounded buffers, accidental hot streams, and collectors that outlive their UI. Make retry/backoff finite and cancellation-aware.
6. Test with controlled dispatchers or virtual time where the project supports it. Prove ordering, cancellation, duplicate subscription, errors, empty values, timeout, and retry behavior without relying on sleeps or live network calls.
7. Verify the narrowest affected tests and a build path after confirming project task names. For race or leak claims, collect a reproducible trace or test failure; do not label timing intuition as a root cause.

## Acceptance criteria

- Every launched coroutine has an explicit owner and cancellation path.
- The chosen async primitive’s replay, loss, ordering, backpressure, and error semantics match the product contract.
- Cancellation remains distinguishable from failure, and retries/backoff are bounded.
- Tests deterministically prove the changed async behavior, including relevant lifecycle edges.
- No global scope, blocking main-thread work, or dispatcher assumption is introduced without evidence and review.

## Provenance and maintenance

This skill synthesizes official [Kotlin coroutine guidance](https://kotlinlang.org/docs/coroutines-guide.html), [Android coroutine best practices](https://developer.android.com/kotlin/coroutines), and [StateFlow/SharedFlow guidance](https://developer.android.com/kotlin/flow/stateflow-and-sharedflow), checked 2026-09-10. It incorporates the semantics-first coroutine and Flow patterns audited in `rcosteira79/android-skills` commit `0cdfc74ad89d5be0141807f6974d5ee37412d6f7` and `Drjacky/claude-android-ninja` commit `baa6e883e9355945838a51ae628e3747dbe6c764`, with no prose copied. Re-verify with `Get-ChildItem -Force -Recurse -File | Where-Object { $_.Extension -in @('.kt','.kts') } | Select-String -Pattern '\b(GlobalScope|CoroutineScope|StateFlow|SharedFlow|Channel|collectAsStateWithLifecycle)\b'` and inspect the project’s actual coroutine versions and scope conventions.

