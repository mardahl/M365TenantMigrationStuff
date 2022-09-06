@ECHO OFF

if exist %USERPROFILE%\MigrationDone.txt goto end
msg "%username%" Starting migration fix - click OK and WAIT for completed message!
pushd "%~dp0"

@ECHO Fixing user after migration...
@ECHO ******************************************

@ECHO Forcing new Outlook profile
@ECHO ******************************************
@taskkill /F /IM "outlook.exe" /T
@CALL ".\OutlookProfile\ForceNewOutlookProfile.bat"

pushd "%~dp0"

@ECHO Remove Azure AD Registration
@ECHO ******************************************
@CALL ".\AADRegistration\WPJCleanUp.cmd"

pushd "%~dp0"

@ECHO Updating O365 License
@ECHO ******************************************
@Cscript ".\LicenseCleanup\OLicenseCleanup.VBS" //Nologo
timeout /T 10 /nobreak>nul
@Cscript ".\LicenseCleanup\OLicenseCleanup.VBS" //Nologo
timeout /T 10 /nobreak>nul

@ECHO Updating OneDrive
@ECHO ******************************************
@reg delete HKEY_CURRENT_USER\SOFTWARE\Microsoft\OneDrive\Accounts /f
@if exist "%localappdata%\Microsoft\OneDrive\onedrive.exe" (Start %localappdata%\Microsoft\OneDrive\onedrive.exe /reset)
@if exist "C:\Program Files (x86)\Microsoft OneDrive\OneDrive.exe" (Start "C:\Program Files (x86)\Microsoft OneDrive\OneDrive.exe /reset")

timeout /T 5 /nobreak>nul

@ECHO Updating Teams
@ECHO ******************************************
@taskkill /F /IM "teams.exe" /T
@del %appdata%\Microsoft\Teams\desktop-config.json

REM Deleting Teams Cache
@del "%appdata%\Microsoft\teams\application cache\cache\*.*" /S /Q
@del "%appdata%\Microsoft\teams\blob_storage\*.*" /S /Q
@del "%appdata%\Microsoft\teams\Cache\*.*" /S /Q
@del "%appdata%\Microsoft\teams\databases\*.*" /S /Q
@del "%appdata%\Microsoft\teams\GPUcache\*.*" /S /Q
@del "%appdata%\Microsoft\teams\IndexedDB\*.db" /S /Q
@del "%appdata%\Microsoft\teams\Local Storage\*.*" /S /Q
@del "%appdata%\Microsoft\teams\tmp\*.*" /S /Q

timeout /T 5 /nobreak>nul

@ECHO Resetting Azure AD access broker
@ECHO ******************************************
@rename %localappdata%\Packages\Microsoft.AAD.BrokerPlugin_cw5n1h2txyewy Microsoft.AAD.BrokerPlugin_cw5n1h2txyewy.old

echo done >> %USERPROFILE%\MigrationDone.txt
msg "%username%" Migration fix done
:end