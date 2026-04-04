# DNS Cache Clear — WinTweaks
# Flushes DNS resolver cache

Write-Host "=== DNS Cache Clear ===" -ForegroundColor Cyan

ipconfig /flushdns
Clear-DnsClientCache
Write-Host "[OK] DNS cache flushed" -ForegroundColor Green

Write-Host "`nDone!" -ForegroundColor Cyan
