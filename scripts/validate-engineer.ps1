[CmdletBinding()]
param(
    [string]$Root,
    [switch]$RequireSkills
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
    param(
        [Parameter(Mandatory = $true)][ValidateSet("Blocking", "Important", "Minor")][string]$Severity,
        [Parameter(Mandatory = $true)][string]$Path,
        [Parameter(Mandatory = $true)][string]$Message
    )

    $script:Issues.Add([pscustomobject]@{
        Severity = $Severity
        Path = $Path
        Message = $Message
    })
}

function Get-RelativePath {
    param(
        [Parameter(Mandatory = $true)][string]$Base,
        [Parameter(Mandatory = $true)][string]$Path
    )

    $baseUri = [System.Uri]((Join-Path -Path $Base -ChildPath ".") + [System.IO.Path]::DirectorySeparatorChar)
    $pathUri = [System.Uri]$Path
    return [System.Uri]::UnescapeDataString($baseUri.MakeRelativeUri($pathUri).ToString()).Replace("/", [System.IO.Path]::DirectorySeparatorChar)
}

function Get-TextFiles {
    param([Parameter(Mandatory = $true)][string]$Directory)

    if (-not (Test-Path -LiteralPath $Directory -PathType Container)) {
        return @()
    }

    $binaryExtensions = @(".png", ".jpg", ".jpeg", ".gif", ".webp", ".ico", ".pdf", ".zip", ".gz", ".tar", ".dll", ".exe", ".bin", ".keystore", ".jks")
    return @(Get-ChildItem -LiteralPath $Directory -Recurse -File -Force | Where-Object {
        $binaryExtensions -notcontains $_.Extension.ToLowerInvariant() -and $_.Length -lt 1048576
    })
}

function Test-InternalLink {
    param(
        [Parameter(Mandatory = $true)][string]$SourceFile,
        [Parameter(Mandatory = $true)][string]$Target
    )

    $cleanTarget = $Target.Trim().Trim("<", ">", "'", '"')
    if ([string]::IsNullOrWhiteSpace($cleanTarget)) { return $true }
    if ($cleanTarget -match "^(?i)(https?|mailto|data):") { return $true }
    if ($cleanTarget.StartsWith("#")) { return $true }

    $cleanTarget = ($cleanTarget -split "[?#]", 2)[0]
    if ([string]::IsNullOrWhiteSpace($cleanTarget)) { return $true }
    $cleanTarget = [System.Uri]::UnescapeDataString($cleanTarget).Replace("/", [System.IO.Path]::DirectorySeparatorChar)
    $candidate = if ([System.IO.Path]::IsPathRooted($cleanTarget)) {
        [System.IO.Path]::GetFullPath($cleanTarget)
    }
    else {
        [System.IO.Path]::GetFullPath((Join-Path -Path (Split-Path -Parent $SourceFile) -ChildPath $cleanTarget))
    }

    return (Test-Path -LiteralPath $candidate)
}

function Read-SkillFrontmatter {
    param(
        [Parameter(Mandatory = $true)][string]$FilePath,
        [Parameter(Mandatory = $true)][string]$RootPath
    )

    $relative = Get-RelativePath -Base $RootPath -Path $FilePath
    $lines = (Get-Content -LiteralPath $FilePath -Raw) -split "`r?`n"
    if ($lines.Count -eq 0 -or $lines[0].Trim() -ne "---") {
        Add-Issue -Severity "Blocking" -Path $relative -Message "SKILL.md must begin with YAML frontmatter delimited by ---."
        return $null
    }

    $closingIndex = -1
    for ($index = 1; $index -lt $lines.Count; $index++) {
        if ($lines[$index].Trim() -eq "---") {
            $closingIndex = $index
            break
        }
    }
    if ($closingIndex -lt 0) {
        Add-Issue -Severity "Blocking" -Path $relative -Message "SKILL.md frontmatter has no closing --- delimiter."
        return $null
    }

    $fields = @{}
    for ($index = 1; $index -lt $closingIndex; $index++) {
        $line = $lines[$index]
        if ([string]::IsNullOrWhiteSpace($line) -or $line.TrimStart().StartsWith("#")) { continue }
        if ($line -match "^\s*([A-Za-z][A-Za-z0-9_-]*)\s*:\s*(.*)$") {
            $name = $Matches[1]
            if ($fields.ContainsKey($name)) {
                Add-Issue -Severity "Blocking" -Path $relative -Message "Frontmatter field '$name' is duplicated."
            }
            $fields[$name] = $Matches[2].Trim()
        }
        elseif ($line -match "^\s+") {
            continue
        }
        else {
            Add-Issue -Severity "Blocking" -Path $relative -Message "Frontmatter line $($index + 1) is not a simple YAML field."
        }
    }

    foreach ($required in @("name", "description")) {
        if (-not $fields.ContainsKey($required) -or [string]::IsNullOrWhiteSpace([string]$fields[$required])) {
            Add-Issue -Severity "Blocking" -Path $relative -Message "Frontmatter requires a non-empty '$required' field."
        }
    }
    foreach ($field in $fields.Keys) {
        if (@("name", "description") -notcontains $field) {
            Add-Issue -Severity "Important" -Path $relative -Message "Frontmatter field '$field' is not allowed; only name and description are supported."
        }
    }

    if ($fields.ContainsKey("name") -and [string]$fields.name -notmatch "^[a-z0-9][a-z0-9-]*$") {
        Add-Issue -Severity "Important" -Path $relative -Message "Skill name '$($fields.name)' must use lowercase letters, numbers, and hyphens."
    }
    if ($fields.ContainsKey("description") -and [string]$fields.description -match "^(\||\>|\|-|\>-)\s*$") {
        Add-Issue -Severity "Important" -Path $relative -Message "Description uses a YAML block marker without inline text; keep the trigger description directly readable."
    }

    return [pscustomobject]@{
        Name = [string]$fields.name
        Description = [string]$fields.description
        RelativePath = $relative
        Directory = (Split-Path -Parent $FilePath)
    }
}

$scriptDirectory = Split-Path -Parent $MyInvocation.MyCommand.Path
if ([string]::IsNullOrWhiteSpace($Root)) {
    $Root = Split-Path -Parent $scriptDirectory
}
$rootFullPath = Resolve-FullPath -Path $Root -Base (Get-Location).Path
if (-not (Test-Path -LiteralPath $rootFullPath -PathType Container)) {
    throw "Root directory does not exist: $rootFullPath"
}

$script:Issues = New-Object System.Collections.Generic.List[object]
$skillRoot = Join-Path -Path $rootFullPath -ChildPath ".codex\skills"
$sourceRoot = Join-Path -Path $rootFullPath -ChildPath ".codex"
$evalRoot = Join-Path -Path $rootFullPath -ChildPath "evals"
$skillFiles = @()
if (Test-Path -LiteralPath $skillRoot -PathType Container) {
    $skillFiles = @(Get-ChildItem -LiteralPath $skillRoot -Recurse -File -Force | Where-Object { $_.Name -eq "SKILL.md" })
    if ($RequireSkills -and $skillFiles.Count -eq 0) {
        Add-Issue -Severity "Blocking" -Path ".codex\skills" -Message "Skill directory contains no SKILL.md files and -RequireSkills was supplied."
    }
}
elseif ($RequireSkills) {
    Add-Issue -Severity "Blocking" -Path ".codex\skills" -Message "Skill directory is missing and -RequireSkills was supplied."
}
else {
    "Warning: no .codex\skills directory found; skill validation is partial until the library is authored."
}

$skillNames = @{}
foreach ($skillFile in $skillFiles) {
    $metadata = Read-SkillFrontmatter -FilePath $skillFile.FullName -RootPath $rootFullPath
    if ($null -eq $metadata) { continue }
    if ($skillNames.ContainsKey($metadata.Name)) {
        Add-Issue -Severity "Blocking" -Path $metadata.RelativePath -Message "Duplicate skill name '$($metadata.Name)' also appears at $($skillNames[$metadata.Name])."
    }
    else {
        $skillNames[$metadata.Name] = $metadata.RelativePath
    }
    if ((Split-Path -Leaf $metadata.Directory) -ne $metadata.Name) {
        Add-Issue -Severity "Important" -Path $metadata.RelativePath -Message "Skill directory '$((Split-Path -Leaf $metadata.Directory))' must match frontmatter name '$($metadata.Name)'."
    }
}

$excludedPathPattern = '(?i)[\\/](?:\.git|\.gradle|build)[\\/]'
$repositoryTextFiles = @(Get-TextFiles -Directory $rootFullPath | Where-Object {
    $_.FullName -notmatch $excludedPathPattern
})
$markdownFiles = @($repositoryTextFiles | Where-Object { $_.Extension.ToLowerInvariant() -eq ".md" })
$linkPattern = [regex]'(?<!!)\[[^\]]*\]\((?<target>[^)\s]+)'
foreach ($markdownFile in $markdownFiles) {
    $relative = Get-RelativePath -Base $rootFullPath -Path $markdownFile.FullName
    $inFence = $false
    $lineNumber = 0
    foreach ($line in (Get-Content -LiteralPath $markdownFile.FullName)) {
        $lineNumber++
        if ($line -match '^\s*```') {
            $inFence = -not $inFence
            continue
        }
        if ($inFence) { continue }
        foreach ($match in $linkPattern.Matches($line)) {
            $target = [string]($match.Groups.Get_Item("target").Value)
            if (-not (Test-InternalLink -SourceFile $markdownFile.FullName -Target $target)) {
                Add-Issue -Severity "Blocking" -Path $relative -Message "Line $lineNumber links to a missing local target '$target'."
            }
        }
    }
}

$jsonFiles = @($repositoryTextFiles | Where-Object { $_.Extension.ToLowerInvariant() -eq ".json" })
$jsonDocuments = @{}
foreach ($jsonFile in $jsonFiles) {
    $relative = Get-RelativePath -Base $rootFullPath -Path $jsonFile.FullName
    try {
        $jsonDocuments[$relative] = Get-Content -LiteralPath $jsonFile.FullName -Raw | ConvertFrom-Json
    }
    catch {
        Add-Issue -Severity "Blocking" -Path $relative -Message "Invalid JSON: $($_.Exception.Message)"
    }
}

$registryRelative = (Join-Path -Path ".codex\sources" -ChildPath "registry.json")
$ledgerRelative = (Join-Path -Path ".codex\sources" -ChildPath "audit-ledger.json")
if ($jsonDocuments.ContainsKey($registryRelative) -and $jsonDocuments.ContainsKey($ledgerRelative)) {
    $registryDocument = $jsonDocuments[$registryRelative]
    $ledgerDocument = $jsonDocuments[$ledgerRelative]
    $registrySources = @($registryDocument.sources)
    $ledgerEntries = @($ledgerDocument.entries)
    if ($registrySources.Count -ne $ledgerEntries.Count) {
        Add-Issue -Severity "Blocking" -Path $registryRelative -Message "Registry source count ($($registrySources.Count)) does not match ledger entry count ($($ledgerEntries.Count))."
    }
    foreach ($source in $registrySources) {
        $sourceId = [string]$source.id
        $entry = $ledgerEntries | Where-Object { [string]$_.sourceId -eq $sourceId } | Select-Object -First 1
        if ($null -eq $entry) {
            Add-Issue -Severity "Blocking" -Path $ledgerRelative -Message "Ledger has no entry for registry source '$sourceId'."
            continue
        }
        if ([string]$entry.repository -ne [string]$source.repository) {
            Add-Issue -Severity "Blocking" -Path $ledgerRelative -Message "Repository mismatch for source '$sourceId'."
        }
        if ([string]$entry.auditedCommit -ne [string]$source.auditedCommit) {
            Add-Issue -Severity "Blocking" -Path $ledgerRelative -Message "Audited commit mismatch for source '$sourceId'."
        }
        if ([string]$entry.auditDate -ne [string]$source.auditDate) {
            Add-Issue -Severity "Blocking" -Path $ledgerRelative -Message "Audit date mismatch for source '$sourceId'."
        }
    }
}

$placeholderPattern = "(?i)(?<![A-Za-z])(?:REPLACE_ME|CHANGEME|TBD|FIXME|TODO)\b|<YOUR_[A-Z0-9_]+>|example\.com|/path/to/"
$placeholderRoots = @($sourceRoot, $evalRoot)
foreach ($placeholderRoot in $placeholderRoots) {
    foreach ($file in (Get-TextFiles -Directory $placeholderRoot)) {
        $relative = Get-RelativePath -Base $rootFullPath -Path $file.FullName
        try {
            $content = Get-Content -LiteralPath $file.FullName -Raw
            $match = [regex]::Match($content, $placeholderPattern)
            if ($match.Success) {
                Add-Issue -Severity "Important" -Path $relative -Message "Placeholder token '$($match.Value)' is present; replace it or document an explicit example exception."
            }
        }
        catch {
            Add-Issue -Severity "Minor" -Path $relative -Message "Could not read text for placeholder validation: $($_.Exception.Message)"
        }
    }
}

"Engineer library validation"
"Root: $rootFullPath"
"Skills found: $($skillFiles.Count)"
"Markdown files checked: $($markdownFiles.Count)"
"JSON files checked: $($jsonFiles.Count)"
""
if ($Issues.Count -eq 0) {
    "Result: PASS"
    exit 0
}

foreach ($issue in $Issues) {
    "[{0}] {1}: {2}" -f $issue.Severity.ToUpperInvariant(), $issue.Path, $issue.Message
}
"Result: FAIL ($($Issues.Count) issue(s))"
exit 1
