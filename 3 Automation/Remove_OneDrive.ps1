# Remove OneDrive — WinTweaks
# Completely removes Microsoft OneDrive

Write-Host "=== OneDrive Removal ===" -ForegroundColor Cyan

# Kill OneDrive process
Stop-Process -Name "OneDrive" -Force -ErrorAction SilentlyContinue
Start-Sleep -Seconds 2

# Uninstall
$x86 = "$env:SystemRoot\System32\OneDriveSetup.exe"
$x64 = "$env:SystemRoot\SysWOW64\OneDriveSetup.exe"

if (Test-Path $x64) {
    & $x64 /uninstall
} elseif (Test-Path $x86) {
    & $x86 /uninstall
}
Write-Host "[OK] OneDrive uninstalled" -ForegroundColor Green

# Remove leftover folders
Remove-Item "$env:USERPROFILE\OneDrive" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "$env:LOCALAPPDATA\Microsoft\OneDrive" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "C:\OneDriveTemp" -Recurse -Force -ErrorAction SilentlyContinue

# Remove from Explorer sidebar
$clsid = "HKCR:\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}"
if (Test-Path $clsid) {
    Set-ItemProperty -Path $clsid -Name "System.IsPinnedToNameSpaceTree" -Value 0
}
Write-Host "[OK] OneDrive removed from Explorer" -ForegroundColor Green

Write-Host "`nDone!" -ForegroundColor Cyan
