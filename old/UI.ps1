Set-ExecutionPolicy remotesigned -Scope CurrentUser -EA SilentlyContinue -Force

$scriptState = $true

#Location of scripts
$scriptDir = "C:\Users\Rajiv.Ahmed\OneDrive - insidemedia.net\Documents\Useful Shit\PowerShell Scripts"

Write-Output "1. Extract and Rename Backup Creatives"
Write-Output "2. Extract Backup Creatives"
Write-Output "3. Extract Zips in Zip"
Write-Output "4. Extract Zips To Individual Folders - Still Testing - MAY NOT WORK PROPERLY!"
Write-Output "5. Find And Replace Text"
Write-Output "6. Unzip"
Write-Output "7. Zip Folders Individually"
Write-Output "8. Append Text to File Name"

#Choose script to run
$scriptOption = Read-Host "Choose which script you wish to run"

#Confirm choice - if, then exit script
Write-Output "You have selected '$scriptOption'. Is this correct?"
$optionConfirm =  Read-Host "[Y/N]?"

if($optionConfirm -ne "y") {
    Write-Output "Exiting Script..."
    Start-Sleep -seconds 1.5
    Exit
}
else{
    #Do nothing
}

#Loop through until option found, run script, and then exit when done
#Option 4 is currently still in testing - DO NOT USE!
if($scriptOption -eq '1') {
    cd $scriptDir
    &("$scriptDir\Extract_Rename_Backup_Creatives.ps1")
    cd $scriptDir
    Start-Sleep -Seconds 1.5
}
elseif($scriptOption -eq '2') {
    cd $scriptDir
    &("$scriptDir\Extract_Backup_Creatives.ps1")
    cd $scriptDir
    Start-Sleep -Seconds 1.5
}
elseif($scriptOption -eq '3') {
    cd $scriptDir
    &("$scriptDir\Extract_Zips_in_Zip.ps1")
    cd $scriptDir
    Start-Sleep -Seconds 1.5
}
elseif($scriptOption -eq '4') {
#    Write-Output "Option 4 is not currrently available"
#    Read-Host -Prompt "Press Enter to exit..."
#    Exit 
    Write-Output "WARNING! MAY NOT WORK PROPERLY!"
    cd $scriptDir
    &("$scriptDir\Extract_Zips_Individual_Folders.ps1")
    cd $scriptDir
}
elseif($scriptOption -eq '5') {
    cd $scriptDir
    &("$scriptDir\Find_Replace_Text.ps1")
    cd $scriptDir
    Start-Sleep -Seconds 1.5
}
elseif($scriptOption -eq '6') {
    cd $scriptDir
    &("$scriptDir\Unzip.ps1")
    cd $scriptDir
    Start-Sleep -Seconds 1.5
}
elseif($scriptOption -eq '7') {
    cd "C:\Users\Rajiv.Ahmed\PycharmProjects\scripts"
    python zip-individual.py
}
elseif($scriptOption -eq '8') {
    cd $scriptDir
    &("$scriptDir\Append_Text_FileName.ps1")
    cd $scriptDir
    Start-Sleep -Seconds 1.5
}
else {
    Write-Output "ERROR! Incorrect Input!"
    Write-Output "Exiting Script..."
    Remove-Variable * -ErrorAction SilentlyContinue
    Exit
}
Write-Output "Done!`n"
Read-Host -Prompt "Press Enter to exit..."