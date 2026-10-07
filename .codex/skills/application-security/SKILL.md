---
name: application-security
description: Threat-model and harden authentication, authorization, sessions, input handling and privacy.
---

## When to use

Use for the stated scope.

## When not to use

Dependency/CI trust: supply-chain-security. Android release: android-security-release.

## Workflow

1. Inspect assets, actors and trust boundaries; test only authorized fixtures.
2. Choose published controls and coverage; a checklist is not certification.
3. Verify enforcing authorization; keep secrets out of source and diagnostics.
4. For auth/input/privacy changes read [controls](references/controls.md).
5. Test the abuse case with sanitized evidence; scanner silence proves nothing.

## Acceptance criteria

- Record impact, repair and retest; no third-party attack authority.
- Preserve target conventions and permission boundaries.
- Record checks/omissions and obtain independent review.

## Provenance and maintenance

Local synthesis, 2026-10-07. Re-verify: inspect the target and current primary guidance; [sources](../../sources/fullstack-2026-10-07.md). Open source records only for provenance/revalidation, not every task.
