function Import-RegFiles {
    $pp=Split-Path -parent $PSScriptRoot
    $Path=Join-Path -Path $pp  -ChildPath "\conf\reg\"


    # Ottieni tutti i file di registro nella directory specificata
    $files = Get-ChildItem -Path $Path -Filter *.reg -File

    # Importa ogni file di registro trovato
    foreach ($file in $files) {
        Write-Output "Importing registry file $($file.FullName)"
        try {
            # Utilizza il cmdlet "reg.exe" per importare il file di registro
            reg.exe import $file.FullName | Out-Null
        } catch {
            Write-Warning "Failed to import registry file $($file.FullName): $_"
        }
    }
}
