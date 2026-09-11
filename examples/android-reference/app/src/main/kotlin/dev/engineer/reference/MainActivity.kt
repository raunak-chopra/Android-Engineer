package dev.engineer.reference

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.material3.MaterialTheme
import androidx.compose.runtime.Composable
import androidx.compose.ui.res.stringResource
import dev.engineer.reference.feature.home.HomeScreen
import dev.engineer.reference.feature.home.HomeUiState

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent { EngineerTheme { AppContent() } }
    }
}

@Composable
private fun AppContent() {
    HomeScreen(
        state = HomeUiState.Success(
            listOf(
                stringResource(R.string.step_inspect),
                stringResource(R.string.step_implement),
                stringResource(R.string.step_verify),
                stringResource(R.string.step_review),
            ),
        ),
        onRetry = {},
    )
}

@Composable
private fun EngineerTheme(content: @Composable () -> Unit) {
    MaterialTheme(content = content)
}
