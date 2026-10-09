[CmdletBinding()]
param([string]$Root)
$ErrorActionPreference = 'Stop'
if (-not $Root) { $Root = Split-Path -Parent $PSScriptRoot }
$rootFull = [IO.Path]::GetFullPath($Root)
if (-not (Test-Path -LiteralPath $rootFull -PathType Container)) { throw 'Root must be an existing directory.' }
function Assert-SafeEvidencePath([string]$Path) {
    $full = [IO.Path]::GetFullPath($Path)
    $prefix = $rootFull.TrimEnd([char]'\',[char]'/') + [IO.Path]::DirectorySeparatorChar
    if (-not $full.StartsWith($prefix,[StringComparison]::OrdinalIgnoreCase)) { throw 'Safety evidence escapes root.' }
    $cursor = $full
    while ($cursor) {
        if (Test-Path -LiteralPath $cursor) {
            $item = Get-Item -LiteralPath $cursor
            if (($item.Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0) { throw 'Reparse point in safety evidence path.' }
        }
        $parent = Split-Path -Parent $cursor
        if (-not $parent -or $parent -eq $cursor) { break }
        $cursor = $parent
    }
}
function Write-NewEvidence([string]$Path, [string]$Text) {
    Assert-SafeEvidencePath $Path
    if (Test-Path -LiteralPath $Path) { throw 'Preserve existing safety evidence.' }
    [IO.File]::WriteAllText($Path,$Text,[Text.UTF8Encoding]::new($false))
}
$hostExe = (Get-Process -Id $PID).Path
$helper = Join-Path $rootFull 'scripts/test-lazy-load-contract.ps1'
$baseline = Get-Content (Join-Path $rootFull 'evals/lazy/load-contract.json') -Raw
$runId = [Guid]::NewGuid().ToString('N')
$relativeDirectory = "docs/evidence/lazy-implementation-2026-10-07/safety-$runId"
$directory = Join-Path $rootFull $relativeDirectory
Assert-SafeEvidencePath $directory
New-Item -ItemType Directory -Path $directory -Force | Out-Null
Assert-SafeEvidencePath $directory
$results = [Collections.Generic.List[object]]::new()

function Assert-Rejected([string]$Name, [string[]]$Arguments) {
    $output = & $hostExe -NoProfile -File $helper -Root $rootFull @Arguments 2>&1
    if ($LASTEXITCODE -eq 0) { throw "Safety regression accepted: $Name" }
    $script:results.Add([pscustomobject]@{case=$Name;outcome='rejected';diagnostic=(@($output | Select-Object -Last 1) -join ' ')})
}

Assert-Rejected 'contract traversal' @('-ContractPath','../AGENTS.md')
Assert-Rejected 'report escape' @('-ReportPath','outside-lazy-report.json')
$mutations = @(
    @{name='stacked coordinators';change={param($doc) $doc.fixtures[0].skills=@('engineering-router','fullstack-delivery')}},
    @{name='duplicate load';change={param($doc) $doc.fixtures[0].skills=@('web-frontend','web-frontend')}},
    @{name='foreign reference';change={param($doc) $doc.fixtures[0].references=@('database-engineering/references/evolution.md')}},
    @{name='reference traversal';change={param($doc) $doc.fixtures[0].references=@('web-frontend/references/../../application-security/SKILL.md')}},
    @{name='over-budget context';change={param($doc) $doc.ordinarySetMaxBytes=1}},
    @{name='forbidden specialist';change={param($doc) $doc.fixtures[0].forbiddenSkills=@('web-frontend')}}
)
foreach ($mutation in $mutations) {
    $doc = $baseline | ConvertFrom-Json
    & $mutation.change $doc
    $relative = "$relativeDirectory/$($mutation.name.Replace(' ','-')).json"
    Write-NewEvidence (Join-Path $rootFull $relative) ($doc | ConvertTo-Json -Depth 12)
    Assert-Rejected $mutation.name @('-ContractPath',$relative)
}
$sentinelRelative = "$relativeDirectory/preserve.json"
$sentinelPath = Join-Path $rootFull $sentinelRelative
$sentinelText = '{"preserved":true}'
Write-NewEvidence $sentinelPath $sentinelText
Assert-Rejected 'existing report' @('-ReportPath',$sentinelRelative)
if ([IO.File]::ReadAllText($sentinelPath) -ne $sentinelText) { throw 'Existing report was overwritten.' }
Write-NewEvidence (Join-Path $directory 'results.json') ($results | ConvertTo-Json -Depth 4)
"PASS: $($results.Count) safety regressions; isolated mutation evidence: $relativeDirectory"
