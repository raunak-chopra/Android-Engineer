exec(open(r'C:\Users\rauna\Desktop\Bots\Engineer\scripts\kalo-habits-update.py', encoding='utf-8').read().split("write(BASE+'feature/meal/MealPortions.kt'")[0])

p=BASE+'feature/meal/MealViewModel.kt'
edit(p, '    fun resumeDraft() {\n        _uiState', '    fun resumeDraft() {\n        val generation = ++galleryGeneration\n        _uiState')
edit(p, '            lastImageBytes = kotlinx.coroutines.withContext', '            val bytes = kotlinx.coroutines.withContext')
edit(p, '            if (_uiState.value.items.isEmpty() && lastImageBytes != null) runAnalysis()', '            if (generation != galleryGeneration) return@launch\n            lastImageBytes = bytes\n            if (_uiState.value.items.isEmpty() && lastImageBytes != null) runAnalysis()')
edit(p, 'try { draftStore.save(currentState) } finally { draftMutex.unlock() }', 'try { draftStore.save(currentState) }\n                catch (cancelled: kotlinx.coroutines.CancellationException) { throw cancelled }\n                catch (_: Exception) { /* A draft-storage failure must not prevent logging a meal. */ }\n                finally { draftMutex.unlock() }')
edit(p, '        _uiState.value = MealScanUiState()', '        _uiState.value = MealScanUiState(timestamp = initialTimestamp)')
p=BASE+'core/network/MealAnalysisService.kt'
edit(p, 'class MealAnalysisService(', 'open class MealAnalysisService(')
edit(p, '    suspend fun analyzeMealImage(', '    open suspend fun analyzeMealImage(')
edit(p, 'it.portionGrams.isFinite() && it.portionGrams > 0f &&', 'it.portionGrams.isFinite() && it.portionGrams in 1f..5000f &&')
edit(p, 'it.calories >= 0 &&', 'it.calories in 0..100000 &&')
edit(p, 'it.protein >= 0f', 'it.protein in 0f..5000f')
edit(p, 'it.carbs >= 0f', 'it.carbs in 0f..5000f')
edit(p, 'it.fat >= 0f', 'it.fat in 0f..5000f')
edit(p, '}.map { it.copy(confidence = it.confidence.coerceIn(0f, 1f)) }', '}.take(100).map { it.copy(confidence = if (it.confidence.isFinite()) it.confidence.coerceIn(0f, 1f) else 0f) }')

# Avoid silently discarding the quick form on switching: retain its composition and clearly open a separate detailed logger.
p=BASE+'feature/workout/WorkoutScreen.kt'
edit(p, '    if (!detailed) {\n        DailyFitnessScreen', '    androidx.compose.runtime.saveable.SaveableStateProviderPlaceholder\n    if (!detailed) {\n        DailyFitnessScreen')
edit(p, '    androidx.compose.runtime.saveable.SaveableStateProviderPlaceholder', '    val quickStateHolder = androidx.compose.runtime.saveable.rememberSaveableStateHolder()')
edit(p, '        DailyFitnessScreen(state, fitnessDefaults, onClose, { detailed = true }, viewModel::setTimestamp) { minutes, weight, effort, reps ->', '        quickStateHolder.SaveableStateProvider("quickFitness") {\n        DailyFitnessScreen(state, fitnessDefaults, onClose, { detailed = true }, viewModel::setTimestamp) { minutes, weight, effort, reps ->')
edit(p, '        }\n        return\n', '        }\n        }\n        return\n')
p=BASE+'feature/workout/DailyFitnessScreen.kt'
edit(p, 'Text("More exercises / detailed workout")', 'Text("Switch to separate detailed workout")')
edit(p, '    val effort = FitnessEffort.valueOf(effortName)', '    val effort = runCatching { FitnessEffort.valueOf(effortName) }.getOrDefault(FitnessEffort.MODERATE)')

p=BASE+'feature/meal/ManualMealScreen.kt'
edit(p, '    val totalCalories = addedItems.sumOf', '''    fun scaleDraft(multiplier: Float) {
        if (saveStatus.busy) return
        val scaled = addedItems.map { it.copy(portionGrams = it.portionGrams * multiplier,
            calories = kotlin.math.round(it.calories * multiplier).toInt(), protein = it.protein * multiplier,
            carbs = it.carbs * multiplier, fat = it.fat * multiplier) }
        addedItems.clear()
        addedItems.addAll(scaled)
    }
    val totalCalories = addedItems.sumOf''')
# Locate content block to add quick relative adjustment once.
edit(p, '        LazyColumn(', '        LazyColumn(')
t=(ROOT/p).read_text(encoding='utf-8'); a=t.index('        LazyColumn('); b=t.index(') {', a)+3
t=t[:b]+'''
            if (addedItems.isNotEmpty()) item {
                Row(horizontalArrangement = Arrangement.spacedBy(8.dp)) {
                    OutlinedButton(onClick = { scaleDraft(0.75f) }, enabled = !saveStatus.busy) { Text("Smaller meal") }
                    OutlinedButton(onClick = { scaleDraft(1.25f) }, enabled = !saveStatus.busy) { Text("Larger meal") }
                }
                Text("Adjust the whole draft, including a repeated meal. Each tap changes it by about a quarter.", style = KaloTypography.bodySmall)
            }
'''+t[b:]; write(p,t)

p=BASE+'core/data/repository/MealRepository.kt'
edit(p, '    private val mealDao: MealDao\n', '    private val mealDao: MealDao,\n    private val dispatcher: kotlinx.coroutines.CoroutineDispatcher = Dispatchers.IO\n')
edit(p, 'withContext(Dispatchers.IO)', 'withContext(dispatcher)')

print('Review repairs and repeated-meal adjustments applied')
