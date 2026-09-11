# Android reference app

This deliberately small project was materialized from the `standard` template,
then extended as reference evidence. The unmodified template profiles are
compiled separately by the validation workflow. This app's home feature models
loading, empty, success, and error states and tests their deterministic reducer.

It is evidence for the engineering workflow, not a production starter or a
claim that every optional architecture choice is appropriate. Navigation,
persistence, synchronization, screenshot tests, and release signing remain
target-specific additions and must be justified by an actual app.

On Windows with Android SDK 36 and JDK 17:

```powershell
.\gradlew.bat :app:testDebugUnitTest :feature:home:testDebugUnitTest :app:assembleDebug :app:assembleRelease
```

The release build enables R8 and resource shrinking with the default optimized
rules. It is intentionally unsigned; signing and publication require a named
target plus explicit owner approval.
