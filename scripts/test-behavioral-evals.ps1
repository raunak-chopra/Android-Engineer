[CmdletBinding()]
param(
    [string]$Root,
    [string]$CasesPath = "evals\android\behavioral-cases.json",
    [string]$ReportPath,
    [ValidateSet("Table", "Json")][string]$Format = "Table",
    [switch]$AllowMissingSkills
)

$ErrorActionPreference = "Stop"

function Resolve-FromBase([string]$Path, [string]$Base) {
    if ([System.IO.Path]::IsPathRooted($Path)) { return [System.IO.Path]::GetFullPath($Path) }
    return [System.IO.Path]::GetFullPath((Join-Path $Base $Path))
}

function Add-Issue([string]$Message) { $script:Issues.Add($Message) }

function Add-ReportIssue([string]$Message) {
    $script:reportMetadataValid = $false
    Add-Issue $Message
}

function Get-Strings($Value) {
    return ,(@($Value | Where-Object { $null -ne $_ -and -not [string]::IsNullOrWhiteSpace([string]$_) } | ForEach-Object { [string]$_ }))
}

function Contains-IgnoreCase($Values, [string]$Expected) {
    return @($Values | Where-Object { [string]::Equals([string]$_, $Expected, [System.StringComparison]::OrdinalIgnoreCase) }).Count -gt 0
}

function Test-ArrayField($Object, [string]$Property, [string]$Label, [switch]$Required) {
    $propertyInfo = $Object.PSObject.Properties[$Property]
    if ($null -eq $propertyInfo) {
        if ($Required) { Add-Issue "$Label must be a JSON array." }
        return $false
    }
    if ($null -eq $propertyInfo.Value -or -not ($propertyInfo.Value -is [array])) {
        Add-Issue "$Label must be a JSON array."
        return $false
    }
    return $true
}

function Test-StringArrayField($Object, [string]$Property, [string]$Label, [switch]$Required) {
    if (-not (Test-ArrayField $Object $Property $Label -Required:$Required)) { return $false }
    foreach ($item in @($Object.PSObject.Properties[$Property].Value)) {
        if ($item -isnot [string] -or [string]::IsNullOrWhiteSpace([string]$item)) {
            Add-Issue "$Label must contain only non-empty strings."
            return $false
        }
    }
    return $true
}

function Test-IntegerField($Object, [string]$Property, [string]$Label, [switch]$Required) {
    $propertyInfo = $Object.PSObject.Properties[$Property]
    if ($null -eq $propertyInfo) {
        if ($Required) { Add-Issue "$Label must be an integer." }
        return $false
    }
    if ($propertyInfo.Value -isnot [int] -and $propertyInfo.Value -isnot [long]) {
        Add-Issue "$Label must be an integer."
        return $false
    }
    return $true
}

function Test-ReportStringField($Object, [string]$Property, [string]$Label, [switch]$Required) {
    $propertyInfo = $Object.PSObject.Properties[$Property]
    if ($null -eq $propertyInfo -or $propertyInfo.Value -isnot [string] -or ($Required -and [string]::IsNullOrWhiteSpace([string]$propertyInfo.Value))) {
        Add-ReportIssue "$Label must be a non-empty string."
        return $false
    }
    return $true
}

function Test-ReportTimestampField($Object, [string]$Property, [string]$Label, [switch]$Required) {
    $propertyInfo = $Object.PSObject.Properties[$Property]
    if ($null -eq $propertyInfo -or $null -eq $propertyInfo.Value) {
        if ($Required) { Add-ReportIssue "$Label must be an ISO-8601 UTC timestamp." }
        return $false
    }
    $value = $propertyInfo.Value
    $text = if ($value -is [DateTime]) {
        if (([DateTime]$value).Kind -eq [DateTimeKind]::Unspecified) {
            Add-ReportIssue "$Label must include an explicit UTC timezone."
            return $false
        }
        ([DateTime]$value).ToUniversalTime().ToString("yyyy-MM-dd'T'HH:mm:ss.fff'Z'")
    }
    elseif ($value -is [DateTimeOffset]) {
        ([DateTimeOffset]$value).ToUniversalTime().ToString("yyyy-MM-dd'T'HH:mm:ss.fff'Z'")
    }
    elseif ($value -is [string]) { [string]$value }
    else { "" }
    if ($text -notmatch "^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}(?:\.\d+)?Z$") {
        Add-ReportIssue "$Label must be an ISO-8601 UTC timestamp."
        return $false
    }
    return $true
}

function Validate-Set($Values, [string]$Label, [System.Collections.Generic.HashSet[string]]$Allowed) {
    foreach ($value in $Values) {
        if (-not $Allowed.Contains($value)) { Add-Issue "$Label references unknown skill '$value'." }
    }
}

$scriptDirectory = Split-Path -Parent $MyInvocation.MyCommand.Path
if ([string]::IsNullOrWhiteSpace($Root)) { $Root = Split-Path -Parent $scriptDirectory }
$rootPath = Resolve-FromBase $Root (Get-Location).Path
$casesFile = Resolve-FromBase $CasesPath $rootPath
if (-not (Test-Path -LiteralPath $casesFile -PathType Leaf)) { throw "Behavioral cases file does not exist: $casesFile" }

$script:Issues = New-Object System.Collections.Generic.List[string]
$document = Get-Content -Raw -LiteralPath $casesFile | ConvertFrom-Json
if (-not (Test-IntegerField $document "schemaVersion" "Behavioral schemaVersion" -Required) -or [int]$document.schemaVersion -ne 1) { Add-Issue "Unsupported behavioral evaluation schemaVersion '$($document.schemaVersion)'." }
if ($document.PSObject.Properties["kind"] -eq $null -or $document.kind -isnot [string] -or [string]$document.kind -ne "android-behavioral-evals") { Add-Issue "Unsupported behavioral evaluation kind '$($document.kind)'." }
if (-not (Test-IntegerField $document "reportSchemaVersion" "Behavioral reportSchemaVersion" -Required) -or [int]$document.reportSchemaVersion -ne 1) { Add-Issue "Unsupported report schema version '$($document.reportSchemaVersion)'." }

$casesProperty = $document.PSObject.Properties["cases"]
if ($null -eq $casesProperty -or -not ($casesProperty.Value -is [array])) { Add-Issue "Behavioral cases must be a JSON array." }

$skillRoot = Join-Path $rootPath ".codex\skills"
$discoveredSkills = New-Object 'System.Collections.Generic.HashSet[string]' ([System.StringComparer]::OrdinalIgnoreCase)
if (Test-Path -LiteralPath $skillRoot -PathType Container) {
    foreach ($directory in Get-ChildItem -LiteralPath $skillRoot -Directory -Force) {
        if (Test-Path -LiteralPath (Join-Path $directory.FullName "SKILL.md") -PathType Leaf) { $null = $discoveredSkills.Add($directory.Name) }
    }
}

$cases = @($document.cases)
if ($cases.Count -eq 0) { Add-Issue "Behavioral cases must contain at least one case." }
$caseById = @{}
foreach ($case in $cases) {
    $id = [string]$case.id
    if ([string]::IsNullOrWhiteSpace($id)) { Add-Issue "A behavioral case is missing id."; continue }
    if ($caseById.ContainsKey($id)) { Add-Issue "Duplicate behavioral case '$id'."; continue }
    $caseById[$id] = $case

    if ([string]::IsNullOrWhiteSpace([string]$case.prompt)) { Add-Issue "Case '$id' has an empty prompt." }
    $expectedValid = Test-StringArrayField $case "expectedSkills" "Case '$id'.expectedSkills" -Required
    $adjacentValid = Test-StringArrayField $case "allowedAdjacentSkills" "Case '$id'.allowedAdjacentSkills"
    $forbiddenValid = Test-StringArrayField $case "forbiddenSkills" "Case '$id'.forbiddenSkills"
    $checksValid = Test-StringArrayField $case "requiredChecks" "Case '$id'.requiredChecks" -Required
    $evidenceValid = Test-StringArrayField $case "requiredEvidence" "Case '$id'.requiredEvidence" -Required
    $expected = if ($expectedValid) { Get-Strings $case.expectedSkills } else { @() }
    $adjacent = if ($adjacentValid) { Get-Strings $case.allowedAdjacentSkills } else { @() }
    $forbidden = if ($forbiddenValid) { Get-Strings $case.forbiddenSkills } else { @() }
    Validate-Set $expected "Case '$id'.expectedSkills" $discoveredSkills
    Validate-Set $adjacent "Case '$id'.allowedAdjacentSkills" $discoveredSkills
    Validate-Set $forbidden "Case '$id'.forbiddenSkills" $discoveredSkills
    if (-not $AllowMissingSkills) {
        foreach ($skill in @($expected + $adjacent + $forbidden)) {
            if ([string]::IsNullOrWhiteSpace($skill)) { continue }
            if (-not $discoveredSkills.Contains($skill)) { Add-Issue "Case '$id' references missing skill '$skill'." }
        }
    }

    if ($expected.Count -gt 0) {
        $primary = [string]$case.expectedPrimarySkill
        if ([string]::IsNullOrWhiteSpace($primary) -or -not (Contains-IgnoreCase $expected $primary)) { Add-Issue "Positive case '$id' must name an expectedPrimarySkill." }
        foreach ($skill in $adjacent) {
            if (-not (Contains-IgnoreCase $expected $skill) -or [string]::Equals($skill, $primary, [System.StringComparison]::OrdinalIgnoreCase)) {
                Add-Issue "Case '$id' allowedAdjacentSkills must be expected non-primary skills."
            }
        }
    }
    elseif (-not [bool]$case.forbidAllPlanned) {
        Add-Issue "Negative case '$id' must set forbidAllPlanned."
    }

    $checks = if ($checksValid) { Get-Strings $case.requiredChecks } else { @() }
    $evidence = if ($evidenceValid) { Get-Strings $case.requiredEvidence } else { @() }
    if ($checks.Count -eq 0) { Add-Issue "Case '$id' must declare requiredChecks." }
    if ($evidence.Count -eq 0) { Add-Issue "Case '$id' must declare requiredEvidence." }
    if (@("none", "bounded") -notcontains [string]$case.changePolicy) { Add-Issue "Case '$id' has invalid changePolicy." }
}

$runCount = 0
$passedCount = 0
$evaluationMode = "corpus-only"
$evidenceStatus = "not-applicable"
if (-not [string]::IsNullOrWhiteSpace($ReportPath)) {
    $evaluationMode = "report-scoring"
    $script:reportMetadataValid = $true
    $reportFile = Resolve-FromBase $ReportPath $rootPath
    if (-not (Test-Path -LiteralPath $reportFile -PathType Leaf)) { throw "Behavioral report does not exist: $reportFile" }
    $reportDocument = Get-Content -Raw -LiteralPath $reportFile | ConvertFrom-Json
    if ($reportDocument.PSObject.Properties["kind"] -eq $null -or $reportDocument.kind -isnot [string] -or [string]$reportDocument.kind -ne "android-behavioral-eval-report") { Add-ReportIssue "Report kind must be 'android-behavioral-eval-report'." }
    if (-not (Test-IntegerField $reportDocument "schemaVersion" "Report schemaVersion" -Required) -or [int]$reportDocument.schemaVersion -ne 1) { Add-ReportIssue "Unsupported behavioral report schema version '$($reportDocument.schemaVersion)'." }
    $exampleOnlyProperty = $reportDocument.PSObject.Properties["exampleOnly"]
    if ($null -ne $exampleOnlyProperty -and $exampleOnlyProperty.Value -isnot [bool]) { Add-ReportIssue "Report exampleOnly must be a JSON boolean." }
    elseif ($null -ne $exampleOnlyProperty -and [bool]$exampleOnlyProperty.Value) { Add-ReportIssue "Example-only reports cannot be scored as run evidence." }
    $provenance = $reportDocument.provenance
    if ($null -eq $provenance) {
        Add-ReportIssue "Report must include provenance metadata."
    }
    else {
        $sourceTypeValid = Test-ReportStringField $provenance "sourceType" "Report provenance sourceType" -Required
        if ($sourceTypeValid -and @("codex-run", "manual", "imported") -notcontains [string]$provenance.sourceType) { Add-ReportIssue "Report provenance sourceType must be codex-run, manual, or imported." }
        $revisionValid = Test-ReportStringField $provenance "repositoryRevision" "Report provenance repositoryRevision" -Required
        if ($revisionValid -and [string]$provenance.repositoryRevision -notmatch "^(working-tree|[0-9a-fA-F]{7,64})$") { Add-ReportIssue "Report provenance repositoryRevision must be a commit SHA or 'working-tree'." }
        $collectedAtValid = Test-ReportTimestampField $provenance "collectedAt" "Report provenance collectedAt" -Required
        $statusValid = Test-ReportStringField $provenance "evidenceStatus" "Report provenance evidenceStatus" -Required
        if ($statusValid -and @("self-reported", "independently-verified") -notcontains [string]$provenance.evidenceStatus) { Add-ReportIssue "Report provenance evidenceStatus must be self-reported or independently-verified." }
        elseif ($statusValid -and [string]$provenance.evidenceStatus -eq "independently-verified") {
            $verification = $provenance.verification
            if ($null -eq $verification) {
                Add-ReportIssue "Independently verified reports must include verification metadata."
                $evidenceStatus = "invalid"
            }
            else {
                $reviewerValid = Test-ReportStringField $verification "reviewer" "Report verification reviewer" -Required
                $reviewedAtValid = Test-ReportTimestampField $verification "reviewedAt" "Report verification reviewedAt" -Required
                $artifactValid = Test-ReportStringField $verification "artifact" "Report verification artifact" -Required
                if ($artifactValid) {
                    $artifact = [string]$verification.artifact
                    $artifactUri = $null
                    $isAbsoluteHttps = [System.Uri]::TryCreate($artifact, [System.UriKind]::Absolute, [ref]$artifactUri) -and [string]::Equals($artifactUri.Scheme, "https", [System.StringComparison]::OrdinalIgnoreCase) -and -not [string]::IsNullOrWhiteSpace($artifactUri.Host)
                    if ($isAbsoluteHttps) {
                        $artifactValid = $true
                    }
                    elseif ([System.IO.Path]::IsPathRooted($artifact) -or $artifact -match "(^|[\\/])\.\.([\\/]|$)") {
                        Add-ReportIssue "Report verification artifact must be an HTTPS URL or a repository-relative path."
                        $artifactValid = $false
                    }
                    elseif (-not (Test-Path -LiteralPath (Resolve-FromBase $artifact $rootPath) -PathType Leaf)) {
                        Add-ReportIssue "Report verification artifact path does not exist: $artifact."
                        $artifactValid = $false
                    }
                }
                if ($reviewerValid -and $reviewedAtValid -and $artifactValid) { $evidenceStatus = "independently-verified-attested" } else { $evidenceStatus = "invalid" }
            }
        }
        elseif ($statusValid) { $evidenceStatus = "self-reported" }
    }
    $runsProperty = $reportDocument.PSObject.Properties["runs"]
    if ($null -eq $runsProperty -or -not ($runsProperty.Value -is [array])) {
        Add-Issue "Report runs must be a JSON array."
        $runs = @()
    }
    else { $runs = @($runsProperty.Value) }
    $seenRuns = New-Object 'System.Collections.Generic.HashSet[string]' ([System.StringComparer]::OrdinalIgnoreCase)
    foreach ($run in $runs) {
        $runCount++
        $id = [string]$run.caseId
        $runIssues = New-Object System.Collections.Generic.List[string]
        if (-not $caseById.ContainsKey($id)) { $runIssues.Add("unknown case '$id'") }
        elseif (-not $seenRuns.Add($id)) { $runIssues.Add("duplicate run") }
        else {
            $case = $caseById[$id]
            $selectedValid = Test-StringArrayField $run "selectedSkills" "Run '$id'.selectedSkills" -Required
            $checksValid = Test-StringArrayField $run "checksRun" "Run '$id'.checksRun" -Required
            $evidenceValid = Test-StringArrayField $run "evidence" "Run '$id'.evidence" -Required
            $changedValid = Test-StringArrayField $run "changedPaths" "Run '$id'.changedPaths"
            $selected = if ($selectedValid) { Get-Strings $run.selectedSkills } else { @() }
            $expected = Get-Strings $case.expectedSkills
            $adjacent = Get-Strings $case.allowedAdjacentSkills
            $forbidden = Get-Strings $case.forbiddenSkills
            if ($expected.Count -gt 0) {
                if ($selected.Count -eq 0 -or -not [string]::Equals($selected[0], [string]$case.expectedPrimarySkill, [System.StringComparison]::OrdinalIgnoreCase)) { $runIssues.Add("primary skill is not first") }
                foreach ($skill in $expected) { if (-not (Contains-IgnoreCase $selected $skill)) { $runIssues.Add("missing expected skill '$skill'") } }
                foreach ($skill in $selected) { if (-not (Contains-IgnoreCase $expected $skill) -and -not (Contains-IgnoreCase $adjacent $skill)) { $runIssues.Add("unapproved extra skill '$skill'") } }
            }
            elseif ($selected.Count -gt 0) { $runIssues.Add("selected a skill for a negative case") }
            foreach ($skill in $forbidden) { if (Contains-IgnoreCase $selected $skill) { $runIssues.Add("forbidden skill '$skill' was selected") } }
            $checksRun = if ($checksValid) { Get-Strings $run.checksRun } else { @() }
            $evidence = if ($evidenceValid) { Get-Strings $run.evidence } else { @() }
            $changedPaths = if ($changedValid) { Get-Strings $run.changedPaths } else { @() }
            foreach ($check in (Get-Strings $case.requiredChecks)) { if (-not (Contains-IgnoreCase $checksRun $check)) { $runIssues.Add("missing check '$check'") } }
            foreach ($evidenceItem in (Get-Strings $case.requiredEvidence)) { if (-not (Contains-IgnoreCase $evidence $evidenceItem)) { $runIssues.Add("missing evidence '$evidenceItem'") } }
            if ([string]$case.changePolicy -eq "none" -and $changedPaths.Count -gt 0) { $runIssues.Add("changed files are not allowed") }
        }
        if ($runIssues.Count -eq 0) { $passedCount++ } else { foreach ($issue in $runIssues) { Add-Issue "Run '$id': $issue." } }
    }
    foreach ($id in $caseById.Keys) { if (-not $seenRuns.Contains($id)) { Add-Issue "Report is missing run for case '$id'." } }
    if (-not $script:reportMetadataValid) { $passedCount = 0 }
}

$result = [pscustomobject]@{
    kind = "android-behavioral-eval-result"
    mode = $evaluationMode
    evidenceStatus = $evidenceStatus
    cases = $cases.Count
    runs = $runCount
    passedRuns = if ($script:Issues.Count -eq 0) { $passedCount } else { 0 }
    scorable = ($script:Issues.Count -eq 0)
    issues = @($script:Issues)
    result = if ($script:Issues.Count -gt 0) { "FAIL" } elseif ($evaluationMode -eq "report-scoring") { "REPORT_PASS" } else { "CORPUS_PASS" }
}
if ($Format -eq "Json") { $result | ConvertTo-Json -Depth 6 }
else {
    "Android behavioral evaluations"
    "Mode: $($result.mode); evidence status: $($result.evidenceStatus)"
    "Cases: $($result.cases); report runs: $($result.runs); passed runs: $($result.passedRuns)"
    if ($script:Issues.Count -eq 0) { "Result: $($result.result)" } else { $script:Issues | ForEach-Object { "[FAIL] $_" }; "Result: FAIL ($($script:Issues.Count) issue(s))" }
}
if ($script:Issues.Count -gt 0) { exit 1 }
