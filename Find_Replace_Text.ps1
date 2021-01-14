#Comment one or the other

$fileLocation = read-host "Type/Paste location"
if (Test-Path \\lonfpcp01101z\International\* -PathType Leaf) {
    $serverPathName = "\\lonfpcp01101z\International\"
    $driveLetter = "I:\"
    $fileLocation = ($fileLocation -replace [regex]::Escape($serverPathName),$driveLetter)
}
$fileLocation = Set-Location $fileLocation
Get-Location

$oldWord = read-host "Please enter text to find"
$newWord = read-host "Please enter text to replace with"
$newWord = $newWord -replace '\s','-'

Write-Output "Choose text replace method"
Write-Output "1. Choose this option if files are in multiple folders"
Write-Output "2. Choose this option to ignore all folders"

$replaceText = Read-Host "Option 1 or 2? [1/2]?"

if($replaceText -eq '1') {
#Rename files in subfolders of current directory
Get-ChildItem -File -Recurse | ForEach-Object { Rename-Item -Path $_.PSPath -NewName $_.Name.replace("$oldWord","$newWord")}
}
elseif($replaceText -eq '2') {
#Rename files in current directory
#Dir | Rename-Item -NewName {$_.name -replace "$oldWord", "$newWord"}
Get-ChildItem -Filter "*$oldWord*" -Recurse | Rename-Item -NewName {$_.Name -replace "$oldWord","$newWord"}
}
else {
    write-host "ERROR! Incorrect Input!"
    Write-Host "Exiting Script..."
    Exit
}

#Clear Console
Clear-Host
#Read-Host -Prompt “Press Enter to exit”
