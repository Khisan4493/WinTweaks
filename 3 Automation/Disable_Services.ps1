# Disable Unnecessary Services — WinTweaks
# Stops and disables services that waste resources

Write-Host "=== Service Optimizer ===" -ForegroundColor Cyan

$servicesToDisable = @(
    "DiagTrack"              # Diagnostics Tracking (telemetry)
    "dmwappushservice"       # WAP Push Message Routing
    "SysMain"                # Superfetch
    "WSearch"                # Windows Search indexer
    "MapsBroker"             # Downloaded Maps Manager
    "lfsvc"                  # Geolocation Service
    "RetailDemo"             # Retail Demo Service
    "wisvc"                  # Windows Insider Service
    "WerSvc"                 # Windows Error Reporting
    "Fax"                    # Fax service
    "XblAuthManager"         # Xbox Live Auth
    "XblGameSave"            # Xbox Live Game Save
    "XboxNetApiSvc"          # Xbox Live Networking
    "XboxGipSvc"             # Xbox Accessory Management
    "TabletInputService"     # Touch Keyboard
    "PhoneSvc"               # Phone Service
    "RemoteRegistry"         # Remote Registry
    "TrkWks"                 # Distributed Link Tracking
)

foreach ($svc in $servicesToDisable) {
    $service = Get-Service -Name $svc -ErrorAction SilentlyContinue
    if ($service) {
        Stop-Service -Name $svc -Force -ErrorAction SilentlyContinue
        Set-Service -Name $svc -StartupType Disabled -ErrorAction SilentlyContinue
        Write-Host "[DISABLED] $svc — $($service.DisplayName)" -ForegroundColor Green
    }
}

Write-Host "`nDone! Restart recommended." -ForegroundColor Cyan
