
Rem set drive
for %%i in (b c d e f g h i j k l m n o p q r s t u v w x y z) do (
	if exist %%i:\FirstRun\FirstRun.bat set DRIVE=%%i
)

Rem Install chocolatey
powershell.exe -command "& {Set-ExecutionPolicy -ExecutionPolicy Bypass -Force}"
powershell.exe -command [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
set PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin

Rem Install packages
cmd /c choco install %DRIVE%:\FirstRun\packages.config -y --ignore-checksums



Rem tweaks

for %%f in (%DRIVE%:\FirstRun\reg\*.reg) do (
    if "%%~xf"==".reg" reg import %%f
)


Rem ps1
for %%f in (%DRIVE%:\FirstRun\ps1\*.ps1) do (
    if "%%~xf"==".ps1" powershell -executionpolicy bypass -File %%f
)





Rem Install Win-for
cmd.exe /c %DRIVE%:\FirstRun\winfor-cli.exe -Install -IncludeWsl  


