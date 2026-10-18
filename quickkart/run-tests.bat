@echo off
setlocal
echo ==================================================================
echo   Running QuickKart Automated Unit & Regression Tests (Windows)
echo ==================================================================
if defined JAVA_HOME (
    set "PATH=%JAVA_HOME%\bin;%PATH%"
)

where mvn >nul 2>nul
if %ERRORLEVEL% equ 0 (
    call mvn test
) else (
    if exist mvnw.cmd (
        call mvnw.cmd test
    ) else (
        echo [ERROR] Maven not found. Please install Apache Maven.
        pause
    )
)
echo.
echo ==================================================================
echo   Test execution completed!
echo ==================================================================
endlocal
