function Install-WindowsFeatures {


    $pp=Split-Path -parent $PSScriptRoot
    $Path=Join-Path -Path $pp -ChildPath "\conf\features\features.txt" 
    if (-not (Test-Path $Path)) {
        Write-Error "Il file $Path non esiste."
        return
    }

    try {
        $features = Get-Content $Path
    }
    catch {
        Write-Error "Impossibile leggere il file $Path."
        return
    }

    foreach ($feature in $features) {
        if ($feature.StartsWith("!")) {
            $featureName = $feature.Substring(1)
            Write-Verbose "Disinstallazione della funzionalità $featureName."
            try {
                dism /Online /Disable-Feature /FeatureName:$featureName /NoRestart
                Write-Verbose "La funzionalità $featureName è stata disinstallata con successo."
            }
            catch {
                Write-Error "Impossibile disinstallare la funzionalità $featureName $_"
            }
        }
        else {
            $featureName = $feature
            Write-Verbose "Installazione della funzionalità $featureName."
            try {
                dism /Online /Enable-Feature /FeatureName:$featureName /NoRestart
                Write-Verbose "La funzionalità $featureName è stata installata con successo."
            }
            catch {
                Write-Error "Impossibile installare la funzionalità $featureName $_"
            }
        }
    }
}
