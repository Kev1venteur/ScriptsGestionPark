@echo off
IF "%PROCESSOR_ARCHITECTURE%"=="x86" (set osbit=32) else (set osbit=64)
net use W: \\srvinfo\Z /USER:EDUCATION\gadmin 123789
W:\Logiciels\Veyon\Veyon_2019\veyon-4.3.2.0-win%osbit%-setup.exe /S /NoMaster
C:\Windows\System32\Robocopy.exe "W:\Logiciels\Veyon\Veyon_2019\Cle" "C:\Program Files\Veyon\Cle" /MIR > nul
net use W: /delete
