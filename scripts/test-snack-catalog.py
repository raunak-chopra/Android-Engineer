from pathlib import Path
root=Path(r"C:\Users\rauna\Desktop\Projects\Meal-Tracking-App")
base=root/"app/src/main/java/com/kalotracker/app"
p=base/"feature/barcode/BarcodeScannerViewModel.kt";s=p.read_text(encoding="utf8");s=s.replace("    val currentCalories:", "    val canLog: Boolean get() = product != null && !isSaving && !isSaved && !isLookingUp &&\n        (product.requiresLabelConfirmation.not() || labelConfirmed)\n    val currentCalories:");s=s.replace("if (s.isSaving || s.isSaved || s.isLookingUp || (prod.requiresLabelConfirmation && !s.labelConfirmed)) return","if (!s.canLog) return");p.write_text(s,encoding="utf8")
p=base/"feature/barcode/BarcodeScannerScreen.kt";s=p.read_text(encoding="utf8");s=s.replace("labelConfirmed = state.labelConfirmed, onConfirmLabel", "canLog = state.canLog, labelConfirmed = state.labelConfirmed, onConfirmLabel");s=s.replace("    labelConfirmed: Boolean, onConfirmLabel", "    canLog: Boolean, labelConfirmed: Boolean, onConfirmLabel");s=s.replace("enabled = !isSaving && (!product.requiresLabelConfirmation || labelConfirmed)","enabled = canLog");p.write_text(s,encoding="utf8")
p=root/"app/src/test/java/com/kalotracker/app/core/network/IndianSnackCatalogTest.kt"
p.write_text('''package com.kalotracker.app.core.network

import com.kalotracker.app.feature.barcode.BarcodeUiState
import org.json.JSONObject
import org.junit.Assert.*
import org.junit.Test
import java.io.File

class IndianSnackCatalogTest {
    private val text = File("src/main/assets/indian_snacks_100.json").readText()
    private val catalog = IndianSnackCatalog.parse(text)

    @Test fun bundledRecordsHaveUniqueBarcodesAndLabelProvenance() {
        val rows = JSONObject(text).getJSONArray("products")
        assertEquals(100, rows.length())
        val codes = (0 until rows.length()).map { rows.getJSONObject(it).getString("barcode") }
        assertEquals(100, codes.toSet().size)
        for (i in 0 until rows.length()) {
            val row = rows.getJSONObject(i)
            assertTrue(row.getString("label_url").startsWith("https://images.openfoodfacts.org/"))
            assertTrue(row.getString("source_url").endsWith(row.getString("barcode")))
        }
    }

    @Test fun bhujiaUsesExactPackAndRequiresConfirmation() {
        val p = catalog.lookup("8904004400694")!!.getOrThrow()
        assertEquals("Aloo Bhujia", p.name)
        assertEquals(42f, p.servingSizeGrams, 0f)
        assertTrue(p.fromCatalog)
        assertTrue(p.requiresLabelConfirmation)
        assertFalse(BarcodeUiState(product = p).canLog)
        assertTrue(BarcodeUiState(product = p, labelConfirmed = true).canLog)
        assertFalse(BarcodeUiState(product = p, labelConfirmed = true, isLookingUp = true).canLog)
    }

    @Test fun maggiPreparedBasisCannotBeSilentlyLogged() {
        val error = catalog.lookup("8901058000290")!!.exceptionOrNull()
        assertTrue(error is BarcodeLookupException.LabelReviewRequired)
        assertTrue((error as BarcodeLookupException.LabelReviewRequired).labelUrl.contains("nutrition_en"))
    }

    @Test fun unknownBarcodeFallsThroughRatherThanGuessing() {
        assertNull(catalog.lookup("0000000000000"))
    }

    @Test fun everyIncompleteRecordGoesToLabelReview() {
        val rows = JSONObject(text).getJSONArray("products")
        for (i in 0 until rows.length()) {
            val row = rows.getJSONObject(i)
            val n = row.getJSONObject("nutrition_per_100g_as_recorded")
            if (!row.getString("nutrition_basis").startsWith("as sold") ||
                listOf("kcal", "protein_g", "carbohydrate_g", "fat_g").any { n.isNull(it) }) {
                assertTrue(catalog.lookup(row.getString("barcode"))!!.exceptionOrNull() is BarcodeLookupException.LabelReviewRequired)
            }
        }
    }
}
''',encoding="utf8")
