Add-Type -AssemblyName System.Drawing

function Resize-Image {
    param (
        [string]$InputFile,
        [string]$OutputFile,
        [int]$Width,
        [int]$Height
    )
    $srcImg = [System.Drawing.Image]::FromFile($InputFile)
    $newImg = New-Object System.Drawing.Bitmap($Width, $Height)
    $g = [System.Drawing.Graphics]::FromImage($newImg)
    
    $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    $g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
    $g.CompositingQuality = [System.Drawing.Drawing2D.CompositingQuality]::HighQuality
    
    $g.DrawImage($srcImg, 0, 0, $Width, $Height)
    
    $srcImg.Dispose()
    $g.Dispose()
    
    # 임시 파일로 저장 후 원본 덮어쓰기
    $tempFile = $OutputFile + ".tmp.png"
    $newImg.Save($tempFile, [System.Drawing.Imaging.ImageFormat]::Png)
    $newImg.Dispose()
    
    Move-Item -Path $tempFile -Destination $OutputFile -Force
}

# icon-192.png -> 192x192
Resize-Image -InputFile "icon-192.png" -OutputFile "icon-192.png" -Width 192 -Height 192

# icon-512.png -> 512x512
Resize-Image -InputFile "icon-512.png" -OutputFile "icon-512.png" -Width 512 -Height 512

Write-Host "Icons successfully resized!"
