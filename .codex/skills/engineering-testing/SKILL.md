---
name: engineering-testing
description: Design web/backend regression, integration, contract and end-to-end behavioral tests.
---

## When to use

Use for the stated scope.

## When not to use

Android: android-testing. Live diagnosis: reliability-observability.

## Workflow

1. Inspect runners/fixtures; define observable acceptance and verified commands.
2. Reproduce safely; prefer tests that fail before a bug fix.
3. Choose the smallest boundary; use real integrations where mocks hide semantics.
4. Control time/network and isolate data; exercise relevant denial/error/concurrency.
5. Run affected tests/build; investigate flakes without masking failures.

## Acceptance criteria

- Record outcomes/omissions; coverage and syntax are not behavior.
- Preserve target conventions and permission boundaries.
- Record checks/omissions and obtain independent review.

## Provenance and maintenance

Local synthesis, 2026-10-07. Re-verify: inspect the target and current primary guidance; [sources](../../sources/fullstack-2026-10-07.md). Open source records only for provenance/revalidation, not every task.
