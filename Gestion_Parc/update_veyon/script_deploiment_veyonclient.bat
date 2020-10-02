@echo off
echo %date%>log.txt
for /f %%i in (IPclient.txt) do (
xcopy "F:\Z\_bat\_scripts_kevin\scripts_envoyes_clients" "\\%%i\C$\ProgramData\Microsoft\Windows\" /E/y/r/d
echo %%i>>log.txt
start cmd /c ..\PSTools\psexec.exe -s \\%%i "\\%%i\C$\ProgramData\Microsoft\Windows\install_veyon_client.bat"
)
pause
