Add-Type -AssemblyName System.Drawing

$ilguPath = "C:\Users\soonjae\.gemini\antigravity-ide\brain\ee42a786-4053-4d52-ad35-5f83d93e0786\ilgu_clean_app_icon_1785715341690.png"

function Create-SquareIcon {
    param (
        [string]$SrcPath,
        [string]$DstPath,
        [int]$CanvasSize
    )
    $src = [System.Drawing.Image]::FromFile($SrcPath)
    $bmp = New-Object System.Drawing.Bitmap($CanvasSize, $CanvasSize)
    $g = [System.Drawing.Graphics]::FromImage($bmp)

    $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    $g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
    $g.CompositingQuality = [System.Drawing.Drawing2D.CompositingQuality]::HighQuality

    # 배경색: 단일 순백색(#FFFFFF)
    $bgColor = [System.Drawing.Color]::White
    $brush = New-Object System.Drawing.SolidBrush($bgColor)
    $g.FillRectangle($brush, 0, 0, $CanvasSize, $CanvasSize)

    # 원본 비율 유지하며 82% 크기 중앙 배치 (귀나 손이 테두리에 닿지 않도록 충분한 여백 제공)
    $targetMax = [double]($CanvasSize * 0.82)
    $scaleW = $targetMax / $src.Width
    $scaleH = $targetMax / $src.Height
    $ratio = [Math]::Min($scaleW, $scaleH)

    $newW = [int]($src.Width * $ratio)
    $newH = [int]($src.Height * $ratio)
    $posX = [int](($CanvasSize - $newW) / 2)
    $posY = [int](($CanvasSize - $newH) / 2)

    $g.DrawImage($src, $posX, $posY, $newW, $newH)

    $src.Dispose()
    $g.Dispose()
    $brush.Dispose()

    $tempFile = [System.IO.Path]::GetTempFileName() + ".png"
    $bmp.Save($tempFile, [System.Drawing.Imaging.ImageFormat]::Png)
    $bmp.Dispose()

    Copy-Item -Path $tempFile -Destination $DstPath -Force
    Remove-Item -Path $tempFile -Force
}

Create-SquareIcon -SrcPath $ilguPath -DstPath ".\icon-512.png" -CanvasSize 512
Create-SquareIcon -SrcPath $ilguPath -DstPath ".\icon-192.png" -CanvasSize 192

Write-Host "Clean Il-gu character icons successfully generated!"
