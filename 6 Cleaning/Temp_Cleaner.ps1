# Temp File Cleaner — WinTweaks
# Removes temporary files, caches, and logs

Write-Host "=== Temp File Cleaner ===" -ForegroundColor Cyan

$paths = @(
    "$env:TEMP"
    "$env:SystemRoot\Temp"
    "$env:SystemRoot\Prefetch"
    "$env:LOCALAPPDATA\Temp"
    "$env:SystemRoot\SoftwareDistribution\Download"
)

$totalSize = 0

foreach ($path in $paths) {
    if (Test-Path $path) {
        $items = Get-ChildItem -Path $path -Recurse -Force -ErrorAction SilentlyContinue
        $size = ($items | Measure-Object -Property Length -Sum -ErrorAction SilentlyContinue).Sum
        $totalSize += $size
        Remove-Item -Path "$path\*" -Recurse -Force -ErrorAction SilentlyContinue
        Write-Host "[CLEANED] $path" -ForegroundColor Green
    }
}

$freedMB = [math]::Round($totalSize / 1MB, 2)
Write-Host "`n[OK] Freed approximately $freedMB MB" -ForegroundColor Cyan
