exec(open(r'C:\Users\rauna\Desktop\Bots\Engineer\scripts\kalo-habits-update.py', encoding='utf-8').read().split("write(BASE+'feature/meal/MealPortions.kt'")[0])
p=BASE+'feature/meal/MealViewModel.kt'
edit(p, '    fun resetScan() {\n        analysisGeneration++', '    fun resetScan() {\n        if (_uiState.value.isSaving) return\n        analysisGeneration++')
edit(p, '    fun retryAnalysis() {\n        if (lastImageBytes', '    fun retryAnalysis() {\n        if (_uiState.value.isSaving || _uiState.value.resumePending || _uiState.value.draftLoading) return\n        if (lastImageBytes')
edit(p, 'currentState.isAnalyzing || currentState.isSaved)', 'currentState.isAnalyzing || currentState.isSaved || currentState.resumePending || currentState.draftLoading)')
edit(p, '            lastImageBytes = bytes\n            if (_uiState.value.items.isEmpty()', '            lastImageBytes = bytes\n            if (bytes == null) _uiState.update { it.copy(draftMessage = "The draft photo is unavailable. Your estimated items can still be saved, or choose another photo.") }\n            if (_uiState.value.items.isEmpty()')
p=BASE+'feature/meal/CameraScreen.kt'
edit(p, '    val state by viewModel.uiState.collectAsState()', '    val state by viewModel.uiState.collectAsState()\n    androidx.activity.compose.BackHandler(enabled = state.isSaving) {}')
edit(p, '                onClick = onClose,', '                onClick = onClose,\n                enabled = !state.isSaving,')
p=BASE+'feature/meal/MealReviewBottomSheet.kt'
edit(p, '                    onClick = actions.onDiscard,', '                    onClick = actions.onDiscard,\n                    enabled = !uiState.isSaving,')
p=BASE+'feature/workout/WorkoutScreen.kt'
edit(p, '    val state by viewModel.uiState.collectAsState()', '    val state by viewModel.uiState.collectAsState()\n    androidx.activity.compose.BackHandler(enabled = state.isSaving) {}')

p='app/src/test/java/com/kalotracker/app/feature/meal/HabitMealTest.kt'
edit(p, '    @Test fun alreadyCommittedDraftIsCleared', '''    @Test fun discardCannotResetDraftDuringASuspendedSave() = runTest {
        val dispatcher = StandardTestDispatcher(testScheduler)
        Dispatchers.setMain(dispatcher)
        val gate = CompletableDeferred<Unit>()
        val disk = object : MealDraftStore {
            override suspend fun load() = MealScanUiState(draftMealId = "stable", items = listOf(item()))
            override suspend fun save(state: MealScanUiState) { if (state.isSaving) gate.await() }
            override suspend fun clear() {}
        }
        val writes = mutableListOf<MealEntity>()
        val vm = MealViewModel(MealRepository(fakeDao(writes), dispatcher), DeferredAnalysis(), draftStore = disk)
        val store = ViewModelStore().apply { put("meal", vm) }
        try {
            runCurrent(); vm.resumeDraft(); runCurrent()
            vm.saveMeal {}; runCurrent()
            assertTrue(vm.uiState.value.isSaving)
            vm.resetScan()
            assertEquals("stable", vm.uiState.value.draftMealId)
            assertFalse(vm.uiState.value.items.isEmpty())
            gate.complete(Unit); runCurrent()
            assertEquals(1, writes.size)
            assertTrue(vm.uiState.value.isSaved)
        } finally { store.clear(); Dispatchers.resetMain() }
    }

    @Test fun alreadyCommittedDraftIsCleared''')
p='app/src/test/java/com/kalotracker/app/feature/workout/WorkoutViewModelTest.kt'
edit(p, '    private class FakeWorkoutDao', '''    @Test fun quickFitnessPersistsAdjustedRepsAndTotalTimeOnceWithDuplicateTapGuard() = runTest {
        val dispatcher = StandardTestDispatcher(testScheduler)
        Dispatchers.setMain(dispatcher)
        val dao = FakeWorkoutDao()
        val vm = WorkoutViewModel(WorkoutRepository(dao, dispatcher))
        val holder = androidx.lifecycle.ViewModelStore().apply { put("workout", vm) }
        try {
            runCurrent()
            var saved = 0
            repeat(3) { vm.saveDailyFitness("7", "70", FitnessEffort.EASY, listOf("20", "0", "15")) { saved++ } }
            runCurrent()
            assertEquals(1, saved)
            assertEquals(1, dao.writes)
            assertEquals(7, dao.savedWorkout!!.durationMinutes)
            assertEquals("Daily fitness", dao.savedWorkout!!.title)
            assertEquals(listOf(20, 15), dao.savedSets.map { it.reps })
            assertTrue(dao.savedSets.all { it.weightKg == 0f })
        } finally { holder.clear(); Dispatchers.resetMain() }
    }

    private class FakeWorkoutDao''')
p='app/src/androidTest/java/com/kalotracker/app/IntegrationRunner.kt'
edit(p, '            val settings = AppSettings(ctx)', '''            val draftPath = File(photos, "meal-draft.json")
            val draftStore = com.kalotracker.app.feature.meal.FileMealDraftStore(draftPath)
            val draft = com.kalotracker.app.feature.meal.MealScanUiState(draftMealId = "fixture-draft", timestamp = 1234,
                mealTitle = "Fixture", items = listOf(com.kalotracker.app.feature.meal.EditableFoodItem(
                    name = "Rice", portionGrams = 100f, baseCaloriesPerGram = 1.3f,
                    baseProteinPerGram = .03f, baseCarbsPerGram = .28f, baseFatPerGram = .01f, confidence = .7f)))
            draftStore.save(draft)
            check(draftStore.load() == draft)
            draftStore.clear()
            check(draftStore.load() == null)
            val settings = AppSettings(ctx)''')
edit(p, 'goal restart persistence.\\n', 'goal restart persistence; atomic photo draft round-trip/clear.\\n')
p=BASE+'feature/dashboard/DashboardScreen.kt'
edit(p, 'Text("Log workout")', 'Text("Log daily fitness")')
print('Save/discard race repaired and regression tests extended')
