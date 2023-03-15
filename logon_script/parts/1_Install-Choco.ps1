function Install-Choco {

    $pp=Split-Path -parent $PSScriptRoot
    $Path=Join-Path -Path $pp -ChildPath "\conf\choco\packages.config"

    
    if (-Not (Test-Path "$($env:ProgramData)\chocolatey\choco.exe")) {
        Set-ExecutionPolicy Bypass -Scope Process -Force
        [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
        Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
    }

    choco feature enable -n allowGlobalConfirmation
    choco feature enable -n allowEmptyChecksums
    choco install $Path -y --ignore-checksums


}
