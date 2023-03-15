for %%i in (b c d e f g h i j k l m n o p q r s t u v w x y z) do (
	if exist %%i:\logon_script\logon.ps1 cmd /c powershell -ExecutionPolicy ByPass -File %%i:\logon_script\logon.ps1
)