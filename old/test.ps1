#Current Directory of creatives
$fileLocation = read-host "Type/Paste location of creatives"

if (Test-Path \\lonfpcp01101z\International\* -PathType Leaf) {
    $serverPathName = "\\lonfpcp01101z\International\"
    $driveLetter = "I:\"
    $fileLocation = ($fileLocation -replace [regex]::Escape($serverPathName),$driveLetter)
}
$fileLocation = Resolve-Path $fileLocation
Write-Output $fileLocation

$zipFilesPath = cd "$fileLocation"
$currentDirectory = pwd

#File type of backup
#Note: `n = new line
write-host "`nChoose Creative Backup File Type"
Write-Host "1. JPG"
Write-host "2. JPEG"
Write-Host "3. PNG"
Write-Host "4. GIF"

$typeFilter = Read-Host "`nType? 1/2/3/4"
if($typeFilter -eq '1'){
    $typeFilter = 'jpg'
}
elseif($typeFilter -eq '2'){
    $typeFilter = 'jpeg'
}
elseif($typeFilter -eq '3'){
    $typeFilter = 'png'
}
elseif($typeFilter -eq '4'){
    $typeFilter = 'gif'
}
else {
    write-host "ERROR! Incorrect Input!"
    Write-Host "Exiting Script..."
    start-sleep -seconds 1.5
    Exit
}

#Files Location
$ZipFilesPath = "$currentDirectory"

#Unzip To Same Location
$UnzipPath = "$currentDirectory"

#Check if Temp Folder exists
$TempCheck = Test-Path "$currentDirectory\Temp"

If ($TempCheck -eq $false) {
#Create Temp Folder
New-Item -ItemType directory -Path "$currentDirectory\Temp" -Force
}

$TempPath = "$currentDirectory\Temp"

$Shell = New-Object -com Shell.Application
$Location = $Shell.NameSpace($TempPath)
$ZipFiles = Get-Childitem $ZipFilesPath -Recurse -Include *.ZIP

$FileCounter = 1

#Clear Initilisation Vars from Console
clear

foreach ($ZipFile in $ZipFiles) {
    #Get The Base Filename without the extension
    $ZipFileActualName = [io.path]::GetFileNameWithoutExtension($ZipFile.FullName)

    write-host File:   $ZipFileActualName

    $ZipFolder = $Shell.NameSpace($ZipFile.fullname)
    $Location.Copyhere($ZipFolder.items(), 1040)
    $DestinationDir = $ZipFile.DirectoryName.Replace($ZipFilesPath,$unzipPath)

    #Find and rename backups
    $BackupFiles = Get-ChildItem $TempPath -Filter *backup*.$typeFilter -Recurse
    $BackupFiles |% {Move-Item $_.Fullname $DestinationDir/$ZipFileActualName'_backup'.$typefilter}
    
    #Clear Temp Folder
    Get-ChildItem -Path "$currentDirectory\Temp" -Include *.* -File -Recurse | foreach { $_.Delete()}
    
    #Move Along to Next File
    $FileCounter++
}

#Delete Temp Folder
Remove-Item "$currentDirectory\Temp" -Force -Recurse

#Clear Console
clear
#Read-Host -Prompt “Press Enter to exit”
#start .\