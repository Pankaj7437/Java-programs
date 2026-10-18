#!/usr/bin/env bash
# ==============================================================================
# QuickKart - Run Java Socket Networking Demo (java.net Server & Client)
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
NETWORK_CP="$SCRIPT_DIR/quickkart-network/target/classes:$SCRIPT_DIR/quickkart-dao/target/classes:$SCRIPT_DIR/quickkart-common/target/classes:$M2_REPO/com/h2database/h2/2.2.224/h2-2.2.224.jar:$M2_REPO/com/zaxxer/HikariCP/5.1.0/HikariCP-5.1.0.jar:$M2_REPO/org/slf4j/slf4j-api/2.0.12/slf4j-api-2.0.12.jar:$M2_REPO/ch/qos/logback/logback-classic/1.5.3/logback-classic-1.5.3.jar:$M2_REPO/ch/qos/logback/logback-core/1.5.3/logback-core-1.5.3.jar:$M2_REPO/org/mindrot/jbcrypt/0.4/jbcrypt-0.4.jar"

echo "=================================================================="
echo "  Starting QuickKart java.net Inventory Server on port 9090..."
echo "=================================================================="

# Start server in background
if [ -f "$M2_REPO/com/zaxxer/HikariCP/5.1.0/HikariCP-5.1.0.jar" ]; then
    java -cp "$NETWORK_CP" com.quickkart.network.server.InventoryServer > /tmp/inventory_server.log 2>&1 &
else
    "$SCRIPT_DIR/mvnw" exec:java -pl quickkart-network -Dexec.mainClass="com.quickkart.network.server.InventoryServer" > /tmp/inventory_server.log 2>&1 &
fi
SERVER_PID=$!

# Ensure cleanup on exit
trap 'kill -9 $SERVER_PID 2>/dev/null || true' EXIT

sleep 2

echo "Running java.net Inventory Client against localhost:9090..."
echo "------------------------------------------------------------------"
if [ -f "$M2_REPO/com/zaxxer/HikariCP/5.1.0/HikariCP-5.1.0.jar" ]; then
    java -cp "$NETWORK_CP" com.quickkart.network.client.InventoryClient
else
    "$SCRIPT_DIR/mvnw" exec:java -pl quickkart-network -Dexec.mainClass="com.quickkart.network.client.InventoryClient"
fi

echo ""
echo "=================================================================="
echo "  ✓ java.net Socket Server & Client test completed successfully!"
echo "=================================================================="
