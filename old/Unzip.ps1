$fileLocation = read-host "Type/Paste location"
$zipFilesPath = cd "$fileLocation"
$currentDirectory = pwd
Get-ChildItem "$currentDirectory" -Filter *.zip | Expand-Archive -DestinationPath "$currentDirectory" -Force
#Clear Console
clear
#Read-Host -Prompt “Press Enter to exit”
start .\