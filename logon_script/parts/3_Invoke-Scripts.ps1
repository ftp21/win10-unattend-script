function Invoke-Scripts {
    $pp=Split-Path -parent $PSScriptRoot
    $Path=Join-Path -Path $pp -ChildPath "\conf\scripts\"


    # Ricerca tutti i file con estensione ".ps1", ".bat" o ".cmd"
    $files = Get-ChildItem -Path $Path -Recurse -Include *.ps1, *.bat, *.cmd

    # Cicla attraverso i file trovati
    foreach ($file in $files) {
        if ($file.Extension -eq '.ps1') {
            # Se il file è uno script PowerShell, verifica se esiste un file di argomenti
            $argumentsFile = Join-Path -Path $file.DirectoryName -ChildPath ($file.BaseName + ".txt")
            if (Test-Path $argumentsFile) {
                # Leggi il contenuto del file di argomenti e usa i suoi valori come argomenti dello script
                $arguments = Get-Content $argumentsFile
                & $file.FullName $arguments
            }
            else {
                # Nessun file di argomenti, esegui lo script senza argomenti
                & $file.FullName
            }
        }
        else {
            # Se il file è un file batch o un file batch DOS, eseguilo direttamente
            & $file.FullName
        }
    }
}
