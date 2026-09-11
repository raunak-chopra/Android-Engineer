# Android project templates

Use `New-EngineerAndroidProject.ps1` to materialize a small, buildable Android
project from one of three profiles.

| Profile | Intended use | Initial shape |
|---|---|---|
| `minimal` | Prototype or single-purpose app | One `:app` module |
| `standard` | Default product app | `:app`, `:core:model`, `:feature:home` |
| `modular` | Larger product with enforced build conventions | Standard modules plus an included `build-logic` build |

The templates deliberately do not add networking, persistence, analytics,
authentication, or dependency injection until the product requires them.
Dependency versions are inputs, not timeless recommendations. The defaults were
verified against the local toolchain on 2026-09-10; re-resolve them before use.
The files under `profiles/` are human-readable profile contracts used by review
and documentation checks; the generator remains the executable source of the
emitted topology.

Example:

```powershell
powershell -ExecutionPolicy Bypass -File .\templates\android\New-EngineerAndroidProject.ps1 `
  -Name SampleApp -PackageName com.example.sample -Profile standard `
  -Destination .\artifacts\sample-app
```

The destination must not already contain files. The generator never deletes or
overwrites an existing project. Each generated project includes the verified
Gradle 8.13 wrapper, so use `.\gradlew.bat` on Windows or `./gradlew` on Unix;
the first run may download declared dependencies.
