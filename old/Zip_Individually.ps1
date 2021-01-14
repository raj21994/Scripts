#Current path to directory
$fileLocation = read-host "Type/Paste location"
$zipFilesPath = cd "$fileLocation"
$currentDirectory = pwd

$directories = Get-ChildItem -Path $currentDirectory -Directory
gci | Where-Object{($_.PSIsContainer)} | foreach-object{$_.Name}

Write-Host "Choose one of the following options"
Write-Host "1. Choose this option if creative location does contain subfolders"
Write-Host "2. Choose this option if creative location does NOT contain subfolders"
$zipMethod = Read-Host "Option 1 or 2 [1/2]?"

if($zipMethod -eq '1'){
    ForEach ($directory in $directories) {
        $path = $directory.FullName
        Compress-Archive -Path $path -DestinationPath "$path.zip" -Force -CompressionLevel Optimal
    }
}
elseif($zipMethod -eq '2'){
    Add-Type -assembly "system.io.compression.filesystem"

    foreach ($directory in $directories) {
    $path = $directory.FullName
    [System.IO.Compression.ZipFile]::CreateFromDirectory($path, "$path.zip", $CompressLevel, $ExcludeBaseDir)
}
}
else{
    Write-Output "ERROR! Incorrect Input!"
    Write-Output "Exiting Script..."
    Exit
}

#Clear Console
#clear
#Read-Host -Prompt “Press Enter to exit”
start .\