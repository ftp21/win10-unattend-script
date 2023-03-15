function Update-Windows {
    Write-Host "Install Nuget PackageProvider"
    Install-PackageProvider -Name NuGet -Confirm:$false -Force | Out-Null
    Write-Host "Install PendingReboot Module"
    Install-Module PendingReboot -Confirm:$false -Force | Out-Null
    Import-Module PendingReboot
    Write-Host "Install WindowsUpdate Module"
    Install-Module PSWindowsUpdate -Confirm:$false -Force | Out-Null

    Get-WindowsUpdate -Install -AcceptAll -Confirm:$false


}