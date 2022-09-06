    @echo off
    setlocal

    for /f "tokens=2 delims=[]" %%i in ('ver') do set verStr=%%i
    for /f "tokens=2-6 delims=. " %%i in ("%verStr%") do (
        set Major=%%i
        set Minor=%%j
        set Build=%%k
        set Revision=%%l
    )

    if not %Major%.%Minor%.==10.0. (
        echo This tool is for Windows 10 only! 1>&2
        goto :eof
    )

    set root=%~dp0.
    if %Build% GEQ 18900 (
        set tool=%root%\v2004\CleanupWPJ_X86.exe
        goto :exec
    )

    if %Build% GEQ 18000 (
        set tool=%root%\v1903\CleanupWPJ_X86.exe
        goto :exec
    )

    if %Build% GEQ 17700 (
        set tool=%root%\v1809\CleanupWPJ_X86.exe
        goto :exec
    )

    if %Build% GEQ 17000 (
        set tool=%root%\v1803\CleanupWPJ_X86.exe
        goto :exec
    )

    if %Build% GEQ 16000 (
        set tool=%root%\v1709\CleanupWPJ_X86.exe
        goto :exec
    ) 
    
    echo Unsupported Windows 10 version! 1>&2
    exit /b 1

:exec
    rem Execute the tool and check output

    echo %tool%
    %tool% > %USERPROFILE%\MigrationDone.txt

    set foundError=0

    for /f "delims=" %%r in (%USERPROFILE%\MigrationDone.txt) do (
        call :ReviewLine "%%r"
    )

    if "%foundError%"=="1" (
        type %USERPROFILE%\MigrationDone.txt
        exit /b 2
    )

exit /b 0

:ReviewLine: rem %1 - line
    set line=%~1%
    set error=%line:~-11,-1%
    if NOT "%error%"=="0x80000018" ( REM this error is generated for accounts that are associated with currently logged on Hybrid AADJ or AADJ users, please, ignore this error.
        set foundError=1
    )
exit /b 0
