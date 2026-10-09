---
name: reliability-observability
description: Diagnose service failures and latency; design telemetry and recovery evidence.
---

## When to use

Use for the stated scope.

## When not to use

Android: android-debugging-performance. Queries: database-engineering.

## Workflow

1. Inspect topology and sanitized telemetry; follow incident governance.
2. Trace the failing flow; measure latency/errors/saturation against baseline.
3. Separate correlation from demonstrated cause.
4. For telemetry/recovery read [operations](references/operations.md).
5. Test proposed repair in isolation; live actions require exact approval.

## Acceptance criteria

- Use comparable measurements and record unresolved hypotheses.
- Preserve target conventions and permission boundaries.
- Record checks/omissions; get fresh-context review for Tier 2 changes (AGENTS.md).

## Provenance and maintenance

Local synthesis, 2026-10-07. Re-verify: inspect the target and current primary guidance; [sources](../../sources/fullstack-2026-10-07.md). Open source records only for provenance/revalidation, not every task.
