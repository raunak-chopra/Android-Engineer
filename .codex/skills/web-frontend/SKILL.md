---
name: web-frontend
description: Build web UI, forms, responsive layouts and browser accessibility. Exclude backend-only work.
---

## When to use

Use for the stated scope.

## When not to use

API: backend-api. Android: android-compose-ui. Use Sites skills for Sites projects.

## Workflow

1. Inspect stack, rendering and components; preserve approved design.
2. Own server/draft/navigation state; handle loading/error and stale responses.
3. Prefer semantic controls; test labels, keyboard, focus, announcements, zoom and contrast.
4. Keep secrets/server privileges out of browser code; treat remote HTML as untrusted.
5. Verify browser behavior/build. For custom interactions or changed announcements read [widgets](references/widgets.md).

## Acceptance criteria

- Browser evidence proves behavior; screenshots/scanners alone do not.
- Preserve target conventions and permission boundaries.
- Record checks/omissions and obtain independent review.

## Provenance and maintenance

Local synthesis, 2026-10-07. Re-verify: inspect the target and current primary guidance; [sources](../../sources/fullstack-2026-10-07.md). Open source records only for provenance/revalidation, not every task.
