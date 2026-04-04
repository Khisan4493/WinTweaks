# Firewall Rules — WinTweaks
# Blocks telemetry and tracking via Windows Firewall

Write-Host "=== Privacy Firewall Rules ===" -ForegroundColor Cyan

$blockIPs = @(
    "13.107.4.50"
    "13.107.5.88"
    "13.78.232.226"
    "13.64.90.137"
    "40.77.228.92"
    "40.115.119.185"
    "52.178.38.151"
    "65.52.100.7"
    "65.52.100.91"
    "65.52.100.93"
    "65.55.44.108"
    "65.55.252.63"
    "131.253.40.37"
    "134.170.30.202"
    "134.170.115.60"
    "157.56.91.77"
    "204.79.197.200"
)

# Create outbound block rules
foreach ($ip in $blockIPs) {
    $ruleName = "WinTweaks_Block_$($ip.Replace('.','_'))"
    $existing = Get-NetFirewallRule -DisplayName $ruleName -ErrorAction SilentlyContinue
    if (!$existing) {
        New-NetFirewallRule -DisplayName $ruleName -Direction Outbound -RemoteAddress $ip -Action Block | Out-Null
        Write-Host "[BLOCKED] $ip" -ForegroundColor Green
    }
}

Write-Host "`n[OK] Telemetry IPs blocked via firewall." -ForegroundColor Cyan
