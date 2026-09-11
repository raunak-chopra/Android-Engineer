[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [ValidatePattern('^[A-Za-z][A-Za-z0-9]*$')]
    [string]$Name,

    [Parameter(Mandatory = $true)]
    [ValidatePattern('^[a-z][a-z0-9]*(\.[a-z][a-z0-9]*)+$')]
    [string]$PackageName,

    [ValidateSet('minimal', 'standard', 'modular')]
    [string]$Profile = 'standard',

    [Parameter(Mandatory = $true)]
    [string]$Destination,

    [ValidatePattern('^[0-9A-Za-z][0-9A-Za-z.+-]*$')]
    [string]$AgpVersion = '8.13.2',
    [ValidatePattern('^[0-9A-Za-z][0-9A-Za-z.+-]*$')]
    [string]$KotlinVersion = '2.3.21',
    [ValidatePattern('^[0-9A-Za-z][0-9A-Za-z.+-]*$')]
    [string]$ComposeBomVersion = '2025.08.00',
    [int]$CompileSdk = 36,
    [int]$MinSdk = 23,
    [int]$TargetSdk = 36
)

$ErrorActionPreference = 'Stop'
$resolvedDestination = [System.IO.Path]::GetFullPath($Destination)
$wrapperSource = Join-Path $PSScriptRoot 'wrapper'
$wrapperPaths = @(
    'gradlew',
    'gradlew.bat',
    'gradle\wrapper\gradle-wrapper.jar',
    'gradle\wrapper\gradle-wrapper.properties'
)

if ($MinSdk -lt 1 -or $MinSdk -gt $TargetSdk -or $TargetSdk -gt $CompileSdk) {
    throw "SDK values must satisfy 1 <= MinSdk <= TargetSdk <= CompileSdk. Received $MinSdk <= $TargetSdk <= $CompileSdk."
}
foreach ($relativeWrapperPath in $wrapperPaths) {
    $source = Join-Path $wrapperSource $relativeWrapperPath
    if (-not (Test-Path -LiteralPath $source -PathType Leaf)) {
        throw "Template wrapper asset is missing: $source"
    }
}

if (Test-Path -LiteralPath $resolvedDestination) {
    $existing = @(Get-ChildItem -LiteralPath $resolvedDestination -Force)
    if ($existing.Count -gt 0) {
        throw "Destination must be absent or empty: $resolvedDestination"
    }
} else {
    New-Item -ItemType Directory -Path $resolvedDestination | Out-Null
}

function Write-Utf8File {
    param([string]$RelativePath, [string]$Content)
    $target = Join-Path $resolvedDestination $RelativePath
    $parent = Split-Path -Parent $target
    if (-not (Test-Path -LiteralPath $parent)) {
        New-Item -ItemType Directory -Path $parent -Force | Out-Null
    }
    [System.IO.File]::WriteAllText($target, $Content, [System.Text.UTF8Encoding]::new($false))
}

$packagePath = $PackageName.Replace('.', '/')
$includeBuild = if ($Profile -eq 'modular') { 'pluginManagement { includeBuild("build-logic")' + "`n" } else { 'pluginManagement {' + "`n" }
$moduleIncludes = if ($Profile -eq 'minimal') {
    'include(":app")'
} else {
    'include(":app", ":core:model", ":feature:home")'
}

$settings = @"
$includeBuild    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}

dependencyResolutionManagement {
    repositoriesMode.set(RepositoriesMode.FAIL_ON_PROJECT_REPOS)
    repositories {
        google()
        mavenCentral()
    }
}

rootProject.name = "$Name"
$moduleIncludes
"@

$rootBuild = @'
plugins {
    alias(libs.plugins.android.application) apply false
    alias(libs.plugins.android.library) apply false
    alias(libs.plugins.kotlin.android) apply false
    alias(libs.plugins.kotlin.jvm) apply false
    alias(libs.plugins.kotlin.compose) apply false
}
'@

$catalog = @"
[versions]
agp = "$AgpVersion"
kotlin = "$KotlinVersion"
composeBom = "$ComposeBomVersion"
activityCompose = "1.13.0"
coreKtx = "1.18.0"
lifecycle = "2.10.0"
junit4 = "4.13.2"

[libraries]
androidx-activity-compose = { module = "androidx.activity:activity-compose", version.ref = "activityCompose" }
androidx-core-ktx = { module = "androidx.core:core-ktx", version.ref = "coreKtx" }
androidx-lifecycle-runtime-compose = { module = "androidx.lifecycle:lifecycle-runtime-compose", version.ref = "lifecycle" }
androidx-compose-bom = { module = "androidx.compose:compose-bom", version.ref = "composeBom" }
compose-ui-core = { module = "androidx.compose.ui:ui" }
compose-ui-preview = { module = "androidx.compose.ui:ui-tooling-preview" }
compose-ui-tooling = { module = "androidx.compose.ui:ui-tooling" }
androidx-compose-material3 = { module = "androidx.compose.material3:material3" }
junit4 = { module = "junit:junit", version.ref = "junit4" }

[plugins]
android-application = { id = "com.android.application", version.ref = "agp" }
android-library = { id = "com.android.library", version.ref = "agp" }
kotlin-android = { id = "org.jetbrains.kotlin.android", version.ref = "kotlin" }
kotlin-jvm = { id = "org.jetbrains.kotlin.jvm", version.ref = "kotlin" }
kotlin-compose = { id = "org.jetbrains.kotlin.plugin.compose", version.ref = "kotlin" }
"@

$appPlugins = if ($Profile -eq 'modular') {
@'
plugins {
    id("engineer.android.application")
}
'@
} else {
@"
plugins {
    alias(libs.plugins.android.application)
    alias(libs.plugins.kotlin.android)
    alias(libs.plugins.kotlin.compose)
}

android {
    namespace = "$PackageName"
    compileSdk = $CompileSdk
    defaultConfig {
        applicationId = "$PackageName"
        minSdk = $MinSdk
        targetSdk = $TargetSdk
        versionCode = 1
        versionName = "0.1.0"
    }
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }
}
"@
}

$featureDependency = if ($Profile -eq 'minimal') { '' } else { '    implementation(project(":feature:home"))' }
$appBuild = @"
$appPlugins

dependencies {
$featureDependency
    implementation(libs.androidx.core.ktx)
    implementation(libs.androidx.activity.compose)
    implementation(libs.androidx.lifecycle.runtime.compose)
    implementation(platform(libs.androidx.compose.bom))
    implementation(libs.compose.ui.core)
    implementation(libs.androidx.compose.material3)
    implementation(libs.compose.ui.preview)
    debugImplementation(libs.compose.ui.tooling)
    testImplementation(libs.junit4)
}
"@

$homeImport = if ($Profile -eq 'minimal') { '' } else { "import $PackageName.feature.home.HomeScreen`n" }
$homeBody = if ($Profile -eq 'minimal') {
@'
            Surface(modifier = Modifier.fillMaxSize()) {
                Text(text = stringResource(R.string.welcome), modifier = Modifier.padding(24.dp))
            }
'@
} else {
@'
            HomeScreen()
'@
}

$mainActivity = @"
package $PackageName

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.unit.dp
$homeImport
class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent { EngineerTheme { AppContent() } }
    }
}

@Composable
private fun AppContent() {
$homeBody
}

@Composable
private fun EngineerTheme(content: @Composable () -> Unit) {
    MaterialTheme(content = content)
}
"@

Write-Utf8File 'settings.gradle.kts' $settings
Write-Utf8File 'build.gradle.kts' $rootBuild
Write-Utf8File 'gradle.properties' "org.gradle.jvmargs=-Xmx2g -Dfile.encoding=UTF-8`nandroid.useAndroidX=true`nkotlin.code.style=official`n"
Write-Utf8File 'gradle/libs.versions.toml' $catalog
Write-Utf8File 'local.properties.example' "sdk.dir=C:\\Android`n"
Write-Utf8File 'app/build.gradle.kts' $appBuild
Write-Utf8File 'app/src/main/AndroidManifest.xml' @"
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <application android:label="@string/app_name" android:theme="@style/Theme.EngineerApp">
        <activity android:name=".MainActivity" android:exported="true">
            <intent-filter>
                <action android:name="android.intent.action.MAIN" />
                <category android:name="android.intent.category.LAUNCHER" />
            </intent-filter>
        </activity>
    </application>
</manifest>
"@
Write-Utf8File "app/src/main/kotlin/$packagePath/MainActivity.kt" $mainActivity
Write-Utf8File "app/src/main/kotlin/$packagePath/ProjectIdentity.kt" @"
package $PackageName

internal object ProjectIdentity {
    const val applicationId = "$PackageName"
    const val profile = "$Profile"
}
"@
Write-Utf8File 'app/src/main/res/values/strings.xml' "<resources>`n    <string name=`"app_name`">$Name</string>`n    <string name=`"welcome`">Welcome to $Name</string>`n</resources>`n"
Write-Utf8File 'app/src/main/res/values/themes.xml' "<resources>`n    <style name=`"Theme.EngineerApp`" parent=`"android:style/Theme.Material.Light.NoActionBar`" />`n</resources>`n"
Write-Utf8File "app/src/test/kotlin/$packagePath/ProjectSmokeTest.kt" @"
package $PackageName

import org.junit.Assert.assertEquals
import org.junit.Test

class ProjectSmokeTest {
    @Test fun generatedIdentityMatchesInputs() {
        assertEquals("$PackageName", ProjectIdentity.applicationId)
        assertEquals("$Profile", ProjectIdentity.profile)
    }
}
"@

if ($Profile -ne 'minimal') {
    Write-Utf8File 'core/model/build.gradle.kts' @'
plugins { alias(libs.plugins.kotlin.jvm) }
kotlin { jvmToolchain(17) }
'@
    Write-Utf8File "core/model/src/main/kotlin/$packagePath/core/model/Greeting.kt" @"
package $PackageName.core.model

data class Greeting(val message: String)
"@
    Write-Utf8File 'feature/home/build.gradle.kts' @"
plugins {
    alias(libs.plugins.android.library)
    alias(libs.plugins.kotlin.android)
    alias(libs.plugins.kotlin.compose)
}
android {
    namespace = "$PackageName.feature.home"
    compileSdk = $CompileSdk
    defaultConfig { minSdk = $MinSdk }
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }
}
dependencies {
    implementation(project(":core:model"))
    implementation(platform(libs.androidx.compose.bom))
    implementation(libs.compose.ui.core)
    implementation(libs.androidx.compose.material3)
}
"@
    Write-Utf8File "feature/home/src/main/kotlin/$packagePath/feature/home/HomeScreen.kt" @"
package $PackageName.feature.home

import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import $PackageName.core.model.Greeting

@Composable
fun HomeScreen(modifier: Modifier = Modifier) {
    val greeting = Greeting("Welcome to $Name")
    Column(modifier = modifier.padding(24.dp)) {
        Text(greeting.message)
        Text("Generated with the $Profile profile")
    }
}
"@
}

if ($Profile -eq 'modular') {
    Write-Utf8File 'build-logic/settings.gradle.kts' @'
pluginManagement { repositories { google(); mavenCentral(); gradlePluginPortal() } }
dependencyResolutionManagement { repositories { google(); mavenCentral() } }
'@
    Write-Utf8File 'build-logic/build.gradle.kts' @"
plugins { ``kotlin-dsl`` }
repositories { google(); mavenCentral(); gradlePluginPortal() }
dependencies {
    implementation("com.android.tools.build:gradle:$AgpVersion")
    implementation("org.jetbrains.kotlin:kotlin-gradle-plugin:$KotlinVersion")
}
gradlePlugin {
    plugins {
        register("androidApplication") {
            id = "engineer.android.application"
            implementationClass = "EngineerAndroidApplicationPlugin"
        }
    }
}
"@
    Write-Utf8File 'build-logic/src/main/kotlin/EngineerAndroidApplicationPlugin.kt' @"
import com.android.build.api.dsl.ApplicationExtension
import org.gradle.api.JavaVersion
import org.gradle.api.Plugin
import org.gradle.api.Project
import org.gradle.kotlin.dsl.configure

class EngineerAndroidApplicationPlugin : Plugin<Project> {
    override fun apply(target: Project) = with(target) {
        pluginManager.apply("com.android.application")
        pluginManager.apply("org.jetbrains.kotlin.android")
        pluginManager.apply("org.jetbrains.kotlin.plugin.compose")
        extensions.configure<ApplicationExtension> {
            namespace = "$PackageName"
            compileSdk = $CompileSdk
            defaultConfig {
                applicationId = "$PackageName"
                minSdk = $MinSdk
                targetSdk = $TargetSdk
                versionCode = 1
                versionName = "0.1.0"
            }
            compileOptions {
                sourceCompatibility = JavaVersion.VERSION_17
                targetCompatibility = JavaVersion.VERSION_17
            }
        }
    }
}
"@
}

Write-Utf8File 'ENGINEER_TEMPLATE.json' (@{
    profile = $Profile
    generatedOn = (Get-Date).ToString('yyyy-MM-dd')
    versions = @{ agp = $AgpVersion; kotlin = $KotlinVersion; composeBom = $ComposeBomVersion }
    sdk = @{ compile = $CompileSdk; min = $MinSdk; target = $TargetSdk }
} | ConvertTo-Json -Depth 4)

foreach ($relativeWrapperPath in $wrapperPaths) {
    $source = Join-Path $wrapperSource $relativeWrapperPath
    $target = Join-Path $resolvedDestination $relativeWrapperPath
    $targetParent = Split-Path -Parent $target
    if (-not (Test-Path -LiteralPath $targetParent)) {
        New-Item -ItemType Directory -Path $targetParent -Force | Out-Null
    }
    Copy-Item -LiteralPath $source -Destination $target
}

Write-Output "Generated $Profile Android project at $resolvedDestination"
