@echo off
IF "%PROCESSOR_ARCHITECTURE%"=="x86" (set osbit=32) else (set osbit=64)
pushd \\srvinfo\z\Logiciels\Veyon\Veyon_2019
veyon-4.3.2.0-win%osbit%-setup.exe /S /NoMaster
C:\Windows\System32\Robocopy.exe "\\srvinfo\z\Logiciels\Veyon\Veyon_2019\Cle" "C:\Program Files\Veyon\Cle" /MIR
popd