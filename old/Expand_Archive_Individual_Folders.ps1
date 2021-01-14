#Current Directory of creatives
$fileLocation = read-host "Type/Paste location of creatives"

if (Test-Path \\lonfpcp01101z\International\* -PathType Leaf) {
    $serverPathName = "\\lonfpcp01101z\International\"
    $driveLetter = "I:\"
    $fileLocation = ($fileLocation -replace [regex]::Escape($serverPathName),$driveLetter)
}
$fileLocation = Resolve-Path $fileLocation
Write-Output $fileLocation

$zipFilesPath = Set-Location "$fileLocation"
$currentDirectory = Get-Location

# Find all the Zip files and Count them
$ZipFiles = get-childitem *.zip
$ZipFiles.count | out-default

# Set the Index for unique folders
$FileCounter = 1

# For every zip file in the folder
foreach ($ZipFile in $ZipFiles)
{

    # Get the full path to the zip file
    $ZipFile.fullname | out-default

    $ZipFileActualName = [io.path]::GetFileNameWithoutExtension($ZipFile.FullName)
    
    Expand-Archive -Path "$currentDirectory/$ZipFileActualName.zip" -DestinationPath "$currentDirectory/$ZipFileActualName/$ZipFileActualPath"
   
    $FileCounter++
}

#Clear Console
Clear-Host
#Read-Host -Prompt “Press Enter to exit”