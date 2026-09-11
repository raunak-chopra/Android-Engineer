---
name: android-data-and-sync
description: Design, implement, or debug Android data boundaries including Room or other local storage, DataStore, repositories, paging, caching, and WorkManager synchronization. Use when data durability or consistency is part of the task; do not add offline infrastructure speculatively.
---

# Overview

Make the source of truth and consistency policy explicit before choosing a library. Keep storage and transport details behind a boundary, make synchronization repeatable, and treat schema or user-data changes as high-risk work.

## When to use

- Adding or changing a database, preferences store, cache, repository, paging source, or sync worker.
- Defining offline behavior, conflict resolution, refresh, retry, or cache invalidation.
- Reviewing data mapping, migration safety, durable state, or repository error behavior.

## When not to use / routing

- Route HTTP contract, authentication transport, serialization, and TLS issues to `android-networking`.
- Route coroutine ownership, Flow hotness, cancellation, and test dispatchers to `android-concurrency`.
- Route layer ownership and domain abstractions to `android-architecture`.
- Route build/plugin/version mechanics to `android-project-bootstrap`.
- Do not use for a purely in-memory UI state change or to justify offline-first storage without a product requirement.

## Evidence-oriented workflow

1. Write the data contract first: entities, identity, ownership, freshness, allowed staleness, deletion semantics, privacy class, and behavior with no network. State whether the server, local store, or user action is authoritative for each field.
2. Inspect current data sources, schema/version declarations, migrations, repositories, serializers, worker scheduling, DI, and tests. Search for existing tables, keys, cache policies, and error types before introducing duplicates.
3. Choose the smallest persistence mechanism that matches the contract. Use a relational store for relational/queryable durable data, a key-value/preferences store for small settings, and in-memory state for ephemeral data. Confirm the project’s existing library before adding or migrating one.
4. Keep DTOs, database entities, and UI/domain models separate where their lifecycles or invariants differ. Translate transport/database exceptions at the repository boundary; never make the UI parse SQL or HTTP errors.
5. If offline-first is required, define read and write paths, freshness, invalidation, queued work, conflict resolution, idempotency key, retry/backoff, connectivity constraints, and user-visible sync status. If it is not required, avoid a cache whose invalidation policy is less reliable than a direct request.
6. Make workers safe to run twice and safe to stop. Bound retries, respect cancellation, avoid leaking credentials or PII to logs, and make partial progress observable. Treat destructive cleanup, account deletion, and data migration as explicit approval points.
7. Test mapping and business rules without Android, repository behavior with deterministic fakes or controlled integration stores, migrations against representative old schemas, and sync transitions including offline, duplicate, conflict, retry, and cancellation cases.
8. Verify the project’s actual database/code-generation/sync tasks and release build after schema or worker changes. Record device/emulator limitations and unavailable checks rather than inventing success.

## Acceptance criteria

- Authority, freshness, consistency, deletion, and failure policies are documented for changed data.
- Existing schema and migration history are preserved; a forward migration is tested before any destructive path.
- Repository callers receive stable outcomes and cannot depend on storage/transport implementation details.
- Sync is idempotent, cancellable, bounded, and observable, or the decision not to sync is explicit.
- Tests cover the changed contract, and no user data is deleted or uploaded without authorization.

## Provenance and maintenance

This skill synthesizes official [data-layer architecture](https://developer.android.com/topic/architecture/data-layer), [offline-first guidance](https://developer.android.com/topic/architecture/data-layer/offline-first), [Room](https://developer.android.com/training/data-storage/room), [DataStore](https://developer.android.com/topic/libraries/architecture/datastore), [Paging](https://developer.android.com/topic/libraries/architecture/paging/v3-overview), and [WorkManager](https://developer.android.com/topic/libraries/architecture/workmanager) documentation reviewed 2026-09-10. It also incorporates conditional repository and sync patterns audited in `rcosteira79/android-skills` commit `0cdfc74ad89d5be0141807f6974d5ee37412d6f7` and `Drjacky/claude-android-ninja` commit `baa6e883e9355945838a51ae628e3747dbe6c764`; these are not copied. Re-verify with `Get-ChildItem -Force -Recurse -File | Where-Object { $_.Name -match '(Room|Database|Dao|DataStore|Worker|Repository|Migration)' }` and inspect the actual schema, migration, and dependency declarations before making version-specific claims.

