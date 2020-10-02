@echo off
taskkill /IM veyon-master.exe /F
taskkill /IM veyon-configurator.exe /F
IF "%PROCESSOR_ARCHITECTURE%"=="x86" (set osbit=32) else (set osbit=64)
net use P: \\srvinfo\Z /USER:EDUCATION\gadmin 123789
P:\Logiciels\Veyon\Veyon_2019\veyon-4.3.2.0-win%osbit%-setup.exe /S /ApplyConfig="P:\Logiciels\Veyon\Veyon_2019\Conf\conf_maitre.json"
C:\Windows\System32\Robocopy.exe "P:\Logiciels\Veyon\Veyon_2019\Cle" "C:\Program Files\Veyon\Cle" /MIR > nul
net use P: /delete