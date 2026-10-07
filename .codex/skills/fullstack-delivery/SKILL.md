---
name: fullstack-delivery
description: Coordinate end-to-end web features across UI, services and storage. Use for cross-stack delivery.
---

## When to use

Use for the stated scope.

## When not to use

Focused tasks: direct specialist. Android: android-router. Sites: installed Sites skills.

## Workflow

1. Inspect target instructions, stack, contracts and tests; define the user flow.
2. Map affected layers and agree API/schema compatibility.
3. Choose only the current stage's specialist from [routes](references/stages.md); never load the list together.
4. Implement the smallest slice; preserve server authorization and migration safety.
5. Test changed boundaries; record evidence, omissions and independent review.

## Acceptance criteria

- Feature and compatibility are demonstrated; no deployment authority is implied.
- Preserve target conventions and permission boundaries.
- Record checks/omissions and obtain independent review.

## Provenance and maintenance

Local synthesis, 2026-10-07. Re-verify: inspect the target and current primary guidance; [sources](../../sources/fullstack-2026-10-07.md). Open source records only for provenance/revalidation, not every task.
