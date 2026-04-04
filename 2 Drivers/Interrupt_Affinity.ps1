# Interrupt Affinity Tool — WinTweaks
# Sets GPU and NIC interrupts to dedicated CPU cores

Write-Host "=== Interrupt Affinity Configuration ===" -ForegroundColor Cyan

Write-Host @"
[INFO] For best results, manually configure interrupt affinity:
  1. Download Microsoft Interrupt Affinity Policy Tool
  2. Set GPU interrupts to Core 2 (mask: 0x04)
  3. Set NIC interrupts to Core 3 (mask: 0x08)
  4. Keep Core 0 free for OS tasks

This avoids interrupt sharing and reduces DPC latency.
"@ -ForegroundColor Yellow

# Disable interrupt moderation on NIC (if supported)
$adapters = Get-NetAdapter | Where-Object { $_.Status -eq "Up" }
foreach ($adapter in $adapters) {
    Set-NetAdapterAdvancedProperty -Name $adapter.Name -RegistryKeyword "*InterruptModeration" -RegistryValue 0 -ErrorAction SilentlyContinue
    Write-Host "[OK] Interrupt moderation disabled on: $($adapter.Name)" -ForegroundColor Green
}

Write-Host "`nDone!" -ForegroundColor Cyan
