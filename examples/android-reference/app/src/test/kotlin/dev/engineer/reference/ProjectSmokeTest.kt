package dev.engineer.reference

import org.junit.Assert.assertEquals
import org.junit.Test

class ProjectSmokeTest {
    @Test fun generatedIdentityMatchesInputs() {
        assertEquals("dev.engineer.reference", ProjectIdentity.applicationId)
        assertEquals("standard", ProjectIdentity.profile)
    }
}
