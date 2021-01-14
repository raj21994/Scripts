$fileLocation = read-host "Type/Paste location of creatives"

if (Test-Path \\lonfpcp01101z\International\* -PathType Leaf) {
    $serverPathName = "\\lonfpcp01101z\International\"
    $driveLetter = "I:\"
    $fileLocation = ($fileLocation -replace [regex]::Escape($serverPathName),$driveLetter)
}
Set-Location $fileLocation
Write-Output $fileLocation

$newText = read-host "Please enter text to append"
$newText = $newText -replace '\s', '-'

$addMarket = read-host "Are folders split by market? [Y/N]"

if ($addMarket -eq "N") {
    Get-ChildItem -Path $fileLocation -Recurse -Filter "*.zip" -File |  
    ForEach-Object { 
        Rename-Item -Path $_.FullName -NewName ((($_.BaseName -replace '\s', '-') + "-" + $newText + $_.Extension)) 
    }
}
elseif ($addMarket -eq "Y") {
    Get-ChildItem -Path $fileLocation -Recurse -Filter "*.zip" -File |  
    ForEach-Object { 
        Rename-Item -Path $_.FullName -NewName ((($_.BaseName -replace '\s', '-') + "-" + (($_.Directory.Name -replace '\s', '-')) + "-" + $newText + $_.Extension))
    }
}
else {
    write-host "ERROR! Incorrect Input!"
    Write-Host "Exiting Script..."
    Exit
}

Clear-Host