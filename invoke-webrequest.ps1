[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
#$url = "https://www.playstation.com/en-gb/explore/ps4/"
$url = "https://www.footlocker.fr/fr/tous/adidas_zx-2k?utm_source=spotify&utm_medium=display&utm_campaign=Adidaszx082020"

$webRequest = Invoke-WebRequest -Uri $url #-MaximumRedirection 0 -ErrorAction SilentlyContinue
$webRequest.RawContent > Downloads/output.txt