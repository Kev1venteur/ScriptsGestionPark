@echo off
for /f %%i in (IPmaster.txt) do (
xcopy "F:\Z\_bat\_scripts_kevin\scripts_envoyes_clients" "\\%%i\C$\ProgramData\Microsoft\Windows\" /E/y/r/d
echo %%i>>log.txt
start cmd /c ..\PSTools\psexec.exe -s \\%%i "\\%%i\C$\ProgramData\Microsoft\Windows\install_veyon_master.bat"
)
pause
