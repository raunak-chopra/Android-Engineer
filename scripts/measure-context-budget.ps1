[CmdletBinding()]
param(
    [string]$Root,
    [string]$BudgetPath = "evals\context-budget.json",
    [switch]$Enforce,
    [ValidateSet("Table", "Json")][string]$Format = "Table"
)

$ErrorActionPreference = "Stop"

function Resolve-FromBase([string]$Path, [string]$Base) {
    if ([System.IO.Path]::IsPathRooted($Path)) { return [System.IO.Path]::GetFullPath($Path) }
    return [System.IO.Path]::GetFullPath((Join-Path $Base $Path))
}

function Get-Metrics([string]$Path) {
    $text = [System.IO.File]::ReadAllText($Path, [System.Text.UTF8Encoding]::new($false))
    $bytes = [System.Text.UTF8Encoding]::new($false).GetByteCount($text)
    [pscustomobject]@{
        bytes = $bytes
        characters = $text.Length
        words = @($text -split '\s+' | Where-Object { $_ }).Count
        lines = @($text -split "`r?`n").Count
        estimatedTokens = [math]::Ceiling($bytes / 4)
    }
}

function Read-Description([string]$Path) {
    $text = [System.IO.File]::ReadAllText($Path, [System.Text.UTF8Encoding]::new($false))
    if ($text -match '(?ms)^---\s*\r?\n.*?^description:\s*(.+?)\r?\n---') { return $Matches[1].Trim() }
    throw "Missing inline description in $Path"
}

function Get-EffectiveLimit([string]$Metric, [string]$Path, [int]$Default, $Exceptions) {
    $match = @($Exceptions | Where-Object { $_.metric -eq $Metric -and ($_.path -eq $Path -or $_.path -eq '*') } | Select-Object -First 1)
    if ($match.Count -eq 0) { return $Default }
    return [int]$match[0].maxValue
}

try {
    $scriptDirectory = Split-Path -Parent $MyInvocation.MyCommand.Path
    if ([string]::IsNullOrWhiteSpace($Root)) { $Root = Split-Path -Parent $scriptDirectory }
    $rootPath = Resolve-FromBase $Root (Get-Location).Path
    $budgetFile = Resolve-FromBase $BudgetPath $rootPath
    if (-not (Test-Path -LiteralPath $budgetFile -PathType Leaf)) { throw "Budget file not found: $budgetFile" }
    $budget = Get-Content -Raw -LiteralPath $budgetFile | ConvertFrom-Json
    if ($budget.schemaVersion -ne 1 -or $budget.kind -ne 'engineer-context-budget') { throw "Unsupported context budget schema." }
    foreach ($field in @('instructions','skillRoot')) {
        if ([string]::IsNullOrWhiteSpace([string]$budget.allowedPaths.$field)) { throw "Missing allowed path '$field'." }
    }
    foreach ($field in @('agentsBytes','skillDescriptionCharacters','skillLibraryBytes','routerPlusLargestSpecialistBytes')) {
        if ($null -eq $budget.baseline.$field -or [double]$budget.baseline.$field -le 0) { throw "Missing or invalid baseline '$field'." }
    }
    foreach ($field in @('agentsBytes','skillDescriptionCharactersEach','skillDescriptionCharactersTotal','routerBytes','specialistBytesEach','skillLibraryBytes','activatedSetBytes','minimumSkillLibraryReductionPercent')) {
        if ($null -eq $budget.ceilings.$field -or [double]$budget.ceilings.$field -le 0) { throw "Missing or invalid ceiling '$field'." }
    }
    if (@($budget.activatedSets).Count -eq 0) { throw 'At least one activated skill set is required.' }

    $agentsPath = Resolve-FromBase ([string]$budget.allowedPaths.instructions) $rootPath
    $skillRoot = Resolve-FromBase ([string]$budget.allowedPaths.skillRoot) $rootPath
    if (-not (Test-Path -LiteralPath $agentsPath -PathType Leaf)) { throw "Instruction file not found: $agentsPath" }
    if (-not (Test-Path -LiteralPath $skillRoot -PathType Container)) { throw "Skill root not found: $skillRoot" }

    $violations = New-Object System.Collections.Generic.List[string]
    $activeExceptions = @()
    $supportedExceptionMetrics = @('agentsBytes','skillDescriptionCharactersEach','skillDescriptionCharactersTotal','routerBytes','specialistBytesEach','skillLibraryBytes','activatedSetBytes')
    foreach ($exception in @($budget.exceptions)) {
        foreach ($field in @('path','metric','maxValue','rationale','expiresOn','reviewRecord')) {
            if ($null -eq $exception.$field -or [string]::IsNullOrWhiteSpace([string]$exception.$field)) { throw "Budget exception is missing '$field'." }
        }
        if ($supportedExceptionMetrics -notcontains [string]$exception.metric) { throw "Unsupported exception metric '$($exception.metric)'." }
        if ([int]$exception.maxValue -lt 1) { throw "Budget exception maxValue must be positive." }
        if ([datetime]$exception.expiresOn -lt [datetime]::Today) { $violations.Add("expired budget exception: $($exception.path) $($exception.metric)") }
        else { $activeExceptions += $exception }
    }
    $agents = Get-Metrics $agentsPath
    $agentsLimit = Get-EffectiveLimit 'agentsBytes' 'AGENTS.md' ([int]$budget.ceilings.agentsBytes) $activeExceptions
    if ($agents.bytes -gt $agentsLimit) { $violations.Add("AGENTS.md bytes $($agents.bytes) > $agentsLimit") }

    $skills = @()
    $descriptionTotal = 0
    $libraryBytes = 0
    foreach ($file in (Get-ChildItem -LiteralPath $skillRoot -Recurse -Filter SKILL.md -File | Sort-Object FullName)) {
        $name = $file.Directory.Name
        $metrics = Get-Metrics $file.FullName
        $description = Read-Description $file.FullName
        $descriptionTotal += $description.Length
        $libraryBytes += $metrics.bytes
        $metric = if ($name -eq 'android-router') { 'routerBytes' } else { 'specialistBytesEach' }
        $defaultLimit = if ($name -eq 'android-router') { [int]$budget.ceilings.routerBytes } else { [int]$budget.ceilings.specialistBytesEach }
        $limit = Get-EffectiveLimit $metric $name $defaultLimit $activeExceptions
        if ($metrics.bytes -gt $limit) { $violations.Add("$name bytes $($metrics.bytes) > $limit") }
        $descriptionLimit = Get-EffectiveLimit 'skillDescriptionCharactersEach' $name ([int]$budget.ceilings.skillDescriptionCharactersEach) $activeExceptions
        if ($description.Length -gt $descriptionLimit) { $violations.Add("$name description characters $($description.Length) > $descriptionLimit") }
        $skills += [pscustomobject]@{ name=$name; descriptionCharacters=$description.Length; metrics=$metrics }
    }
    $descriptionTotalLimit = Get-EffectiveLimit 'skillDescriptionCharactersTotal' '.codex/skills' ([int]$budget.ceilings.skillDescriptionCharactersTotal) $activeExceptions
    $libraryLimit = Get-EffectiveLimit 'skillLibraryBytes' '.codex/skills' ([int]$budget.ceilings.skillLibraryBytes) $activeExceptions
    if ($descriptionTotal -gt $descriptionTotalLimit) { $violations.Add("description characters $descriptionTotal > $descriptionTotalLimit") }
    if ($libraryBytes -gt $libraryLimit) { $violations.Add("skill library bytes $libraryBytes > $libraryLimit") }
    $reduction = [math]::Round((1 - ($libraryBytes / [double]$budget.baseline.skillLibraryBytes)) * 100, 2)
    if ($reduction -lt $budget.ceilings.minimumSkillLibraryReductionPercent) { $violations.Add("skill library reduction $reduction% < $($budget.ceilings.minimumSkillLibraryReductionPercent)%") }

    $skillByName = @{}; foreach ($skill in $skills) { $skillByName[$skill.name] = $skill }
    $sets = @()
    foreach ($set in @($budget.activatedSets)) {
        $names = @($set | ForEach-Object { [string]$_ })
        $missing = @($names | Where-Object { -not $skillByName.ContainsKey($_) })
        if ($missing.Count -gt 0) { throw "Activated set references missing skill(s): $($missing -join ', ')" }
        $bytes = ($names | ForEach-Object { $skillByName[$_].metrics.bytes } | Measure-Object -Sum).Sum
        $setName = $names -join ' + '
        $setLimit = Get-EffectiveLimit 'activatedSetBytes' $setName ([int]$budget.ceilings.activatedSetBytes) $activeExceptions
        if ($bytes -gt $setLimit) { $violations.Add("activated set $setName bytes $bytes > $setLimit") }
        $sets += [pscustomobject]@{ skills=$names; bytes=$bytes; estimatedTokens=[math]::Ceiling($bytes / 4) }
    }

    $result = [pscustomobject]@{
        kind='engineer-context-budget-result'; root=$rootPath; agents=$agents; skillDescriptionCharacters=$descriptionTotal
        skillLibraryBytes=$libraryBytes; skillLibraryReductionPercent=$reduction; skills=$skills; activatedSets=$sets
        tokenEstimate='UTF-8 bytes / 4; estimate only'; violations=@($violations)
    }
    if ($Format -eq 'Json') { $result | ConvertTo-Json -Depth 8 }
    else {
        "Engineer context budget"
        "AGENTS.md: $($agents.bytes) bytes (~$($agents.estimatedTokens) estimated tokens)"
        "Skill descriptions: $descriptionTotal characters"
        "Skill library: $libraryBytes bytes; reduction: $reduction%"
        "Activated sets: $($sets.Count); largest: $(($sets | Measure-Object bytes -Maximum).Maximum) bytes"
        if ($violations.Count -eq 0) { "Result: PASS" } else { $violations | ForEach-Object { "[FAIL] $_" }; "Result: FAIL ($($violations.Count) violation(s))" }
    }
    if ($Enforce -and $violations.Count -gt 0) { exit 1 }
    exit 0
}
catch {
    [Console]::Error.WriteLine("Context budget error: $($_.Exception.Message)")
    exit 1
}
