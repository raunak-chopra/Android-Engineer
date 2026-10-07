# Scratcher two-edition plan independent review

Date: 4 October 2026 (India). Reviewer: `review_scratcher_plan`, independent of the plan author. Artifact: [Scratcher release plan](../../SCRATCHER_RELEASE_PLAN.md), two-edition revision. Scope: planning guidance only; the [original review](SCRATCHER_PLAN_REVIEW.md) remains preserved.

Result: **Reviewed**. No blocking or important findings. Root acceptance and owner milestone approval remain pending. Neither edition is implemented or release ready by this review.

## Review evidence

Read the revised plan against the previously inspected Game1 baseline and Engineer engineering/Android standards, architecture, implementation plan, change control and release playbook. Reopened [official Android build-variant guidance](https://developer.android.com/build/build-variants) on 4 October 2026: it supports a single project with product flavors, shared sources/resources and distinct application IDs. The proposal is compatible with the existing single app module; actual configuration and build commands remain unimplemented and unverified.

Independently opened the official [Pixel Adventure UI](https://kenney.nl/assets/ui-pack-pixel-adventure), [Tiny Town](https://kenney.nl/assets/tiny-town), and [Food Expansion](https://kenney.nl/assets/pixel-platformer-food-expansion) pages. Their displayed CC0 classifications support discovery use; Tiny Town's page specifies 16 × 16 tiles. No archives were downloaded or audited. The plan correctly treats these packs as candidate inputs and does not claim a complete shop/character pack or approved import.

## Assessment

- Both Classic and Pixel retain the entire work/earn/buy/scratch/life loop and shared transaction, persistence, job and event rules. Shared seeded parity tests plus edition-specific UI/build evidence avoid duplicating the economy engine or inheriting rendered evidence between editions.
- Separate install identities and app-private wallets are explicit. P0 defines flavor identities, comparison preserves the existing prototype, and no cross-app save transfer is promised. Legacy schema migration and a future prototype-ID migration are distinguished.
- Pixel art has an original coherent palette/grid/animation contract. Nearest-neighbor decorative rendering and adaptive native text/actions remain separate concerns. Precise input, coverage geometry, reveal thresholds and payouts remain shared, preserving scratch behavior rather than quantizing the input to sprite texels.
- The paired graphical slice includes room, shop, portrait, customers, products, ticket and coin in each style. Paired creative production remains assigned to Brand-Manager-Creative, with source sheets, timing and export requirements plus provenance/rights checks.
- Both editions require actual screenshots, identities/hashes, complete gameplay and restore flows, accessibility checks and physical-device performance evidence. Store names, final IDs, rights approval and distribution remain future decisions; the revision grants no signing/upload authority.

## Limits and disposition

No source edits, flavor builds, new assets, device tests or pixel rendering experiments occurred in this review. Concrete sprite scales, masks and performance remain prototype hypotheses. The author reports a fresh targeted check passing all five plan-local links and an Engineer validator rerun reporting the same five existing archived-link issues, with no plan issues. Those repository-wide omissions remain outside this revision; no repository-wide pass is claimed.

Advisory for implementation: include a side-by-side install test that verifies buying/resetting in one edition leaves the other edition and prototype unchanged. The existing independent-wallet requirement already establishes the expected behavior; this test makes isolation observable.

Independent review is complete for the two-edition planning revision. Implementation packages require their own review and verification.
