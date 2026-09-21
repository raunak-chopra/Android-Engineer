[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)][string]$Path,
    [ValidateSet("Summary", "Build", "UI", "Data", "Test", "All")][string]$Area = "Summary",
    [ValidateSet("Markdown", "Json")][string]$Format = "Markdown",
    [ValidateRange(1, 100)][int]$MaxItems = 12
)

$ErrorActionPreference = "Stop"
$excludedDirectories = New-Object 'System.Collections.Generic.HashSet[string]' ([System.StringComparer]::OrdinalIgnoreCase)
foreach ($name in @('.git','.gradle','.idea','build','out','generated','node_modules')) { $null = $excludedDirectories.Add($name) }
$allowedExtensions = New-Object 'System.Collections.Generic.HashSet[string]' ([System.StringComparer]::OrdinalIgnoreCase)
foreach ($extension in @('.gradle','.kts','.toml','.properties','.xml','.kt','.java','.yml','.yaml')) { $null = $allowedExtensions.Add($extension) }

function Get-Relative([string]$Root, [string]$File) {
    $rootUri = [uri]((Join-Path $Root '.') + [IO.Path]::DirectorySeparatorChar)
    $fileUri = [uri]$File
    return [uri]::UnescapeDataString($rootUri.MakeRelativeUri($fileUri).ToString())
}

function Get-ProjectFiles([string]$Root) {
    $result = New-Object System.Collections.Generic.List[System.IO.FileInfo]
    $stack = New-Object 'System.Collections.Generic.Stack[string]'
    $stack.Push($Root)
    while ($stack.Count -gt 0) {
        $directory = $stack.Pop()
        try {
            foreach ($child in [IO.Directory]::EnumerateDirectories($directory)) {
                if (-not $excludedDirectories.Contains([IO.Path]::GetFileName($child))) { $stack.Push($child) }
            }
            foreach ($file in [IO.Directory]::EnumerateFiles($directory)) {
                $info = [IO.FileInfo]$file
                if ($allowedExtensions.Contains($info.Extension) -or $info.Name -in @('gradlew','gradlew.bat')) { $result.Add($info) }
            }
        }
        catch [System.UnauthorizedAccessException] { continue }
    }
    return @($result)
}

function Read-Text([System.IO.FileInfo]$File) {
    if ($null -eq $File -or [string]::IsNullOrWhiteSpace($File.FullName)) { return '' }
    if ($File.Length -gt 1048576) { return '' }
    return [IO.File]::ReadAllText($File.FullName, [Text.UTF8Encoding]::new($false))
}

function Evidence-Field([object]$Value, [string[]]$Evidence) {
    [pscustomobject]@{ value = if ($null -eq $Value -or @($Value).Count -eq 0) { 'unknown' } else { $Value }; evidence = @($Evidence | Select-Object -Unique -First $MaxItems) }
}

function Find-Evidence($Files, [string]$Pattern) {
    if ([string]::IsNullOrWhiteSpace($Pattern)) { return @() }
    $evidenceMatches = New-Object System.Collections.Generic.List[string]
    foreach ($file in @($Files)) {
        if ($file -isnot [System.IO.FileInfo]) { continue }
        if ((Read-Text $file) -match $Pattern) { $evidenceMatches.Add((Get-Relative $rootPath $file.FullName)) }
    }
    return @($evidenceMatches | Select-Object -Unique -First $MaxItems)
}

function Render-Field([string]$Label, $Field) {
    $value = if ($Field.value -is [array]) { @($Field.value) -join ', ' } else { [string]$Field.value }
    $evidence = if (@($Field.evidence).Count -gt 0) { " | " + (@($Field.evidence) -join ', ') } else { '' }
    "- **${Label}:** $value$evidence"
}

try {
    $rootPath = [IO.Path]::GetFullPath($Path)
    if (-not (Test-Path -LiteralPath $rootPath -PathType Container)) { throw "Project path does not exist: $rootPath" }
    $files = Get-ProjectFiles $rootPath
    $settings = @($files | Where-Object { $_.Name -in @('settings.gradle','settings.gradle.kts') })
    $buildFiles = @($files | Where-Object { $_.Name -in @('build.gradle','build.gradle.kts') })
    $catalogs = @($files | Where-Object { $_.Name -eq 'libs.versions.toml' })
    $manifests = @($files | Where-Object { $_.Name -eq 'AndroidManifest.xml' })
    $gradleFiles = @($settings + $buildFiles + $catalogs | Sort-Object FullName -Unique)
    $gradleText = ($gradleFiles | ForEach-Object { Read-Text $_ }) -join "`n"
    $isAndroid = $manifests.Count -gt 0 -or $gradleText -match '(?i)(com\.android\.(application|library)|android\s*\{)'

    $modules = New-Object System.Collections.Generic.List[string]
    foreach ($file in $settings) {
        foreach ($match in [regex]::Matches((Read-Text $file), "(?m)^[^/\r\n]*\binclude\s*\(?\s*([^\r\n]+)")) {
            foreach ($quoted in [regex]::Matches($match.Groups[1].Value, '[''"](:[^''"]+)[''"]')) { $modules.Add($quoted.Groups[1].Value) }
        }
    }
    $wrapper = @($files | Where-Object { $_.Name -eq 'gradle-wrapper.properties' } | Select-Object -First 1)
    $wrapperVersion = $null
    if ($wrapper.Count -gt 0 -and (Read-Text $wrapper[0]) -match 'gradle-([0-9][0-9A-Za-z.-]*)-(?:bin|all)\.zip') { $wrapperVersion = $Matches[1] }
    $sdk = @{}
    foreach ($name in @('compileSdk','minSdk','targetSdk')) {
        if ($gradleText -match "(?m)\b$name(?:Version)?\s*(?:=|\s)\s*([0-9]+)") { $sdk[$name] = $Matches[1] }
    }
    $layoutFiles = @($files | Where-Object { (Get-Relative $rootPath $_.FullName) -match '(^|/)src/[^/]+/res/layout[^/]*/.+\.xml$' })
    $testFiles = @($files | Where-Object { (Get-Relative $rootPath $_.FullName) -match '(^|/)src/(test|androidTest)/' })

    $result = [ordered]@{
        kind = 'android-project-inspection'
        root = $rootPath
        androidProject = $isAndroid
        build = [ordered]@{
            settings = Evidence-Field (@($settings | ForEach-Object { Get-Relative $rootPath $_.FullName })) (@($settings | ForEach-Object { Get-Relative $rootPath $_.FullName }))
            gradleWrapper = Evidence-Field $wrapperVersion (@($wrapper | ForEach-Object { Get-Relative $rootPath $_.FullName }))
            versionCatalogs = Evidence-Field (@($catalogs | ForEach-Object { Get-Relative $rootPath $_.FullName })) (@($catalogs | ForEach-Object { Get-Relative $rootPath $_.FullName }))
            modules = Evidence-Field (@($modules | Select-Object -Unique -First $MaxItems)) (@($settings | ForEach-Object { Get-Relative $rootPath $_.FullName }))
            compileSdk = Evidence-Field $sdk.compileSdk (@($buildFiles | ForEach-Object { Get-Relative $rootPath $_.FullName }))
            minSdk = Evidence-Field $sdk.minSdk (@($buildFiles | ForEach-Object { Get-Relative $rootPath $_.FullName }))
            targetSdk = Evidence-Field $sdk.targetSdk (@($buildFiles | ForEach-Object { Get-Relative $rootPath $_.FullName }))
        }
        ui = [ordered]@{
            compose = Evidence-Field ($(if ($gradleText -match '(?i)(androidx\.compose|kotlin\.plugin\.compose|compose\s*=\s*true)') { 'present' } else { 'unknown' })) (Find-Evidence $gradleFiles '(?i)(androidx\.compose|kotlin\.plugin\.compose|compose\s*=\s*true)')
            views = Evidence-Field ($(if ($layoutFiles.Count -gt 0 -or $gradleText -match '(?i)androidx\.appcompat') { 'present' } else { 'unknown' })) (@($layoutFiles | ForEach-Object { Get-Relative $rootPath $_.FullName } | Select-Object -First $MaxItems))
            navigation = Evidence-Field ($(if ((Find-Evidence $files '(?i)(androidx\.navigation|NavHost|NavController)').Count -gt 0) { 'present' } else { 'unknown' })) (Find-Evidence $files '(?i)(androidx\.navigation|NavHost|NavController)')
        }
        data = [ordered]@{
            dependencyInjection = Evidence-Field ($(if ((Find-Evidence $files '(?i)(dagger\.hilt|com\.google\.dagger\.hilt|\bkoin\b)').Count -gt 0) { 'present' } else { 'unknown' })) (Find-Evidence $files '(?i)(dagger\.hilt|com\.google\.dagger\.hilt|\bkoin\b)')
            persistence = Evidence-Field ($(if ((Find-Evidence $files '(?i)(androidx\.room|androidx\.datastore|sqldelight)').Count -gt 0) { 'present' } else { 'unknown' })) (Find-Evidence $files '(?i)(androidx\.room|androidx\.datastore|sqldelight)')
            networking = Evidence-Field ($(if ((Find-Evidence $files '(?i)(retrofit2|io\.ktor|okhttp3)').Count -gt 0) { 'present' } else { 'unknown' })) (Find-Evidence $files '(?i)(retrofit2|io\.ktor|okhttp3)')
        }
        test = [ordered]@{
            sourceFiles = Evidence-Field $testFiles.Count (@($testFiles | ForEach-Object { Get-Relative $rootPath $_.FullName } | Select-Object -First $MaxItems))
            instrumentation = Evidence-Field ($(if (@($testFiles | Where-Object { (Get-Relative $rootPath $_.FullName) -match '/androidTest/' }).Count -gt 0) { 'present' } else { 'unknown' })) (@($testFiles | Where-Object { (Get-Relative $rootPath $_.FullName) -match '/androidTest/' } | ForEach-Object { Get-Relative $rootPath $_.FullName } | Select-Object -First $MaxItems))
            benchmarkOrScreenshot = Evidence-Field ($(if ((Find-Evidence $files '(?i)(macrobenchmark|benchmark|paparazzi|roborazzi|screenshot)').Count -gt 0) { 'present' } else { 'unknown' })) (Find-Evidence $files '(?i)(macrobenchmark|paparazzi|roborazzi|screenshot)')
        }
    }

    if ($Format -eq 'Json') { [pscustomobject]$result | ConvertTo-Json -Depth 8; exit 0 }
    $lines = New-Object System.Collections.Generic.List[string]
    $lines.Add('# Android project inspection')
    $lines.Add('')
    $lines.Add("- **Root:** $rootPath")
    $lines.Add("- **Android project:** $isAndroid")
    $sections = if ($Area -eq 'Summary' -or $Area -eq 'All') { @('build','ui','data','test') } else { @($Area.ToLowerInvariant()) }
    foreach ($section in $sections) {
        $lines.Add(''); $lines.Add("## $($section.Substring(0,1).ToUpperInvariant() + $section.Substring(1))")
        foreach ($property in $result[$section].GetEnumerator()) { $lines.Add((Render-Field $property.Key $property.Value)) }
    }
    $output = $lines -join "`n"
    $bytes = [Text.UTF8Encoding]::new($false).GetByteCount($output)
    if ($Area -eq 'Summary' -and $bytes -gt 4000) { throw "Summary output is $bytes bytes; reduce -MaxItems." }
    $output
    exit 0
}
catch {
    [Console]::Error.WriteLine("Android inspection error: $($_.Exception.Message) $($_.ScriptStackTrace)")
    exit 1
}
