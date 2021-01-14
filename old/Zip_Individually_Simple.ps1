#Current path to directory
$fileLocation = read-host "Type/Paste location"
$zipFilesPath = cd "$fileLocation"
$currentDirectory = pwd

$directories = Get-ChildItem -Path $fileLocation -Directory

Add-Type -assembly "system.io.compression.filesystem"

Foreach ($directory in $directories)

 {

  $destination = Join-path -path $fileLocation -ChildPath "$($directory.name).zip"

  If(Test-path $destination) {Remove-item $destination}

  [io.compression.zipfile]::CreateFromDirectory($directory.fullname, $destination)}