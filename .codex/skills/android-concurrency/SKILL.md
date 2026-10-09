---
name: android-concurrency
description: Design or debug Android Kotlin coroutine and Flow scopes, cancellation, dispatchers, sharing, backpressure, and async tests. Exclude general architecture.
---

## When to use

- Use for scopes, suspend functions, dispatchers, Flow operators/sharing, event delivery, races, cancellation, or async tests.

## When not to use

- Route cross-layer state to `android-architecture`, durable sync to `android-data-and-sync`, transport to `android-networking`, and Compose effects/rendering to `android-compose-ui`.
- Do not replace the coroutine/test stack or add global scopes without a migration reason.

## Workflow

1. Identify each coroutine owner and lifetime; inspect scopes, supervisors, dispatchers, and cancellation.
2. State the delivery contract. Choose suspend, cold Flow, state sharing, or events from loss, replay, ordering, multiplicity, and latest-value semantics.
3. Preserve structured concurrency, propagate cancellation, avoid `GlobalScope`, and never swallow `CancellationException`; supervise only with defined recovery.
4. Inject dispatchers where blocking or time-sensitive work needs control; keep CPU, I/O, and main work intentional.
5. Review sharing, replay, buffers, conflation, and operator order; prevent duplicate work, leaks, and unbounded backpressure. Bound retry.
6. Test ordering, cancellation, duplicates, errors, empty values, timeout, and retry with controlled dispatchers or virtual time, not sleeps/live services.
7. Run confirmed tests/builds and require reproducible trace or failure evidence for race/leak claims.

## Acceptance criteria

- Every coroutine has an owner and cancellation path.
- Replay, loss, ordering, backpressure, and errors match the contract.
- Cancellation remains distinct; retries are bounded; tests cover lifecycle edges.
- No global scope, main-thread blocking, or dispatcher assumption lacks evidence.

## Provenance and maintenance

Sources: [Kotlin coroutines](https://kotlinlang.org/docs/coroutines-guide.html), [Android coroutines](https://developer.android.com/kotlin/coroutines), and audited registry IDs (2026-09-10). Re-verify: inspect target scopes, Flow primitives, dispatchers, versions, and async tests.
