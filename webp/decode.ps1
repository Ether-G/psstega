param(
    [Parameter(Mandatory=$true)]
    [string]$StegoPath,
    
    [Parameter(Mandatory=$true)]
    [string]$OutputZipPath
)

try {
    $allBytes = [System.IO.File]::ReadAllBytes($StegoPath)
    $offset = 12
    $found = $false
    while ($offset -lt $allBytes.Length) {
        if ($offset + 8 -gt $allBytes.Length) { break }
        $chunkIdBytes = $allBytes[$offset..($offset+3)]
        $chunkId = [System.Text.Encoding]::ASCII.GetString($chunkIdBytes)
        $offset += 4
        $chunkSizeBytes = $allBytes[$offset..($offset+3)]
        $chunkSize = [System.BitConverter]::ToInt32($chunkSizeBytes, 0)
        $offset += 4

        if ($chunkId -eq "stEG") {
            $found = $true
            $zipData = $allBytes[$offset..($offset + $chunkSize - 1)]
            [System.IO.File]::WriteAllBytes($OutputZipPath, $zipData)
            Write-Host "Successfully extracted the ZIP file to: $OutputZipPath"
            break
        }
        else {
            $offset += $chunkSize
            if ($chunkSize % 2 -eq 1) {
                $offset += 1
            }
        }
    }

    if (-not $found) {
        Write-Error "Custom stego chunk ('stEG') not found in the file."
    }
}
catch {
    Write-Error "An error occurred during extraction: $_"
}