# Disk Optimization — WinTweaks
# Runs disk cleanup and optimizes drives

Write-Host "=== Disk Optimization ===" -ForegroundColor Cyan

# Automated disk cleanup
$cleanupKeys = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches"
$categories = Get-ChildItem $cleanupKeys -ErrorAction SilentlyContinue
foreach ($cat in $categories) {
    Set-ItemProperty -Path $cat.PSPath -Name "StateFlags0099" -Value 2 -Type DWord -ErrorAction SilentlyContinue
}
Start-Process cleanmgr -ArgumentList "/sagerun:99" -Wait
Write-Host "[OK] Disk cleanup completed" -ForegroundColor Green

# Optimize/TRIM SSD
$drives = Get-PhysicalDisk | Where-Object { $_.MediaType -eq "SSD" }
if ($drives) {
    Optimize-Volume -DriveLetter C -ReTrim -Verbose
    Write-Host "[OK] SSD TRIM executed" -ForegroundColor Green
} else {
    Write-Host "[INFO] No SSD detected, skipping TRIM" -ForegroundColor Yellow
}

Write-Host "`nDone!" -ForegroundColor Cyan
