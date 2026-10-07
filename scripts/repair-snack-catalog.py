from pathlib import Path
b=Path(r"C:\Users\rauna\Desktop\Projects\Meal-Tracking-App/app/src/main/java/com/kalotracker/app")
p=b/"core/network/OpenFoodFactsService.kt";s=p.read_text(encoding="utf8");s=s.replace("            val cached =", "            // Known starter records keep their preparation/confirmation rules on every path.\n            val local = catalog?.lookup(cleaned)\n            if (local != null) return@withContext local\n            val cached =",1);s=s.replace("            val local = catalog?.lookup(cleaned)\n            if (local != null && !refresh) return@withContext local\n","");s=s.replace("return@withContext local ?: Result.failure(it)","return@withContext Result.failure(it)").replace("404 -> local ?: Result.failure", "404 -> Result.failure").replace("else -> local ?: Result.failure", "else -> Result.failure").replace("local ?: if (cached != null)","if (cached != null)");p.write_text(s,encoding="utf8")
p=b/"feature/barcode/BarcodeScannerViewModel.kt";s=p.read_text(encoding="utf8");s=s.replace("val barcode = _uiState.value.product?.barcode ?: return","val product = _uiState.value.product ?: return\n        if (product.fromCatalog) return\n        val barcode = product.barcode");p.write_text(s,encoding="utf8")
p=b/"feature/barcode/BarcodeScannerScreen.kt";s=p.read_text(encoding="utf8");s=s.replace('TextButton(onClick = onRefresh, enabled = !isSaving) { Text("Refresh label data") }','if (!product.fromCatalog) TextButton(onClick = onRefresh, enabled = !isSaving) { Text("Refresh label data") }');p.write_text(s,encoding="utf8")
p=Path(r"C:\Users\rauna\Desktop\Projects\Meal-Tracking-App/app/src/test/java/com/kalotracker/app/core/network/IndianSnackCatalogTest.kt");s=p.read_text(encoding="utf8");s=s.replace("    @Test fun unknownBarcode",'''    @Test fun refreshKeepsPreparedAndConfirmationRules() = kotlinx.coroutines.test.runTest {
        val service = OpenFoodFactsService(catalogLoader = { catalog })
        assertTrue(service.getProductByBarcode("8901058000290", refresh = true).exceptionOrNull() is BarcodeLookupException.LabelReviewRequired)
        assertTrue(service.getProductByBarcode("8904004400694", refresh = true).getOrThrow().requiresLabelConfirmation)
    }

    @Test fun unknownBarcode''');p.write_text(s,encoding="utf8")
