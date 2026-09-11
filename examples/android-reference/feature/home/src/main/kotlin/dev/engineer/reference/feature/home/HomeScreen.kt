package dev.engineer.reference.feature.home

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.Button
import androidx.compose.material3.CircularProgressIndicator
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.unit.dp

sealed interface HomeUiState {
    data object Loading : HomeUiState
    data object Empty : HomeUiState
    data class Success(val items: List<String>) : HomeUiState
    data class Error(val message: String) : HomeUiState
}

fun reduceHomeState(items: List<String>?, failure: String?): HomeUiState = when {
    failure != null -> HomeUiState.Error(failure)
    items == null -> HomeUiState.Loading
    items.isEmpty() -> HomeUiState.Empty
    else -> HomeUiState.Success(items)
}

@Composable
fun HomeScreen(
    state: HomeUiState,
    onRetry: () -> Unit,
    modifier: Modifier = Modifier,
) {
    Column(
        modifier = modifier.padding(24.dp),
        verticalArrangement = Arrangement.spacedBy(12.dp),
    ) {
        Text(stringResource(R.string.engineer_reference_title))
        when (state) {
            HomeUiState.Loading -> CircularProgressIndicator()
            HomeUiState.Empty -> Text(stringResource(R.string.no_app_ideas))
            is HomeUiState.Success -> state.items.forEach { Text(it) }
            is HomeUiState.Error -> {
                Text(state.message)
                Button(onClick = onRetry) { Text(stringResource(R.string.retry)) }
            }
        }
    }
}
