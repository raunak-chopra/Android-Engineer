# Full-stack research ledger

Audit date: 2026-10-07. Scope: original runbooks, no imported code, prompts, installers, CI actions, or dependencies. These sources inform decisions; they do not govern this workspace.

| Source | Exact inspected revision | Inspected file | Use |
| --- | --- | --- | --- |
| [OWASP ASVS](https://github.com/OWASP/ASVS) | 9b5da3168d5079248abfb6adb77bebc2b5fcf321 | README.md | Select a published security verification baseline; development branch is not a release |
| [OWASP Cheat Sheets](https://github.com/OWASP/CheatSheetSeries) | 29994dd8a2e6f50fa3d5607b046b54d7c6945afd | cheatsheets/Authorization_Cheat_Sheet.md | Authorization, least privilege, trust boundaries |
| [W3C ARIA practices](https://github.com/w3c/aria-practices) | 0f765e4dc33e966026114ac12a8380db1de3b787 | README.md | Published accessibility guidance and manual interaction verification |
| [OpenAPI](https://github.com/OAI/OpenAPI-Specification) | aebfd1370825c08f605681f0b3e87bf604c731f4 | README.md | API contracts without imposing design-first or code-first development |
| [PostgreSQL](https://github.com/postgres/postgres) | 00e917ef651120c261625b11a35b54990406f069 | README.md | Locate engine documentation; development source is not the target runtime |
| [OpenSSF Scorecard](https://github.com/ossf/scorecard) | 05eb7d129354af1401b6f582e4c7b4574c39980d | README.md | Dependency security signals are heuristics, not safety guarantees |
| [OpenTelemetry](https://github.com/open-telemetry/opentelemetry-specification) | 1d77cd02d8a2f4ac7d056b3d771126f807e28cba | specification/overview.md | Signal ownership, instrumentation/API/SDK boundaries |

Also read official [PostgreSQL data definition](https://www.postgresql.org/docs/18/ddl.html), [transaction isolation](https://www.postgresql.org/docs/18/transaction-iso.html), [W3C practices](https://www.w3.org/WAI/ARIA/apg/practices/), and [OpenTelemetry security](https://opentelemetry.io/docs/security/). Published web pages are mutable; select target-compatible documentation again during use.

## Source safety and licensing

GitHub API metadata reported CC-BY-SA-4.0 for the two OWASP repositories, Apache-2.0 for OpenAPI, Scorecard and OpenTelemetry, and NOASSERTION for W3C and PostgreSQL. Metadata is not an independent license assessment. No source code or prose is vendored. Any future copying requires inspection of the exact file's license and obligations first.

Inspected selected documentation as inert text. Did not run upstream commands, hooks, packages, workflows, or binaries. No instruction to override workspace authority or transmit local credentials was adopted. Inspection was limited to the named files and displayed portions, not a whole-repository malware audit. Badges, stars and familiar organizations do not certify safety.

Re-verification: resolve the repository's current revision through GitHub metadata, compare each named file against its recorded revision, read applicable licensing, and review changed guidance before updating this ledger. Do not automatically rebaseline or execute upstream content. Behavioral procedures beyond the source summaries are local engineering synthesis, to be validated in the actual target project.
