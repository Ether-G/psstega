param(
    [Parameter(Mandatory = $true)]
    [string]$ImagePath,
    
    [Parameter(Mandatory = $true)]
    [string]$ZipPath,
    
    [Parameter(Mandatory = $true)]
    [string]$OutputPath
)

try {
    $imageBytes = [System.IO.File]::ReadAllBytes($ImagePath)
    $zipBytes   = [System.IO.File]::ReadAllBytes($ZipPath)

    [System.IO.File]::WriteAllBytes($OutputPath, $imageBytes)

    $fs = [System.IO.File]::Open($OutputPath, [System.IO.FileMode]::Append)
    $fs.Write($zipBytes, 0, $zipBytes.Length)
    $fs.Close()

    Write-Host "Successfully embedded '$ZipPath' into '$ImagePath' as '$OutputPath'."
}
catch {
    Write-Error "An error occurred: $_"
}