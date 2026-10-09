[CmdletBinding()]
param(
    [string]$Root,
    [string]$ContractsPath = "evals\android\skill-contracts.json"
)

$ErrorActionPreference = "Stop"
function Resolve-FromBase([string]$Path, [string]$Base) {
    if ([System.IO.Path]::IsPathRooted($Path)) { return [System.IO.Path]::GetFullPath($Path) }
    return [System.IO.Path]::GetFullPath((Join-Path $Base $Path))
}
function Has-Concept([string]$Text, $Concept) {
    $any = @($Concept.anyOf | Where-Object { $Text.IndexOf([string]$_, [System.StringComparison]::OrdinalIgnoreCase) -ge 0 })
    if ($any.Count -eq 0) { return $false }
    foreach ($term in @($Concept.allOf)) {
        if ($Text.IndexOf([string]$term, [System.StringComparison]::OrdinalIgnoreCase) -lt 0) { return $false }
    }
    return $true
}

try {
    $scriptDirectory = Split-Path -Parent $MyInvocation.MyCommand.Path
    if ([string]::IsNullOrWhiteSpace($Root)) { $Root = Split-Path -Parent $scriptDirectory }
    $rootPath = Resolve-FromBase $Root (Get-Location).Path
    $contractFile = Resolve-FromBase $ContractsPath $rootPath
    $document = Get-Content -Raw -LiteralPath $contractFile | ConvertFrom-Json
    if ($document.schemaVersion -ne 1 -or $document.kind -ne 'android-skill-contracts') { throw 'Unsupported skill contract schema.' }
    foreach ($rangeName in @('workflowSteps','acceptanceConditions')) {
        $range = $document.common.$rangeName
        if ($null -eq $range -or [int]$range.minimum -lt 1 -or [int]$range.maximum -lt [int]$range.minimum) { throw "Malformed '$rangeName' range." }
    }
    $issues = New-Object System.Collections.Generic.List[string]
    $seen = New-Object 'System.Collections.Generic.HashSet[string]' ([System.StringComparer]::OrdinalIgnoreCase)
    foreach ($contract in @($document.contracts)) {
        $name = [string]$contract.skill
        if (-not $seen.Add($name)) { $issues.Add("Duplicate contract '$name'."); continue }
        $path = Join-Path $rootPath ".codex\skills\$name\SKILL.md"
        if (-not (Test-Path -LiteralPath $path -PathType Leaf)) { $issues.Add("Missing skill '$name'."); continue }
        $text = [System.IO.File]::ReadAllText($path, [System.Text.UTF8Encoding]::new($false))
        foreach ($section in @($document.common.requiredSections)) {
            if ($text -notmatch "(?im)^##\s+$([regex]::Escape([string]$section))\s*$") { $issues.Add("$name lacks section '$section'.") }
        }
        $workflow = [regex]::Match($text, '(?ms)^## Workflow\s*(.*?)^## Acceptance criteria').Groups[1].Value
        $workflowCount = [regex]::Matches($workflow, '(?m)^\d+\.\s').Count
        if ($workflowCount -lt [int]$document.common.workflowSteps.minimum -or $workflowCount -gt [int]$document.common.workflowSteps.maximum) {
            $issues.Add("$name has $workflowCount workflow steps; expected $($document.common.workflowSteps.minimum)-$($document.common.workflowSteps.maximum).")
        }
        $acceptance = [regex]::Match($text, '(?ms)^## Acceptance criteria\s*(.*?)^## Provenance and maintenance').Groups[1].Value
        $acceptanceCount = [regex]::Matches($acceptance, '(?m)^-\s').Count
        if ($acceptanceCount -lt [int]$document.common.acceptanceConditions.minimum -or $acceptanceCount -gt [int]$document.common.acceptanceConditions.maximum) {
            $issues.Add("$name has $acceptanceCount acceptance conditions; expected $($document.common.acceptanceConditions.minimum)-$($document.common.acceptanceConditions.maximum).")
        }
        foreach ($concept in @($document.common.requiredConcepts) + @($contract.requiredConcepts)) {
            if (-not (Has-Concept $text $concept)) { $issues.Add("$name lacks concept '$($concept.id)'.") }
        }
    }
    $skillCount = @(Get-ChildItem (Join-Path $rootPath '.codex\skills') -Directory).Count
    if ($seen.Count -ne $skillCount) { $issues.Add("Contracts cover $($seen.Count) skills but $skillCount skill directories exist.") }
    "Android skill contract evaluation"
    "Contracts: $($seen.Count); skills: $skillCount"
    if ($issues.Count -eq 0) { "Result: PASS"; exit 0 }
    $issues | ForEach-Object { "[FAIL] $_" }
    "Result: FAIL ($($issues.Count) issue(s))"
    exit 1
}
catch {
    [Console]::Error.WriteLine("Skill contract error: $($_.Exception.Message)")
    exit 1
}
