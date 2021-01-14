$fileLocation = read-host "Type/Paste location of creatives"
#$testPathName = Test-Path \\lonfpcp01101z\International\* -PathType Leaf

#if ($fileLocation -contains "\\lonfpcp01101z\International\") {
#    $serverPathName = "\\lonfpcp01101z\International\"
#    $driveLetter = "I:\"
#    $fileLocation = ($fileLocation -replace [regex]::Escape($serverPathName),$driveLetter)
#}

if (Test-Path \\lonfpcp01101z\International\* -PathType Leaf) {
    $serverPathName = "\\lonfpcp01101z\International\"
    $driveLetter = "I:\"
    $fileLocation = ($fileLocation -replace [regex]::Escape($serverPathName),$driveLetter)
}
$fileLocation = Resolve-Path $fileLocation

Write-Output $fileLocation