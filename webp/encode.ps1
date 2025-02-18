param(
    [Parameter(Mandatory=$true)]
    [string]$ImagePath,
    
    [Parameter(Mandatory=$true)]
    [string]$ZipPath,
    
    [Parameter(Mandatory=$true)]
    [string]$OutputPath
)

try {
    $webpBytes = [System.IO.File]::ReadAllBytes($ImagePath)
    $zipBytes = [System.IO.File]::ReadAllBytes($ZipPath)
    $chunkId = [System.Text.Encoding]::ASCII.GetBytes("stEG")
    $zipLength = $zipBytes.Length
    $chunkSizeBytes = [System.BitConverter]::GetBytes($zipLength)
    if ($zipLength % 2 -eq 1) {
        $padBytes = [byte[]]@(0)
    }
    else {
        $padBytes = @()
    }
    $customChunk = $chunkId + $chunkSizeBytes + $zipBytes + $padBytes
    $newBytes = $webpBytes + $customChunk
    $newFileSize = $newBytes.Length - 8
    $newFileSizeBytes = [System.BitConverter]::GetBytes($newFileSize)
    [Array]::Copy($newFileSizeBytes, 0, $newBytes, 4, 4)
    [System.IO.File]::WriteAllBytes($OutputPath, $newBytes)
    Write-Host "Successfully embedded '$ZipPath' into '$ImagePath' as '$OutputPath'."
}
catch {
    Write-Error "An error occurred: $_"
}