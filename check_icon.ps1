Add-Type -AssemblyName System.Drawing
$a = [System.Drawing.Image]::FromFile("icon-192.png")
$b = [System.Drawing.Image]::FromFile("icon-512.png")
Write-Host "icon-192.png width:" $a.Width "height:" $a.Height
Write-Host "icon-512.png width:" $b.Width "height:" $b.Height
$a.Dispose()
$b.Dispose()
