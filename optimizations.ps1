$window = (Get-Host).UI.RawUI
$windowSize = $window.WindowSize
$bufferSize = $window.BufferSize
$windowPosition = $window.WindowPosition

$windowSize.Width = 80
$windowSize.Height = 30
$window.WindowSize = $windowSize
$bufferSize.Width = $windowSize.Width
$bufferSize.Height = 300
$window.BufferSize = $bufferSize
$windowPosition.X = 0
$windowPosition.Y = 0
$window.WindowPosition = $windowPosition

# FPS-Boosting and System Optimization Functions

function Clear-TempFiles {
    Write-Host "`nClearing Temp Files..." -ForegroundColor Yellow
    Remove-Item -Path "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item -Path "$env:WINDIR\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue
    Write-Host "Temp files cleared successfully." -ForegroundColor Green
}

function Optimize-StartupPrograms {
    Write-Host "`nListing Startup Programs..." -ForegroundColor Yellow
    Get-CimInstance Win32_StartupCommand | Select-Object -Property Name, Command, User | Format-Table -AutoSize
    Write-Host "`nTip: Use Task Manager to disable unnecessary startup programs." -ForegroundColor Green
}

function Stop-Services {
    Write-Host "`nStopping Non-Essential Services..." -ForegroundColor Yellow
    $services = @("DiagTrack", "SysMain", "MapsBroker", "WSearch")
    foreach ($service in $services) {
        Stop-Service -Name $service -ErrorAction SilentlyContinue
        Set-Service -Name $service -StartupType Disabled
    }
    Write-Host "Services stopped and disabled." -ForegroundColor Green
}

function Disable-BackgroundApps {
    Write-Host "`nDisabling Unwanted Background Apps..." -ForegroundColor Yellow
    Get-AppxPackage | Where-Object {$_.NonRemovable -eq $false} | ForEach-Object {Stop-Process -Name $_.Name -ErrorAction SilentlyContinue}
    Write-Host "Unwanted background apps have been disabled." -ForegroundColor Green
}

function Remove-Bloatware {
    Write-Host "`nRemoving Common Bloatware..." -ForegroundColor Yellow
    $bloatware = @("Microsoft.3DBuilder", "Microsoft.BingFinance", "Microsoft.BingNews", "Microsoft.BingSports", "Microsoft.BingWeather", "Microsoft.GetHelp", "Microsoft.Getstarted", "Microsoft.MicrosoftOfficeHub", "Microsoft.MicrosoftSolitaireCollection", "Microsoft.Office.Sway", "Microsoft.People", "Microsoft.SkypeApp", "Microsoft.WindowsMaps", "Microsoft.WindowsSoundRecorder", "Microsoft.XboxApp")
    foreach ($app in $bloatware) {
        Get-AppxPackage $app -AllUsers | Remove-AppxPackage -ErrorAction SilentlyContinue
    }
    Write-Host "Bloatware removed." -ForegroundColor Green
}

function Manage-ScheduledTasks {
    Write-Host "`nDisabling Unnecessary Scheduled Tasks..." -ForegroundColor Yellow
    $tasks = @("Microsoft\Windows\Customer Experience Improvement Program\Consolidator", "Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask", "Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask", "Microsoft\Windows\Windows Update\Scheduled Start")
    foreach ($task in $tasks) {
        Disable-ScheduledTask -TaskName $task -ErrorAction SilentlyContinue
    }
    Write-Host "Scheduled tasks disabled." -ForegroundColor Green
}

function Check-WindowsUpdates {
    Write-Host "`nChecking for Windows Updates..." -ForegroundColor Yellow
    Get-WindowsUpdate | Out-Null
    Write-Host "Windows Update check completed." -ForegroundColor Green
}

function Run-SystemMaintenance {
    Write-Host "`nRunning System Maintenance..." -ForegroundColor Yellow
    Start-Process -FilePath "msdt.exe" -ArgumentList "/id PerformanceDiagnostic" -NoNewWindow -Wait
    Write-Host "System maintenance completed." -ForegroundColor Green
}

function Disable-VisualEffects {
    Write-Host "`nDisabling Visual Effects for better performance..." -ForegroundColor Yellow
    $visualEffectsKey = "HKCU:\Control Panel\Desktop"
    Set-ItemProperty -Path $visualEffectsKey -Name "VisualFXSetting" -Value 2 -Force
    Write-Host "Visual effects disabled." -ForegroundColor Green
}

function Set-PowerPlanPerformance {
    Write-Host "`nSetting Power Plan to High Performance..." -ForegroundColor Yellow
    powercfg -setactive SCHEME_MIN
    Write-Host "High Performance power plan enabled." -ForegroundColor Green
}

function Clear-WindowsUpdateCache {
    Write-Host "`nClearing Windows Update Cache..." -ForegroundColor Yellow
    Stop-Service -Name wuauserv -Force
    Remove-Item -Path "C:\Windows\SoftwareDistribution\Download\*" -Recurse -Force -ErrorAction SilentlyContinue
    Start-Service -Name wuauserv
    Write-Host "Windows Update cache cleared." -ForegroundColor Green
}

function Clear-BrowserCache {
    Write-Host "`nClearing Browser Cache (for Microsoft Edge)..." -ForegroundColor Yellow
    Stop-Process -Name "msedge" -ErrorAction SilentlyContinue
    $edgeCachePath = "$env:LOCALAPPDATA\Microsoft\Edge\User Data\Default\Cache\*"
    Remove-Item -Path $edgeCachePath -Recurse -Force -ErrorAction SilentlyContinue
    Write-Host "Browser cache cleared." -ForegroundColor Green
}

function Defrag-Disks {
    Write-Host "`nDefragmenting Disk Drives..." -ForegroundColor Yellow
    defrag C: -w
    Write-Host "Disk defragmentation completed." -ForegroundColor Green
}

function Optimize-Network {
    Write-Host "`nOptimizing Network Settings..." -ForegroundColor Yellow
    # Example: Disable TCP Offload
    Set-NetOffloadGlobalSetting -IPv4OffloadEnabled $false -IPv6OffloadEnabled $false
    Write-Host "Network settings optimized." -ForegroundColor Green
}

function Show-SystemInfo {
    Write-Host "`nSystem Information:" -ForegroundColor Yellow
    Get-ComputerInfo | Select-Object -Property CsName, OsArchitecture, WindowsVersion, WindowsBuildLabEx | Format-Table -AutoSize
}

# New FPS-boosting functions
function Disable-GameMode {
    Write-Host "`nDisabling Game Mode..." -ForegroundColor Yellow
    New-ItemProperty -Path "HKCU:\Software\Microsoft\GameBar" -Name "AllowAutoGameMode" -PropertyType DWord -Value 0 -Force | Out-Null
    Write-Host "Game Mode disabled." -ForegroundColor Green
}

function Disable-FullScreenOptimizations {
    Write-Host "`nDisabling Full Screen Optimizations..." -ForegroundColor Yellow
    New-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_FSEBehaviorMode" -PropertyType DWord -Value 2 -Force | Out-Null
    Write-Host "Full Screen Optimizations disabled." -ForegroundColor Green
}

function Disable-XboxDVR {
    Write-Host "`nDisabling Xbox Game DVR..." -ForegroundColor Yellow
    New-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_Enabled" -PropertyType DWord -Value 0 -Force | Out-Null
    New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\GameDVR" -Name "AppCaptureEnabled" -PropertyType DWord -Value 0 -Force | Out-Null
    Write-Host "Xbox Game DVR disabled." -ForegroundColor Green
}

function Disable-Notifications {
    Write-Host "`nDisabling Notifications..." -ForegroundColor Yellow
    New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\PushNotifications" -Name "ToastEnabled" -PropertyType DWord -Value 0 -Force | Out-Null
    Write-Host "Notifications disabled." -ForegroundColor Green
}

function Disable-BackgroundIntelligenceTransferService {
    Write-Host "`nStopping Background Intelligent Transfer Service (BITS)..." -ForegroundColor Yellow
    Stop-Service -Name BITS -Force -ErrorAction SilentlyContinue
    Set-Service -Name BITS -StartupType Disabled
    Write-Host "Background Intelligent Transfer Service disabled." -ForegroundColor Green
}

function Disable-OneDrive {
    Write-Host "`nDisabling OneDrive Sync..." -ForegroundColor Yellow
    Stop-Process -Name OneDrive -Force -ErrorAction SilentlyContinue
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\OneDrive" -Name "DisableFileSync" -Value 1
    Write-Host "OneDrive sync disabled." -ForegroundColor Green
}

function Set-HighPerformancePowerPlan {
    Write-Host "`nSetting High-Performance Power Plan..." -ForegroundColor Yellow
    powercfg -setactive SCHEME_MIN
    Write-Host "High-Performance Power Plan enabled." -ForegroundColor Green
}

function Disable-AnimationsAndTransparency {
    Write-Host "`nDisabling Windows animations and transparency..." -ForegroundColor Yellow
    # Disable Animations
    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "UserPreferencesMask" -Value ([byte[]](0x90,0x12,0x03,0x80,0x12,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00))
    # Disable Transparency
    New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "EnableTransparency" -PropertyType DWord -Value 0 -Force | Out-Null
    Write-Host "Animations and transparency disabled." -ForegroundColor Green
}

# Main Menu
function Show-Menu {
    Clear-Host
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host "         FPS BOOST OPTIMIZATION TOOL    " -ForegroundColor Yellow
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host "1. Clear Temp Files"
    Write-Host "2. Optimize Startup Programs"
    Write-Host "3. Stop Non-Essential Services"
    Write-Host "4. Disable Unwanted Background Apps"
    Write-Host "5. Remove Common Bloatware"
    Write-Host "6. Manage Scheduled Tasks"
    Write-Host "7. Check for Windows Updates"
    Write-Host "8. Run System Maintenance"
    Write-Host "9. Disable Visual Effects"
    Write-Host "10. Set Power Plan to High Performance"
    Write-Host "11. Clear Windows Update Cache"
    Write-Host "12. Clear Browser Cache"
    Write-Host "13. Defragment Disk Drives"
    Write-Host "14. Optimize Network Settings"
    Write-Host "15. Show System Information"
    Write-Host "16. Disable Game Mode"
    Write-Host "17. Disable Full-Screen Optimizations"
    Write-Host "18. Disable Xbox Game DVR"
    Write-Host "19. Disable Notifications"
    Write-Host "20. Disable Background Intelligence Transfer Service"
    Write-Host "21. Disable OneDrive"
    Write-Host "22. Set High-Performance Power Plan"
    Write-Host "23. Disable Animations and Transparency"
    Write-Host "0. Exit"
    Write-Host "========================================" -ForegroundColor Cyan
}

# Main Loop
do {
    Show-Menu
    $choice = Read-Host "Enter your choice (0 to exit)"
    
    switch ($choice) {
        '1' { Clear-TempFiles }
        '2' { Optimize-StartupPrograms }
        '3' { Stop-Services }
        '4' { Disable-BackgroundApps }
        '5' { Remove-Bloatware }
        '6' { Manage-ScheduledTasks }
        '7' { Check-WindowsUpdates }
        '8' { Run-SystemMaintenance }
        '9' { Disable-VisualEffects }
        '10' { Set-PowerPlanPerformance }
        '11' { Clear-WindowsUpdateCache }
        '12' { Clear-BrowserCache }
        '13' { Defrag-Disks }
        '14' { Optimize-Network }
        '15' { Show-SystemInfo }
        '16' { Disable-GameMode }
        '17' { Disable-FullScreenOptimizations }
        '18' { Disable-XboxDVR }
        '19' { Disable-Notifications }
        '20' { Disable-BackgroundIntelligenceTransferService }
        '21' { Disable-OneDrive }
        '22' { Set-HighPerformancePowerPlan }
        '23' { Disable-AnimationsAndTransparency }
        '0' { Write-Host "Exiting..." -ForegroundColor Green }
        default { Write-Host "Invalid choice. Please select a valid option." -ForegroundColor Red }
    }
    
    if ($choice -ne '0') {
        Write-Host "`nPress any key to return to the menu..." -ForegroundColor Yellow
        [System.Console]::ReadKey($true) | Out-Null
    }

} while ($choice -ne '0')
