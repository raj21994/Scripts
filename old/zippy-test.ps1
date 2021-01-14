$fileLocation = read-host "Type/Paste location"
$zipFilesPath = cd "$fileLocation"
$currentDirectory = pwd

$source = Get-ChildItem -Path $currentDirectory "1131836?" -Directory

Add-Type -Assembly "system.io.compression.filesystem"

Foreach ($s in $source) {
    $destination = Join-Path -Path -ChildPath "$($s.name).zip"
    If(Test-path $destination) {
        Remove-item $destination
    }
    [io.compression.zipfile]::CreateFromDirectory($s.fullname, $destination)
}