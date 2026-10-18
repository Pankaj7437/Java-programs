@echo off
setlocal
echo ==================================================================
echo   Starting QuickKart Web Application (Windows)
echo ==================================================================
if defined CATALINA_HOME (
    echo Launching Apache Tomcat from %CATALINA_HOME%...
    call "%CATALINA_HOME%\bin\startup.bat"
    echo.
    echo ==================================================================
    echo   QuickKart is launching!
    echo   Open in your browser: http://localhost:8080/
    echo ==================================================================
) else (
    echo [NOTE] CATALINA_HOME environment variable is not set.
    echo If running with Docker:
    echo   docker compose -f docker\docker-compose.yml up -d
    echo If running with standalone Tomcat:
    echo   Set CATALINA_HOME=C:\path\to\apache-tomcat-10.1 and run this script again.
)
endlocal
