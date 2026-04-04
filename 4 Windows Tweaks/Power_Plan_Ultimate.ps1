# Ultimate Performance Power Plan — WinTweaks
# Creates and activates a maxed-out power plan

Write-Host "=== Ultimate Performance Power Plan ===" -ForegroundColor Cyan

# Duplicate Ultimate Performance plan
powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 2>$null
if ($LASTEXITCODE -ne 0) {
    Write-Host "[INFO] Ultimate Performance scheme not available, duplicating High Performance..." -ForegroundColor Yellow
    powercfg -duplicatescheme 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
}

# Find and activate it
$plans = powercfg /list
$ultimate = ($plans | Select-String "Ultimate Performance" | Select-Object -First 1).ToString()
if ($ultimate -match "([a-f0-9-]{36})") {
    $guid = $matches[1]
    powercfg /setactive $guid
    Write-Host "[OK] Ultimate Performance plan activated: $guid" -ForegroundColor Green
}

# Disable power throttling
$throttlePath = "HKLM:\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling"
if (!(Test-Path $throttlePath)) { New-Item -Path $throttlePath -Force | Out-Null }
Set-ItemProperty -Path $throttlePath -Name "PowerThrottlingOff" -Value 1 -Type DWord
Write-Host "[OK] Power throttling disabled" -ForegroundColor Green

# Disable CPU parking
powercfg -setacvalueindex SCHEME_CURRENT SUB_PROCESSOR CPMINCORES 100
powercfg -setactive SCHEME_CURRENT
Write-Host "[OK] CPU core parking disabled" -ForegroundColor Green

Write-Host "`nDone!" -ForegroundColor Cyan
