# Tracking Disable — WinTweaks
# Disables advertising ID, activity history, and location tracking

Write-Host "=== Disable Tracking ===" -ForegroundColor Cyan

# Disable advertising ID
$advPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo"
if (!(Test-Path $advPath)) { New-Item -Path $advPath -Force | Out-Null }
Set-ItemProperty -Path $advPath -Name "Enabled" -Value 0 -Type DWord
Write-Host "[OK] Advertising ID disabled" -ForegroundColor Green

# Disable activity history
$actPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System"
Set-ItemProperty -Path $actPath -Name "EnableActivityFeed" -Value 0 -Type DWord
Set-ItemProperty -Path $actPath -Name "PublishUserActivities" -Value 0 -Type DWord
Set-ItemProperty -Path $actPath -Name "UploadUserActivities" -Value 0 -Type DWord
Write-Host "[OK] Activity history disabled" -ForegroundColor Green

# Disable location tracking
$locPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location"
Set-ItemProperty -Path $locPath -Name "Value" -Value "Deny" -Type String -ErrorAction SilentlyContinue
Write-Host "[OK] Location tracking disabled" -ForegroundColor Green

# Disable clipboard history
$clipPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System"
Set-ItemProperty -Path $clipPath -Name "AllowClipboardHistory" -Value 0 -Type DWord
Write-Host "[OK] Clipboard history disabled" -ForegroundColor Green

# Disable app launch tracking
$explorerPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
Set-ItemProperty -Path $explorerPath -Name "Start_TrackProgs" -Value 0 -Type DWord
Write-Host "[OK] App launch tracking disabled" -ForegroundColor Green

Write-Host "`nDone!" -ForegroundColor Cyan
