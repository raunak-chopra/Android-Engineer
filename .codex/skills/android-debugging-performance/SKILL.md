---
name: android-debugging-performance
description: Diagnose Android build failures, crashes, ANRs, jank, startup, memory, battery, or network performance with traces and Macrobenchmark evidence.
---

## When to use

- Use for reproducible build/runtime failures, leaks, jank, startup, memory, battery, latency, traces, profiles, or optimization claims.

## When not to use

- Route durable regression tests to `android-testing`, races to `android-concurrency`, data faults to `android-data-and-sync`, and UI/navigation/security/accessibility issues to their specialists.
- Do not replace reproduction with a profiler or infer root cause from one log line.

## Workflow

1. Record symptom, expected behavior, build/device/OS/version, first known good state, and reproducibility; redact preserved errors and traces.
2. Classify configuration, compile/runtime, lifecycle/state, data/transport, device, or performance; inspect the smallest relevant files and changes.
3. Reproduce under control and vary one discriminating factor at a time; record positive and negative observations.
4. Test one falsifiable hypothesis with stack traces, logs, assertions, heap/profile data, system traces, or timing. Never capture credentials or PII.
5. Apply the smallest demonstrated fix. For performance, compare the same baseline before and after with controlled device, input, warm-up, time, and build mode.
6. Add a regression test or repeatable measurement. After three failed fixes, revisit the boundary/hypothesis; keep unverified optimization labeled candidate.
7. Run confirmed checks, preserve useful artifacts, report uncertainty/status, and require explicit approval before device-data or production changes.

## Acceptance criteria

- Reproduction limits and root-cause evidence are explicit.
- Functional fixes have regression evidence; performance fixes have comparable measurements.
- Logs/traces/fixtures are privacy-safe and retained only as needed.
- Environment limits and unresolved uncertainty remain visible.

## Provenance and maintenance

Sources: [Android performance](https://developer.android.com/topic/performance), [Macrobenchmark](https://developer.android.com/topic/performance/benchmarking/macrobenchmark-overview), and audited registry IDs (2026-09-10). Re-verify: inspect target failures, benchmark/profile setup, devices, build modes, and tests.
