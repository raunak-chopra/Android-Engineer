---
name: database-engineering
description: Design schemas, queries, transactions, migrations, indexes and backup recovery.
---

## When to use

Use for the stated scope.

## When not to use

Room/DataStore: android-data-and-sync. API contracts: backend-api.

## Workflow

1. Inspect engine/version, schema and roles; use isolated authorized fixtures.
2. Constrain invariants; parameterize queries and isolate tenants.
3. Before migrations/recovery read [evolution](references/evolution.md).
4. Measure representative plans safely; execution can cause effects.
5. Test isolation and concurrency; retry transactions only with safe side effects.

## Acceptance criteria

- Prove invariants/compatibility; live data changes require exact authorization.
- Preserve target conventions and permission boundaries.
- Record checks/omissions and obtain independent review.

## Provenance and maintenance

Local synthesis, 2026-10-07. Re-verify: inspect the target and current primary guidance; [sources](../../sources/fullstack-2026-10-07.md). Open source records only for provenance/revalidation, not every task.
