# Feel and touch UI

Read for controls, feedback, motion or HUD placement. Original synthesis, revised 2026-10-12. Parameters are hypotheses until exercised in the target game.

Diagnose input recognition, gameplay response, motion/collision, camera and presentation separately. Larger particles do not fix missed taps. Tune one cause and compare the same action. Buffering, dead zones, acceleration and wind-up depend on genre; precise board games need different choices from platformers.

Specify immediate acknowledgement, outcome feedback and return to rest. Distinguish routine, reward and danger through a restrained mix of sound, motion, particles or haptics. Provide alternatives to color/sound alone and reduced shake/flashing. Do not let repeated hit-stop hold indefinitely, shake physics bodies, or block input with effects.

Use density-aware targets: Android's 48dp baseline is not 48 physical pixels. Expanded hit regions must not overlap ambiguously; verify engine units. Inspect real finger occlusion instead of assuming a universal pixel size. Keep predictions and action information visible; consider control placement/size options for intended players.

Specify applicable tap/hold/drag/release and preview/commit/cancel behavior. Teach finger-down and release; a mouse demonstration does not prove touch usability. Native Android tracks stable pointer IDs and resolves indices per event; engine identifiers have their own contracts. Test one finger lifting while another remains, cancellation and pause for stuck actions.

Assign each gesture to gameplay, camera or UI. Menu state must gate polling as well as consumed events. Dismissal must not replay into gameplay. Test simultaneous controls and pause. Do not reject all edge touches without target evidence.

Use anchors, aspect policy and safe insets. Test long translations, large text, color alternatives and reduced effects. Engine widgets need explicit accessibility support; visible labels do not prove TalkBack access.

Primary sources: [targets](https://developer.android.com/develop/ui/compose/accessibility/api-defaults), [multi-touch](https://developer.android.com/develop/ui/views/touch-and-input/gestures/multi). Community provenance and evidence limits: [research record](../../../sources/mobile-games-2026-10-12.md).
