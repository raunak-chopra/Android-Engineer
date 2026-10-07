from pathlib import Path
import json
root=Path(r'C:\Users\rauna\Desktop\Projects\Meal-Tracking-App');base=root/'app/src/main/java/com/kalotracker/app'
catalog=json.loads(Path('docs/evidence/indian-snacks-2026-10-02/indian-snacks-100.json').read_text(encoding='utf8'))
asset=root/'app/src/main/assets/indian_snacks_100.json';asset.parent.mkdir(parents=True,exist_ok=True)
keys=['barcode','name','brand','pack_size_as_recorded','nutrition_per_100g_as_recorded','nutrition_basis','label_url','source_url']
asset.write_text(json.dumps({'retrieved_date':catalog['retrieved_date'],'attribution':'Open Food Facts contributors; database ODbL; contents DBCL; photo links CC BY-SA','products':[{k:p[k] for k in keys} for p in catalog['products']]},ensure_ascii=False,indent=2),encoding='utf8')
(base/'core/network/IndianSnackCatalog.kt').write_text('''package com.kalotracker.app.core.network

import org.json.JSONObject

/** Bundled community records. Packet confirmation is required before logging. */
class IndianSnackCatalog private constructor(private val entries: Map<String, JSONObject>) {
    fun lookup(barcode: String): Result<ScannedFoodProduct>? {
        val entry = entries[barcode] ?: return null
        val label = entry.getString("label_url")
        val name = entry.getString("name")
        val n = entry.getJSONObject("nutrition_per_100g_as_recorded")
        val keys = listOf("kcal", "protein_g", "carbohydrate_g", "fat_g")
        val values = keys.map { n.optDouble(it, Double.NaN) }
        if (!entry.getString("nutrition_basis").startsWith("as sold") ||
            values.any { !it.isFinite() || it < 0 } || values[0] > 1000 || values.drop(1).any { it > 100 }) {
            return Result.failure(BarcodeLookupException.LabelReviewRequired(name, label))
        }
        // Only explicitly unit-bearing gram pack sizes may provide a default portion.
        val pack = entry.optString("pack_size_as_recorded")
        val grams = Regex("(?i)^\\\\s*(\\\\d+(?:\\\\.\\\\d+)?)\\\\s*(g|gm|gram|grams)\\\\s*$").matchEntire(pack)
            ?.groupValues?.get(1)?.toFloatOrNull()?.takeIf { it in 5f..2500f } ?: 100f
        return Result.success(ScannedFoodProduct(barcode, name,
            brand = entry.optString("brand").takeUnless { it.isBlank() || it == "null" },
            servingSizeGrams = grams, caloriesPer100g = values[0].toInt(),
            proteinPer100g = values[1].toFloat(), carbsPer100g = values[2].toFloat(), fatPer100g = values[3].toFloat(),
            labelUrl = label, requiresLabelConfirmation = true, fromCatalog = true))
    }

    companion object {
        fun parse(text: String): IndianSnackCatalog {
            val rows = JSONObject(text).getJSONArray("products")
            return IndianSnackCatalog((0 until rows.length()).associate { i ->
                val row = rows.getJSONObject(i)
                row.getString("barcode") to row
            })
        }
    }
}
''',encoding='utf8')
p=base/'core/network/OpenFoodFactsService.kt';s=p.read_text(encoding='utf8')
s=s.replace('val fromCache: Boolean = false','val fromCache: Boolean = false,\n    val labelUrl: String? = null,\n    val requiresLabelConfirmation: Boolean = false,\n    val fromCatalog: Boolean = false')
s=s.replace('    class Offline :','    class LabelReviewRequired(val productName: String, val labelUrl: String) :\n        BarcodeLookupException("Found $productName. Nutrition is incomplete or its preparation basis needs checking. Open the label, then enter nutrition manually.")\n\n    class Offline :')
s=s.replace('class OpenFoodFactsService(private val cache: com.kalotracker.app.core.database.dao.PersonalDao? = null)', 'class OpenFoodFactsService(private val cache: com.kalotracker.app.core.database.dao.PersonalDao? = null,\n    private val catalogLoader: (() -> IndianSnackCatalog)? = null)')
s=s.replace('    suspend fun getProductByBarcode', '    private val catalog by lazy { catalogLoader?.invoke() }\n\n    suspend fun getProductByBarcode')
s=s.replace('            val conn = try {', '''            val local = catalog?.lookup(cleaned)
            if (local != null && !refresh) return@withContext local
            val conn = try {''')
s=s.replace('return@withContext Result.failure(it)','return@withContext local ?: Result.failure(it)')
s=s.replace('404 -> Result.failure(BarcodeLookupException.NotFound(cleaned))','404 -> local ?: Result.failure(BarcodeLookupException.NotFound(cleaned))')
s=s.replace('else -> Result.failure(BarcodeLookupException.Other("Lookup failed (HTTP $code). Try again."))','else -> local ?: Result.failure(BarcodeLookupException.Other("Lookup failed (HTTP $code). Try again."))')
s=s.replace('if (cached != null) Result.success(cached) else Result.failure(BarcodeLookupException.Offline())','local ?: if (cached != null) Result.success(cached) else Result.failure(BarcodeLookupException.Offline())')
p.write_text(s,encoding='utf8')
p=base/'feature/barcode/BarcodeScannerViewModel.kt';s=p.read_text(encoding='utf8')
s=s.replace('val manualBarcodeText: String = ""','val manualBarcodeText: String = "",\n    val labelConfirmed: Boolean = false,\n    val reviewLabelUrl: String? = null')
s=s.replace('errorMessage = null\n            )','errorMessage = null, labelConfirmed = false, reviewLabelUrl = null\n            )',1)
s=s.replace('errorMessage = err.localizedMessage ?: "Lookup failed."','errorMessage = err.localizedMessage ?: "Lookup failed.",\n                        reviewLabelUrl = (err as? com.kalotracker.app.core.network.BarcodeLookupException.LabelReviewRequired)?.labelUrl')
s=s.replace('    fun setTimestamp', '    fun confirmLabel(value: Boolean) { _uiState.update { it.copy(labelConfirmed = value) } }\n\n    fun setTimestamp')
s=s.replace('errorMessage = result.exceptionOrNull()?.localizedMessage)', 'labelConfirmed = false,\n                errorMessage = result.exceptionOrNull()?.localizedMessage)')
s=s.replace('isSaved = false\n','isSaved = false, labelConfirmed = false, reviewLabelUrl = null\n')
s=s.replace('if (s.isSaving || s.isSaved || s.isLookingUp) return','if (s.isSaving || s.isSaved || s.isLookingUp || (prod.requiresLabelConfirmation && !s.labelConfirmed)) return')
s=s.replace('confidence = 1.0f','confidence = if (prod.fromCatalog) 0.7f else 1.0f')
s=s.replace('private val initialTimestamp: Long = System.currentTimeMillis()\n) : ViewModelProvider.Factory', 'private val initialTimestamp: Long = System.currentTimeMillis(),\n    private val catalogLoader: (() -> com.kalotracker.app.core.network.IndianSnackCatalog)? = null\n) : ViewModelProvider.Factory')
s=s.replace('OpenFoodFactsService(personalDao)', 'OpenFoodFactsService(personalDao, catalogLoader)')
p.write_text(s,encoding='utf8')
p=base/'navigation/KaloNavHost.kt';s=p.read_text(encoding='utf8').replace('BarcodeScannerViewModelFactory(mealRepository, personalDao, logTimestamp)','''BarcodeScannerViewModelFactory(mealRepository, personalDao, logTimestamp) {
                    appContext.assets.open("indian_snacks_100.json").bufferedReader().use {
                        com.kalotracker.app.core.network.IndianSnackCatalog.parse(it.readText())
                    }
                }''');p.write_text(s,encoding='utf8')
p=base/'feature/barcode/BarcodeScannerScreen.kt';s=p.read_text(encoding='utf8')
s=s.replace('    val context = LocalContext.current','    val uriHandler = androidx.compose.ui.platform.LocalUriHandler.current\n    val context = LocalContext.current',1)
s=s.replace('                Row(horizontalArrangement = Arrangement.spacedBy(10.dp)) {\n                    OutlinedButton(','''                state.reviewLabelUrl?.let { url ->
                    TextButton(onClick = { uriHandler.openUri(url) }) { Text("Open nutrition label") }
                }
                Row(horizontalArrangement = Arrangement.spacedBy(10.dp)) {
                    OutlinedButton(''',1)
s=s.replace('                    product = product,','                    product = product,\n                    labelConfirmed = state.labelConfirmed, onConfirmLabel = viewModel::confirmLabel,\n                    onOpenLabel = { product.labelUrl?.let { uriHandler.openUri(it) } },',1)
s=s.replace('    product: ScannedFoodProduct,\n    timestamp:', '    product: ScannedFoodProduct,\n    labelConfirmed: Boolean, onConfirmLabel: (Boolean) -> Unit, onOpenLabel: () -> Unit,\n    timestamp:')
s=s.replace('            saveError?.let', '''            if (product.fromCatalog) {
                Text("Indian snack starter catalog · Open Food Facts contributors", style = KaloTypography.labelSmall)
                Text("Check the product and pack size against your packet. Label photos need internet.")
            }
            if (product.labelUrl != null) TextButton(onClick = onOpenLabel) { Text("Open nutrition label") }
            if (product.requiresLabelConfirmation) {
                Row(verticalAlignment = Alignment.CenterVertically) {
                    Checkbox(checked = labelConfirmed, onCheckedChange = onConfirmLabel)
                    Text("This product and nutrition match my packet", modifier = Modifier.weight(1f))
                }
            }
            saveError?.let''')
s=s.replace('enabled = !isSaving\n            )','enabled = !isSaving && (!product.requiresLabelConfirmation || labelConfirmed)\n            )')
p.write_text(s,encoding='utf8')
