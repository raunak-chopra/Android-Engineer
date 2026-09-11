# Android routing evaluations

This directory contains a deterministic, lightweight trigger corpus for the Android skill library. It is intentionally independent of network access, Android Studio, Gradle, and a device: the check compares each prompt with the `name` and `description` frontmatter of discovered skills.

Run the strict check after changing skill metadata or routing cases:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\scripts\test-skill-triggers.ps1
```

During staged authoring, permit missing skill folders while still validating the corpus shape and coverage:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\scripts\test-skill-triggers.ps1 -AllowMissingSkills
```

The corpus has one positive route case for every skill, plus unrelated prompts
that must not route to an Android skill. A positive case declares a primary
skill, signals, a minimum score, and a minimum lead over every non-adjacent
skill; explicitly allowed adjacent skills may be named for genuinely
cross-cutting prompts. A negative case sets `forbidAllPlanned` so every
discovered planned skill is checked.

This is a routing smoke test, not a semantic proof. Its ranking assertion catches
lexical ambiguity in the corpus, but it cannot establish that advice is
factually correct or that a command compiles. Those claims require independent
review plus the template and reference-app checks in the implementation plan.

When a skill is renamed or split, update `plannedSkills` and its positive case in the same reviewed change. Keep negative cases genuinely outside Android so accidental broad trigger descriptions remain visible.
