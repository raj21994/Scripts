#Current Directory of creatives
$fileLocation = read-host "Type/Paste location of creatives"

if (Test-Path \\lonfpcp01101z\International\* -PathType Leaf) {
    $serverPathName = "\\lonfpcp01101z\International\"
    $driveLetter = "I:\"
    $fileLocation = ($fileLocation -replace [regex]::Escape($serverPathName),$driveLetter)
}
$fileLocation = Resolve-Path $fileLocation
Write-Output $fileLocation

$newText = read-host "Please enter text to append"
$newText = $newText -replace '\s','-'

$addMarket = read-host "Are folders split by market? [Y/N]"

$ZipFiles = Get-ChildItem -Path "$currentDirectory" -Recurse

if ($addMarket -eq "N") {
    foreach  ($Zipfile in $ZipFiles) {
        Get-ChildItem | %{$_|rename-item -NewName ((($_.BaseName -replace '\s','-') + "-" + $newText + $_.Extension))}
    }
}
elseif($addMarket -eq "Y") {
    foreach  ($Zipfile in $ZipFiles) {
        Get-ChildItem -File -Recurse | Rename-Item -NewName {(($_.BaseName -replace '\s','-')  + "-" + (($_.Directory.Name -replace '\s','-')) + "-" + $newText + $_.Extension).ToLower()}
    }
}
else {
    write-host "ERROR! Incorrect Input!"
    Write-Host "Exiting Script..."
    Exit
}

#Clear Console
clear
Read-Host -Prompt “Press Enter to exit”