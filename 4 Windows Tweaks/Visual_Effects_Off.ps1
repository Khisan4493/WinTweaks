# Visual Effects Off — WinTweaks
# Disables Windows animations and visual effects for performance

Write-Host "=== Disable Visual Effects ===" -ForegroundColor Cyan

$vfxPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects"
Set-ItemProperty -Path $vfxPath -Name "VisualFXSetting" -Value 2 -Type DWord -ErrorAction SilentlyContinue

$advPath = "HKCU:\Control Panel\Desktop"
Set-ItemProperty -Path $advPath -Name "UserPreferencesMask" -Value ([byte[]](0x90,0x12,0x03,0x80,0x10,0x00,0x00,0x00)) -Type Binary
Set-ItemProperty -Path $advPath -Name "MenuShowDelay" -Value "0" -Type String
Set-ItemProperty -Path $advPath -Name "DragFullWindows" -Value "0" -Type String

$dwmPath = "HKCU:\Software\Microsoft\Windows\DWM"
Set-ItemProperty -Path $dwmPath -Name "EnableAeroPeek" -Value 0 -Type DWord -ErrorAction SilentlyContinue
Set-ItemProperty -Path $dwmPath -Name "AlwaysHibernateThumbnails" -Value 0 -Type DWord -ErrorAction SilentlyContinue

$explorerPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
Set-ItemProperty -Path $explorerPath -Name "ListviewAlphaSelect" -Value 0 -Type DWord
Set-ItemProperty -Path $explorerPath -Name "TaskbarAnimations" -Value 0 -Type DWord
Set-ItemProperty -Path $explorerPath -Name "IconsOnly" -Value 0 -Type DWord

Write-Host "[OK] Visual effects disabled — menu delay set to 0" -ForegroundColor Green
Write-Host "`nDone! Sign out and back in to apply." -ForegroundColor Cyan
