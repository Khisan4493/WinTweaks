# Prefetch Flush — WinTweaks
# Clears prefetch data for a fresh start

Write-Host "=== Prefetch Flush ===" -ForegroundColor Cyan

$prefetchPath = "$env:SystemRoot\Prefetch"
if (Test-Path $prefetchPath) {
    $count = (Get-ChildItem $prefetchPath -ErrorAction SilentlyContinue).Count
    Remove-Item "$prefetchPath\*" -Force -ErrorAction SilentlyContinue
    Write-Host "[OK] Cleared $count prefetch files" -ForegroundColor Green
} else {
    Write-Host "[SKIP] Prefetch folder not found" -ForegroundColor Yellow
}

Write-Host "`nDone!" -ForegroundColor Cyan
