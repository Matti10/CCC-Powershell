#start logging
$timestamp = Get-Date -Format "dd-MM-yyyy-hh-mm-ss"
Start-Transcript -Path "C:\CCC-Powershell\fixWindows\fixWindows-$timeStamp"

#stop update service
try {
    Get-Service -Name "Windows Update" | Set-Service -Status Stopped  -Verbose
}
catch {
    Write-Host -ForegroundColor Yellow "Failed to stop windows update service, likely as its being used currently. This is non-critical to overall functionality as service will still not start on startup"
}

#disable stop it from starting again
Write-Host "Setting Start key in HKLM:\SYSTEM\CurrentControlSet\Services\wuauserv too 4 to disable update service boot"
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\wuauserv" -Name Start -Value 4 -Verbose


Stop-Transcript