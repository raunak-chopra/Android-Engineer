package dev.engineer.reference.feature.home

import org.junit.Assert.assertEquals
import org.junit.Assert.assertSame
import org.junit.Test

class HomeStateTest {
    @Test fun nullItemsMeansLoading() {
        assertSame(HomeUiState.Loading, reduceHomeState(items = null, failure = null))
    }

    @Test fun emptyItemsMeansEmpty() {
        assertSame(HomeUiState.Empty, reduceHomeState(items = emptyList(), failure = null))
    }

    @Test fun itemsMeanSuccess() {
        assertEquals(HomeUiState.Success(listOf("one")), reduceHomeState(listOf("one"), null))
    }

    @Test fun failureWinsOverItems() {
        assertEquals(HomeUiState.Error("offline"), reduceHomeState(listOf("cached"), "offline"))
    }
}
