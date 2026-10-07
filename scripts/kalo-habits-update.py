from pathlib import Path
import shutil

ROOT = Path(r'C:\Users\rauna\Desktop\Projects\Meal-Tracking-App')
SNAP = Path(r'C:\Users\rauna\Desktop\Bots\Engineer\docs\evidence\kalo-habits-before')
BASE = 'app/src/main/java/com/kalotracker/app/'

def write(rel, value):
    path = ROOT / rel
    prior = SNAP / rel
    if path.exists() and not prior.exists():
        prior.parent.mkdir(parents=True, exist_ok=True)
        shutil.copy2(path, prior)
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(value, encoding='utf-8', newline='\n')

def edit(rel, old, new):
    path = ROOT / rel
    text = path.read_text(encoding='utf-8')
    assert old in text, f'Missing anchor: {rel}: {old[:70]}'
    write(rel, text.replace(old, new))

write(BASE+'feature/meal/MealPortions.kt', '''package com.kalotracker.app.feature.meal

/** Relative portions keep estimated nutrition proportional; no scale is required. */
internal fun EditableFoodItem.scaledPortion(multiplier: Float): EditableFoodItem {
    require(multiplier.isFinite() && multiplier > 0f)
    return copy(portionGrams = (portionGrams * multiplier).coerceIn(1f, 5000f))
}

enum class CookingFat(val label: String, val kcalPerGram: Float, val fatPerGram: Float) {
    OIL("Cooking oil", 8.57f, 1f),
    BUTTER("Butter", 7.17f, 0.81f)
}
''')

p=BASE+'feature/meal/MealViewModel.kt'
edit(p, 'val hasAddedOil: Boolean = false,', 'val hasAddedOil: Boolean = false,\n    val cookingFat: CookingFat = CookingFat.OIL,\n    val cookingFatGrams: Float = 14f,')
edit(p, '(if (hasAddedOil) ADDED_OIL_CALORIES else 0)', '(if (hasAddedOil) (cookingFatGrams * cookingFat.kcalPerGram).toInt() else 0)')
edit(p, '(if (hasAddedOil) ADDED_OIL_GRAMS else 0f)', '(if (hasAddedOil) cookingFatGrams * cookingFat.fatPerGram else 0f)')
edit(p, '    fun setUserNote(note: String)', '''    fun setCookingFat(fat: CookingFat, grams: Float) {
        if (!grams.isFinite() || grams !in 1f..100f) return
        _uiState.update { it.copy(cookingFat = fat, cookingFatGrams = grams, hasAddedOil = true) }
    }

    fun scaleMeal(multiplier: Float) {
        if (_uiState.value.isAnalyzing || _uiState.value.isSaving) return
        _uiState.update { it.copy(items = it.items.map { item -> item.scaledPortion(multiplier) }) }
    }

    fun setUserNote(note: String)''')
edit(p, 'name = ADDED_OIL_NAME,\n                        portionGrams = ADDED_OIL_GRAMS,\n                        calories = ADDED_OIL_CALORIES,', 'name = "Extra ${currentState.cookingFat.label.lowercase()}",\n                        portionGrams = currentState.cookingFatGrams,\n                        calories = (currentState.cookingFatGrams * currentState.cookingFat.kcalPerGram).toInt(),')
edit(p, 'fat = ADDED_OIL_GRAMS,', 'fat = currentState.cookingFatGrams * currentState.cookingFat.fatPerGram,')
edit(p, '    private var lastImageBytes: ByteArray? = null', '    private var lastImageBytes: ByteArray? = null\n    private var analysisJob: kotlinx.coroutines.Job? = null\n    private var analysisGeneration = 0L')
edit(p, '        _uiState.update { it.copy(isAnalyzing = true, errorMessage = null, canRetry = false) }\n\n        viewModelScope.launch {', '        analysisJob?.cancel()\n        val generation = ++analysisGeneration\n        val note = _uiState.value.userNote.ifBlank { null }\n        _uiState.update { it.copy(isAnalyzing = true, errorMessage = null, canRetry = false) }\n\n        analysisJob = viewModelScope.launch {')
edit(p, 'userNote = _uiState.value.userNote.ifBlank { null }', 'userNote = note')
edit(p, '            result.onSuccess { response ->', '            if (generation != analysisGeneration) return@launch\n            result.onSuccess { response ->')
edit(p, '        if (currentState.items.isEmpty() || currentState.isSaving) return', '        if (currentState.items.isEmpty() || currentState.isSaving || currentState.isAnalyzing || currentState.isSaved) return')
edit(p, '    fun resetScan() {\n        discardUnsavedPhoto()', '    fun resetScan() {\n        analysisGeneration++\n        analysisJob?.cancel()\n        discardUnsavedPhoto()')
# Do not block the UI reading full-sized gallery files.
edit(p, '                val bytes = context.contentResolver.openInputStream(uri)?.use { it.readBytes() }', '                val bytes = kotlinx.coroutines.withContext(kotlinx.coroutines.Dispatchers.IO) {\n                    context.contentResolver.openInputStream(uri)?.use { stream ->\n                        val bytes = stream.readNBytes(25 * 1024 * 1024 + 1)\n                        require(bytes.size <= 25 * 1024 * 1024) { "Choose a photo smaller than 25 MB." }\n                        bytes\n                    }\n                }')
# Android InputStream API compatibility: bounded loop instead of Java 9 readNBytes.
edit(p, 'val bytes = stream.readNBytes(25 * 1024 * 1024 + 1)', '''val output = java.io.ByteArrayOutputStream()
                        val buffer = ByteArray(8192)
                        var count = stream.read(buffer)
                        while (count != -1) {
                            require(output.size() + count <= 25 * 1024 * 1024) { "Choose a photo smaller than 25 MB." }
                            output.write(buffer, 0, count)
                            count = stream.read(buffer)
                        }
                        val bytes = output.toByteArray()''')
edit(p, '            } catch (e: Exception) {\n                _uiState.update', '            } catch (cancelled: kotlinx.coroutines.CancellationException) {\n                throw cancelled\n            } catch (e: Exception) {\n                _uiState.update')

p=BASE+'core/network/MealAnalysisService.kt'
edit(p, '        } catch (e: MealAnalysisException) {', '        } catch (cancelled: kotlinx.coroutines.CancellationException) {\n            throw cancelled\n        } catch (e: MealAnalysisException) {')
edit(p, '4. Do NOT add cooking oil or butter unless it is clearly visible as its own item; the app adds oil separately when the user asks.', '4. Include a plausible modest allowance for cooking fats and sauces within the dish nutrition when preparation suggests them. Do not count them again as separate items unless visibly separate or the user explicitly describes an extra amount. State important assumptions.')
edit(p, '6. estimation_notes: one short sentence naming the main assumption, for example the plate size you assumed.', '6. estimation_notes: one short sentence naming the main assumption, including raw/cooked preparation or cooking fat when relevant. Aim for a useful everyday estimate; never require the user to weigh food. Follow the user note for quantities and food corrections.')

p=BASE+'feature/meal/CameraScreen.kt'
edit(p, 'onTitleChange = viewModel::setMealTitle,', 'onTitleChange = viewModel::setMealTitle,\n                    onScaleMeal = viewModel::scaleMeal,\n                    onCookingFatChange = viewModel::setCookingFat,')

p=BASE+'feature/meal/MealReviewBottomSheet.kt'
edit(p, '    val onTitleChange: (String) -> Unit,', '    val onTitleChange: (String) -> Unit,\n    val onScaleMeal: (Float) -> Unit,\n    val onCookingFatChange: (CookingFat, Float) -> Unit,')
edit(p, '    val lowConfidence = uiState.confidence < 0.6f', '    var showDetails by androidx.compose.runtime.saveable.rememberSaveable { mutableStateOf(false) }')
edit(p, 'Column {\n                    Text("AI ESTIMATE - CHECK BEFORE SAVING",', 'Column(Modifier.weight(1f)) {\n                    Text("YOUR MEAL · APPROXIMATE",')
edit(p, 'text = if (lowConfidence) "Photo estimate · Check portions carefully" else "Photo estimate · Review every portion",', 'text = "Save as it looks, or make a quick adjustment.",')
edit(p, 'color = if (lowConfidence) KaloFat else KaloTextMuted', 'color = KaloTextMuted')
start=(ROOT/p).read_text(encoding='utf-8')
a=start.index('            Row(\n                horizontalArrangement = Arrangement.spacedBy(14.dp)')
b=start.index('            Spacer(Modifier.height(8.dp))\n            DateTimeChip',a)
start=start[:a]+'''            Text("About ${uiState.totalCalories} kcal", style = KaloTypography.headlineLarge, color = KaloCalories)
            Row(horizontalArrangement = Arrangement.spacedBy(8.dp)) {
                OutlinedButton(onClick = { actions.onScaleMeal(0.75f) }, enabled = !uiState.isAnalyzing && !uiState.isSaving) { Text("Smaller") }
                OutlinedButton(onClick = { actions.onScaleMeal(1.25f) }, enabled = !uiState.isAnalyzing && !uiState.isSaving) { Text("Larger") }
            }
            Text("Each tap adjusts the current portion by about a quarter.", style = KaloTypography.bodySmall, color = KaloTextMuted)
            TextButton(onClick = { showDetails = !showDetails }) { Text(if (showDetails) "Hide grams & macros" else "Optional: grams & macros") }
            if (showDetails) Text("About ${uiState.totalProtein.toInt()} g protein · ${uiState.totalCarbs.toInt()} g carbs · ${uiState.totalFat.toInt()} g fat", color = KaloTextSecondary)

'''+start[b:]
write(p,start)
edit(p, '                    EditableItemRow(', '                    if (showDetails) EditableItemRow(')
edit(p, '                    )\n                }\n\n                item {\n                    Row(horizontalArrangement', '''                    ) else Surface(shape = RoundedCornerShape(14.dp), color = KaloSurfaceElevated) {
                        Column(Modifier.fillMaxWidth().padding(12.dp)) {
                            Text(item.name, style = KaloTypography.titleMedium)
                            Text("About ${item.currentCalories} kcal", color = KaloTextSecondary)
                            Row {
                                TextButton(onClick = { actions.onGramsChange(item.id, (item.portionGrams * 0.75f).coerceAtLeast(1f)) }, enabled = !uiState.isAnalyzing && !uiState.isSaving) { Text("Smaller") }
                                TextButton(onClick = { actions.onGramsChange(item.id, (item.portionGrams * 1.25f).coerceAtMost(5000f)) }, enabled = !uiState.isAnalyzing && !uiState.isSaving) { Text("Larger") }
                                TextButton(onClick = { actions.onRemoveItem(item.id) }, enabled = !uiState.isAnalyzing && !uiState.isSaving) { Text("Remove") }
                            }
                        }
                    }
                }

                item {
                    Row(horizontalArrangement''')
# Replace fixed oil UI with optional extra controls, vertical to support large text.
t=(ROOT/p).read_text(encoding='utf-8'); a=t.index('                    Row(horizontalArrangement = Arrangement.spacedBy(8.dp), verticalAlignment'); b=t.index('\n                if (!uiState.notes',a)
t=t[:a]+'''                    Column {
                        OutlinedButton(onClick = actions.onAddFood, enabled = !uiState.isAnalyzing && !uiState.isSaving) { Text("+ Add food") }
                        Text("AI already estimates cooking fats. Add extra only if something was missed.", style = KaloTypography.bodySmall)
                        FilterChip(selected = uiState.hasAddedOil, onClick = actions.onToggleOil,
                            enabled = !uiState.isAnalyzing && !uiState.isSaving,
                            label = { Text(if (uiState.hasAddedOil) "Remove extra cooking fat" else "Optional: extra oil or butter") })
                        if (uiState.hasAddedOil) {
                            CookingFat.entries.forEach { fat ->
                                TextButton(onClick = { actions.onCookingFatChange(fat, uiState.cookingFatGrams) }, enabled = !uiState.isAnalyzing && !uiState.isSaving) {
                                    Text(if (fat == uiState.cookingFat) "✓ ${fat.label}" else fat.label)
                                }
                            }
                            listOf(5f to "About 1 teaspoon", 14f to "About 1 tablespoon", 28f to "About 2 tablespoons").forEach { (grams, label) ->
                                TextButton(onClick = { actions.onCookingFatChange(uiState.cookingFat, grams) }, enabled = !uiState.isAnalyzing && !uiState.isSaving) {
                                    Text(if (grams == uiState.cookingFatGrams) "✓ $label" else label)
                                }
                            }
                        }
                    }
                }
'''+t[b:]; write(p,t)
edit(p, 'e.g. half portion, 2 tbsp oil, skim milk', 'e.g. two rotis, half a bowl, paneer not chicken')
edit(p, 'enabled = !uiState.isAnalyzing\n', 'enabled = !uiState.isAnalyzing && !uiState.isSaving\n')
edit(p, 'Photo estimates can miss ingredients and portions. Check names, grams and nutrition before saving.', 'An everyday estimate for tracking habits. You can save without weighing or counting macros.')
edit(p, 'text = "Log Meal (${uiState.totalCalories} kcal)"', 'text = "Save meal · about ${uiState.totalCalories} kcal"')
edit(p, 'remember(item.id) { mutableStateOf(item.portionGrams.toInt().toString()) }', 'remember(item.id, item.portionGrams) { mutableStateOf(item.portionGrams.toInt().toString()) }')

print('Meal flow updated; original affected source preserved in', SNAP)
