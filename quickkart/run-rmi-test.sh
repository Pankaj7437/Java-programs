#!/usr/bin/env bash
# ==============================================================================
# QuickKart - Run Java Remote Method Invocation (RMI) Demo
# ==============================================================================
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ -z "$JAVA_HOME" ]; then
    if [ -d "/home/devops-user/tools/jdk-21.0.12.1+1" ]; then
        export JAVA_HOME="/home/devops-user/tools/jdk-21.0.12.1+1"
    fi
fi

if [ -n "$JAVA_HOME" ]; then
    export PATH="$JAVA_HOME/bin:$PATH"
fi

M2_REPO="${HOME}/.m2/repository"
RMI_CP="$SCRIPT_DIR/quickkart-rmi/target/classes:$SCRIPT_DIR/quickkart-dao/target/classes:$SCRIPT_DIR/quickkart-common/target/classes:$M2_REPO/com/h2database/h2/2.2.224/h2-2.2.224.jar:$M2_REPO/com/zaxxer/HikariCP/5.1.0/HikariCP-5.1.0.jar:$M2_REPO/org/slf4j/slf4j-api/2.0.12/slf4j-api-2.0.12.jar:$M2_REPO/ch/qos/logback/logback-classic/1.5.3/logback-classic-1.5.3.jar:$M2_REPO/ch/qos/logback/logback-core/1.5.3/logback-core-1.5.3.jar:$M2_REPO/org/mindrot/jbcrypt/0.4/jbcrypt-0.4.jar"

echo "=================================================================="
echo "  Starting QuickKart Java RMI Server & Registry on port 1099..."
echo "=================================================================="

# Start server in background
if [ -f "$M2_REPO/com/zaxxer/HikariCP/5.1.0/HikariCP-5.1.0.jar" ]; then
    java -cp "$RMI_CP" com.quickkart.rmi.server.RmiServerLauncher > /tmp/rmi_server.log 2>&1 &
else
    "$SCRIPT_DIR/mvnw" exec:java -pl quickkart-rmi -Dexec.mainClass="com.quickkart.rmi.server.RmiServerLauncher" > /tmp/rmi_server.log 2>&1 &
fi
RMI_PID=$!

# Ensure cleanup on exit
trap 'kill -9 $RMI_PID 2>/dev/null || true' EXIT

sleep 2

echo "Running Java RMI Client Test against localhost:1099..."
echo "------------------------------------------------------------------"
if [ -f "$M2_REPO/com/zaxxer/HikariCP/5.1.0/HikariCP-5.1.0.jar" ]; then
    java -cp "$RMI_CP" com.quickkart.rmi.client.RmiClientTest
else
    "$SCRIPT_DIR/mvnw" exec:java -pl quickkart-rmi -Dexec.mainClass="com.quickkart.rmi.client.RmiClientTest"
fi

echo ""
echo "=================================================================="
echo "  ✓ Java RMI Remote Service test completed successfully!"
echo "=================================================================="
