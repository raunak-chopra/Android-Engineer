exec(open(r'C:\Users\rauna\Desktop\Bots\Engineer\scripts\kalo-habits-update.py', encoding='utf-8').read().split("write(BASE+'feature/meal/MealPortions.kt'")[0])

p=BASE+'feature/meal/MealViewModel.kt'
edit(p, 'data class EditableFoodItem(', '@kotlinx.serialization.Serializable\ndata class EditableFoodItem(')
edit(p, 'data class MealScanUiState(', '@kotlinx.serialization.Serializable\ndata class MealScanUiState(')
edit(p, '    val isAnalyzing: Boolean = false,', '    val draftMealId: String = UUID.randomUUID().toString(),\n    val draftLoading: Boolean = false,\n    val resumePending: Boolean = false,\n    val draftMessage: String? = null,\n    val isAnalyzing: Boolean = false,')
edit(p, '(cookingFatGrams * cookingFat.kcalPerGram).toInt()', 'kotlin.math.round(cookingFatGrams * cookingFat.kcalPerGram).toInt()')
edit(p, '(currentState.cookingFatGrams * currentState.cookingFat.kcalPerGram).toInt()', 'kotlin.math.round(currentState.cookingFatGrams * currentState.cookingFat.kcalPerGram).toInt()')
edit(p, 'private val initialTimestamp: Long = System.currentTimeMillis()\n', 'private val initialTimestamp: Long = System.currentTimeMillis(),\n    private val draftStore: MealDraftStore? = null\n')
edit(p, 'MealScanUiState(timestamp = initialTimestamp))', 'MealScanUiState(timestamp = initialTimestamp, draftLoading = draftStore != null))')
edit(p, '    private var analysisGeneration = 0L', '''    private var analysisGeneration = 0L
    private var galleryJob: kotlinx.coroutines.Job? = null
    private var galleryGeneration = 0L
    private val draftMutex = kotlinx.coroutines.sync.Mutex()

    init {
        if (draftStore != null) viewModelScope.launch {
            try {
                val saved = draftStore.load()
                if (saved != null && mealRepository.getMeal(saved.draftMealId) == null) {
                    _uiState.value = saved.copy(draftLoading = false, resumePending = true,
                        isAnalyzing = false, isSaving = false, isSaved = false, errorMessage = null)
                } else {
                    draftStore.clear()
                    _uiState.update { it.copy(draftLoading = false) }
                }
            } catch (cancelled: kotlinx.coroutines.CancellationException) { throw cancelled }
            catch (_: Exception) { _uiState.update { it.copy(draftLoading = false, draftMessage = "Could not recover the last draft. You can start a new meal.") } }
            _uiState.collect { snapshot ->
                if (!snapshot.resumePending && !snapshot.draftLoading) {
                    draftMutex.lock()
                    try {
                        if (snapshot == _uiState.value) {
                            if (snapshot.isSaved || (snapshot.items.isEmpty() && snapshot.localImageUri == null)) draftStore.clear()
                            else draftStore.save(snapshot)
                        }
                    } catch (cancelled: kotlinx.coroutines.CancellationException) { throw cancelled }
                    catch (_: Exception) { _uiState.update { it.copy(draftMessage = "Draft recovery is unavailable. Keep this screen open until you save.") } }
                    finally { draftMutex.unlock() }
                }
            }
        }
    }

    fun resumeDraft() {
        _uiState.update { it.copy(resumePending = false) }
        val path = _uiState.value.localImageUri ?: return
        viewModelScope.launch {
            lastImageBytes = kotlinx.coroutines.withContext(kotlinx.coroutines.Dispatchers.IO) {
                runCatching { File(path).takeIf { it.length() <= 25 * 1024 * 1024 }?.readBytes() }.getOrNull()
            }
            if (_uiState.value.items.isEmpty() && lastImageBytes != null) runAnalysis()
        }
    }''')
edit(p, '    fun analyzeCapturedImage(imageBytes: ByteArray, localImageUri: String? = null) {\n        lastImageBytes', '    fun analyzeCapturedImage(imageBytes: ByteArray, localImageUri: String? = null) {\n        if (_uiState.value.isSaving || _uiState.value.draftLoading || _uiState.value.resumePending) return\n        galleryGeneration++\n        galleryJob?.cancel()\n        acceptImage(imageBytes, localImageUri)\n    }\n\n    private fun acceptImage(imageBytes: ByteArray, localImageUri: String?) {\n        lastImageBytes')
edit(p, '    fun analyzeImageFromGallery(context: Context, uri: Uri) {\n        viewModelScope.launch {', '''    fun analyzeImageFromGallery(context: Context, uri: Uri) {
        if (_uiState.value.isSaving || _uiState.value.draftLoading || _uiState.value.resumePending) return
        galleryJob?.cancel()
        analysisJob?.cancel()
        analysisGeneration++
        val generation = ++galleryGeneration
        galleryJob = viewModelScope.launch {''')
edit(p, '                val rotationDegrees = try {', '                val rotationDegrees = kotlinx.coroutines.withContext(kotlinx.coroutines.Dispatchers.IO) { try {')
edit(p, '                } catch (_: Exception) {\n                    0\n                }', '                } catch (cancelled: kotlinx.coroutines.CancellationException) { throw cancelled }\n                catch (_: Exception) { 0 } }')
edit(p, '                val processed = ImageUtils.processBytes(context, bytes, rotationDegrees)\n                analyzeCapturedImage(processed.compressedBytes, processed.localUri)', '''                if (generation != galleryGeneration) return@launch
                var processed: com.kalotracker.app.core.util.ProcessedImage? = null
                // Finish file creation even on cancellation, then clean any obsolete photo.
                kotlinx.coroutines.withContext(kotlinx.coroutines.NonCancellable) {
                    processed = ImageUtils.processBytes(context, bytes, rotationDegrees)
                }
                val image = processed ?: return@launch
                if (generation != galleryGeneration || !kotlinx.coroutines.currentCoroutineContext().isActive) {
                    kotlinx.coroutines.withContext(kotlinx.coroutines.NonCancellable + kotlinx.coroutines.Dispatchers.IO) { File(image.localUri).delete() }
                    return@launch
                }
                acceptImage(image.compressedBytes, image.localUri)''')
# isActive extension import
edit(p, 'import kotlinx.coroutines.launch', 'import kotlinx.coroutines.launch\nimport kotlinx.coroutines.isActive')
edit(p, '            val mealId = UUID.randomUUID().toString()', '''            // Persist the stable ID before the DB write so recovery cannot duplicate a committed meal.
            if (draftStore != null) {
                draftMutex.lock()
                try { draftStore.save(currentState) } finally { draftMutex.unlock() }
            }
            val mealId = currentState.draftMealId''')
edit(p, '                    mealId = mealId,\n                    name = item.name', '                    id = item.id,\n                    mealId = mealId,\n                    name = item.name')
edit(p, '        analysisGeneration++\n        analysisJob?.cancel()\n        discardUnsavedPhoto()', '        analysisGeneration++\n        galleryGeneration++\n        galleryJob?.cancel()\n        analysisJob?.cancel()\n        discardUnsavedPhoto()')
edit(p, '        discardUnsavedPhoto()\n        super.onCleared()', '        if (draftStore == null) discardUnsavedPhoto()\n        super.onCleared()')
edit(p, 'return MealViewModel(mealRepository, analysisService, initialTimestamp) as T', 'return MealViewModel(mealRepository, analysisService, initialTimestamp, draftStore) as T')

write(BASE+'feature/meal/MealDraftStore.kt', '''package com.kalotracker.app.feature.meal

import android.util.AtomicFile
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext
import kotlinx.serialization.json.Json
import java.io.File

interface MealDraftStore {
    suspend fun load(): MealScanUiState?
    suspend fun save(state: MealScanUiState)
    suspend fun clear()
}

internal object MealDraftCodec {
    private val json = Json { ignoreUnknownKeys = true }
    fun encode(state: MealScanUiState): String = json.encodeToString(MealScanUiState.serializer(),
        state.copy(isAnalyzing = false, isSaving = false, isSaved = false, draftLoading = false,
            resumePending = false, draftMessage = null, errorMessage = null))
    fun decode(value: String): MealScanUiState = json.decodeFromString(MealScanUiState.serializer(), value).also { s ->
        require(s.items.size <= 100 && s.cookingFatGrams.isFinite() && s.cookingFatGrams in 1f..100f)
        require(s.items.all { it.portionGrams.isFinite() && it.portionGrams in 1f..5000f &&
            listOf(it.baseCaloriesPerGram, it.baseProteinPerGram, it.baseCarbsPerGram, it.baseFatPerGram).all { n -> n.isFinite() && n >= 0 } })
    }
}

/** One device-local draft, excluded from exports and Android backup. */
class FileMealDraftStore(file: File) : MealDraftStore {
    private val atomic = AtomicFile(file)
    override suspend fun load(): MealScanUiState? = withContext(Dispatchers.IO) {
        try { atomic.openRead().use { MealDraftCodec.decode(it.bufferedReader().readText()) } }
        catch (_: java.io.FileNotFoundException) { null }
    }
    override suspend fun save(state: MealScanUiState) = withContext(Dispatchers.IO) {
        val stream = atomic.startWrite()
        try {
            stream.write(MealDraftCodec.encode(state).toByteArray(Charsets.UTF_8))
            atomic.finishWrite(stream)
        } catch (e: Exception) { atomic.failWrite(stream); throw e }
    }
    override suspend fun clear() = withContext(Dispatchers.IO) { atomic.delete() }
}
''')
p=BASE+'navigation/KaloNavHost.kt'
edit(p, 'MealViewModelFactory(mealRepository, analysisService, logTimestamp)', 'MealViewModelFactory(mealRepository, analysisService, logTimestamp,\n                    com.kalotracker.app.feature.meal.FileMealDraftStore(java.io.File(appContext.noBackupFilesDir, "meal-draft.json")))')
p=BASE+'feature/meal/CameraScreen.kt'
edit(p, '    Box(modifier = modifier.fillMaxSize().background(Color.Black)) {', '''    if (state.resumePending) AlertDialog(onDismissRequest = {},
        title = { Text("Resume your meal?") }, text = { Text("Your unfinished photo meal is still here, including its original date and corrections.") },
        confirmButton = { TextButton(onClick = viewModel::resumeDraft) { Text("Resume") } },
        dismissButton = { TextButton(onClick = viewModel::resetScan) { Text("Discard") } })
    if (state.draftLoading) {
        Box(Modifier.fillMaxSize().background(KaloBackground), contentAlignment = Alignment.Center) { CircularProgressIndicator() }
        return
    }
    Box(modifier = modifier.fillMaxSize().background(Color.Black)) {''')
edit(p, 'visible = state.items.isNotEmpty(),', 'visible = state.items.isNotEmpty() && !state.resumePending,')
edit(p, '            MealReviewBottomSheet(', '            MealReviewBottomSheet(')
p=BASE+'feature/meal/MealReviewBottomSheet.kt'
edit(p, '            uiState.errorMessage?.let', '            uiState.draftMessage?.let { Text(it, color = KaloTextSecondary) }\n            uiState.errorMessage?.let')
edit(p, 'remember(item.id, item.portionGrams) { mutableStateOf(item.portionGrams.toInt().toString()) }', 'remember(item.id) { mutableStateOf(item.portionGrams.toString()) }')
# Local decimal typing must survive updates. Advanced editor is recreated when details toggle.
p=BASE+'core/data/backup/BackupManager.kt'
edit(p, 'private val settings: com.kalotracker.app.core.settings.AppSettings\n', 'private val settings: com.kalotracker.app.core.settings.AppSettings,\n    private val draftFile: File? = null\n')
edit(p, '        profileRepository.resetHistory()', '        draftFile?.let { android.util.AtomicFile(it).delete() }\n        profileRepository.resetHistory()')
p=BASE+'KaloApplication.kt'
edit(p, 'java.io.File(filesDir, "meals"), appSettings)', 'java.io.File(filesDir, "meals"), appSettings, java.io.File(noBackupFilesDir, "meal-draft.json"))')
print('Photo draft recovery added')
