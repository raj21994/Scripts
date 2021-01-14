[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

try {

$urlStr = Read-Host "Please enter URL to check"
[uri]$urlStr

# First we create the request.
$HTTPS_Request = [System.Net.WebRequest]::Create("$urlStr")

# We then get a response from the site.
$HTTPS_Response = $HTTPS_Request.GetResponse()

# We then get the HTTP code as an integer.
$HTTPS_Status = [int]$HTTPS_Response.StatusCode
$HTTPS_StatusDesc = [string]$HTTPS_Response.StatusDescription
} catch [System.Net.WebException] {
$HTTPS_Status = [int]$_.Exception.Response.StatusCode
$HTTPS_StatusDesc = [string]$HTTPS_Response.StatusDescription
}

do { 
If ($HTTPS_Status -eq 301) {
    Write-Host "URL: $urlStr"
    Write-Host "HTTP CODE: $HTTPS_Status"
    Write-Host "HTTP CODE DESCRIPTION: $HTTPS_StatusDesc"
    Write-Host "Landing page moved permanently and redirects to another URL."
    Write-Host "Please update Landing page to new URL"
}
ElseIf ($HTTPS_Status -eq 302) {
    Write-Host "URL: $urlStr"
    Write-Host "HTTP CODE: $HTTPS_Status"
    Write-Host "HTTP CODE DESCRIPTION: $HTTPS_StatusDesc"
    Write-Host "If this occurs once, then no issues"
    Write-Host "If this occurs more than once, please update Landing page to new URL"
}
} while ($HTTPS_Status -ge 300 -and $HTTPS_Status -lt 400)

If ($HTTPS_Status -eq 200) {
    Write-Host "URL: $urlStr"
    Write-Host "HTTP CODE: $HTTPS_Status"
    Write-Host "HTTP CODE DESCRIPTION: $HTTPS_StatusDesc"
    Write-Host $HTTPS_Response.GetResponseHeader();
    Write-Host "Landed on page"
}
ElseIf ($HTTPS_Status -gt 400) {
    Write-Host "URL: $urlStr"
    Write-Host "HTTP CODE: $HTTPS_Status"
    Write-Host "HTTP CODE DESCRIPTION: $HTTPS_StatusDesc"
    Write-Host "Error - issue with Landing page. Please investigate."
}

#$HTTPS_Response | Export-Csv "C:\Users\Rajiv.Ahmed\OneDrive - insidemedia.net\Desktop\testurl_result2.csv" -NoTypeInformation

# Finally, we clean up the http request by closing it.
$HTTPS_Response.Close()
$HTTPS_Response.Dispose()
#Read-Host -Prompt “Press Enter to exit”