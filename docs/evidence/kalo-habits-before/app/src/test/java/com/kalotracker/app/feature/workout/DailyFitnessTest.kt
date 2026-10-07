package com.kalotracker.app.feature.workout

import org.junit.Assert.*
import org.junit.Test

class DailyFitnessTest {
    @Test fun sessionTimeIsAllocatedOnceAndBodyweightSetsAreValid() {
        for (minutes in listOf(5, 10)) {
            val rows = dailyFitnessExercises(minutes, 70.0)
            assertEquals(minutes, rows.sumOf { it.durationMinutes })
            assertEquals(3, rows.size)
            rows.forEach {
                assertEquals("0", it.sets.single().weightKg)
                assertEquals("20", it.sets.single().reps)
            }
            assertNull(validateWorkout(WorkoutUiState(exerciseName = "", otherExercises = rows)))
        }
        assertEquals(21, dailyFitnessExercises(5, 70.0).sumOf { it.calories })
        assertEquals(43, dailyFitnessExercises(10, 70.0).sumOf { it.calories })
    }

    @Test fun estimateScalesWithBodyWeight() {
        assertTrue(dailyFitnessExercises(5, 100.0).sumOf { it.calories } >
            dailyFitnessExercises(5, 50.0).sumOf { it.calories })
    }

    @Test(expected = IllegalArgumentException::class)
    fun invalidWeightIsRejected() { dailyFitnessExercises(5, Double.NaN) }
}
