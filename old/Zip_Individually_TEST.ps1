#Current path to directory
$fileLocation = read-host "Type/Paste location"
$zipFilesPath = cd "$fileLocation"
$currentDirectory = pwd

$directories = Get-ChildItem -Path $fileLocation -Directory
#gci | Where-Object{($_.PSIsContainer)} | foreach-object{$_.Name}

#Add-Type -assembly "system.io.compression.filesystem"

Foreach ($directory in $directories) {
    Compress-Archive -Path $currentDirectory -CompressionLevel Optimal -DestinationPath $currentDirectory
    #$zipDestination = Join-path -path $currentDirectory -ChildPath "$($directory.name).zip"
    
    If(Test-path $zipDestination){
        Remove-item $zipDestination
    }
    #[io.compression.zipfile]::CreateFromDirectory($directory.fullname, $zipDestination)
}
#Clear Console
#clear
#Read-Host -Prompt “Press Enter to exit”
start .\