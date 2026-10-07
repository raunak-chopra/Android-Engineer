exec(open(r'C:\Users\rauna\Desktop\Bots\Engineer\scripts\kalo-habits-update.py', encoding='utf-8').read().split("write(BASE+'feature/meal/MealPortions.kt'")[0])
for rel in ['app/src/test/java/com/kalotracker/app/feature/workout/WorkoutViewModelTest.kt', 'app/src/test/java/com/kalotracker/app/feature/meal/HabitMealTest.kt']:
    text = (ROOT / rel).read_text(encoding='utf-8')
    text = text.replace('holder.clear(); Dispatchers.resetMain()', 'holder.clear(); runCurrent(); Dispatchers.resetMain()').replace('store.clear(); Dispatchers.resetMain()', 'store.clear(); runCurrent(); Dispatchers.resetMain()')
    write(rel, text)
p=BASE+'feature/meal/MealViewModel.kt'
edit(p, 'it.copy(items = it.items.map { item -> item.scaledPortion(multiplier) })', 'it.copy(items = it.items.map { item -> item.scaledPortion(multiplier) },\n            cookingFatGrams = if (it.hasAddedOil) (it.cookingFatGrams * multiplier).coerceIn(1f, 100f) else it.cookingFatGrams)')
print('Test lifecycle cleanup corrected; extra fat scales with whole meal')
