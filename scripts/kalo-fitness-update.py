exec(open(r'C:\Users\rauna\Desktop\Bots\Engineer\scripts\kalo-habits-update.py', encoding='utf-8').read().split("write(BASE+'feature/meal/MealPortions.kt'")[0])

p=BASE+'feature/workout/DailyFitness.kt'
write(p, '''package com.kalotracker.app.feature.workout

import kotlin.math.roundToInt

enum class FitnessEffort(val label: String) { EASY("Easy"), MODERATE("Moderate"), HARD("Hard") }

/** Rough gross energy: MET × 3.5 × kg / 200 × minutes.
 * 2024 Adult Compendium, conditioning activities 02020/02022/02024.
 * Total session time is allocated once; pace and rests make this approximate.
 */
internal fun dailyFitnessExercises(
    minutes: Int, weightKg: Double,
    effort: FitnessEffort = FitnessEffort.MODERATE,
    reps: List<Int> = listOf(20, 20, 20)
): List<WorkoutExercise> {
    require(minutes in 3..60)
    require(weightKg.isFinite() && weightKg in 20.0..300.0)
    require(reps.size == 3 && reps.all { it in 0..10000 } && reps.any { it > 0 })
    val selected = listOf("Push-ups", "Sit-ups", "Crunches").zip(reps).filter { it.second > 0 }
    return selected.mapIndexed { index, (name, count) ->
        val duration = minutes / selected.size + if (index < minutes % selected.size) 1 else 0
        val met = when (effort) {
            FitnessEffort.EASY -> 2.8
            FitnessEffort.MODERATE -> if (name == "Crunches") 2.8 else 3.8
            FitnessEffort.HARD -> 7.5
        }
        WorkoutExercise(name, sets = listOf(EditableSet(1, "0", count.toString())),
            durationMinutes = duration,
            calories = (met * 3.5 * weightKg / 200 * duration).roundToInt())
    }
}
''')

p=BASE+'feature/workout/WorkoutViewModel.kt'
edit(p, '    fun toggleSetComplete(index:', '''    fun saveDailyFitness(minutes: String, weightKg: String, effort: FitnessEffort,
        reps: List<String>, onSuccess: () -> Unit) {
        val state = _uiState.value
        if (state.isSaving || state.isSaved || state.isLoading || workoutId != null) return
        val rows = runCatching {
            dailyFitnessExercises(minutes.toInt(), weightKg.toDouble(), effort, reps.map { it.toInt() })
        }.getOrElse {
            _uiState.update { it.copy(errorMessage = "Enter 3–60 minutes, 20–300 kg and whole reps (0 skips an exercise). Include at least one exercise.") }
            return
        }
        historyRequest++
        fitnessBodyWeight = weightKg.toDouble()
        _uiState.update { it.copy(otherExercises = rows, exerciseName = "", sets = listOf(EditableSet(1)),
            sessionTitle = "Daily fitness", previousSessionFound = false, overloadHint = null, errorMessage = null) }
        saveWorkout(onSuccess)
    }

    fun toggleSetComplete(index:''')

write(BASE+'feature/workout/DailyFitnessScreen.kt', '''package com.kalotracker.app.feature.workout

import androidx.compose.foundation.layout.*
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.verticalScroll
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.unit.dp
import com.kalotracker.app.core.designsystem.components.DateTimeChip
import com.kalotracker.app.core.designsystem.components.KaloButton

@Composable
fun DailyFitnessScreen(state: WorkoutUiState, defaults: List<String>,
    onClose: () -> Unit, onAdvanced: () -> Unit, onTimeChange: (Long) -> Unit,
    onSave: (String, String, FitnessEffort, List<String>) -> Unit) {
    var minutes by rememberSaveable { mutableStateOf(defaults[0]) }
    var weight by rememberSaveable { mutableStateOf(defaults[1]) }
    var effortName by rememberSaveable { mutableStateOf(defaults[2]) }
    var pushups by rememberSaveable { mutableStateOf(defaults[3]) }
    var situps by rememberSaveable { mutableStateOf(defaults[4]) }
    var crunches by rememberSaveable { mutableStateOf(defaults[5]) }
    val effort = FitnessEffort.valueOf(effortName)
    val reps = listOf(pushups, situps, crunches)
    val estimate = runCatching { dailyFitnessExercises(minutes.toInt(), weight.toDouble(), effort, reps.map { it.toInt() }).sumOf { it.calories } }.getOrNull()
    Scaffold(topBar = {
        Row(Modifier.fillMaxWidth().statusBarsPadding().padding(12.dp)) {
            TextButton(onClick = onClose, enabled = !state.isSaving) { Text("Close") }
            Text("Daily fitness", style = MaterialTheme.typography.headlineSmall, modifier = Modifier.weight(1f))
        }
    }, bottomBar = {
        Box(Modifier.fillMaxWidth().navigationBarsPadding().padding(20.dp)) {
            KaloButton("Save session", { onSave(minutes, weight, effort, reps) }, loading = state.isSaving,
                enabled = !state.isSaving && !state.isSaved && estimate != null)
        }
    }) { padding ->
        Column(Modifier.fillMaxSize().padding(padding).verticalScroll(rememberScrollState()).padding(20.dp),
            verticalArrangement = Arrangement.spacedBy(12.dp)) {
            Text("A few minutes for your daily habit", style = MaterialTheme.typography.titleLarge)
            Text("Your last saved choices are ready to repeat. Change only what you did differently.")
            DateTimeChip(state.timestamp, onTimeChange)
            Text("How long?", style = MaterialTheme.typography.titleMedium)
            Row(horizontalArrangement = Arrangement.spacedBy(8.dp)) {
                listOf(5, 7, 10).forEach { n -> FilterChip(minutes == n.toString(), { minutes = n.toString() }, label = { Text("$n min") }, enabled = !state.isSaving) }
            }
            OutlinedTextField(minutes, { minutes = it }, label = { Text("Total minutes, including breaks") },
                singleLine = true, enabled = !state.isSaving, keyboardOptions = KeyboardOptions(keyboardType = KeyboardType.Number), modifier = Modifier.fillMaxWidth())
            Text("How did it feel?", style = MaterialTheme.typography.titleMedium)
            FitnessEffort.entries.forEach { value -> FilterChip(value == effort, { effortName = value.name }, label = { Text(value.label) }, enabled = !state.isSaving) }
            Text("Reps · enter 0 to skip", style = MaterialTheme.typography.titleMedium)
            listOf(Triple("Push-ups", pushups, { value: String -> pushups = value }),
                Triple("Sit-ups", situps, { value: String -> situps = value }),
                Triple("Crunches", crunches, { value: String -> crunches = value })).forEach { (name, value, change) ->
                OutlinedTextField(value, change, label = { Text(name) }, singleLine = true, enabled = !state.isSaving,
                    keyboardOptions = KeyboardOptions(keyboardType = KeyboardType.Number), modifier = Modifier.fillMaxWidth())
            }
            OutlinedTextField(weight, { weight = it }, label = { Text("Body weight (kg) · remembered next time") },
                singleLine = true, enabled = !state.isSaving, keyboardOptions = KeyboardOptions(keyboardType = KeyboardType.Decimal), modifier = Modifier.fillMaxWidth())
            Text(if (estimate == null) "Enter your body weight once and check the minutes and reps to save." else "About $estimate kcal · a rough estimate")
            Text("Estimate includes resting energy. Pace and breaks affect it; it stays separate from food intake.", style = MaterialTheme.typography.bodySmall)
            state.errorMessage?.let { Text(it, color = MaterialTheme.colorScheme.error) }
            TextButton(onClick = onAdvanced, enabled = !state.isSaving) { Text("More exercises / detailed workout") }
        }
    }
}
''')

p=BASE+'feature/workout/WorkoutScreen.kt'
edit(p, '    modifier: Modifier = Modifier\n', '    modifier: Modifier = Modifier,\n    quickFitness: Boolean = false,\n    fitnessDefaults: List<String> = listOf("7", "", "MODERATE", "20", "20", "20"),\n    onFitnessDefaultsSaved: (List<String>) -> Unit = {}\n')
edit(p, '    val routines by viewModel.routines.collectAsState()', '''    val routines by viewModel.routines.collectAsState()
    var detailed by rememberSaveable { mutableStateOf(!quickFitness) }
    if (!detailed) {
        DailyFitnessScreen(state, fitnessDefaults, onClose, { detailed = true }, viewModel::setTimestamp) { minutes, weight, effort, reps ->
            viewModel.saveDailyFitness(minutes, weight, effort, reps) {
                onFitnessDefaultsSaved(listOf(minutes, weight, effort.name) + reps)
                onWorkoutSaved()
            }
        }
        return
    }''')
edit(p, '            item {\n                Surface(shape = RoundedCornerShape(16.dp), color = KaloSurfaceElevated)', '            if (quickFitness) item { TextButton(onClick = { detailed = false }, enabled = !state.isSaving) { Text("Back to quick daily fitness") } }\n            item {\n                Surface(shape = RoundedCornerShape(16.dp), color = KaloSurfaceElevated)')

p=BASE+'core/settings/AppSettings.kt'
edit(p, '    companion object {', '''    fun fitnessDefaults(): List<String> = listOf(
        prefs.getString("fitness_minutes", "7") ?: "7",
        prefs.getString("fitness_weight", "") ?: "",
        prefs.getString("fitness_effort", "MODERATE") ?: "MODERATE",
        prefs.getString("fitness_pushups", "20") ?: "20",
        prefs.getString("fitness_situps", "20") ?: "20",
        prefs.getString("fitness_crunches", "20") ?: "20"
    )

    fun saveFitnessDefaults(values: List<String>) {
        require(values.size == 6)
        val editor = prefs.edit()
        listOf("minutes", "weight", "effort", "pushups", "situps", "crunches").zip(values).forEach { (key, value) ->
            editor.putString("fitness_$key", value)
        }
        editor.apply()
    }

    companion object {''')
p=BASE+'navigation/KaloNavHost.kt'
edit(p, 'onWorkoutSaved = { navController.popBackStack() }\n', 'onWorkoutSaved = { navController.popBackStack() },\n                quickFitness = true, fitnessDefaults = appSettings.fitnessDefaults(),\n                onFitnessDefaultsSaved = appSettings::saveFitnessDefaults\n')

write(BASE+'feature/trends/HabitSummary.kt', '''package com.kalotracker.app.feature.trends

import com.kalotracker.app.core.database.dao.MealWithItems
import com.kalotracker.app.core.database.dao.WorkoutWithSets
import java.time.Instant
import java.time.LocalDate
import java.time.ZoneId

data class HabitSummary(val mealDays: Int = 0, val sessions: Int = 0, val minutes: Int = 0,
    val reps: Map<String, Int> = emptyMap())

internal fun habitSummary(meals: List<MealWithItems>, workouts: List<WorkoutWithSets>,
    start: LocalDate, end: LocalDate, zone: ZoneId): HabitSummary {
    fun within(timestamp: Long) = Instant.ofEpochMilli(timestamp).atZone(zone).toLocalDate() in start..end
    val sessions = workouts.filter { within(it.workout.timestamp) }
    return HabitSummary(meals.filter { within(it.meal.timestamp) }.map { Instant.ofEpochMilli(it.meal.timestamp).atZone(zone).toLocalDate() }.distinct().size,
        sessions.size, sessions.sumOf { it.workout.durationMinutes },
        sessions.flatMap { it.sets }.filter { it.isCompleted }.groupBy { it.exerciseName }.mapValues { (_, sets) -> sets.sumOf { it.reps } })
}
''')
p=BASE+'feature/trends/TrendsViewModel.kt'
edit(p, '    val rangeDays: Int = 7,', '    val rangeDays: Int = 7,\n    val habits: HabitSummary = HabitSummary(),')
edit(p, '                stats = stats,', '                stats = stats,\n                habits = habitSummary(meals, workouts, today.minusDays(state.rangeDays.toLong() - 1), today, zone),')
p=BASE+'feature/trends/TrendsScreen.kt'
edit(p, '            val stats = state.stats', '''            if (!state.isLoading) item {
                Surface(shape = RoundedCornerShape(16.dp), color = KaloSurfaceElevated) {
                    Column(Modifier.fillMaxWidth().padding(16.dp), verticalArrangement = Arrangement.spacedBy(8.dp)) {
                        Text("Your habits · last ${state.rangeDays} days", style = KaloTypography.titleLarge)
                        Text("Meals recorded on ${state.habits.mealDays} days")
                        Text("${state.habits.sessions} fitness sessions · ${state.habits.minutes} minutes")
                        state.habits.reps.forEach { (exercise, reps) -> Text("$exercise · $reps completed reps") }
                        Text("Recording a meal builds the habit. Mark a day complete only when all its food is logged; nutrition averages use complete past days.", style = KaloTypography.bodySmall)
                    }
                }
            }

            val stats = state.stats''')
print('Quick fitness and habit summary updated')
