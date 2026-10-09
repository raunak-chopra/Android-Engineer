---
name: android-data-and-sync
description: Build Android Room, DataStore, repository, paging, cache, migration, or WorkManager sync behavior. Use for durable data; exclude ephemeral UI state.
---

## When to use

- Use for databases, preferences, caches, repositories, paging, migrations, offline rules, or sync workers.

## When not to use

- Route HTTP/TLS to `android-networking`, coroutine semantics to `android-concurrency`, layer ownership to `android-architecture`, and build mechanics to `android-project-bootstrap`.
- Do not use for ephemeral UI state or justify offline-first behavior without a product requirement.

## Workflow

1. Define entities, identity, ownership, freshness, staleness, deletion, privacy, offline behavior, and which source is authoritative.
2. Inspect data sources, schemas, migrations, repositories, serializers, workers, DI, and tests before adding duplicates.
3. Choose the smallest established persistence mechanism: relational storage for queryable durable data, preferences for small settings, memory for ephemeral data.
4. Separate DTO, entity, and UI/domain models when invariants differ; translate storage/transport failures at the repository boundary.
5. When offline behavior is required, define reads/writes, invalidation, conflicts, idempotent work, bounded retry, cancellation, and visible sync state.
6. Require explicit approval for destructive cleanup, account deletion, or user-data migration; keep credentials and PII out of logs.
7. Test mapping, repositories, representative migrations, and offline/duplicate/conflict/retry/cancellation transitions; run actual generation, sync, and release tasks.

## Acceptance criteria

- Authority, freshness, deletion, and failure policies are explicit.
- Schema history is preserved and forward migration tested before destructive paths.
- Repository outcomes hide storage/transport details.
- Sync is idempotent, cancellable, bounded, observable, and tested; data deletion/upload is authorized.

## Provenance and maintenance

Sources: [Android data layer](https://developer.android.com/topic/architecture/data-layer), [Room](https://developer.android.com/training/data-storage/room), and audited registry IDs (2026-09-10). Re-verify: inspect target schemas, migrations, repositories, workers, dependencies, and tests.
