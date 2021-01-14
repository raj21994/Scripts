[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$urlInput = "F:\Users\Rajiv\Desktop\Mediacom\url-test.txt"
$csvOutput = "F:\Users\Rajiv\Desktop\Mediacom\testurl_result.csv"

#$totalUrls = Get-Content $urlInput | Measure-Object –Line
#Write-Host "Total URLs = $totalUrls" 

Get-Content $urlInput | ForEach-Object { $uri = $_; 
    try 
    { 
        Invoke-WebRequest -Uri $uri -Method HEAD -MaximumRedirection 0 -ErrorAction SilentlyContinue
    } 
    catch 
    {
        New-Object -TypeName psobject -Property @{Error = $_}
    } 
} | Select-Object @{Name='Landing Page'; Expression={$uri}}, StatusCode, @{Name='RedirectTo';Expression={$_.Headers["Location"]}}, Error | Export-Csv $csvOutput -NoTypeInformation