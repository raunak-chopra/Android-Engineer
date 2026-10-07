# Design and lazy-loading provenance

Read date: 2026-10-07. Scope: original local instructions, no imported code, agent prompts, assets, fonts, dependencies or installers. Candidate GitHub and Reddit research remains in [proposal](../../docs/ENGINEERING_EXPANSION_PROPOSAL.md); it is discovery, not an approved import list.

Primary pages re-read during implementation:

- [W3C tutorials](https://www.w3.org/WAI/tutorials/): accessible content patterns and topic-specific lookup. Tutorials do not establish complete WCAG conformance.
- [W3C modal pattern](https://www.w3.org/WAI/ARIA/apg/patterns/dialog-modal/): focus behavior, keyboard containment and actual inert background.
- [W3C form notifications](https://www.w3.org/WAI/tutorials/forms/notifications/): control/message association and perceivable feedback, re-read during the independent-review repair.
- [USWDS tokens](https://designsystem.digital.gov/design-tokens/): semantic visual values and consistency.
- [GOV.UK styles](https://design-system.service.gov.uk/styles/): typography/layout/color as a coherent system.
- [NN/g task scenarios](https://www.nngroup.com/articles/task-scenarios-usability-testing/): realistic task-based usability assessment.

These are mutable official/first-party web pages, not pinned code imports. Re-check current relevant guidance at use time. The runbooks synthesize ideas in original language; they do not copy example implementations or certify licenses for future asset use. Platform-specific behavior still requires target documentation and real verification. Lazy-loading mechanics follow the installed skill-creator instructions: short metadata, selected entrypoint, conditionally read references. Host discovery/selection is not controlled by repository scripts.
