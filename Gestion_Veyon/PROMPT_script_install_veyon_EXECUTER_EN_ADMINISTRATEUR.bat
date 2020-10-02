@echo off
::////////////////////////////On kill le processus////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
taskkill /IM veyon-master.exe
taskkill /IM veyon-configurator.exe

::////////////////////////////On check le nombre de bits du systeme///////////////////////////////////////////////////////////////////////////////////////////////////
:oscheck
IF "%PROCESSOR_ARCHITECTURE%"=="x86" (set osbit=32) else (set osbit=64)

::////////////////////////////On Choisis la version de Veyon à installer//////////////////////////////////////////////////////////////////////////////////////////////
pushd \\srvinfo\z\Logiciels\Veyon\Veyon_2019
:loopversion
set /p version="Quelle version voulez-vous installer ?  "
IF EXIST veyon-%version%-win%osbit%-setup.exe (
    echo Nom de version valide
    GOTO loopinstall
) ELSE (
    echo Nom de version INVALIDE!!!
    GOTO loopversion 
)

::////////////////////////////On fait l'install en mode client ou master//////////////////////////////////////////////////////////////////////////////////////////////
:loopinstall
set /p input="Installer Client ou Master ?  "
IF %input% == client GOTO client
IF %input% == Client GOTO client
IF %input% == CLIENT GOTO client

IF %input% == master GOTO master
IF %input% == Master GOTO master
IF %input% == MASTER GOTO master

IF %input% NEQ master IF %input% NEQ Master IF %input% NEQ MASTER IF %input% NEQ client IF %input% NEQ Client IF %input% NEQ CLIENT GOTO error

:master
echo Debut de l'installation...
veyon-%version%-win%osbit%-setup.exe /S /ApplyConfig="\\srvinfo\z\Logiciels\Veyon\Veyon_2019\Conf\conf_maitre.json"
echo Import de la configuration OK
echo Installation de Veyon en mode master en %osbit%bits terminee
GOTO csv

:client
echo Debut de l'installation...
veyon-%version%-win%osbit%-setup.exe /S /NoMaster
echo Installation de Veyon en mode client en %osbit%bits terminee
GOTO clef

:error
ECHO Valeur saisie incorrecte
GOTO loopinstall

::////////////////////////////On importe les donnees CSV/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
:csv
set /p csvinput="Importer les donnees CSV? Y/N ?  "
IF %csvinput% == y GOTO yescsv
IF %csvinput% == Y GOTO yescsv

IF %csvinput% == n GOTO nocsv
IF %csvinput% == N GOTO nocsv

IF %csvinput% NEQ y IF %csvinput% NEQ Y IF %csvinput% NEQ n IF %csvinput% NEQ N GOTO errorcsv

:yescsv
echo Import des donnees CSV
"C:\Program Files\Veyon\veyon-cli.exe" networkobjects clear
"C:\Program Files\Veyon\veyon-cli.exe" networkobjects import \\srvinfo\z\Logiciels\Veyon\ConfVeyon\ConfVeyonFin.csv format "%%location%%;%%name%%;%%host%%;%%mac%%"
GOTO clef

:nocsv
echo Import des donnees CSV annule
GOTO clef

:errorcsv
ECHO Valeur saisie incorrecte
GOTO csv

::////////////////////////////On importe les Clefs///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
:clef
set /p clefinput="Importer les Clefs? Y/N ?  "
IF %clefinput% == y GOTO yesclef
IF %clefinput% == Y GOTO yesclef

IF %clefinput% == n GOTO noclef
IF %clefinput% == N GOTO noclef

IF %clefinput% NEQ y IF %clefinput% NEQ Y IF %clefinput% NEQ n IF %clefinput% NEQ N GOTO errorclef

:yesclef
echo Import des Clefs
C:\Windows\System32\Robocopy.exe "\\srvinfo\z\Logiciels\Veyon\Veyon_2019\Cle" "C:\Program Files\Veyon\Cle" /MIR
GOTO end

:noclef
echo Import des Clefs annule
GOTO end

:errorclef
ECHO Valeur saisie incorrecte
GOTO clef

:end
popd
PAUSE
