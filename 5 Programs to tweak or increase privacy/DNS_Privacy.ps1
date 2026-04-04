# DNS Privacy — WinTweaks
# Sets DNS to privacy-respecting providers

Write-Host "=== DNS Privacy Configuration ===" -ForegroundColor Cyan

$adapters = Get-NetAdapter | Where-Object { $_.Status -eq "Up" }

foreach ($adapter in $adapters) {
    # Set Cloudflare DNS (privacy-focused, fast)
    Set-DnsClientServerAddress -InterfaceIndex $adapter.ifIndex -ServerAddresses ("1.1.1.1", "1.0.0.1")
    Write-Host "[OK] $($adapter.Name) — DNS set to Cloudflare (1.1.1.1 / 1.0.0.1)" -ForegroundColor Green
}

# Flush DNS cache
ipconfig /flushdns | Out-Null
Write-Host "[OK] DNS cache flushed" -ForegroundColor Green

# Disable DNS over HTTPS smart multi-homed resolution
$dnsParams = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient"
if (!(Test-Path $dnsParams)) { New-Item -Path $dnsParams -Force | Out-Null }
Set-ItemProperty -Path $dnsParams -Name "DisableSmartNameResolution" -Value 1 -Type DWord
Write-Host "[OK] Smart multi-homed name resolution disabled" -ForegroundColor Green

Write-Host "`nDone!" -ForegroundColor Cyan
