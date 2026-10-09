---
name: backend-api
description: Implement server endpoints, API contracts, background jobs and integrations.
---

## When to use

Use for the stated scope.

## When not to use

Schema: database-engineering. Topology: system-architecture.

## Workflow

1. Inspect routes, auth, consumers, jobs and runtime; preserve contracts.
2. Define validation, errors, pagination and old-client compatibility.
3. Enforce operation/resource/tenant access on the server; authentication is insufficient.
4. Bound size/time/concurrency; cancel and sanitize failures. For writes/jobs read [effects](references/effects.md).
5. Test invalid input, denied access, duplicates, timeouts and partial failures.

## Acceptance criteria

- Integration evidence covers isolation and compatibility; no implicit deployment.
- Preserve target conventions and permission boundaries.
- Record checks/omissions; get fresh-context review for Tier 2 changes (AGENTS.md).

## Provenance and maintenance

Local synthesis, 2026-10-07. Re-verify: inspect the target and current primary guidance; [sources](../../sources/fullstack-2026-10-07.md). Open source records only for provenance/revalidation, not every task.
