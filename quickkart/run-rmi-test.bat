@echo off
setlocal
echo ==================================================================
echo   QuickKart - Java Remote Method Invocation (RMI) Test (Windows)
echo ==================================================================
if defined JAVA_HOME (
    set "PATH=%JAVA_HOME%\bin;%PATH%"
)

echo Starting Java RMI Registry and Server on port 1099 in background...
start "QuickKart RMI Server" /min cmd /c "mvn exec:java -pl quickkart-rmi -Dexec.mainClass=\"com.quickkart.rmi.server.RmiServerLauncher\""

echo Waiting 3 seconds for RMI Registry to bind...
timeout /t 3 /nobreak >nul

echo Running Java RMI Client Test against localhost:1099...
echo ------------------------------------------------------------------
call mvn exec:java -pl quickkart-rmi -Dexec.mainClass="com.quickkart.rmi.client.RmiClientTest"

echo.
echo ==================================================================
echo   Java RMI Remote Service test finished!
echo ==================================================================
endlocal
