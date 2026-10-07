package com.kalotracker.app.feature.workout

import kotlin.math.roundToInt

/** Rough gross energy estimate, using the 2024 Adult Compendium conditioning METs.
 * Duration is the whole session, divided across exercises; never charged three times.
 * https://pacompendium.com/conditioning-exercise/
 */
internal fun dailyFitnessExercises(minutes: Int, weightKg: Double): List<WorkoutExercise> {
    require(minutes in 3..60)
    require(weightKg.isFinite() && weightKg in 20.0..300.0)
    val names = listOf("Push-ups", "Sit-ups", "Crunches")
    return names.mapIndexed { index, name ->
        val duration = minutes / 3 + if (index < minutes % 3) 1 else 0
        val met = if (name == "Crunches") 2.8 else 3.8
        WorkoutExercise(name, sets = listOf(EditableSet(1, "0", "20")),
            durationMinutes = duration,
            calories = (met * 3.5 * weightKg / 200 * duration).roundToInt())
    }
}
