# Engineer roadmap

Replaces the archived Android-library milestone plan ([archive](archive/IMPLEMENTATION_PLAN_M0-M7.md)). Items are planned until evidence exists in the working tree. Status of what has been verified lives in [VERIFICATION.md](VERIFICATION.md).

## Direction

Engineer is a shared toolkit for web, Android, game, graphics and backend work. Projects live in their own repositories and are found through `catalog/`. See [AGENTS.md](../AGENTS.md) for rules and approval tiers.

## Steps

| # | Step | State |
| --- | --- | --- |
| 1 | Reconcile mission, README, catalog docs and operating rules | Done on branch `engineer/restructure-2026-10-07` |
| 2 | Align process documents to the three approval tiers (CONTRIBUTING, CHANGE_CONTROL, ENGINEERING_STANDARDS, skills) | Done on the same branch |
| 3 | Update ARCHITECTURE and RELEASES for multi-platform use; retire the M0-M7 plan | Done on the same branch |
| 4 | Move project-owned folders and scripts out; migrate catalog to schema 2 | Done 2026-10-07: test projects and Synapse assets deleted, Kalo files moved to Meal-Tracking-App, game docs archived in `docs/archive/games/` |
| 5 | Fix or baseline the known documentation-link failures; add a catalog validation script | Planned |
| 6 | Prove the workflow on one website, one Android project and one graphics task | Planned |
| 7 | Add skills or templates (web, backend, design) only where those tasks expose a gap | Planned |

## Known limits

- `scripts/validate-engineer.ps1` needs PowerShell 7; it fails on Windows PowerShell 5.1 (`Path.GetRelativePath` missing). Individual checks (`measure-context-budget`, `test-skill-contracts`, `test-skill-triggers`, `test-behavioral-evals`) run on 5.1 and pass as of the restructure commit.
- Templates exist only for Android.
- Many skills' wording still reflects the earlier review-heavy process in places; adjust when touched.
