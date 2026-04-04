# Telemetry Blocker — WinTweaks
# Blocks Microsoft telemetry at multiple levels

Write-Host "=== Telemetry Blocker ===" -ForegroundColor Cyan

# Disable telemetry via registry
$dataCollection = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection"
if (!(Test-Path $dataCollection)) { New-Item -Path $dataCollection -Force | Out-Null }
Set-ItemProperty -Path $dataCollection -Name "AllowTelemetry" -Value 0 -Type DWord
Set-ItemProperty -Path $dataCollection -Name "MaxTelemetryAllowed" -Value 0 -Type DWord
Write-Host "[OK] Telemetry set to Security level (minimum)" -ForegroundColor Green

# Disable DiagTrack service
Stop-Service -Name "DiagTrack" -Force -ErrorAction SilentlyContinue
Set-Service -Name "DiagTrack" -StartupType Disabled
Write-Host "[OK] DiagTrack service disabled" -ForegroundColor Green

# Disable Connected User Experiences
Stop-Service -Name "dmwappushservice" -Force -ErrorAction SilentlyContinue
Set-Service -Name "dmwappushservice" -StartupType Disabled
Write-Host "[OK] dmwappushservice disabled" -ForegroundColor Green

# Block telemetry hosts via hosts file
$hostsFile = "$env:SystemRoot\System32\drivers\etc\hosts"
$telemetryHosts = @(
    "vortex.data.microsoft.com"
    "vortex-win.data.microsoft.com"
    "telecommand.telemetry.microsoft.com"
    "telecommand.telemetry.microsoft.com.nsatc.net"
    "oca.telemetry.microsoft.com"
    "sqm.telemetry.microsoft.com"
    "watson.telemetry.microsoft.com"
    "redir.metaservices.microsoft.com"
    "choice.microsoft.com"
    "choice.microsoft.com.nsatc.net"
    "settings-sandbox.data.microsoft.com"
)

$hostsContent = Get-Content $hostsFile -ErrorAction SilentlyContinue
foreach ($host_ in $telemetryHosts) {
    if ($hostsContent -notcontains "0.0.0.0 $host_") {
        Add-Content -Path $hostsFile -Value "0.0.0.0 $host_"
    }
}
Write-Host "[OK] Telemetry hosts blocked in hosts file" -ForegroundColor Green

Write-Host "`nDone!" -ForegroundColor Cyan
