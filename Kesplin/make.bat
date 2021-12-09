@echo off
@set USER_DATA_DIRECTORY=%APPDATA%\Factorio
@set MOD_NAME=Kesplin
@set MOD_VERSION=1.0.0

set GOAL=%1
    
echo "GOAL = %GOAL%"
if "%GOAL%" == "build" (
    CALL :build
    echo "Done building."
) else if "%GOAL%" == "install" (
    CALL :build
    CALL :install
    echo "Done installing."
) else (
    echo "Invalid goal. Call script in this way: make build|install"
)
EXIT /B 0

rem LOCAL FUNTIONS

:build
    @set OLD_CWD=%CD%
    @cd ..
    tar.exe -acf "%MOD_NAME%_%MOD_VERSION%.zip" %MOD_NAME%
    @cd %OLD_OLD%
EXIT /B 0

:install
    echo ""
    mkdir %USER_DATA_DIRECTORY%\mods\
    copy "%MOD_NAME%_%MOD_VERSION%.zip" %USER_DATA_DIRECTORY%\mods\
EXIT /B 0


