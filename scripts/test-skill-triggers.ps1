[CmdletBinding()]
param(
    [string]$Root,
    [string]$CasesPath,
    [string]$SkillsPath,
    [switch]$AllowMissingSkills
)

$ErrorActionPreference = "Stop"

function Resolve-FullPath {
    param(
        [Parameter(Mandatory = $true)][string]$Path,
        [Parameter(Mandatory = $true)][string]$Base
    )
    if ([System.IO.Path]::IsPathRooted($Path)) {
        return [System.IO.Path]::GetFullPath($Path)
    }
    return [System.IO.Path]::GetFullPath((Join-Path -Path $Base -ChildPath $Path))
}

function Add-Issue {
    param([Parameter(Mandatory = $true)][string]$Message)
    $script:Issues.Add($Message)
}

function Read-SkillMetadata {
    param([Parameter(Mandatory = $true)][string]$FilePath)

    $lines = (Get-Content -LiteralPath $FilePath -Raw) -split "`r?`n"
    if ($lines.Count -eq 0 -or $lines[0].Trim() -ne "---") { return $null }
    $closing = -1
    for ($index = 1; $index -lt $lines.Count; $index++) {
        if ($lines[$index].Trim() -eq "---") { $closing = $index; break }
    }
    if ($closing -lt 0) { return $null }
    $name = $null
    $description = $null
    for ($index = 1; $index -lt $closing; $index++) {
        if ($lines[$index] -match "^\s*name\s*:\s*(.+?)\s*$") { $name = $Matches[1].Trim() }
        elseif ($lines[$index] -match "^\s*description\s*:\s*(.+?)\s*$") { $description = $Matches[1].Trim() }
    }
    if ([string]::IsNullOrWhiteSpace($name)) { return $null }
    return [pscustomobject]@{
        Name = $name
        Description = if ($null -eq $description) { "" } else { $description }
        Searchable = "$name $description"
        Path = $FilePath
    }
}

function Get-Tokens {
    param([AllowNull()][string]$Text)
    if ([string]::IsNullOrWhiteSpace($Text)) { return @() }
    return @([regex]::Matches($Text.ToLowerInvariant(), "[a-z0-9]+") | ForEach-Object { $_.Value })
}

function Contains-Term {
    param(
        [Parameter(Mandatory = $true)][string]$Text,
        [Parameter(Mandatory = $true)][string]$Term
    )
    if ([string]::IsNullOrWhiteSpace($Term)) { return $false }
    return $Text.IndexOf($Term, [System.StringComparison]::OrdinalIgnoreCase) -ge 0
}

function Get-MeaningfulTokens {
    param([AllowNull()][string]$Text)
    $stopWords = @(
        "a", "an", "and", "android", "are", "as", "at", "be", "before", "by", "code", "create", "for", "from", "in", "into", "is", "it", "kotlin", "mobile", "new", "of", "on", "or", "review", "screen", "state", "test", "testing", "the", "this", "to", "use", "with", "write", "build", "add", "app", "application", "project", "design", "data", "system", "tool", "desktop", "browser", "web", "python", "typescript", "react", "powershell", "csv", "marketing", "presentation", "restaurant", "trip", "svg", "logo", "vector", "server", "fastapi", "sql", "endpoint", "quarterly", "backup", "windows", "edit"
    )
    $stopSet = New-Object 'System.Collections.Generic.HashSet[string]' ([System.StringComparer]::OrdinalIgnoreCase)
    foreach ($word in $stopWords) { $null = $stopSet.Add($word) }
    $tokens = New-Object 'System.Collections.Generic.HashSet[string]' ([System.StringComparer]::OrdinalIgnoreCase)
    foreach ($token in (Get-Tokens -Text $Text)) {
        if ($token.Length -ge 3 -and -not $stopSet.Contains($token)) { $null = $tokens.Add($token) }
    }
    return $tokens
}

function Get-Score {
    param(
        [Parameter(Mandatory = $true)][string]$Prompt,
        [Parameter(Mandatory = $true)][string]$Searchable
    )
    $promptTokens = Get-MeaningfulTokens -Text $Prompt
    $skillTokens = Get-MeaningfulTokens -Text $Searchable
    $score = 0
    foreach ($token in $promptTokens) {
        if ($skillTokens.Contains($token)) { $score++ }
    }
    return $score
}

$scriptDirectory = Split-Path -Parent $MyInvocation.MyCommand.Path
if ([string]::IsNullOrWhiteSpace($Root)) {
    $Root = Split-Path -Parent $scriptDirectory
}
$rootFullPath = Resolve-FullPath -Path $Root -Base (Get-Location).Path
if (-not (Test-Path -LiteralPath $rootFullPath -PathType Container)) {
    throw "Root directory does not exist: $rootFullPath"
}
if ([string]::IsNullOrWhiteSpace($CasesPath)) { $CasesPath = "evals\android\trigger-cases.json" }
if ([string]::IsNullOrWhiteSpace($SkillsPath)) { $SkillsPath = ".codex\skills" }
$casesFullPath = Resolve-FullPath -Path $CasesPath -Base $rootFullPath
$skillsFullPath = Resolve-FullPath -Path $SkillsPath -Base $rootFullPath
if (-not (Test-Path -LiteralPath $casesFullPath -PathType Leaf)) {
    throw "Trigger cases file does not exist: $casesFullPath"
}

$script:Issues = New-Object System.Collections.Generic.List[string]
$casesDocument = Get-Content -LiteralPath $casesFullPath -Raw | ConvertFrom-Json
$plannedSkills = @($casesDocument.plannedSkills | ForEach-Object { [string]$_ })
$cases = @($casesDocument.cases)
if ($plannedSkills.Count -eq 0) { Add-Issue "No plannedSkills were declared in the trigger corpus." }
if ($cases.Count -eq 0) { Add-Issue "No trigger cases were declared in the trigger corpus." }
$plannedSkillSet = New-Object 'System.Collections.Generic.HashSet[string]' ([System.StringComparer]::OrdinalIgnoreCase)
foreach ($plannedSkill in $plannedSkills) {
    if ([string]::IsNullOrWhiteSpace($plannedSkill)) {
        Add-Issue "plannedSkills contains an empty skill name."
    }
    elseif (-not $plannedSkillSet.Add($plannedSkill)) {
        Add-Issue "plannedSkills contains duplicate skill '$plannedSkill'."
    }
}

$metadataByName = @{}
if (Test-Path -LiteralPath $skillsFullPath -PathType Container) {
    foreach ($directory in (Get-ChildItem -LiteralPath $skillsFullPath -Directory -Force)) {
        $skillFile = Join-Path -Path $directory.FullName -ChildPath "SKILL.md"
        if (Test-Path -LiteralPath $skillFile -PathType Leaf) {
            $metadata = Read-SkillMetadata -FilePath $skillFile
            if ($null -ne $metadata) {
                if ($metadataByName.ContainsKey($metadata.Name)) {
                    Add-Issue "Duplicate skill metadata name '$($metadata.Name)'."
                }
                else {
                    $metadataByName[$metadata.Name] = $metadata
                }
            }
        }
    }
}

$missingSkills = @($plannedSkills | Where-Object { -not $metadataByName.ContainsKey($_) })
if ($missingSkills.Count -gt 0 -and -not $AllowMissingSkills) {
    Add-Issue ("Planned skills are missing from {0}: {1}" -f $skillsFullPath, ($missingSkills -join ", "))
}
if ($missingSkills.Count -gt 0 -and $AllowMissingSkills) {
    "Warning: missing skills are allowed for this partial run: $($missingSkills -join ', ')"
}

$seenCaseIds = New-Object 'System.Collections.Generic.HashSet[string]' ([System.StringComparer]::OrdinalIgnoreCase)
$coveredSkills = New-Object 'System.Collections.Generic.HashSet[string]' ([System.StringComparer]::OrdinalIgnoreCase)
$positiveCaseCount = 0
$negativeCaseCount = 0
$evaluatedCaseCount = 0

foreach ($case in $cases) {
    $caseId = [string]$case.id
    $prompt = [string]$case.prompt
    if ([string]::IsNullOrWhiteSpace($caseId)) { Add-Issue "A trigger case is missing id."; continue }
    if (-not $seenCaseIds.Add($caseId)) { Add-Issue "Duplicate trigger case id '$caseId'." }
    if ([string]::IsNullOrWhiteSpace($prompt)) { Add-Issue "Case '$caseId' has an empty prompt."; continue }

    $expected = @($case.expectedSkills | Where-Object { $null -ne $_ -and -not [string]::IsNullOrWhiteSpace([string]$_) } | ForEach-Object { [string]$_ })
    $forbidden = @($case.forbiddenSkills | Where-Object { $null -ne $_ -and -not [string]::IsNullOrWhiteSpace([string]$_) } | ForEach-Object { [string]$_ })
    $allowedAdjacent = @($case.allowedAdjacentSkills | Where-Object { $null -ne $_ -and -not [string]::IsNullOrWhiteSpace([string]$_) } | ForEach-Object { [string]$_ })
    $primarySkill = if ($null -ne $case.primarySkill) { [string]$case.primarySkill } elseif ($expected.Count -gt 0) { $expected[0] } else { "" }
    $minimumLead = if ($null -ne $case.minimumLead) { [int]$case.minimumLead } else { 1 }
    if ([bool]$case.forbidAllPlanned) { $forbidden = $plannedSkills }
    $signals = @($case.signals | Where-Object { $null -ne $_ -and -not [string]::IsNullOrWhiteSpace([string]$_) } | ForEach-Object { [string]$_ })
    $minimumScore = 1
    if ($null -ne $case.minimumScore) { $minimumScore = [int]$case.minimumScore }
    if ($minimumScore -lt 1) { Add-Issue "Case '$caseId' minimumScore must be at least 1."; $minimumScore = 1 }

    if ($expected.Count -gt 0) {
        $positiveCaseCount++
        if ([string]::IsNullOrWhiteSpace($primarySkill) -or $expected -notcontains $primarySkill) {
            Add-Issue "Positive case '$caseId' must name a primarySkill that also appears in expectedSkills."
        }
        if ($minimumLead -lt 1) {
            Add-Issue "Positive case '$caseId' minimumLead must be at least 1."
        }
        foreach ($skillName in $expected) {
            $null = $coveredSkills.Add($skillName)
            if (-not $plannedSkillSet.Contains($skillName)) {
                Add-Issue "Positive case '$caseId' names '$skillName', which is not in plannedSkills."
            }
        }
        if ($signals.Count -eq 0) { Add-Issue "Positive case '$caseId' must declare signals." }
        foreach ($signal in $signals) {
            if (-not (Contains-Term -Text $prompt -Term $signal)) {
                Add-Issue "Case '$caseId' declares signal '$signal' but the prompt does not contain it."
            }
        }
    }
    else {
        $negativeCaseCount++
        if (-not [bool]$case.forbidAllPlanned -and $forbidden.Count -eq 0) {
            Add-Issue "Negative case '$caseId' must set forbidAllPlanned or list forbiddenSkills."
        }
    }
    foreach ($skillName in $forbidden) {
        if (-not $plannedSkillSet.Contains($skillName)) {
            Add-Issue "Case '$caseId' forbids '$skillName', which is not in plannedSkills."
        }
    }

    $availableExpected = @($expected | Where-Object { $metadataByName.ContainsKey($_) })
    $availableForbidden = @($forbidden | Where-Object { $metadataByName.ContainsKey($_) })
    $caseCanEvaluate = ($expected.Count -eq 0 -and $metadataByName.Count -gt 0) -or ($availableExpected.Count -eq $expected.Count)
    if (-not $caseCanEvaluate) { continue }
    $evaluatedCaseCount++

    foreach ($skillName in $expected) {
        if (-not $metadataByName.ContainsKey($skillName)) { continue }
        $metadata = $metadataByName[$skillName]
        $score = Get-Score -Prompt $prompt -Searchable $metadata.Searchable
        if ($score -lt $minimumScore) {
            Add-Issue "Case '$caseId' expected '$skillName' but its score was $score (minimum $minimumScore)."
        }
        if ($signals.Count -gt 0 -and (@($signals | Where-Object { Contains-Term -Text $metadata.Searchable -Term $_ }).Count -eq 0)) {
            Add-Issue "Case '$caseId' has no declared signal in '$skillName' metadata."
        }
    }

    foreach ($skillName in $availableForbidden) {
        $metadata = $metadataByName[$skillName]
        $score = Get-Score -Prompt $prompt -Searchable $metadata.Searchable
        if ($score -ge $minimumScore) {
            Add-Issue "Case '$caseId' forbids '$skillName' but its score was $score (minimum allowed $($minimumScore - 1))."
        }
    }

    if ($expected.Count -gt 0 -and $metadataByName.ContainsKey($primarySkill)) {
        $primaryScore = Get-Score -Prompt $prompt -Searchable $metadataByName[$primarySkill].Searchable
        foreach ($candidateName in $metadataByName.Keys) {
            if ($candidateName -eq $primarySkill -or $allowedAdjacent -contains $candidateName) { continue }
            $candidateScore = Get-Score -Prompt $prompt -Searchable $metadataByName[$candidateName].Searchable
            if (($primaryScore - $candidateScore) -lt $minimumLead) {
                Add-Issue "Case '$caseId' primary '$primarySkill' scored $primaryScore, not $minimumLead point(s) above '$candidateName' at $candidateScore."
            }
        }
    }
}

foreach ($skillName in $plannedSkills) {
    if (-not $coveredSkills.Contains($skillName)) {
        Add-Issue "Planned skill '$skillName' has no positive trigger case."
    }
}
if ($positiveCaseCount -eq 0) { Add-Issue "Trigger corpus has no positive cases." }
if ($negativeCaseCount -eq 0) { Add-Issue "Trigger corpus has no negative cases." }

"Android skill trigger evaluation"
"Cases: $($cases.Count); evaluated: $evaluatedCaseCount; positive: $positiveCaseCount; negative: $negativeCaseCount"
"Skills discovered: $($metadataByName.Count); planned: $($plannedSkills.Count)"
if ($AllowMissingSkills -and $missingSkills.Count -gt 0) {
    "Mode: partial (missing skill files are permitted)"
}
else {
    "Mode: strict"
}
""
if ($Issues.Count -eq 0) {
    "Result: PASS"
    exit 0
}
foreach ($issue in $Issues) { "[FAIL] $issue" }
"Result: FAIL ($($Issues.Count) issue(s))"
exit 1
