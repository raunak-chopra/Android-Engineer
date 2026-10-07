---
name: system-architecture
description: Decide service boundaries, integrations, consistency and architecture migrations.
---

## When to use

Use for the stated scope.

## When not to use

Android: android-architecture. Local edits: domain specialist.

## Workflow

1. Inspect actual dependencies and owners; separate observed/proposed structure.
2. Capture constraints; label estimates and unknowns.
3. Compare retaining current structure with the smallest alternatives.
4. Define trust, consistency, effects and contract boundaries.
5. For migrations read [decisions](references/decisions.md); test the riskiest assumption.

## Acceptance criteria

- Every abstraction has a consumer/reason; capacity claims need measurements.
- Preserve target conventions and permission boundaries.
- Record checks/omissions; get fresh-context review for Tier 2 changes (AGENTS.md).

## Provenance and maintenance

Local synthesis, 2026-10-07. Re-verify: inspect the target and current primary guidance; [sources](../../sources/fullstack-2026-10-07.md). Open source records only for provenance/revalidation, not every task.
