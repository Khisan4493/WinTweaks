# Timer Resolution — WinTweaks
# Sets system timer to 0.5ms for lower input latency

Write-Host "=== Timer Resolution Tweak ===" -ForegroundColor Cyan

# Enable HPET in Windows
bcdedit /set useplatformclock true 2>$null
bcdedit /set useplatformtick yes 2>$null
bcdedit /set disabledynamictick yes 2>$null
Write-Host "[OK] Platform clock settings applied" -ForegroundColor Green

# Set high timer resolution via registry
$mmPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile"
if (!(Test-Path $mmPath)) { New-Item -Path $mmPath -Force | Out-Null }
Set-ItemProperty -Path $mmPath -Name "SystemResponsiveness" -Value 0 -Type DWord
Write-Host "[OK] System responsiveness set to 0 (max priority to foreground)" -ForegroundColor Green

# Gaming priority
$gamingPath = "$mmPath\Tasks\Games"
if (!(Test-Path $gamingPath)) { New-Item -Path $gamingPath -Force | Out-Null }
Set-ItemProperty -Path $gamingPath -Name "GPU Priority" -Value 8 -Type DWord
Set-ItemProperty -Path $gamingPath -Name "Priority" -Value 6 -Type DWord
Set-ItemProperty -Path $gamingPath -Name "Scheduling Category" -Value "High" -Type String
Write-Host "[OK] Gaming task priority set to High" -ForegroundColor Green

Write-Host "`nDone! Restart required." -ForegroundColor Cyan
