@echo off
setlocal
echo ==================================================================
echo   QuickKart - Java Socket Networking Test (Windows)
echo ==================================================================
if defined JAVA_HOME (
    set "PATH=%JAVA_HOME%\bin;%PATH%"
)

echo Starting Inventory Socket Server on port 9090 in background...
start "QuickKart Network Server" /min cmd /c "mvn exec:java -pl quickkart-network -Dexec.mainClass=\"com.quickkart.network.server.InventoryServer\""

echo Waiting 3 seconds for ServerSocket to listen...
timeout /t 3 /nobreak >nul

echo Running Inventory Socket Client Test against localhost:9090...
echo ------------------------------------------------------------------
call mvn exec:java -pl quickkart-network -Dexec.mainClass="com.quickkart.network.client.InventoryClient"

echo.
echo ==================================================================
echo   Java Network Socket test finished!
echo ==================================================================
endlocal
