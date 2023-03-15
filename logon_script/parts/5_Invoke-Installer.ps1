function Invoke-Installer {

    $pp=Split-Path -parent $PSScriptRoot
    $Path=Join-Path -Path $pp  -ChildPath "\conf\installers\"

    # Ricerca tutti i file con estensione ".msi" o ".exe"
    $files = Get-ChildItem -Path $Path -Recurse -Include *.msi, *.exe

    # Cicla attraverso i file trovati
    foreach ($file in $files) {
        if ($file.Extension -eq '.msi' -or $file.Extension -eq '.exe') {
            # Verifica se esiste un file di argomenti
            $argumentsFile = Join-Path -Path $file.DirectoryName -ChildPath ($file.BaseName + ".txt")
            if (Test-Path $argumentsFile) {
                # Leggi il contenuto del file di argomenti e usa i suoi valori come argomenti per l'installazione
                $arguments = Get-Content $argumentsFile
                $process = Start-Process -FilePath $file.FullName -ArgumentList $arguments -Wait -PassThru
                if ($process.ExitCode -ne 0) {
                    Write-Error "L'installazione di $($file.Name) ha restituito il codice di errore $($process.ExitCode)."
                }
            }
            else {
                # Nessun file di argomenti, esegui l'installazione senza argomenti
                $process = Start-Process -FilePath $file.FullName -Wait -PassThru
                if ($process.ExitCode -ne 0) {
                    Write-Error "L'installazione di $($file.Name) ha restituito il codice di errore $($process.ExitCode)."
                }
            }
        }
    }
}
