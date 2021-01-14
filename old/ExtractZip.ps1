#requires -Version 5.0

# change $Path to a ZIP file that exists on your system!
$fileLocation = Read-Host "Type/Paste location of creatives"
#$ZipFileActualName = [io.path]::GetFileNameWithoutExtension($ZipFile.FullName)
$Path = "$fileLocation"

# change extension filter to a file extension that exists
# inside your ZIP file
$Filter = '*.jpg'

# change output path to a folder where you want the extracted
# files to appear
$OutPath = "$Path\ZipFiles"

# ensure the output folder exists
$exists = Test-Path -Path $OutPath
if ($exists -eq $false)
{
  $null = New-Item -Path $OutPath -ItemType Directory -Force
}

# load ZIP methods
Add-Type -AssemblyName System.IO.Compression.FileSystem

# open ZIP archive for reading
$zip = [System.IO.Compression.ZipFile]::OpenRead($Path)
#Get-ChildItem *.jpg

# find all files in ZIP that match the filter (i.e. file extension)
$zip.Entries | 
  Where-Object { $_.FullName -like $Filter } |
  ForEach-Object { 
    # extract the selected items from the ZIP archive
    # and copy them to the out folder
    $FileName = $_.Name
    [System.IO.Compression.ZipFileExtensions]::ExtractToFile($_, "$OutPath\$FileName", $true)
    }

# close ZIP file
$zip.Dispose()

# open out folder
explorer $OutPath