@echo off
setlocal
echo ==================================================================
echo   Starting QuickKart Desktop Swing Admin Application (Windows)
echo ==================================================================
if defined JAVA_HOME (
    set "PATH=%JAVA_HOME%\bin;%PATH%"
)

where mvn >nul 2>nul
if %ERRORLEVEL% equ 0 (
    call mvn exec:java -pl quickkart-swing-admin -Dexec.mainClass="com.quickkart.swing.MainSwingAdmin"
) else (
    if exist mvnw.cmd (
        call mvnw.cmd exec:java -pl quickkart-swing-admin -Dexec.mainClass="com.quickkart.swing.MainSwingAdmin"
    ) else (
        echo [ERROR] Maven not found. Please install Apache Maven or run from your IDE.
        pause
    )
)
endlocal
