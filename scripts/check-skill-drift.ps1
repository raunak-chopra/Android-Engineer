[CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Medium")]
param(
    [string]$Root,
    [string]$RegistryPath,
    [string]$LedgerPath,
    [switch]$UpdateLedger,
    [switch]$SkipRemote,
    [switch]$FailOnDrift
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

function Get-RequiredProperty {
    param(
        [Parameter(Mandatory = $true)]$Object,
        [Parameter(Mandatory = $true)][string]$Name,
        [Parameter(Mandatory = $true)][string]$Context
    )

    $property = $Object.PSObject.Properties[$Name]
    if ($null -eq $property -or [string]::IsNullOrWhiteSpace([string]$property.Value)) {
        throw "Missing required '$Name' in $Context."
    }

    return [string]$property.Value
}

function Get-RemoteRef {
    param(
        [Parameter(Mandatory = $true)][string]$Repository,
        [Parameter(Mandatory = $true)][string]$TrackedRef
    )

    if ($null -eq (Get-Command git -ErrorAction SilentlyContinue)) {
        return [pscustomobject]@{
            Status = "unavailable"
            Sha = $null
            Detail = "git was not found on PATH."
        }
    }

    try {
        $output = @(& git ls-remote -- $Repository $TrackedRef 2>&1)
        $exitCode = $LASTEXITCODE
    }
    catch {
        return [pscustomobject]@{
            Status = "unavailable"
            Sha = $null
            Detail = $_.Exception.Message
        }
    }

    $escapedRef = [regex]::Escape($TrackedRef)
    $shaLine = $output | Where-Object { [string]$_ -match "^(?<sha>[0-9a-fA-F]{40})\s+$escapedRef\s*$" } | Select-Object -First 1
    if ($exitCode -ne 0 -or $null -eq $shaLine) {
        $detail = (($output | ForEach-Object { [string]$_ }) -join " ").Trim()
        if ([string]::IsNullOrWhiteSpace($detail)) {
            $detail = "git ls-remote did not return tracked ref '$TrackedRef'."
        }
        return [pscustomobject]@{
            Status = "unavailable"
            Sha = $null
            Detail = $detail
        }
    }

    $null = $shaLine -match "^(?<sha>[0-9a-fA-F]{40})\s+$escapedRef\s*$"
    return [pscustomobject]@{
        Status = "available"
        Sha = $Matches.sha.ToLowerInvariant()
        Detail = "Remote ref '$TrackedRef' resolved successfully."
    }
}

function Set-LedgerProperty {
    param(
        [Parameter(Mandatory = $true)]$Object,
        [Parameter(Mandatory = $true)][string]$Name,
        $Value
    )

    $existing = $Object.PSObject.Properties[$Name]
    if ($null -eq $existing) {
        $Object | Add-Member -MemberType NoteProperty -Name $Name -Value $Value
    }
    else {
        $existing.Value = $Value
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

if ([string]::IsNullOrWhiteSpace($RegistryPath)) {
    $RegistryPath = ".codex\sources\registry.json"
}
if ([string]::IsNullOrWhiteSpace($LedgerPath)) {
    $LedgerPath = ".codex\sources\audit-ledger.json"
}

$registryFullPath = Resolve-FullPath -Path $RegistryPath -Base $rootFullPath
$ledgerFullPath = Resolve-FullPath -Path $LedgerPath -Base $rootFullPath
if (-not (Test-Path -LiteralPath $registryFullPath -PathType Leaf)) {
    throw "Source registry does not exist: $registryFullPath"
}
if (-not (Test-Path -LiteralPath $ledgerFullPath -PathType Leaf)) {
    throw "Audit ledger does not exist: $ledgerFullPath"
}

$registry = Get-Content -LiteralPath $registryFullPath -Raw | ConvertFrom-Json
$ledger = Get-Content -LiteralPath $ledgerFullPath -Raw | ConvertFrom-Json
$sources = @($registry.sources)
if ($sources.Count -eq 0) {
    throw "Source registry contains no sources: $registryFullPath"
}

$results = New-Object System.Collections.Generic.List[object]
foreach ($source in $sources) {
    $sourceId = Get-RequiredProperty -Object $source -Name "id" -Context "registry source"
    $repository = Get-RequiredProperty -Object $source -Name "repository" -Context "source '$sourceId'"
    $auditedSha = Get-RequiredProperty -Object $source -Name "auditedCommit" -Context "source '$sourceId'"
    $trackedRef = Get-RequiredProperty -Object $source -Name "trackedRef" -Context "source '$sourceId'"

    if ($auditedSha -notmatch "^[0-9a-fA-F]{40}$") {
        $results.Add([pscustomobject]@{
            Id = $sourceId
            Repository = $repository
            AuditedSha = $auditedSha
            RemoteSha = $null
            TrackedRef = $trackedRef
            Status = "invalid"
            CheckedAt = [DateTime]::UtcNow.ToString("o")
            Detail = "auditedCommit is not a 40-character hexadecimal commit."
        })
        continue
    }

    if ($SkipRemote) {
        $results.Add([pscustomobject]@{
            Id = $sourceId
            Repository = $repository
            AuditedSha = $auditedSha.ToLowerInvariant()
            RemoteSha = $null
            TrackedRef = $trackedRef
            Status = "skipped"
            CheckedAt = [DateTime]::UtcNow.ToString("o")
            Detail = "Remote lookup skipped by -SkipRemote; no drift conclusion was made."
        })
        continue
    }

    $remote = Get-RemoteRef -Repository $repository -TrackedRef $trackedRef
    $status = $remote.Status
    if ($remote.Status -eq "available") {
        if ($remote.Sha -eq $auditedSha.ToLowerInvariant()) {
            $status = "unchanged"
        }
        else {
            $status = "drift"
        }
    }

    $results.Add([pscustomobject]@{
        Id = $sourceId
        Repository = $repository
        AuditedSha = $auditedSha.ToLowerInvariant()
        RemoteSha = $remote.Sha
        TrackedRef = $trackedRef
        Status = $status
        CheckedAt = [DateTime]::UtcNow.ToString("o")
        Detail = $remote.Detail
    })
}

"Engineer source drift check"
"Registry: $registryFullPath"
"Ledger:   $ledgerFullPath"
"Mode:     $(if ($UpdateLedger) { 'update ledger (explicit)' } else { 'read-only' })"
""
foreach ($result in $results) {
    $remoteSha = if ($null -eq $result.RemoteSha) { "-" } else { $result.RemoteSha }
    "[{0}] {1} audited={2} remote={3} ref={4} :: {5}" -f $result.Status.ToUpperInvariant(), $result.Id, $result.AuditedSha, $remoteSha, $result.TrackedRef, $result.Detail
}

if ($UpdateLedger) {
    if ($PSCmdlet.ShouldProcess($ledgerFullPath, "record source drift check results")) {
        if ($null -eq $ledger.PSObject.Properties["entries"]) {
            $ledger | Add-Member -MemberType NoteProperty -Name "entries" -Value @()
        }
        $entries = @($ledger.entries)
        foreach ($result in $results) {
            $entry = $entries | Where-Object { [string]$_.sourceId -eq $result.Id } | Select-Object -First 1
            if ($null -eq $entry) {
                $entry = [pscustomobject]@{ sourceId = $result.Id }
                $ledger.entries = @($ledger.entries) + $entry
                $entries = @($ledger.entries)
            }

            Set-LedgerProperty -Object $entry -Name "lastCheckedAt" -Value $result.CheckedAt
            Set-LedgerProperty -Object $entry -Name "lastRemoteSha" -Value $result.RemoteSha
            Set-LedgerProperty -Object $entry -Name "lastDriftStatus" -Value $result.Status
            Set-LedgerProperty -Object $entry -Name "lastDriftDetail" -Value $result.Detail
            Set-LedgerProperty -Object $entry -Name "trackedRef" -Value $result.TrackedRef
        }

        Set-LedgerProperty -Object $ledger -Name "lastCheckedAt" -Value ([DateTime]::UtcNow.ToString("o"))
        $json = $ledger | ConvertTo-Json -Depth 20
        $temporaryPath = "$ledgerFullPath.$([Guid]::NewGuid().ToString('N')).tmp"
        $encoding = New-Object -TypeName System.Text.UTF8Encoding -ArgumentList $false
        [System.IO.File]::WriteAllText($temporaryPath, $json + [Environment]::NewLine, $encoding)
        Move-Item -LiteralPath $temporaryPath -Destination $ledgerFullPath -Force
        "Ledger updated: $ledgerFullPath"
    }
    else {
        "Ledger update preview only; no file was changed."
    }
}

$failStatuses = @("drift", "invalid", "unavailable")
$failures = @($results | Where-Object { $failStatuses -contains $_.Status })
if ($FailOnDrift -and $failures.Count -gt 0) {
    Write-Output ("Drift check failed for {0} source(s): {1}" -f $failures.Count, (($failures | ForEach-Object { $_.Id }) -join ", "))
    exit 2
}
