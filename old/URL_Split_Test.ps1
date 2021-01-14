$urlStr = Read-Host "Please enter URL to check"
#[uri]$urlStr

$urlDomain = Split-Path -Path "$urlStr"
Write-Host URL Domain = "$urlDomain"

$urlQuery = ([uri]"$urlStr").Query
$urlSplitQuery = $urlQuery -split "&"
Write-Host Query String = "$urlSplitQuery"

$urlFragment = ([uri]"$urlStr").Fragment
Write-Host Fragment = "$urlFragment"