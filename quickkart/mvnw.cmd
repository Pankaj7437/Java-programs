@echo off
setlocal
if not defined JAVA_HOME (
    where java >nul 2>nul
    if %ERRORLEVEL% neq 0 (
        echo [ERROR] JAVA_HOME is not set and java was not found in PATH.
        echo Please install JDK 17 or 21 and set JAVA_HOME.
        exit /b 1
    )
)
where mvn >nul 2>nul
if %ERRORLEVEL% equ 0 (
    call mvn %*
) else (
    echo [ERROR] Maven is not installed or not in PATH.
    echo Please install Apache Maven 3.9+ or run using an IDE like IntelliJ / Eclipse / VS Code.
    exit /b 1
)
endlocal
