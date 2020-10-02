@echo off
for /f %%i in (..\IP.txt) do (
xcopy "F:\Z\_bat\_scripts_kevin\scripts_envoyes_clients" "\\%%i\C$\ProgramData\Microsoft\Windows\" /E/y/r/d
start cmd /c ..\PSTools\psexec.exe -s \\%%i "\\%%i\C$\ProgramData\Microsoft\Windows\enable_firewall.bat"
)
PAUSE
