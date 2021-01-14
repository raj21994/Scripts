#https://stackoverflow.com/questions/54693287/how-to-get-200-status-code-in-ps-after-checking-a-redirected-url?noredirect=1&lq=1
function Get-WebStatus($url) {
    try {
        $req = [System.Net.HttpWebRequest]::Create($url)
        $req.Method    = "HEAD"
        $req.Timeout   = 30000
        $req.KeepAlive = $false
        $res = $req.GetResponse()
        if ($res.StatusCode.value__ -eq 200) {
            Write-Host ("`nThe site $url is UP (Return code: " + 
                "$($res.StatusCode) - " + 
                "$($res.StatusCode.value__))`n") -ForegroundColor Cyan
        } else {
            Write-Host ("`nThe site $url is DOWN (Return code: " +
                "$($res.StatusCode) - " + 
                "$($res.StatusCode.value__))`n") -ForegroundColor Yellow
        }
    } catch {
        $res = $null  ### or ### [System.Net.HttpWebRequest]::new()
        Write-Host ("`nThe site $url is DOWN " + 
            "($($error[0].Exception.InnerException.Message))`n") -Foreground Red
    }
    $res    ### return a value
}

Get-WebStatus 'https://www.playstation.com/ch-fr/explore/playstation-now/ps-now-games/?emcid=so-st-250083'

