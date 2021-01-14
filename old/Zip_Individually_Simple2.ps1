#Current path to directory
$fileLocation = read-host "Type/Paste location"
$zipFilesPath = cd "$fileLocation"
$currentDirectory = pwd

$directories = Get-ChildItem -Path $fileLocation -Directory
gci | Where-Object{($_.PSIsContainer)} | foreach-object{$_.Name}

Foreach ($directory in $directories) {
    Compress-Archive -Path $directory.FullName -DestinationPath "$($directory.FullName).zip" -Force
}