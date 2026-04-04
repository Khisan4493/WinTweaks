# Network TCP Tweaks — WinTweaks
# Optimizes TCP/IP stack for gaming

Write-Host "=== Network TCP Optimization ===" -ForegroundColor Cyan

# TCP optimizations
netsh int tcp set global autotuninglevel=disabled
netsh int tcp set global chimney=disabled
netsh int tcp set global ecncapability=disabled
netsh int tcp set global timestamps=disabled
netsh int tcp set global rsc=disabled
Write-Host "[OK] TCP global settings optimized" -ForegroundColor Green

# DNS cache optimization
$dnsPath = "HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters"
Set-ItemProperty -Path $dnsPath -Name "MaxCacheEntryTtlLimit" -Value 86400 -Type DWord
Set-ItemProperty -Path $dnsPath -Name "MaxNegativeCacheTtl" -Value 0 -Type DWord
Write-Host "[OK] DNS cache optimized" -ForegroundColor Green

# Disable Windows auto-tuning for stable latency
netsh winsock reset 2>$null
Write-Host "[OK] Winsock reset" -ForegroundColor Green

Write-Host "`nDone! Restart required." -ForegroundColor Cyan
