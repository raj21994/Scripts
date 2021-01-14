#Make Sure To Paste This File Into The Directory You Wish To Use It In
#Please note: This is made under the assumption that the creatives are in the Zip Files with no additional folders to navigate within the Zip Files

#Current Directory
$fileLocation = read-host "Type/Paste location of creatives"
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
    $typeFilter = 'JPEG'
}
elseif($typeFilter -eq '3'){
    $typeFilter = 'PNG'
}
elseif($typeFilter -eq '4'){
    $typeFilter = 'GIF'
}
else {
    write-host "ERROR! Incorrect Input!"
    Write-Host "Exiting Script..."
    Exit
}

#Files Location
$ZipFilesPath = "$currentDirectory\*.zip"

#Unzip To Same Location
$UnzipPath = "$currentDirectory"

#Check if Temp Folder exists
$TempCheck = Test-Path "$currentDirectory\Temp"
If ($TempCheck -eq $false) {
#Create Temp Folder
New-Item -ItemType directory -Path "$currentDirectory\Temp"
}
$TempPath = "$currentDirectory\Temp"

$Shell = New-Object -com Shell.Application
$Location = $Shell.NameSpace($TempPath)
$ZipFiles = Get-Childitem $ZipFilesPath -Recurse -Include *.ZIP

$FileCounter = 1

#Clear Initilisation Vars from Console
clear
$searchTerm = read-host "Enter filename to search for"
foreach ($ZipFile in $ZipFiles) {
    #Get The Base Filename without the Filepath
    $ZipFileActualName = [io.path]::GetFileNameWithoutExtension($ZipFile.FullName)

    write-host File:   $ZipFileActualName

    $ZipFolder = $Shell.NameSpace($ZipFile.fullname)
    $Location.Copyhere($ZipFolder.items(), 1040)

    #Find 4 backup types

    #$BackupFiles = Get-ChildItem $TempPath *.$typeFilter -Recurse
    $BackupFiles = Get-ChildItem $TempPath *$searchTerm*.$typeFilter -Recurse
    #$BackupFiles = Get-ChildItem $TempPath | Select-String -Pattern "$ZipFileActualName.$typeFilter"
    $BackupFiles |% {Move-Item  $_.Fullname}

    #Clear Temp Folder
    Get-ChildItem -Path "$currentDirectory\Temp" -Include *.* -File -Recurse | foreach { $_.Delete()}
    
    #Move Along to Next File
    $FileCounter++
}

#Delete Temp Foler
Remove-Item "$currentDirectory\Temp" -Force -Recurse

#Clear Console
clear
#Read-Host -Prompt “Press Enter to exit”
start .\