exec(open(r'C:\Users\rauna\Desktop\Bots\Engineer\scripts\kalo-habits-update.py', encoding='utf-8').read().split("write(BASE+'feature/meal/MealPortions.kt'")[0])
TEST = 'app/src/test/java/com/kalotracker/app/'
write(TEST+'feature/meal/HabitMealTest.kt', '''package com.kalotracker.app.feature.meal

import androidx.lifecycle.ViewModelStore
import com.kalotracker.app.core.data.repository.MealRepository
import com.kalotracker.app.core.database.dao.MealDao
import com.kalotracker.app.core.database.dao.MealWithItems
import com.kalotracker.app.core.database.entity.MealEntity
import com.kalotracker.app.core.network.*
import com.kalotracker.app.core.settings.AiSettings
import kotlinx.coroutines.*
import kotlinx.coroutines.test.*
import org.junit.Assert.*
import org.junit.Test
import java.lang.reflect.Proxy

@OptIn(ExperimentalCoroutinesApi::class)
class HabitMealTest {
    private fun item() = EditableFoodItem(name = "Rice", portionGrams = 100f,
        baseCaloriesPerGram = 1.3f, baseProteinPerGram = .03f, baseCarbsPerGram = .28f, baseFatPerGram = .01f, confidence = .7f)
    private fun response(name: String) = Result.success(MealAnalysisResponse(mealTitle = name,
        items = listOf(DetectedFoodItem(name, 100f, 130, 3f, 28f, 1f))))

    @Test fun relativePortionsScaleNutritionWithoutChangingFoodIdentity() {
        val original = item()
        val smaller = original.scaledPortion(.75f)
        assertEquals(original.id, smaller.id)
        assertEquals(75f, smaller.portionGrams, .001f)
        assertEquals(97, smaller.currentCalories)
        assertEquals(2.25f, smaller.currentProtein, .001f)
        assertEquals(5000f, original.copy(portionGrams = 4999f).scaledPortion(1.25f).portionGrams, .001f)
    }

    @Test fun oilAndButterHaveDifferentNutritionAndStayInMealTotals() {
        val oil = MealScanUiState(hasAddedOil = true, cookingFatGrams = 14f)
        val butter = oil.copy(cookingFat = CookingFat.BUTTER)
        assertEquals(120, oil.totalCalories)
        assertEquals(100, butter.totalCalories)
        assertEquals(11.34f, butter.totalFat, .001f)
    }

    @Test fun draftRoundTripKeepsCorrectionsDateAndStableIdButNotBusyFlags() {
        val original = MealScanUiState(draftMealId = "stable", mealTitle = "Lunch", timestamp = 123456,
            items = listOf(item().scaledPortion(.75f)), userNote = "half a bowl",
            cookingFat = CookingFat.BUTTER, cookingFatGrams = 5f, hasAddedOil = true,
            isAnalyzing = true, isSaving = true, errorMessage = "temporary")
        val recovered = MealDraftCodec.decode(MealDraftCodec.encode(original))
        assertEquals("stable", recovered.draftMealId)
        assertEquals(123456L, recovered.timestamp)
        assertEquals(original.items, recovered.items)
        assertEquals(original.totalCalories, recovered.totalCalories)
        assertFalse(recovered.isSaving)
        assertFalse(recovered.isAnalyzing)
        assertNull(recovered.errorMessage)
    }

    @Test fun obsoleteAnalysisCannotReplaceANewerPhotoOrDiscardedMeal() = runTest {
        val dispatcher = StandardTestDispatcher(testScheduler)
        Dispatchers.setMain(dispatcher)
        val service = DeferredAnalysis()
        val vm = MealViewModel(MealRepository(fakeDao(), dispatcher), service)
        val store = ViewModelStore().apply { put("meal", vm) }
        try {
            vm.analyzeCapturedImage(byteArrayOf(1)); runCurrent()
            vm.analyzeCapturedImage(byteArrayOf(2)); runCurrent()
            service.requests[1].complete(response("New")); runCurrent()
            service.requests[0].complete(response("Old")); runCurrent()
            assertEquals("New", vm.uiState.value.mealTitle)
            vm.retryAnalysis(); runCurrent()
            vm.resetScan()
            service.requests[2].complete(response("Discarded")); runCurrent()
            assertTrue(vm.uiState.value.items.isEmpty())
            assertFalse(vm.uiState.value.isAnalyzing)
        } finally { store.clear(); Dispatchers.resetMain() }
    }

    @Test fun recoveryRequiresResumeAndSuccessfulSaveKeepsStableMealId() = runTest {
        val dispatcher = StandardTestDispatcher(testScheduler)
        Dispatchers.setMain(dispatcher)
        val disk = MemoryDraft(MealScanUiState(draftMealId = "stable", timestamp = 42, items = listOf(item())))
        val writes = mutableListOf<MealEntity>()
        val vm = MealViewModel(MealRepository(fakeDao(writes), dispatcher), DeferredAnalysis(), draftStore = disk)
        val store = ViewModelStore().apply { put("meal", vm) }
        try {
            runCurrent()
            assertTrue(vm.uiState.value.resumePending)
            assertEquals(42L, vm.uiState.value.timestamp)
            vm.resumeDraft(); runCurrent()
            assertFalse(vm.uiState.value.resumePending)
            var saves = 0
            repeat(3) { vm.saveMeal { saves++ } }; runCurrent()
            assertEquals(1, saves)
            assertEquals(1, writes.size)
            assertEquals("stable", writes.single().id)
            assertNull(disk.value)
        } finally { store.clear(); Dispatchers.resetMain() }
    }

    @Test fun alreadyCommittedDraftIsClearedInsteadOfOfferedAgain() = runTest {
        val dispatcher = StandardTestDispatcher(testScheduler)
        Dispatchers.setMain(dispatcher)
        val disk = MemoryDraft(MealScanUiState(draftMealId = "committed", items = listOf(item())))
        val existing = MealWithItems(MealEntity(id = "committed", title = "Saved", totalCalories = 130,
            totalProteinGrams = 3f, totalCarbsGrams = 28f, totalFatGrams = 1f), emptyList())
        val vm = MealViewModel(MealRepository(fakeDao(existing = existing), dispatcher), DeferredAnalysis(), draftStore = disk)
        val store = ViewModelStore().apply { put("meal", vm) }
        try {
            runCurrent()
            assertFalse(vm.uiState.value.resumePending)
            assertTrue(vm.uiState.value.items.isEmpty())
            assertNull(disk.value)
        } finally { store.clear(); Dispatchers.resetMain() }
    }

    @Test fun saveIsBlockedWhileAnalysisIsInFlight() = runTest {
        val dispatcher = StandardTestDispatcher(testScheduler)
        Dispatchers.setMain(dispatcher)
        val writes = mutableListOf<MealEntity>()
        val service = DeferredAnalysis()
        val vm = MealViewModel(MealRepository(fakeDao(writes), dispatcher), service)
        val store = ViewModelStore().apply { put("meal", vm) }
        try {
            vm.analyzeCapturedImage(byteArrayOf(1)); runCurrent()
            vm.saveMeal {}; runCurrent()
            assertTrue(writes.isEmpty())
            service.requests.single().complete(response("Rice")); runCurrent()
            vm.retryAnalysis(); runCurrent()
            vm.saveMeal {}; runCurrent()
            assertTrue(writes.isEmpty())
            service.requests[1].complete(response("Rice")); runCurrent()
        } finally { store.clear(); Dispatchers.resetMain() }
    }

    private class DeferredAnalysis : MealAnalysisService({ AiSettings() }) {
        val requests = mutableListOf<CompletableDeferred<Result<MealAnalysisResponse>>>()
        override suspend fun analyzeMealImage(imageBytes: ByteArray, userNote: String?): Result<MealAnalysisResponse> {
            val pending = CompletableDeferred<Result<MealAnalysisResponse>>()
            requests += pending
            // Mimic a transport that finishes even after cancellation.
            return withContext(NonCancellable) { pending.await() }
        }
    }
    private class MemoryDraft(var value: MealScanUiState?) : MealDraftStore {
        override suspend fun load() = value
        override suspend fun save(state: MealScanUiState) { value = MealDraftCodec.decode(MealDraftCodec.encode(state)) }
        override suspend fun clear() { value = null }
    }
    private fun fakeDao(writes: MutableList<MealEntity> = mutableListOf(), existing: MealWithItems? = null): MealDao =
        Proxy.newProxyInstance(MealDao::class.java.classLoader, arrayOf(MealDao::class.java)) { _, method, args ->
            when (method.name) {
                "getMealById" -> existing
                "insertMealWithItems" -> { writes += args[0] as MealEntity; Unit }
                else -> error("Unexpected DAO call: ${method.name}")
            }
        } as MealDao
}
''')
write(TEST+'feature/trends/HabitSummaryTest.kt', '''package com.kalotracker.app.feature.trends

import com.kalotracker.app.core.database.dao.*
import com.kalotracker.app.core.database.entity.*
import org.junit.Assert.*
import org.junit.Test
import java.time.*

class HabitSummaryTest {
    @Test fun countsLoggingDaysAndOnlyCompletedRepsInsideTheSelectedRange() {
        val zone = ZoneId.of("Asia/Kolkata")
        val date = LocalDate.of(2026, 10, 2)
        fun timestamp(day: LocalDate) = day.atStartOfDay(zone).toInstant().toEpochMilli()
        fun meal(day: LocalDate) = MealWithItems(MealEntity(title = "Lunch", totalCalories = 100,
            totalProteinGrams = 1f, totalCarbsGrams = 1f, totalFatGrams = 1f, timestamp = timestamp(day)), emptyList())
        fun workout(day: LocalDate) = WorkoutWithSets(WorkoutEntity(id = "session", title = "Daily fitness", type = "STRENGTH",
            durationMinutes = 7, timestamp = timestamp(day)), listOf(
                ExerciseSetEntity(workoutId = "session", exerciseName = "Push-ups", setNumber = 1, weightKg = 0f, reps = 20),
                ExerciseSetEntity(workoutId = "session", exerciseName = "Push-ups", setNumber = 2, weightKg = 0f, reps = 10, isCompleted = false)))
        val stats = habitSummary(listOf(meal(date), meal(date), meal(date.minusDays(10))),
            listOf(workout(date), workout(date.minusDays(10))), date.minusDays(6), date, zone)
        assertEquals(1, stats.mealDays)
        assertEquals(1, stats.sessions)
        assertEquals(7, stats.minutes)
        assertEquals(20, stats.reps["Push-ups"])
    }
}
''')
p=TEST+'feature/workout/DailyFitnessTest.kt'
edit(p, '    @Test(expected = IllegalArgumentException::class)', '''    @Test fun skippingExercisesReallocatesTimeAndEffortChangesTheEstimate() {
        val easy = dailyFitnessExercises(7, 70.0, FitnessEffort.EASY, listOf(20, 0, 30))
        val hard = dailyFitnessExercises(7, 70.0, FitnessEffort.HARD, listOf(20, 0, 30))
        assertEquals(2, easy.size)
        assertEquals(7, easy.sumOf { it.durationMinutes })
        assertEquals(listOf("20", "30"), easy.map { it.sets.single().reps })
        assertTrue(hard.sumOf { it.calories } > easy.sumOf { it.calories })
        assertNull(validateWorkout(WorkoutUiState(exerciseName = "", otherExercises = easy)))
    }

    @Test(expected = IllegalArgumentException::class)
    fun emptyRoutineIsRejected() { dailyFitnessExercises(7, 70.0, reps = listOf(0, 0, 0)) }

    @Test(expected = IllegalArgumentException::class)''')
print('Focused behavioral tests added')
