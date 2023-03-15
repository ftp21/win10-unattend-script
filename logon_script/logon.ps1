$script_path = "logon_script\"
$script_name = "logon.ps1"
$driveLetters = (Get-PSDrive -PSProvider 'FileSystem' | Where-Object { Test-Path $_.Root } | ForEach-Object { $_.Name })

$found = $false
foreach ($drive in $driveLetters) {
    $path = Join-Path -Path "$drive`:\" -ChildPath $script_path$script_name
    if (Test-Path -Path $path -PathType Leaf) {
        $script_path=Join-Path -Path "$drive`:\" -ChildPath $script_path
        $found = $true
        break
    }
}

if ($found) {
    
    # Imposta il percorso della cartella contenente i moduli
    $modulesFolder = "$script_path\parts\"

    # Cerca tutti i file con estensione ".ps1" nella cartella dei moduli e li importa come moduli
    Get-ChildItem -Path $modulesFolder -Filter *.ps1 | Where-Object { $_.Name -match '^\d+_' }  | ForEach-Object {
        $mod
        $mod=$_.BaseName -replace '^\d+_', ''

        $mod_path=Join-Path -Path $modulesFolder -ChildPath $_.Name
        Import-Module $mod_path
        Invoke-Expression $mod
        #Import-Module $_.Name
        #Invoke-Command -ScriptBlock { & $mod }
        #Remove-Module $mod

    }


} else {
    Write-Error "File '$script_path' not found on any drive."
}