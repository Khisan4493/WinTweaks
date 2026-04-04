# USB Latency Fix — WinTweaks
# Disables USB power saving and selective suspend for peripherals

Write-Host "=== USB Latency Fix ===" -ForegroundColor Cyan

# Disable USB selective suspend
$usbPaths = Get-ChildItem "HKLM:\SYSTEM\CurrentControlSet\Enum\USB" -Recurse -ErrorAction SilentlyContinue |
    Where-Object { $_.PSChildName -eq "Device Parameters" }

foreach ($path in $usbPaths) {
    Set-ItemProperty -Path $path.PSPath -Name "EnhancedPowerManagementEnabled" -Value 0 -Type DWord -ErrorAction SilentlyContinue
    Set-ItemProperty -Path $path.PSPath -Name "AllowIdleIrpInD3" -Value 0 -Type DWord -ErrorAction SilentlyContinue
    Set-ItemProperty -Path $path.PSPath -Name "SelectiveSuspendEnabled" -Value 0 -Type DWord -ErrorAction SilentlyContinue
}
Write-Host "[OK] USB selective suspend disabled for all devices" -ForegroundColor Green

# Disable USB power management in power plan
powercfg /setacvalueindex SCHEME_CURRENT 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 0
powercfg /setactive SCHEME_CURRENT
Write-Host "[OK] USB power management disabled in power plan" -ForegroundColor Green

Write-Host "`nDone!" -ForegroundColor Cyan
