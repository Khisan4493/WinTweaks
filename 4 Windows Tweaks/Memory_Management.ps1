# Memory Management — WinTweaks
# Optimizes RAM usage, page file, and standby list

Write-Host "=== Memory Management Tweaks ===" -ForegroundColor Cyan

# Disable Superfetch / SysMain
Stop-Service -Name "SysMain" -Force -ErrorAction SilentlyContinue
Set-Service -Name "SysMain" -StartupType Disabled -ErrorAction SilentlyContinue
Write-Host "[OK] SysMain (Superfetch) disabled" -ForegroundColor Green

# Disable prefetch
$prefetchPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters"
Set-ItemProperty -Path $prefetchPath -Name "EnablePrefetcher" -Value 0 -Type DWord
Set-ItemProperty -Path $prefetchPath -Name "EnableSuperfetch" -Value 0 -Type DWord
Write-Host "[OK] Prefetcher disabled" -ForegroundColor Green

# Large system cache
$mmPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management"
Set-ItemProperty -Path $mmPath -Name "LargeSystemCache" -Value 0 -Type DWord
Set-ItemProperty -Path $mmPath -Name "DisablePagingExecutive" -Value 1 -Type DWord
Write-Host "[OK] Paging executive disabled (keeps kernel in RAM)" -ForegroundColor Green

# Clear standby list on high usage (requires EmptyStandbyList.exe)
Write-Host "[INFO] For standby list cleaning, use EmptyStandbyList.exe via Task Scheduler" -ForegroundColor Yellow

Write-Host "`nDone! Restart required." -ForegroundColor Cyan
