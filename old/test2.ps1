[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$urlInput = "C:\Users\Rajiv.Ahmed\OneDrive - insidemedia.net\Desktop\testurls.txt"
$csvOutput = "C:\Users\Rajiv.Ahmed\OneDrive - insidemedia.net\Desktop\testurl_result.csv"

Get-Content $urlInput| Foreach { $uri = $_; 
    try 
    { 
        Invoke-WebRequest -Uri $uri -Method HEAD -MaximumRedirection 0 -ErrorAction SilentlyContinue -UseBasicParsing
    } 
    catch 
    { 
        New-Object -TypeName psobject -Property @{Error = $_}
    } 
} | Select @{Name='Landing Page'; Expression={$uri}}, StatusCode, @{Name='RedirectTo';Expression={$_.Headers["Location"]}}, Error | Export-Csv $csvOutput