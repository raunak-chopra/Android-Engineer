---
name: android-debugging-performance
description: Diagnose Android build failures, crashes, incorrect runtime behavior, jank, startup, memory, battery, or network performance with reproducible evidence and targeted measurements. Use for investigation and optimization; do not guess from symptoms alone.
---

# Overview

Turn a symptom into a reproducible case, gather the smallest discriminating evidence, test one hypothesis at a time, and leave a regression check or measurement behind. Separate build/toolchain failures from app-runtime failures and performance perceptions from trace-backed findings.

## When to use

- Investigating compiler/sync failures, crashes, ANRs, incorrect state, leaks, jank, slow startup, excessive memory, battery, or network latency.
- Choosing logs, stack traces, profilers, benchmarks, tracing, baseline profiles, or regression tests.
- Reviewing an optimization claim or a fix whose effect needs measurement.

## When not to use / routing

- Route test authoring to `android-testing`, even when the investigation produces a regression test.
- Route coroutine/Flow races to `android-concurrency`, data/sync faults to `android-data-and-sync`, and navigation/UI behavior to their specialists.
- Route accessibility, localization, security, and release failures to their respective skills.
- Do not use a benchmark or profiler as a substitute for a functional reproduction, and do not claim a root cause from a single log line.

## Evidence-oriented workflow

1. Write the exact symptom, affected build/device/OS/version, expected behavior, first known good state, and reproducibility. Preserve the original error, stack trace, or trace artifact with sensitive values redacted.
2. Classify the failure: configuration/Gradle, compile/runtime, lifecycle/state, data/transport, device/platform, or performance. Inspect the smallest relevant files and recent changes before broad refactoring.
3. Reproduce in a controlled environment. Vary one discriminating factor at a time: clean versus incremental build, fixture/data size, network state, window configuration, process recreation, or device API. Record observations and negative results.
4. Form one falsifiable hypothesis. Use stack traces, structured logs, assertions, memory/profile data, system traces, or network timing to test it. Keep logging temporary or redacted; never add credential or PII capture for diagnosis.
5. Make the smallest fix that addresses demonstrated cause. For performance, measure a baseline and the same scenario after the change with controlled warm-up, device, input, time, and build mode. Use Macrobenchmark, tracing, heap tools, or baseline profiles only when the symptom and project setup justify them.
6. Add a regression test or repeatable measurement. If three reasonable fixes fail, revisit the boundary or hypothesis instead of stacking patches. Treat an unverified optimization as a candidate until the comparison is complete.
7. Run the project’s confirmed checks and preserve artifacts. Report environment, commands actually available, observations, remaining uncertainty, and whether the issue is fixed, mitigated, or still open. Do not delete device data or alter production systems as a debugging shortcut without explicit authorization.

## Acceptance criteria

- The symptom is reproducible or the limits of reproduction are documented.
- The root-cause claim is tied to discriminating evidence, with rejected hypotheses recorded when useful.
- Functional fixes have regression evidence; performance fixes have comparable measurements and no meaningful regression in adjacent metrics.
- Logs, traces, dumps, and fixtures are privacy-safe and retained only as needed.
- Environment limitations, unavailable tools, and unresolved uncertainty are stated rather than hidden behind a passing command.

## Provenance and maintenance

This skill synthesizes official [Android performance guidance](https://developer.android.com/topic/performance), [Macrobenchmark](https://developer.android.com/topic/performance/benchmarking/macrobenchmark-overview), [baseline profiles](https://developer.android.com/topic/performance/baselineprofiles/overview), and [Android Studio debugging tools](https://developer.android.com/studio/debug) reviewed 2026-09-10. It incorporates root-cause-first debugging and trace-backed performance practices audited in `rcosteira79/android-skills` commit `0cdfc74ad89d5be0141807f6974d5ee37412d6f7` and `Drjacky/claude-android-ninja` commit `baa6e883e9355945838a51ae628e3747dbe6c764`, not copied prose. Re-verify with `Get-ChildItem -Force -Recurse -File | Where-Object { $_.Name -match '(stacktrace|crash|benchmark|baseline|trace|profile|perf|leak|ANR)' }` and inspect actual build/device tooling before stating that a measurement command is supported.

