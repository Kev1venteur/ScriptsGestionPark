@echo off
taskkill /IM veyon-master.exe
taskkill /IM veyon-configurator.exe
IF "%PROCESSOR_ARCHITECTURE%"=="x86" (set osbit=32) else (set osbit=64)
pushd \\srvinfo\z\Logiciels\Veyon\Veyon_2019
veyon-4.3.2.0-win%osbit%-setup.exe /S /ApplyConfig="\\srvinfo\z\Logiciels\Veyon\Veyon_2019\Conf\conf_maitre.json"
C:\Windows\System32\Robocopy.exe "\\srvinfo\z\Logiciels\Veyon\Veyon_2019\Cle" "C:\Program Files\Veyon\Cle" /MIR
popd