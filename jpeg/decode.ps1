param(
    [Parameter(Mandatory = $true)]
    [string]$StegoPath,

    [Parameter(Mandatory = $false)]
    [string]$OriginalImagePath,

    [Parameter(Mandatory = $false)]
    [Int64]$ImageSize,

    [Parameter(Mandatory = $true)]
    [string]$OutputZipPath
)

if (-not $ImageSize -and -not $OriginalImagePath) {
    Write-Error "none"
    exit
}

if (-not $ImageSize) {
    try {
        $ImageSize = (Get-Item $OriginalImagePath).Length
    }
    catch {
        Write-Error "none"
        exit
    }
}

try {
    $allBytes = [System.IO.File]::ReadAllBytes($StegoPath)

    if ($allBytes.Length -le $ImageSize) {
        Write-Error "none"
        exit
    }
    $zipBytes = $allBytes[$ImageSize..($allBytes.Length - 1)]

    [System.IO.File]::WriteAllBytes($OutputZipPath, $zipBytes)
    Write-Host "none"
}
catch {
    Write-Error "none"
}