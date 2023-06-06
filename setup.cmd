@echo off
set missingfile=
if not exist wifibelt.vb_ set missingfile=wifibelt.vb_
if not exist wifibelt.cf_ set missingfile=wifibelt.cf_
if not exist wirelessnetworkwatcher\wnetwatcher.exe set missingfile=wirelessnetworkwatcher\wnetwatcher.exe
if "%missingfile%"=="" goto allfilesexist
echo File not found %missingfile%
pause
goto end
:choiceerror
echo choice command failed.
pause
goto end
:allfilesexist
echo About ready to install continue?
choice /C YN /M "Press Y for yes,N for no"
if errorlevel 2 goto end
if errorlevel 1 goto install
goto choiceerror
:install
md %SystemDrive%\delphijustin
md %SystemDrive%\delphijustin\wifibelt
copy wirelessnetworkwatcher\*.* %SystemDrive%\delphijustin\wifibelt
set apikey=textbelt
set /P apikey=Enter textbelt API Key, for free once a day text leave blank:
set /P phone=Enter your 10-digit phone#, example 8001234567:
echo apikey="%apikey%" > %SystemDrive%\delphijustin\wifibelt\wifibelt.vbs
echo phone="%phone%" >> %SystemDrive%\delphijustin\wifibelt\wifibelt.vbs
echo database="%SystemDrive%\delphijustin\wifibelt\wifibelt.db" >> %SystemDrive%\delphijustin\wifibelt\wifibelt.vbs
type wifibelt.vb_ >> %SystemDrive%\delphijustin\wifibelt\wifibelt.vbs
copy /Y wifibelt.cf_ %SystemDrive%\delphijustin\wifibelt\wifibelt.cfg
echo NewDeviceExecuteCommand=wscript.exe %SystemDrive%\delphijustin\wifibelt\wifibelt.vbs /mac:%%mac_addr%% /ip:%%ip_addr%% /company:%%adapter_company%% >> %SystemDrive%\delphijustin\wifibelt\wifibelt.cfg
echo Monitor when you login to windows?
choice /C YN /M "Press Y for yes N for no"
if errorlevel 2 goto nostartup
if errorlevel 1 goto yesstartup
goto choiceerror
:yesstartup
reg add HKLM\Software\Microsoft\Windows\CurrentVersion\Run /V WifiBelt /T REG_SZ /D "%SystemDrive%\delphijustin\wifibelt\wnetwatcher.exe /cfg %SystemDrive%\delphijustin\wifibelt\Wifibelt.cfg"
:nostartup
echo start %SystemDrive%\delphijustin\wifibelt\wnetwatcher.exe /cfg %SystemDrive%\delphijustin\wifibelt\Wifibelt.cfg > start_wifibelt.bat
echo Start monitoring now?
choice /C YN /M "Press Y for yes N for no"
if errorlevel 2 goto dontstart
if errorlevel 1 goto startmon
goto choiceerror
:startmon
start %SystemDrive%\delphijustin\wifibelt\wnetwatcher.exe /cfg %SystemDrive%\delphijustin\wifibelt\Wifibelt.cfg
:dontstart
echo Finished, to manually start monitoring open start_wifibelt.bat file
pause
:end
