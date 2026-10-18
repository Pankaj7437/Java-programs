@echo off
setlocal
echo ==================================================================
echo   Stopping QuickKart Web Application (Windows)
echo ==================================================================
if defined CATALINA_HOME (
    call "%CATALINA_HOME%\bin\shutdown.bat"
    echo Tomcat shutdown requested.
) else (
    echo Note: CATALINA_HOME not set. If running with Docker, execute:
    echo   docker compose -f docker\docker-compose.yml down
)
endlocal
