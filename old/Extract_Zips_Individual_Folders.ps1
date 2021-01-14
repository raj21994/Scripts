#Current Directory of creatives
$fileLocation = read-host "Type/Paste location of creatives"

if (Test-Path \\lonfpcp01101z\International\* -PathType Leaf) {
    $serverPathName = "\\lonfpcp01101z\International\"
    $driveLetter = "I:\"
    $fileLocation = ($fileLocation -replace [regex]::Escape($serverPathName),$driveLetter)
}
$fileLocation = Set-Location $fileLocation
Write-Output $fileLocation

$zipFilesPath = cd "$fileLocation"
$currentDirectory = pwd

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
    
    # Set the location and create a new folder to unzip the files into - Edit the line below to change the location to save files to
    $NewLocation = "$currentDirectory\$ZipFileActualName"
    New-Item $NewLocation -type Directory
   
    # Move the zip file to the new folder so that you know which was the original file (can be changed to Move-Item if needed)
    Copy-Item $ZipFile.fullname $NewLocation
    
    # List up all of the zip files in the new folder 
    $NewZipFile = get-childitem $NewLocation *.zip
    
    # Get the COMObjects required for the unzip process
    $NewLocation = $shell.namespace($NewLocation)
    $ZipFolder = $shell.namespace($NewZipFile.fullname)
    
    # Copy the files to the new Folder
    $NewLocation.copyhere($ZipFolder.items())

    # Delete original zip in new Folder
    Remove-Item "$currentDirectory\$ZipFileActualName\$ZipFileActualName.zip" -Force -Recurse
    
    # Increase the Index to ensure that unique folders are made
    $FileCounter++
}
#Clear Console
clear
#Read-Host -Prompt “Press Enter to exit”
start .\