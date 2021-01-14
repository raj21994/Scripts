function Get-HTTPResponseCode
{
  param(
    [Parameter(Mandatory = $true, Position = 0)]
    [uri]$Url,

    [switch]$Quiet
  )

  [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
  try {
    # First we create the request.
    $HTTPS_Request = [System.Net.WebRequest]::Create("$Url")

    # We then get a response from the site.
    $HTTPS_Response = $HTTPS_Request.GetResponse()

    # We then get the HTTP code as an integer.
    $HTTPS_Status = [int]$HTTPS_Response.StatusCode
    $HTTPS_StatusDesc = [string]$HTTPS_Response.StatusDescription
  }
  catch [System.Net.WebException] {
    $HTTPS_Status = [int]$_.Exception.Response.StatusCode
    $HTTPS_StatusDesc = [string]$HTTPS_Response.StatusDescription
  }
  finally {
    # Finally, we clean up the http request by closing it.
    $HTTPS_Response.Close()
    $HTTPS_Response.Dispose()
  }

  if(-not $Quiet){
    if ($HTTPS_Status -eq 301) {
      Write-Host "URL: $Url"
      Write-Host "HTTP CODE: $HTTPS_Status"
      Write-Host "HTTP CODE DESCRIPTION: $HTTPS_StatusDesc"
      Write-Host "Landing page moved permanently and redirects to another URL."
      Write-Host "Please update Landing page to new URL"
    }
    elseif ($HTTPS_Status -eq 302) {
      Write-Host "URL: $Url"
      Write-Host "HTTP CODE: $HTTPS_Status"
      Write-Host "HTTP CODE DESCRIPTION: $HTTPS_StatusDesc"
      Write-Host "Please update Landing page to new URL"
    }
    elseif ($HTTPS_Status -eq 200) {
      Write-Host "URL: $Url"
      Write-Host "HTTP CODE: $HTTPS_Status"
      Write-Host "HTTP CODE DESCRIPTION: $HTTPS_StatusDesc"
      Write-Host "Landed on page"
    }
    elseif ($HTTPS_Status -gt 400) {
      Write-Host "URL: $Url"
      Write-Host "HTTP CODE: $HTTPS_Status"
      Write-Host "HTTP CODE DESCRIPTION: $HTTPS_StatusDesc"
      Write-Host "Error - issue with Landing page. Please investigate."
    }
  }

  # return the response code
  return $HTTPS_Status
}

$URLs = Get-Content "C:\Users\Rajiv.Ahmed\OneDrive - insidemedia.net\Desktop\testurls.txt"
<#$URLs = @(
'https://bs.serving-sys.com/serving/adServer.bs?cn=trd&mc=click&pli=29871464&PluID=0&ord=[timestamp]'
)#>
$URLs | Select-Object @{Name='URL';Expression={$_}},@{Name='Status'; Expression={Get-HTTPResponseCode -Url $_}} | Export-Csv "C:\Users\Rajiv.Ahmed\OneDrive - insidemedia.net\Desktop\testurl_result.csv" -NoTypeInformation