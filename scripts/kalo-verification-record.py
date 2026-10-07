exec(open(r'C:\Users\rauna\Desktop\Bots\Engineer\scripts\kalo-habits-update.py', encoding='utf-8').read().split("write(BASE+'feature/meal/MealPortions.kt'")[0])
import xml.etree.ElementTree as ET
results = list((ROOT/'app/build/test-results/testDebugUnitTest').glob('TEST-*.xml'))
totals = {key: sum(int(ET.parse(p).getroot().get(key, 0)) for p in results) for key in ['tests', 'failures', 'errors', 'skipped']}
assert totals == {'tests':111, 'failures':0, 'errors':0, 'skipped':0}, totals
lint=(ROOT/'app/build/reports/lint-results-debug.txt').read_text(encoding='utf-8')
assert '0 errors, 45 warnings' in lint
p='docs/HABIT_TRACKING.md'
text=(ROOT/p).read_text(encoding='utf-8')
text=text.replace('State: Reviewed.', 'State: Verified.')
text=text.replace('Root acceptance pending recorded final check results.', 'Final checks passed. Independent root acceptance pending the final evidence review.')
text=text.replace('Results will be recorded after completion.', 'Final rerun passed: **111 tests, 0 failures/errors/skips; debug APK and instrumentation APK built; lint 0 errors / 45 warnings**. The final optional gram-display synchronization was included in this rerun. No new lint warnings were introduced.')
text=text.replace('no installation or device-check pass is claimed at this point.', 'no installation or device-check pass is claimed. The expanded instrumentation runner compiled but was not executed.')
(ROOT/p).write_text(text, encoding='utf-8', newline='\n')
print('Recorded final verification:', totals)
