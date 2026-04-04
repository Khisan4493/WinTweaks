# Network Interface Card Tweaks — WinTweaks
# Optimizes NIC settings for lower latency in online games

Write-Host "=== NIC Latency Optimization ===" -ForegroundColor Cyan

# Disable Nagle's Algorithm
$tcpParams = "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters"
Set-ItemProperty -Path $tcpParams -Name "TcpAckFrequency" -Value 1 -Type DWord
Set-ItemProperty -Path $tcpParams -Name "TCPNoDelay" -Value 1 -Type DWord
Set-ItemProperty -Path $tcpParams -Name "TcpDelAckTicks" -Value 0 -Type DWord
Write-Host "[OK] Nagle's Algorithm disabled" -ForegroundColor Green

# Disable Network Throttling
$mmPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile"
Set-ItemProperty -Path $mmPath -Name "NetworkThrottlingIndex" -Value 0xFFFFFFFF -Type DWord
Set-ItemProperty -Path $mmPath -Name "SystemResponsiveness" -Value 0 -Type DWord
Write-Host "[OK] Network throttling disabled" -ForegroundColor Green

# Disable auto-tuning
netsh int tcp set global autotuninglevel=disabled
netsh int tcp set global rss=enabled
Write-Host "[OK] TCP auto-tuning disabled, RSS enabled" -ForegroundColor Green

Write-Host "`nDone! Restart recommended." -ForegroundColor Cyan
