exec(open(r'C:\Users\rauna\Desktop\Bots\Engineer\scripts\kalo-habits-update.py', encoding='utf-8').read().split("write(BASE+'feature/meal/MealPortions.kt'")[0])
p=BASE+'feature/meal/MealReviewBottomSheet.kt'
edit(p, '    var gramsText by remember(item.id) { mutableStateOf(item.portionGrams.toString()) }', '''    var gramsText by remember(item.id) { mutableStateOf(item.portionGrams.toString()) }
    LaunchedEffect(item.portionGrams) {
        // Preserve partial decimal typing, but reflect external Smaller/Larger changes.
        if (gramsText.toFloatOrNull() != item.portionGrams) gramsText = item.portionGrams.toString()
    }''')
readme=(ROOT/'README.md').read_text(encoding='utf-8')
if 'docs/HABIT_TRACKING.md' not in readme:
    write('README.md', readme+'\n## Everyday habits\n\nPhoto meals now lead with approximate calories and optional portion adjustments; grams and macros are expandable. Daily fitness logs short bodyweight sessions with remembered choices. Photo-meal drafts recover locally. See [implementation and verification](docs/HABIT_TRACKING.md) for scope, review, evidence and device-testing limits.\n')
print('Advanced portion display synchronized and README linked')
