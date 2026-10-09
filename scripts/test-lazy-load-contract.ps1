[CmdletBinding()]
param([string]$Root, [string]$ContractPath = 'evals/lazy/load-contract.json', [string]$ReportPath)

$ErrorActionPreference = 'Stop'

function Get-SafeFile([string]$Relative, [string]$Base) {
    if ([IO.Path]::IsPathRooted($Relative) -or $Relative -match '(^|[\\/])\.\.([\\/]|$)') { throw 'Unsafe relative load path.' }
    $baseFull = [IO.Path]::GetFullPath($Base).TrimEnd([char]'\', [char]'/')
    $full = [IO.Path]::GetFullPath((Join-Path $baseFull $Relative))
    if (-not $full.StartsWith($baseFull + [IO.Path]::DirectorySeparatorChar, [StringComparison]::OrdinalIgnoreCase)) { throw 'Load path escapes its root.' }
    if (-not (Test-Path -LiteralPath $full -PathType Leaf)) { throw "Missing load file: $Relative" }
    $cursor = Get-Item -LiteralPath $full
    while ($null -ne $cursor) {
        if (($cursor.Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0) { throw 'Reparse point in load path.' }
        $parent = Split-Path -Parent $cursor.FullName
        if (-not $parent -or $parent -eq $cursor.FullName) { break }
        $cursor = Get-Item -LiteralPath $parent
    }
    return $full
}

try {
    if ([string]::IsNullOrWhiteSpace($Root)) { $Root = Split-Path -Parent $PSScriptRoot }
    $rootFull = [IO.Path]::GetFullPath($Root)
    $skillBase = Join-Path $rootFull '.codex/skills'
    $cursor = Get-Item -LiteralPath $skillBase
    while ($null -ne $cursor) {
        if (($cursor.Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0) { throw 'Reparse point in skill root.' }
        $parent = Split-Path -Parent $cursor.FullName
        if (-not $parent -or $parent -eq $cursor.FullName) { break }
        $cursor = Get-Item -LiteralPath $parent
    }
    $doc = Get-Content -LiteralPath (Get-SafeFile $ContractPath $rootFull) -Raw | ConvertFrom-Json
    if ($doc.schemaVersion -ne 1 -or $doc.kind -ne 'engineer-lazy-load-contract') { throw 'Unsupported lazy contract.' }
    foreach ($field in @('entrypointMaxBytes','routerMaxBytes','referenceMaxBytes','ordinarySetMaxBytes','routerAndSpecialistMaxBytes')) {
        if ($null -eq $doc.$field -or [int]$doc.$field -lt 1) { throw "Invalid limit: $field" }
    }
    $issues = [Collections.Generic.List[string]]::new()
    $entryMetrics = @()
    $references = @()
    $managed = @($doc.managedSkills)
    if ($managed.Count -eq 0 -or @($managed | Select-Object -Unique).Count -ne $managed.Count) { throw 'Managed skill set is empty or duplicated.' }
    foreach ($name in $managed) {
        if ($name -notmatch '^[a-z0-9]+(?:-[a-z0-9]+)*$') { throw 'Invalid skill name.' }
        $path = Get-SafeFile "$name/SKILL.md" $skillBase
        $text = [IO.File]::ReadAllText($path)
        $bytes = [Text.Encoding]::UTF8.GetByteCount($text)
        $limit = if ($name -eq 'engineering-router') { [int]$doc.routerMaxBytes } else { [int]$doc.entrypointMaxBytes }
        if ($bytes -gt $limit) { $issues.Add("Entrypoint over limit: $name") }
        $entryMetrics += [pscustomobject]@{skill=$name;bytes=$bytes}
        $refDirectory = Join-Path (Split-Path -Parent $path) 'references'
        if (Test-Path -LiteralPath $refDirectory) {
            foreach ($ref in Get-ChildItem -LiteralPath $refDirectory -Recurse -File) {
                $relative = [IO.Path]::GetRelativePath((Split-Path -Parent $path),$ref.FullName).Replace('\','/')
                $safe = Get-SafeFile "$name/$relative" $skillBase
                if ($text.IndexOf("($relative)",[StringComparison]::Ordinal) -lt 0) { $issues.Add("Unrouted reference: $name/$relative") }
                $refBytes = [Text.Encoding]::UTF8.GetByteCount([IO.File]::ReadAllText($safe))
                if ($refBytes -gt [int]$doc.referenceMaxBytes) { $issues.Add("Reference over limit: $name/$relative") }
                $references += [pscustomobject]@{path="$name/$relative";bytes=$refBytes}
            }
        }
    }
    $fixtureMetrics = @()
    $seen = [Collections.Generic.HashSet[string]]::new()
    foreach ($fixture in @($doc.fixtures)) {
        if (-not $seen.Add([string]$fixture.id)) { throw 'Duplicate fixture ID.' }
        $skills = @($fixture.skills)
        $refs = @($fixture.references)
        if (@($skills | Select-Object -Unique).Count -ne $skills.Count -or @($refs | Select-Object -Unique).Count -ne $refs.Count) { throw 'Duplicate requested load.' }
        if (@($skills | Where-Object { $_ -in @('engineering-router','android-router','fullstack-delivery') }).Count -gt 1) { $issues.Add("Stacked coordinators: $($fixture.id)") }
        foreach ($forbidden in @($fixture.forbiddenSkills)) {
            if ($skills -contains $forbidden) { $issues.Add("Forbidden skill loaded: $($fixture.id)") }
        }
        $files = @()
        $bytes = 0
        foreach ($name in $skills) {
            if ($name -notmatch '^[a-z0-9]+(?:-[a-z0-9]+)*$') { throw 'Invalid fixture skill.' }
            $safe = Get-SafeFile "$name/SKILL.md" $skillBase
            $size = [Text.Encoding]::UTF8.GetByteCount([IO.File]::ReadAllText($safe))
            $bytes += $size
            $files += [pscustomobject]@{path="$name/SKILL.md";bytes=$size}
        }
        $entryBytes = $bytes
        if ($skills -contains 'engineering-router' -and $entryBytes -gt [int]$doc.routerAndSpecialistMaxBytes) { $issues.Add("Router set over limit: $($fixture.id)") }
        foreach ($relative in $refs) {
            $parts = ([string]$relative).Replace('\','/').Split('/')
            if ($parts.Count -lt 3 -or $skills -notcontains $parts[0] -or $parts[1] -ne 'references') { throw 'Reference is not owned by a selected skill.' }
            $safe = Get-SafeFile $relative $skillBase
            $size = [Text.Encoding]::UTF8.GetByteCount([IO.File]::ReadAllText($safe))
            $bytes += $size
            $files += [pscustomobject]@{path=$relative;bytes=$size}
        }
        if ($bytes -gt [int]$doc.ordinarySetMaxBytes) { $issues.Add("Loaded set over limit: $($fixture.id)") }
        $fixtureMetrics += [pscustomobject]@{id=$fixture.id;skills=$skills;files=$files;managedBytes=$bytes;externalSkill=$fixture.externalSkill;capabilityGap=$fixture.capabilityGap}
    }
    # These checks measure authored load recipes, not a language model's actual selection or host context.
    $storedBytes = (($entryMetrics | Measure-Object bytes -Sum).Sum + ($references | Measure-Object bytes -Sum).Sum)
    $result = [pscustomobject]@{kind='engineer-lazy-load-measurement';entrypoints=$entryMetrics;references=$references;managedStoredBytes=$storedBytes;fixtures=$fixtureMetrics;issues=@($issues);scope='Declared local load recipes only; external skill/doc cost and host routing are unmeasured.'}
    if ($ReportPath) {
        $reportFull = [IO.Path]::GetFullPath((Join-Path $rootFull $ReportPath))
        $evidenceRoot = [IO.Path]::GetFullPath((Join-Path $rootFull 'docs/evidence')).TrimEnd([char]'\',[char]'/')
        if (-not $reportFull.StartsWith($evidenceRoot + [IO.Path]::DirectorySeparatorChar,[StringComparison]::OrdinalIgnoreCase)) { throw 'Report must remain in docs/evidence.' }
        $reportDirectory = Split-Path -Parent $reportFull
        if (-not (Test-Path -LiteralPath $reportDirectory -PathType Container)) { throw 'Create the evidence directory before writing a report.' }
        $cursor = Get-Item -LiteralPath $reportDirectory
        while ($null -ne $cursor) {
            if (($cursor.Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0) { throw 'Reparse point in report path.' }
            $parent = Split-Path -Parent $cursor.FullName
            if (-not $parent -or $parent -eq $cursor.FullName) { break }
            $cursor = Get-Item -LiteralPath $parent
        }
        if (Test-Path -LiteralPath $reportFull) { throw 'Report already exists; preserve prior evidence.' }
        [IO.File]::WriteAllText($reportFull,($result | ConvertTo-Json -Depth 10) + "`n",[Text.UTF8Encoding]::new($false))
    }
    "Lazy load recipes: $($fixtureMetrics.Count); managed skills: $($entryMetrics.Count); references: $($references.Count)"
    "Largest managed fixture: $(($fixtureMetrics | Measure-Object managedBytes -Maximum).Maximum) bytes; managed stored text: $storedBytes bytes"
    if ($issues.Count -gt 0) { $issues | ForEach-Object { "[FAIL] $_" }; exit 1 }
    'Result: PASS (declared recipes; model routing requires independent evaluation)'
    exit 0
}
catch {
    [Console]::Error.WriteLine("Lazy load contract error: $($_.Exception.Message)")
    exit 1
}
