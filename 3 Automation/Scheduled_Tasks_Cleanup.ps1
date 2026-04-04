# Scheduled Tasks Cleanup — WinTweaks
# Disables telemetry and bloat scheduled tasks

Write-Host "=== Scheduled Tasks Cleanup ===" -ForegroundColor Cyan

$tasksToDisable = @(
    "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser"
    "\Microsoft\Windows\Application Experience\ProgramDataUpdater"
    "\Microsoft\Windows\Autochk\Proxy"
    "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator"
    "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip"
    "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector"
    "\Microsoft\Windows\Feedback\Siuf\DmClient"
    "\Microsoft\Windows\Maps\MapsUpdateTask"
    "\Microsoft\Windows\Maps\MapsToastTask"
    "\Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem"
    "\Microsoft\Windows\Shell\FamilySafetyMonitor"
    "\Microsoft\Windows\Shell\FamilySafetyRefreshTask"
    "\Microsoft\Windows\Windows Error Reporting\QueueReporting"
    "\Microsoft\XblGameSave\XblGameSaveTask"
)

foreach ($task in $tasksToDisable) {
    schtasks /Change /TN $task /Disable 2>$null
    if ($LASTEXITCODE -eq 0) {
        Write-Host "[DISABLED] $task" -ForegroundColor Green
    }
}

Write-Host "`nDone!" -ForegroundColor Cyan
