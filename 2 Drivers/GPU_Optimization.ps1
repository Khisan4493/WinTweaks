# GPU Optimization Script — WinTweaks
# Applies driver-level tweaks for NVIDIA and AMD GPUs

Write-Host "=== GPU Optimization ===" -ForegroundColor Cyan

# NVIDIA — Disable shader cache throttle, optimize for performance
$nvPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000"
if (Test-Path $nvPath) {
    Set-ItemProperty -Path $nvPath -Name "RMHdcpKeyglobZero" -Value 1 -Type DWord -ErrorAction SilentlyContinue
    Set-ItemProperty -Path $nvPath -Name "PowerMizerEnable" -Value 1 -Type DWord -ErrorAction SilentlyContinue
    Set-ItemProperty -Path $nvPath -Name "PowerMizerLevel" -Value 1 -Type DWord -ErrorAction SilentlyContinue
    Set-ItemProperty -Path $nvPath -Name "PerfLevelSrc" -Value 8738 -Type DWord -ErrorAction SilentlyContinue
    Write-Host "[OK] NVIDIA driver tweaks applied" -ForegroundColor Green
} else {
    Write-Host "[SKIP] NVIDIA GPU not detected" -ForegroundColor Yellow
}

# Disable GPU idle states for lower latency
$gpuPower = "HKLM:\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000"
if (Test-Path $gpuPower) {
    Set-ItemProperty -Path $gpuPower -Name "DisableDynamicPstate" -Value 1 -Type DWord -ErrorAction SilentlyContinue
    Write-Host "[OK] GPU dynamic P-states disabled" -ForegroundColor Green
}

Write-Host "`nDone! Restart required." -ForegroundColor Cyan
