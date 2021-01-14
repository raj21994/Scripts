$fileLocation = read-host "Type/Paste location"
cd "$fileLocation"
$currentDirectory = pwd
$directories = Get-ChildItem -Path $fileLocation -Directory

foreach ($directory in $directories) {
    Compress-Archive -Path $directory.FullName -DestinationPath "$($directory.FullName).zip" -Force -CompressionLevel Optimal
}

#Clear Console
clear
#Read-Host -Prompt “Press Enter to exit”
start .\