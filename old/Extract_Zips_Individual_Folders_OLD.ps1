#Current Directory
$fileLocation = read-host "Type/Paste location of creatives"
$zipFilesPath = cd "$fileLocation"
$currentDirectory = pwd

$FileCounter = 1

#For every zip file in the folder
foreach ($ZipFile in $ZipFiles)
{
    #Get The Base Filename without the extension
    $ZipFileActualName = [io.path]::GetFileNameWithoutExtension($ZipFile.FullName)
    
    #Set the location and create a new folder to unzip the files into - Edit the line below to change the location to save files to
    New-Item $ZipFileActualName -type Directory
    $NewLocation = "$currentDirectory\$ZipFileActualName"
    $NewLocation
   
    #Copy the zip file to the new folder
    Copy-Item $ZipFile.fullname $NewLocation
    
    #List up all of the zip files in the new folder 
    $UnzipFile = get-childitem $currentDirectory $ZipFileActualName.zip

    Get-ChildItem "$currentDirectory/$ZipFileActualName" -Filter *.zip | Expand-Archive -DestinationPath "$currentDirectory/$ZipFileActualName" -Force
    Remove-Item "$currentDirectory/$ZipFileActualName/$ZipFileActualName.zip" -Force -Recurse

    $FileCounter++
}